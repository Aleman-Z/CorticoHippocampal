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
% xx = inputdlg({'Cortical Brain area'},...
%               'Type your selection', [1 30]); 
xx={'PAR'};
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
%xo
CORTEX=dir(strcat('*',xx{1},'*.mat'));
if isempty(CORTEX)
    g=g(~contains(g,g{k}));
    cd ..
    progress_bar(k,length(g),f)
    break
end
CORTEX=CORTEX.name;
CORTEX=load(CORTEX);
%CORTEX=CORTEX.CORTEX;
CORTEX=getfield(CORTEX,xx{1});
CORTEX=CORTEX.*(0.195);

A = dir('*states*.mat');
A={A.name};

if  ~isempty(A)
       cellfun(@load,A);
else
      error('No Scoring found')    
end
xo
[ripple,RipFreq,rip_duration,Mx_cortex,timeasleep,sig]=gui_findripples(CORTEX,states,xx,tr);
%xo        
        
%% Cortical HFOs
    hfos_cortex(k)=ripple;
    hfos_cortex_rate(k)=RipFreq;
    hfos_cortex_duration(k)=rip_duration;
    clear ripple RipFreq
%     C = cellfun(@minus,Ex_pfc,Sx_pfc,'UniformOutput',false);
%     CC=([C{:}]);
%     hfos_pfc_duration(k)=median(CC);
%% HPC     
HPC=dir(strcat('*','HPC','*.mat'));
HPC=HPC.name;
HPC=load(HPC);
%HPC=HPC.HPC;
HPC=getfield(HPC,'HPC');
HPC=HPC.*(0.195);

[ripple,RipFreq,rip_duration,Mx_hpc,timeasleep]=gui_findripples(HPC,states,{'HPC'},tr);
hfos_hpc(k)=ripple;
hfos_hpc_rate(k)=RipFreq;
hfos_hpc_duration(k)=rip_duration;


%Coocurent hfos
cohfos=cellfun(@(equis1,equis2) co_hfo(equis1,equis2),Mx_hpc,Mx_cortex,'UniformOutput',false);
cohfos_count(k)=sum(cellfun('length',cohfos));
cohfos_rate(k)=sum(cellfun('length',cohfos))/(timeasleep*(60));

progress_bar(k,length(g),f)
    cd ..    
    end
%xo

%Cortex
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,hfos_cortex)
ylabel('Number of HFOs')
title(xx{1})

    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
%         if strcmp(xx{1},'HPC')
%                   string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         else
                  string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(2)));         
%         end
    end

    printing(string)
    close all
%rate
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,hfos_cortex_rate)
ylabel('HFOs per second')
title(xx{1})


    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('HFOs_rate_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
%         if strcmp(xx{1},'HPC')
%                   string=strcat('HFOs_rate_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         else
                  string=strcat('HFOs_rate_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(2)));         
%         end
        
    end

    printing(string)
    close all
%     xo
    TT=table;
    TT.Variables=    [[{'Count'};{'Rate'};{'Duration'}] num2cell([hfos_cortex;hfos_cortex_rate;hfos_cortex_duration])];
%     TT.Variables=    [[{'Count'};{'Rate'};{'Duration'}] num2cell([hfos_hpc;hfos_hpc_rate;hfos_hpc_duration])];
    
    TT.Properties.VariableNames=['Metric';cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)].';
    
%     if strcmp(xx{1},'HPC')
%             writetable(TT,strcat(xx{1},'_',num2str(tr(1)),'.xls'),'Sheet',1,'Range','A2:L6')    
%     else
            writetable(TT,strcat(xx{1},'_',num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:L6')    
%     end

%HPC
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,hfos_hpc)
ylabel('Number of HFOs')
title('HPC')

    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
%         if strcmp(xx{1},'HPC')
%                   string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         else
                  string=strcat('HFOs_counts_','HPC','_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         end
    end

    printing(string)
    close all
%rate
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,hfos_hpc_rate)
ylabel('HFOs per second')
title('HPC')


    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('HFOs_rate_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
%         if strcmp(xx{1},'HPC')
%                   string=strcat('HFOs_rate_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         else
                  string=strcat('HFOs_rate_','HPC','_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         end
        
    end

    printing(string)
    close all
%    xo
    TT=table;
    TT.Variables=    [[{'Count'};{'Rate'};{'Duration'}] num2cell([hfos_hpc;hfos_hpc_rate;hfos_hpc_duration])];
%    TT.Properties.VariableNames=['Metric';g];
    TT.Properties.VariableNames=['Metric';cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)].';
    
%     if strcmp(xx{1},'HPC')
%             writetable(TT,strcat(xx{1},'_',num2str(tr(1)),'.xls'),'Sheet',1,'Range','A2:L6')    
%     else
            writetable(TT,strcat('HPC','_',num2str(tr(1)),'.xls'),'Sheet',1,'Range','A2:L6')    
%     end


%COHFOS
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,cohfos_count)
ylabel('Number of coHFOs')
title('Both areas')

    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('coHFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
%         if strcmp(xx{1},'HPC')
%                   string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         else
                  string=strcat('coHFOs_counts_','Rat',num2str(Rat),'_',num2str(tr(1)),'_',num2str(tr(2)));         
%         end
    end

    printing(string)
    close all
    
    
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,cohfos_rate)
ylabel('coHFOs per second')
title('Both areas')    

    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('coHFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
%         if strcmp(xx{1},'HPC')
%                   string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         else
                  string=strcat('coHFOs_rate_','Rat',num2str(Rat),'_',num2str(tr(1)),'_',num2str(tr(2)));         
%         end
    end

    printing(string)
    close all

    TT=table;
    TT.Variables=    [[{'Count'};{'Rate'}] num2cell([cohfos_count;cohfos_rate;])];
    TT.Properties.VariableNames=['Metric';g];    
    writetable(TT,strcat('coHFOs_',num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:L6')    
    


    if size(label1,1)==3 %If Plusmaze
%        xo
        break;
    end
%xo       
end