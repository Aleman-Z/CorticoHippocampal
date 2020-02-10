%gui_threshold_ripples
%% Find location
close all
dname=uigetdir([],'Select folder with Matlab data');
cd(dname)
%%
z= zeros(length(label1),length(rats));
[T]=gui_table_channels(z,rats,label1,'Threholds');

%%
%Select rat number
opts.Resize = 'on';
opts.WindowStyle = 'modal';
opts.Interpreter = 'tex';
prompt=strcat('\bf Select a rat#. Options:','{ }',num2str(rats));
answer = inputdlg(prompt,'Input',[2 30],{''},opts);
Rat=str2num(answer{1});
cd(num2str(Rat))
tr=getfield(T,strcat('Rat',num2str(Rat)));%Thresholds 
%%
gg=getfolder;
gg=gg.';
if size(label1,1)~=3  % IF not Plusmaze
    gg(ismember(gg,'OR_N'))=[];
    gg(ismember(gg,'OD_N(incomplete)'))=[];
    gg=sort(gg); %Sort alphabetically.
    labelconditions2=gg;
    gg(ismember(gg,'CN'))={'CON'};
end
labelconditions=gg;

%% Select experiment to perform. 
inter=1;
%Select length of window in seconds:
ro=[1200];
coher=0;
selectripples=1;
notch=0; %Might need to be 1.
nrem=3;
level=1;
%%
for iii=1:length(labelconditions) 

    if size(label1,1)~=3  % IF not Plusmaze

        cd( labelconditions2{iii})
        g=getfolder;

        if iii==1
            answer = questdlg('Should we use all trials?', ...
                'Trial selection', ...
                'Use all','Select trials','Select trials');

            % Handle response
            switch answer
                case 'Use all'
                    disp(['Using all.'])
                    an=[];
                case 'Select trials'
                    prompt = {['Enter trials name common word without index:' sprintf('\n') '(Use commas for multiple names)']};
                    dlgtitle = 'Input';
                    dims = [1 35];
                    %definput = {'20','hsv'};
                    an = inputdlg(prompt,dlgtitle,dims);
                    %an=char(an);
            %        g=g(contains(g,{'PT'}));
            end

        end

        if ~isempty(an)
        g=g(contains(g,strsplit(an{1},',')));
        end
  
    else
      g=gg;  
    end
  %% Colormap
       % n=length(g);
        myColorMap=jet(length(g));    
        
% xo        
%         % Ask for brain area.
% xx = inputdlg({'Brain area'},...
%               'Type your selection', [1 30]);          
% D1=tr(find(strcmp(xx{1},label1)==1)); %Threshold for specific brain area.          

%%
f=waitbar(0,'Please wait...');
    for k=1:length(g)
        cd(g{k})

        %Band pass filter design:
        fn=1000; % New sampling frequency. 
        Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=100-300 Hz
        % Wn1=[50/(fn/2) 80/(fn/2)]; 
        [b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

        %LPF 300 Hz:
        fn=1000; % New sampling frequency. 
        Wn1=[320/(fn/2)]; % Cutoff=320 Hz
        [b2,a2] = butter(3,Wn1); %Filter coefficients

        HPC=dir('*HPC*.mat');
        HPC=HPC.name;
        HPC=load(HPC);
        HPC=HPC.HPC;
        HPC=HPC.*(0.195);

        PFC=dir(strcat('*','PAR','*.mat'));
        PFC=PFC.name;
        PFC=load(PFC);
        % PFC=PFC.PFC;
        PFC=getfield(PFC,'PAR');
        PFC=PFC.*(0.195);

        A = dir('*states*.mat');
        A={A.name};


        cellfun(@load,A);

        %Convert signal to 1 sec epochs.
        e_t=1;
        e_samples=e_t*(1000); %fs=1kHz
        ch=length(PFC);
        nc=floor(ch/e_samples); %Number of epochs
        NC=[];
        NC2=[];
%xo
        for kk=1:nc
            if  kk==nc && length(HPC(1+e_samples*(kk-1):end))~= 1000 
                      break
            else
                      NC(:,kk)= HPC(1+e_samples*(kk-1):e_samples*kk);
                      NC2(:,kk)= PFC(1+e_samples*(kk-1):e_samples*kk);
                
            end
            
        end

        vec_bin=states;
        vec_bin(vec_bin~=3)=0;
        vec_bin(vec_bin==3)=1;
        %Cluster one values:
        v2=ConsecutiveOnes(vec_bin);

        v_index=find(v2~=0);
        v_values=v2(v2~=0);
        %
        %xo
        for epoch_count=1:length(v_index)
        v_hpc{epoch_count,1}=reshape(NC(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
        v_pfc{epoch_count,1}=reshape(NC2(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
        end 

        %v_hpc and v_pfc: NREM epochs.

        %Ripple detection

        V_hpc=cellfun(@(equis) filtfilt(b2,a2,equis), v_hpc ,'UniformOutput',false);
        Mono_hpc=cellfun(@(equis) filtfilt(b1,a1,equis), V_hpc ,'UniformOutput',false); %100-300 Hz
        signal2_hpc=cellfun(@(equis) times((1/0.195), equis)  ,Mono_hpc,'UniformOutput',false); %Remove convertion factor for ripple detection

        V_pfc=cellfun(@(equis) filtfilt(b2,a2,equis), v_pfc ,'UniformOutput',false);
        Mono_pfc=cellfun(@(equis) filtfilt(b1,a1,equis), V_pfc ,'UniformOutput',false); %100-300 Hz
        signal2_pfc=cellfun(@(equis) times((1/0.195), equis)  ,Mono_pfc,'UniformOutput',false); %Remove convertion factor for ripple detection
        fn=1000;

        ti=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,signal2_hpc,'UniformOutput',false);
        % ti_pfc=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,signal2_pfc,'UniformOutput',false);
        
    %% HFOs in HPC
    [Sx_hpc,Ex_hpc,Mx_hpc] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2, tr(1), (tr(1))*(1/2), [] ), signal2_hpc,ti,'UniformOutput',false);    
    swr_hpc=[Sx_hpc Ex_hpc Mx_hpc];
    s_hpc=cellfun('length',Sx_hpc);
    hfos_hpc(k)=sum(s_hpc);
%% Cortical HFOs
%D2=35;%THRESHOLD
    [Sx_pfc,Ex_pfc,Mx_pfc] =cellfun(@(equis1,equis2) findRipplesLisa2020(equis1, equis2, tr(2), (tr(2))*(1/2), [] ), signal2_pfc,ti,'UniformOutput',false);    
    swr_pfc=[Sx_pfc Ex_pfc Mx_pfc];
    s_pfc=cellfun('length',Sx_pfc);%% Cortical ripples   
    hfos_pfc(k)=sum(s_pfc);
    
    progress_bar(k,length(g),f)
    cd ..    
    end

%HPC
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,hfos_hpc)
ylabel('Number of HFOs')
title('HPC')


    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('HFOs_counts_','HPC','_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
      string=strcat('HFOs_counts_','HPC','_Rat',num2str(Rat));         
    end

    printing(string)
    close all

%PFC    
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,hfos_pfc)
ylabel('Number of HFOs')
title('PAR')


    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('HFOs_counts_','PAR','_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
      string=strcat('HFOs_counts_','PAR','_Rat',num2str(Rat));         
    end

    printing(string)
    close all
    
    
    
    
    if size(label1,1)==3 %If Plusmaze
%        xo
        break;
    end
%xo       
end