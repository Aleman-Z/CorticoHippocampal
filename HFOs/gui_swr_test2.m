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
    for k=8:length(g)
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
% xo
[ripple,RipFreq,rip_duration,Mx_cortex,timeasleep,sig_cortex,Ex_cortex,Sx_cortex]=gui_findripples(CORTEX,states,xx,tr);
si=sig_cortex(~cellfun('isempty',sig_cortex));
si=[si{:}];
%xo
% plot_hfo(si,Mx_cortex,Sx_cortex,label1{2})
% title(['HFO Cortex  ' strrep(g{k},'_','-')])
% cd ..
% printing(['HFO Cortex  ' strrep(g{k},'_','-')])
% close all
% cd(g{k})


[x,y,z,~,~,~,l]=hfo_specs(si,timeasleep);
fi_cortex(k)=x;
fa_cortex(k)=y;
amp_cortex(k)=z;
auc_cortex(k)=l;
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

[ripple,RipFreq,rip_duration,Mx_hpc,timeasleep,sig_hpc,Ex_hpc,Sx_hpc]=gui_findripples(HPC,states,{'HPC'},tr);

si=sig_hpc(~cellfun('isempty',sig_hpc));
si=[si{:}];

% plot_hfo(si,Mx_hpc,Sx_hpc,label1{1})
% title(['HFO HPC  ' strrep(g{k},'_','-')])
% cd ..
% printing(['HFO HPC  ' strrep(g{k},'_','-')])
% close all
% cd(g{k})

[x,y,z,~,~,~,l]=hfo_specs(si,timeasleep);
fi_hpc(k)=x;
fa_hpc(k)=y;
amp_hpc(k)=z;
auc_hpc(k)=l;
% %Instantaneous frequency.
% x=cellfun(@(equis) mean(instfreq(equis,1000)) ,si,'UniformOutput',false);
% x=cell2mat(x);
% x=median(x);
% fi_hpc(k)=x;
% %Average frequency
% y=cellfun(@(equis) (meanfreq(equis,1000)) ,si,'UniformOutput',false);
% y=cell2mat(y);
% y=median(y);
% fa_hpc(k)=y;
% 
% %Amplitude
% z=cellfun(@(equis) max(abs(hilbert(equis))) ,si,'UniformOutput',false);
% z=cell2mat(z);
% z=median(z);
% amp_hpc(k)=z;

%% HFC HFOs
hfos_hpc(k)=ripple;
hfos_hpc_rate(k)=RipFreq;
hfos_hpc_duration(k)=rip_duration;

%% Coocurent hfos
[cohfos1,cohfos2]=cellfun(@(equis1,equis2) co_hfo(equis1,equis2),Mx_hpc,Mx_cortex,'UniformOutput',false);
%cohfos1: HPC.
%cohfos2: Cortex.
%Common values:
cohfos_count(k)=sum(cellfun('length',cohfos1));
cohfos_rate(k)=sum(cellfun('length',cohfos1))/(timeasleep*(60));

%HPC COHFOS
cohf_mx_hpc=Mx_hpc(~cellfun('isempty',cohfos1));%Peak values cells where HPC cohfos were found.
cohf_sx_hpc=Sx_hpc(~cellfun('isempty',cohfos1));%Peak values cells where HPC cohfos were found.
cohf_ex_hpc=Ex_hpc(~cellfun('isempty',cohfos1));%Peak values cells where HPC cohfos were found.

Cohfos1=cohfos1(~cellfun('isempty',cohfos1));

%Locate sample per cohfos
coh_samp_hpc= cellfun(@(equis1,equis2) co_hfo_get_sample(equis1,equis2),cohf_mx_hpc,Cohfos1,'UniformOutput',false);

cohf_sx_hpc_val=cellfun(@(equis1,equis2) equis1(equis2),cohf_sx_hpc,coh_samp_hpc,'UniformOutput',false);
cohf_sx_hpc_val=[cohf_sx_hpc_val{:}];

