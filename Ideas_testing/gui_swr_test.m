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
        % Ask for brain area.
xx = inputdlg({'Brain area'},...
              'Type your selection', [1 30]); 
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
%(level,nrem,notch,w,lepoch)
%Band pass filter design:
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

%LPF 300 Hz:
fn=1000; % New sampling frequency. 
Wn1=[320/(fn/2)]; % Cutoff=320 Hz
[b2,a2] = butter(3,Wn1); %Filter coefficients

%xx{1}='PAR';
%PFC=dir('*PAR*.mat');
PFC=dir(strcat('*',xx{1},'*.mat'));
PFC=PFC.name;
PFC=load(PFC);
%PFC=PFC.PFC;
PFC=getfield(PFC,xx{1});
PFC=PFC.*(0.195);

% V17=load('V17.mat');
% V17=V17.V17;
% V17=V17.*(0.195);

A = dir('*states*.mat');
A={A.name};

% if scoring==1 && ~isempty(A)
if  ~isempty(A)
       cellfun(@load,A);
else
%     error('No Scoring found')
%     errordlg( strcat('No Scoring found:',cd),'Error')
    ripple2=[];
    timeasleep=[];
    DM=[];
    y1=[];
    return
    %,timeasleep,DM,y1
    
end

% [transitions]=sort_scoring(transitions); %
% %When no NREM is detected
% if isempty(find(transitions(:,1)==3))
% %     errordlg( strcat('No NREM detected:',cd),'Error')
%     ripple2=[];
%     timeasleep=[];
%     DM=[];
%     y1=[];
%     return    
% end

    %Convert signal to 1 sec epochs.
    e_t=1;
    e_samples=e_t*(1000); %fs=1kHz
    ch=length(PFC);
    nc=floor(ch/e_samples); %Number of epochs
    NC=[];
    for kk=1:nc    
      NC(:,kk)= PFC(1+e_samples*(kk-1):e_samples*kk);
    end
    
    vec_bin=states;
    vec_bin(vec_bin~=3)=0;
    vec_bin(vec_bin==3)=1;
    %Cluster one values:
    v2=ConsecutiveOnes(vec_bin);
    
%     %Find shorter vector.
%     if length(v2)<nc
%         min_con=length(v2);
%     else
%         min_con=nc;
%     end
    
    
%     v=cell(length(v2(v2~=0)),1);
    v_index=find(v2~=0);
    v_values=v2(v2~=0);

%     
%     ver=NC(:, v_index(1):v_index(1)+(v_values(1,1)-1));
%     v{1}=reshape(A, numel(A), 1);
for epoch_count=1:length(v_index)
v{epoch_count,1}=reshape(NC(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
end 
    
%     
%     nrem_epochs=(states==3);
%     NC=NC(:,nrem_epochs);
% 
% 
% [v17,~]=reduce_data(V17,transitions,1000,3);

%

% V17=filtfilt(b2,a2,V17);
V=cellfun(@(equis) filtfilt(b2,a2,equis), v ,'UniformOutput',false);
Mono=cellfun(@(equis) filtfilt(b1,a1,equis), V ,'UniformOutput',false);

%Total amount of NREM time:
timeasleep=sum(cellfun('length',V))*(1/1000)/60; % In minutes
signal2=cellfun(@(equis) times((1/0.195), equis)  ,Mono,'UniformOutput',false);
% ti=cellfun(@(equis) linspace(0, length(equis)-1,length(equis))*(1/fn) ,signal2,'UniformOutput',false);
ti=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,signal2,'UniformOutput',false);
%xo
if strcmp(xx{1},'HPC')
[Sx,Ex,Mx] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2, tr(1), (tr(1))*(1/2), [] ), signal2,ti,'UniformOutput',false);               
else
[Sx,Ex,Mx] =cellfun(@(equis1,equis2) findRipplesLisa2020(equis1, equis2, tr(2), (tr(2))*(1/2), [] ), signal2,ti,'UniformOutput',false);               
end

% [Sx,Ex,Mx] =cellfun(@(equis1,equis2) findRipplesLisa2020(equis1, equis2, tr(2), (tr(2))*(1/2), [] ), signal2,ti,'UniformOutput',false);           
s=cellfun('length',Sx);        
RipFreq2=sum(s)/(timeasleep*(60)); %RIpples per second.         
ripple2=sum(s);
%xo        
        
%% Cortical HFOs


    hfos_pfc(k)=ripple2;
    hfos_pfc_rate(k)=RipFreq2;
%     C = cellfun(@minus,Ex_pfc,Sx_pfc,'UniformOutput',false);
%     CC=([C{:}]);
%     hfos_pfc_duration(k)=median(CC);
%     
    progress_bar(k,length(g),f)
    cd ..    
    end
%xo

%PAR
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,hfos_pfc)
ylabel('Number of HFOs')
title(xx{1})


    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('TEST_HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
      string=strcat('TEST_HFOs_counts_',xx{1},'_Rat',num2str(Rat));         
    end

    printing(string)
    close all
%rate
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,hfos_pfc_rate)
ylabel('HFOs per second')
title(xx{1})


    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('TEST_HFOs_rate_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
      string=strcat('TEST_HFOs_rate_',xx{1},'_Rat',num2str(Rat));         
    end

    printing(string)
    close all
    
    TT=table;
    TT.Variables=    [[{'Count'};{'Rate'}] num2cell([hfos_pfc;hfos_pfc_rate])];
%     TT.Properties.VariableNames=['Metric';g];    
    writetable(TT,strcat('TEST_',xx{1},'.xls'),'Sheet',1,'Range','A2:L6')    

    
    if size(label1,1)==3 %If Plusmaze
%        xo
        break;
    end
%xo       
end