cohf_mx_hpc_val=cellfun(@(equis1,equis2) equis1(equis2),cohf_mx_hpc,coh_samp_hpc,'UniformOutput',false);
cohf_mx_hpc_val=[cohf_mx_hpc_val{:}];

cohf_ex_hpc_val=cellfun(@(equis1,equis2) equis1(equis2),cohf_ex_hpc,coh_samp_hpc,'UniformOutput',false);
cohf_ex_hpc_val=[cohf_ex_hpc_val{:}];

cohf_hpc_dura=cohf_ex_hpc_val-cohf_sx_hpc_val;
cohf_hpc_dura=median(cohf_hpc_dura);
Cohf_hpc_dura(k)=cohf_hpc_dura;
%xo
Sig_hpc=sig_hpc(~cellfun('isempty',cohfos1));
Sig_hpc=cellfun(@(equis1,equis2) equis1(equis2),Sig_hpc,coh_samp_hpc,'UniformOutput',false);
Sig_hpc=[Sig_hpc{:}];
%xo

plot_hfo(Sig_hpc,{cohf_mx_hpc_val},{cohf_sx_hpc_val},label1{1})
title(['coHFO HPC envelope  ' strrep(g{k},'_','-')])
cd ..
printing(['coHFO HPC envelope ' strrep(g{k},'_','-')])
close all
cd(g{k})



[x,y,z,w,h,q,l]=hfo_specs(Sig_hpc,timeasleep);
fi_cohfo_hpc(k)=x;
fa_cohfo_hpc(k)=y;
amp_cohfo_hpc(k)=z;
count_cohfo_hpc(k)=w;
rate_cohfo_hpc(k)=h;
dura_cohfo_hpc(k)=q;
auc_cohfo_hpc(k)=l;
%Single HFOs HPC
%[v2]=single_hfo_get_sample(Mx_hpc{1},cohfos1{1});
v2=cellfun(@(equis1,equis2) single_hfo_get_sample(equis1,equis2),Mx_hpc,cohfos1,'UniformOutput',false);

Sig_hpc_single=cellfun(@(equis1,equis2) equis1(equis2),sig_hpc,v2,'UniformOutput',false);
Sig_hpc_single=[Sig_hpc_single{:}];


[single_mx_hpc_val,single_sx_hpc_val]=cellfun(@(equis1,equis2,equis3) single_hfos_mx(equis1,equis2,equis3),cohfos1,Mx_hpc,Sx_hpc,'UniformOutput',false);
single_mx_hpc_val=[single_mx_hpc_val{:}];
single_sx_hpc_val=[single_sx_hpc_val{:}];
% xo


plot_hfo(Sig_hpc_single,{single_mx_hpc_val},{single_sx_hpc_val},label1{1})
title(['Single HPC envelope ' strrep(g{k},'_','-')])
cd ..
printing(['Single HPC envelope ' strrep(g{k},'_','-')])
close all
cd(g{k})

[x,y,z,w,h,q,l]=hfo_specs(Sig_hpc_single,timeasleep);
fi_single_hpc(k)=x;
fa_single_hpc(k)=y;
amp_single_hpc(k)=z;
count_single_hpc(k)=w;
rate_single_hpc(k)=h;
dura_single_hpc(k)=q;
auc_single_hpc(k)=l;


%%%%
%Cortical COHFOS
cohf_mx_cortex=Mx_cortex(~cellfun('isempty',cohfos2));%Peak values cells where cortex cohfos were found.
cohf_sx_cortex=Sx_cortex(~cellfun('isempty',cohfos2));%Peak values cells where cortex cohfos were found.
cohf_ex_cortex=Ex_cortex(~cellfun('isempty',cohfos2));%Peak values cells where cortex cohfos were found.

Cohfos2=cohfos2(~cellfun('isempty',cohfos2));

%Locate sample per cohfos
coh_samp_cortex= cellfun(@(equis1,equis2) co_hfo_get_sample(equis1,equis2),cohf_mx_cortex,Cohfos2,'UniformOutput',false);
cohf_sx_cortex_val=cellfun(@(equis1,equis2) equis1(equis2),cohf_sx_cortex,coh_samp_cortex,'UniformOutput',false);
cohf_sx_cortex_val=[cohf_sx_cortex_val{:}];

cohf_mx_cortex_val=cellfun(@(equis1,equis2) equis1(equis2),cohf_mx_cortex,coh_samp_cortex,'UniformOutput',false);
cohf_mx_cortex_val=[cohf_mx_cortex_val{:}];

cohf_ex_cortex_val=cellfun(@(equis1,equis2) equis1(equis2),cohf_ex_cortex,coh_samp_cortex,'UniformOutput',false);
cohf_ex_cortex_val=[cohf_ex_cortex_val{:}];
cohf_cortex_dura=cohf_ex_cortex_val-cohf_sx_cortex_val;
cohf_cortex_dura=median(cohf_cortex_dura);
Cohf_cortex_dura(k)=cohf_cortex_dura;

Sig_cortex=sig_cortex(~cellfun('isempty',cohfos2));
Sig_cortex=cellfun(@(equis1,equis2) equis1(equis2),Sig_cortex,coh_samp_cortex,'UniformOutput',false);
Sig_cortex=[Sig_cortex{:}];
% xo

plot_hfo(Sig_cortex,{cohf_mx_cortex_val},{cohf_sx_cortex_val},label1{2})
title(['coHFO cortex envelope ' strrep(g{k},'_','-')])
cd ..
printing(['coHFO cortex envelope ' strrep(g{k},'_','-')])
close all
cd(g{k})


[x,y,z,w,h,q,l]=hfo_specs(Sig_cortex,timeasleep);
fi_cohfo_cortex(k)=x;
fa_cohfo_cortex(k)=y;
amp_cohfo_cortex(k)=z;
count_cohfo_cortex(k)=w;
rate_cohfo_cortex(k)=h;
dura_cohfo_cortex(k)=q;
auc_cohfo_cortex(k)=l;

%Single HFOs Cortex
%[v2]=single_hfo_get_sample(Mx_hpc{1},cohfos1{1});
v2=cellfun(@(equis1,equis2) single_hfo_get_sample(equis1,equis2),Mx_cortex,cohfos2,'UniformOutput',false);

Sig_cortex_single=cellfun(@(equis1,equis2) equis1(equis2),sig_cortex,v2,'UniformOutput',false);
Sig_cortex_single=[Sig_cortex_single{:}];
%xo
[single_mx_cortex_val,single_sx_cortex_val]=cellfun(@(equis1,equis2,equis3) single_hfos_mx(equis1,equis2,equis3),cohfos2,Mx_cortex,Sx_cortex,'UniformOutput',false);
single_mx_cortex_val=[single_mx_cortex_val{:}];
single_sx_cortex_val=[single_sx_cortex_val{:}];



plot_hfo(Sig_cortex_single,{single_mx_cortex_val},{single_sx_cortex_val},label1{2})
title(['Single cortex envelope ' strrep(g{k},'_','-')])
cd ..
printing(['Single cortex envelope ' strrep(g{k},'_','-')])
close all
cd(g{k})

[x,y,z,w,h,q,l]=hfo_specs(Sig_cortex_single,timeasleep);
fi_single_cortex(k)=x;
fa_single_cortex(k)=y;
amp_single_cortex(k)=z;
count_single_cortex(k)=w;
rate_single_cortex(k)=h;
dura_single_cortex(k)=q;
auc_single_cortex(k)=l;
% xo
progress_bar(k,length(g),f)
    cd ..    
    end
xo

%AUC
TT=table;
TT.Variables=    [[{'All_cortex'};{'All_HPC'};{'Cohfo_cortex'};{'Cohfo_hpc'};{'Single_cortex'};{'Single_HPC'}] num2cell([auc_cortex;auc_hpc;auc_cohfo_cortex;auc_cohfo_hpc;auc_single_cortex;auc_single_hpc])];
TT.Properties.VariableNames=['HFO Type';cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)].';
writetable(TT,strcat('AUC_',num2str(tr(1)),'_',num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:L10')    
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
    
%Average Frequency
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,fa_cortex)
ylabel('Average frequency')
title(xx{1})
ylim([100 300])

    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
%         if strcmp(xx{1},'HPC')
%                   string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         else
                  string=strcat('HFOs_average_frequency_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(2)));         
%         end
    end

    printing(string)
    close all
    
%Instantaneous Frequency
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,fi_cortex)
ylabel('Average instantaneous frequency')
title(xx{1})
ylim([100 300])

    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
%         if strcmp(xx{1},'HPC')
%                   string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         else
                  string=strcat('HFOs_instantaneous_frequency_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(2)));         
%         end
    end

    printing(string)
    close all
    
%Amplitude    
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,amp_cortex)
ylabel('Amplitude (uV)')
title(xx{1})
%ylim([100 300])

    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
%         if strcmp(xx{1},'HPC')
%                   string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         else
                  string=strcat('HFOs_amplitude_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(2)));         
%         end
    end

    printing(string)
    close all
    
    
%     xo
    TT=table;
    TT.Variables=    [[{'Count'};{'Rate'};{'Duration'};{'Average Frequency'};{'Instantaneous Frequency'};{'Amplitude'}] num2cell([hfos_cortex;hfos_cortex_rate;hfos_cortex_duration;fa_cortex;fi_cortex; amp_cortex])];
%     TT.Variables=    [[{'Count'};{'Rate'};{'Duration'}] num2cell([hfos_hpc;hfos_hpc_rate;hfos_hpc_duration])];
    
    TT.Properties.VariableNames=['Metric';cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)].';
    
%     if strcmp(xx{1},'HPC')
%             writetable(TT,strcat(xx{1},'_',num2str(tr(1)),'.xls'),'Sheet',1,'Range','A2:L6')    
%     else
            writetable(TT,strcat(xx{1},'_',num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:L10')    
%     end
%%
%Cortex cohfos
    TT=table;
    TT.Variables=    [[{'Count'};{'Rate'};{'Duration'};{'Average Frequency'};{'Instantaneous Frequency'};{'Amplitude'}] num2cell([count_cohfo_cortex;rate_cohfo_cortex;dura_cohfo_cortex;fa_cohfo_cortex;fi_cohfo_cortex; amp_cohfo_cortex])];
%     TT.Variables=    [[{'Count'};{'Rate'};{'Duration'}] num2cell([hfos_hpc;hfos_hpc_rate;hfos_hpc_duration])];
    
    TT.Properties.VariableNames=['Metric';cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)].';
    
%     if strcmp(xx{1},'HPC')
%             writetable(TT,strcat(xx{1},'_',num2str(tr(1)),'.xls'),'Sheet',1,'Range','A2:L6')    
%     else
            writetable(TT,strcat(xx{1},'_',num2str(tr(2)),'_cohfos','.xls'),'Sheet',1,'Range','A2:L10')    

%Cortex singles
    TT=table;
    TT.Variables=    [[{'Count'};{'Rate'};{'Duration'};{'Average Frequency'};{'Instantaneous Frequency'};{'Amplitude'}] num2cell([count_single_cortex;rate_single_cortex;dura_single_cortex;fa_single_cortex;fi_single_cortex; amp_single_cortex])];
%     TT.Variables=    [[{'Count'};{'Rate'};{'Duration'}] num2cell([hfos_hpc;hfos_hpc_rate;hfos_hpc_duration])];
    
    TT.Properties.VariableNames=['Metric';cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)].';
    
%     if strcmp(xx{1},'HPC')
%             writetable(TT,strcat(xx{1},'_',num2str(tr(1)),'.xls'),'Sheet',1,'Range','A2:L6')    
%     else
            writetable(TT,strcat(xx{1},'_',num2str(tr(2)),'_singles','.xls'),'Sheet',1,'Range','A2:L10')    

  %%          

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


%Average Frequency
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,fa_hpc)
ylabel('Average frequency')
title('HPC')
ylim([100 300])

    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
%         if strcmp(xx{1},'HPC')
%                   string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         else
                  string=strcat('HFOs_average_frequency_','HPC','_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         end
    end

    printing(string)
    close all
    
%Instantaneous Frequency
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,fi_hpc)
ylabel('Average instantaneous frequency')
title('HPC')
ylim([100 300])

    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
%         if strcmp(xx{1},'HPC')
%                   string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         else
                  string=strcat('HFOs_instantaneous_frequency_','HPC','_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         end
    end

    printing(string)
    close all

%Amplitude    
c = categorical(cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)); 
bar(c,amp_hpc)
ylabel('Amplitude (uV)')
title('HPC')
%ylim([100 300])

    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
%         if strcmp(xx{1},'HPC')
%                   string=strcat('HFOs_counts_',xx{1},'_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         else
                  string=strcat('HFOs_amplitude_','HPC','_Rat',num2str(Rat),'_',num2str(tr(1)));         
%         end
    end

    printing(string)
    close all


    TT=table;
    TT.Variables=    [[{'Count'};{'Rate'};{'Duration'};{'Average Frequency'};{'Instantaneous Frequency'};{'Amplitude'}] num2cell([hfos_hpc;hfos_hpc_rate;hfos_hpc_duration;fa_hpc;fi_hpc;amp_hpc])];        
%    TT.Properties.VariableNames=['Metric';g];
    TT.Properties.VariableNames=['Metric';cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)].';
    
%     if strcmp(xx{1},'HPC')
%             writetable(TT,strcat(xx{1},'_',num2str(tr(1)),'.xls'),'Sheet',1,'Range','A2:L6')    
%     else
            writetable(TT,strcat('HPC','_',num2str(tr(1)),'.xls'),'Sheet',1,'Range','A2:L10')    
%     end
%%
%hpc cohfos
    TT=table;
    TT.Variables=    [[{'Count'};{'Rate'};{'Duration'};{'Average Frequency'};{'Instantaneous Frequency'};{'Amplitude'}] num2cell([count_cohfo_hpc;rate_cohfo_hpc;dura_cohfo_hpc;fa_cohfo_hpc;fi_cohfo_hpc; amp_cohfo_hpc])];
%     TT.Variables=    [[{'Count'};{'Rate'};{'Duration'}] num2cell([hfos_hpc;hfos_hpc_rate;hfos_hpc_duration])];
    
    TT.Properties.VariableNames=['Metric';cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)].';
    
%     if strcmp(xx{1},'HPC')
%             writetable(TT,strcat(xx{1},'_',num2str(tr(1)),'.xls'),'Sheet',1,'Range','A2:L6')    
%     else
            writetable(TT,strcat('HPC','_',num2str(tr(1)),'_',num2str(tr(2)),'_cohfos','.xls'),'Sheet',1,'Range','A2:L10')    

%hpc singles
    TT=table;
    TT.Variables=    [[{'Count'};{'Rate'};{'Duration'};{'Average Frequency'};{'Instantaneous Frequency'};{'Amplitude'}] num2cell([count_single_hpc;rate_single_hpc;dura_single_hpc;fa_single_hpc;fi_single_hpc; amp_single_hpc])];
%     TT.Variables=    [[{'Count'};{'Rate'};{'Duration'}] num2cell([hfos_hpc;hfos_hpc_rate;hfos_hpc_duration])];
    
    TT.Properties.VariableNames=['Metric';cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false)].';
    
%     if strcmp(xx{1},'HPC')
%             writetable(TT,strcat(xx{1},'_',num2str(tr(1)),'.xls'),'Sheet',1,'Range','A2:L6')    
%     else
            writetable(TT,strcat('HPC','_',num2str(tr(1)),'_',num2str(tr(2)),'_singles','.xls'),'Sheet',1,'Range','A2:L10')    



%%
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