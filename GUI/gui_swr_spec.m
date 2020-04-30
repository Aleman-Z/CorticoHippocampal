%gui_threshold_ripples
%% Find location
close all
dname=uigetdir([],'Select folder with Matlab data containing all rats.');
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

multiplets=[{'singlets'} {'doublets'} {'triplets'} {'quatruplets'} {'pentuplets'} {'sextuplets'} {'septuplets'} {'octuplets'} {'nonuplets'}];
%%
iii=1;
%for iii=1:length(labelconditions) 

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
fn=1000; %Sampling frequency after downsampling.
%%
    %Center figure.
    f=figure();
    movegui(gcf,'center');

    %Checkboxes
    Boxcheck = cell(1,4);
    for h1=1:length(labelconditions)
    boxcheck = uicontrol(f,'Style','checkbox','String',labelconditions{h1},'Position',[10 f.Position(4)-30*h1 400 20]);
    boxcheck.FontSize=11;
    boxcheck.Value=1;
    Boxcheck{h1}=boxcheck;   
    end

    set(f, 'NumberTitle', 'off', ...
        'Name', 'Select conditions');

    %Push button
    c = uicontrol;
    c.String = 'Continue';
    c.FontSize=10;
    c.Position=[f.Position(1)/3.5 c.Position(2)-10 f.Position(3)/2 c.Position(4)];

    %Callback
    c.Callback='uiresume(gcbf)';
    uiwait(gcf); 
    boxch=cellfun(@(x) get(x,'Value'),Boxcheck);
    clear Boxcheck
%     labelconditions=labelconditions(find(boxch~=0));
%     labelconditions2=labelconditions2(find(boxch~=0));
% xo
    close(f);
g={g{logical(boxch)}};    

if sum(cell2mat(cellfun(@(equis1) contains(equis1,'nl'),g,'UniformOutput',false)))==1
%     if  find(cell2mat(cellfun(@(equis1) contains(equis1,'nl'),g,'UniformOutput',false))==1)~=1
%         g=flip(g);
%     end
g=g([find(cell2mat(cellfun(@(equis1) contains(equis1,labelconditions2{1}),g,'UniformOutput',false)))...
 find(cell2mat(cellfun(@(equis1) contains(equis1,labelconditions2{2}),g,'UniformOutput',false)))...
 find(cell2mat(cellfun(@(equis1) contains(equis1,labelconditions2{3}),g,'UniformOutput',false)))...
 find(cell2mat(cellfun(@(equis1) contains(equis1,labelconditions2{4}),g,'UniformOutput',false)))]);

else
    error('Name issue')
end

%%
f=waitbar(0,'Please wait...');
    for k=1:length(g)
        cd(g{k})
% Load signals
CORTEX=dir(strcat('*',xx{1},'*.mat'));
if isempty(CORTEX)
    g=g(~contains(g,g{k}));
    cd ..
    progress_bar(k,length(g),f)
    break
end

%PARIETAL
CORTEX=CORTEX.name;
CORTEX=load(CORTEX);
%CORTEX=CORTEX.CORTEX;
CORTEX=getfield(CORTEX,xx{1});
CORTEX=CORTEX.*(0.195);

%HPC
HPC=dir(strcat('*','HPC','*.mat'));
HPC=HPC.name;
HPC=load(HPC);
%HPC=HPC.HPC;
HPC=getfield(HPC,'HPC');
HPC=HPC.*(0.195);

%PFC
PFC=dir(strcat('*','PFC','*.mat'));
PFC=PFC.name;
PFC=load(PFC);
%PFC=PFC.PFC;
PFC=getfield(PFC,'PFC');
PFC=PFC.*(0.195);



A = dir('*states*.mat');
A={A.name};

if  ~isempty(A)
       cellfun(@load,A);
else
      error('No Scoring found')    
end
 %xo
[ripple,RipFreq,rip_duration,Mx_cortex,timeasleep,sig_cortex,Ex_cortex,Sx_cortex,...
  p_cortex,q_cortex,cont_cortex ...
  ]=gui_findripples_spec(CORTEX,states,xx,tr,PFC,HPC,fn);


si=sig_cortex(~cellfun('isempty',sig_cortex));
si=[si{:}];

%% HPC     

[ripple,RipFreq,rip_duration,Mx_hpc,timeasleep,sig_hpc,Ex_hpc,Sx_hpc,...
  p_hpc,q_hpc,cont_hpc ...
]=gui_findripples_spec(HPC,states,{'HPC'},tr,PFC,CORTEX,fn);

si=sig_hpc(~cellfun('isempty',sig_hpc));
si=[si{:}];

%% Coocurent hfos
[cohfos1,cohfos2]=cellfun(@(equis1,equis2) co_hfo(equis1,equis2),Mx_hpc,Mx_cortex,'UniformOutput',false);
%cohfos1: HPC.
%cohfos2: Cortex.

%%

%HPC COHFOS
cohf_mx_hpc=Mx_hpc(~cellfun('isempty',cohfos1));%Peak values cells where HPC cohfos were found.
cohf_sx_hpc=Sx_hpc(~cellfun('isempty',cohfos1));%Start values cells where HPC cohfos were found.
cohf_ex_hpc=Ex_hpc(~cellfun('isempty',cohfos1));%End values cells where HPC cohfos were found.

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

%COHFOS windows
p_cohfos_hpc=p_hpc(~cellfun('isempty',cohfos1));
p_cohfos_hpc=cellfun(@(equis1,equis2) equis1(equis2),p_cohfos_hpc,coh_samp_hpc,'UniformOutput',false);
p_cohfos_hpc=[p_cohfos_hpc{:}];
q_cohfos_hpc=q_hpc(~cellfun('isempty',cohfos1));
q_cohfos_hpc=cellfun(@(equis1,equis2) equis1(equis2),q_cohfos_hpc,coh_samp_hpc,'UniformOutput',false);
q_cohfos_hpc=[q_cohfos_hpc{:}];
p_cohfos_hpc=p_cohfos_hpc(~cellfun('isempty',p_cohfos_hpc));
q_cohfos_hpc=q_cohfos_hpc(~cellfun('isempty',q_cohfos_hpc));



%Single HFOs HPC
%[v2]=single_hfo_get_sample(Mx_hpc{1},cohfos1{1});
v2=cellfun(@(equis1,equis2) single_hfo_get_sample(equis1,equis2),Mx_hpc,cohfos1,'UniformOutput',false);

Sig_hpc_single=cellfun(@(equis1,equis2) equis1(equis2),sig_hpc,v2,'UniformOutput',false);
Sig_hpc_single=[Sig_hpc_single{:}];

%single windows
p_single_hpc=cellfun(@(equis1,equis2) equis1(equis2),p_hpc,v2,'UniformOutput',false);
p_single_hpc=[p_single_hpc{:}];
q_single_hpc=cellfun(@(equis1,equis2) equis1(equis2),q_hpc,v2,'UniformOutput',false);
q_single_hpc=[q_single_hpc{:}];
p_single_hpc=p_single_hpc(~cellfun('isempty',p_single_hpc));
q_single_hpc=q_single_hpc(~cellfun('isempty',q_single_hpc));


[single_mx_hpc_val,single_sx_hpc_val]=cellfun(@(equis1,equis2,equis3) single_hfos_mx(equis1,equis2,equis3),cohfos1,Mx_hpc,Sx_hpc,'UniformOutput',false);
single_mx_hpc_val=[single_mx_hpc_val{:}];
single_sx_hpc_val=[single_sx_hpc_val{:}];
% xo


%%%%
%Cortical COHFOS
cohf_mx_cortex=Mx_cortex(~cellfun('isempty',cohfos2));%Peak values cells where cortex cohfos were found.
cohf_sx_cortex=Sx_cortex(~cellfun('isempty',cohfos2));%Start values cells where cortex cohfos were found.
cohf_ex_cortex=Ex_cortex(~cellfun('isempty',cohfos2));%End values cells where cortex cohfos were found.

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

%COHFOS windows
p_cohfos_cortex=p_cortex(~cellfun('isempty',cohfos2));
p_cohfos_cortex=cellfun(@(equis1,equis2) equis1(equis2),p_cohfos_cortex,coh_samp_cortex,'UniformOutput',false);
p_cohfos_cortex=[p_cohfos_cortex{:}];
q_cohfos_cortex=q_cortex(~cellfun('isempty',cohfos2));
q_cohfos_cortex=cellfun(@(equis1,equis2) equis1(equis2),q_cohfos_cortex,coh_samp_cortex,'UniformOutput',false);
q_cohfos_cortex=[q_cohfos_cortex{:}];
p_cohfos_cortex=p_cohfos_cortex(~cellfun('isempty',p_cohfos_cortex));
q_cohfos_cortex=q_cohfos_cortex(~cellfun('isempty',q_cohfos_cortex));

%Single HFOs Cortex
%[v2]=single_hfo_get_sample(Mx_hpc{1},cohfos1{1});
v2=cellfun(@(equis1,equis2) single_hfo_get_sample(equis1,equis2),Mx_cortex,cohfos2,'UniformOutput',false);

Sig_cortex_single=cellfun(@(equis1,equis2) equis1(equis2),sig_cortex,v2,'UniformOutput',false);
Sig_cortex_single=[Sig_cortex_single{:}];

%Single cortex windows
p_single_cortex=cellfun(@(equis1,equis2) equis1(equis2),p_cortex,v2,'UniformOutput',false);
p_single_cortex=[p_single_cortex{:}];
q_single_cortex=cellfun(@(equis1,equis2) equis1(equis2),q_cortex,v2,'UniformOutput',false);
q_single_cortex=[q_single_cortex{:}];
p_single_cortex=p_single_cortex(~cellfun('isempty',p_single_cortex));
q_single_cortex=q_single_cortex(~cellfun('isempty',q_single_cortex));


%xo
[single_mx_cortex_val,single_sx_cortex_val]=cellfun(@(equis1,equis2,equis3) single_hfos_mx(equis1,equis2,equis3),cohfos2,Mx_cortex,Sx_cortex,'UniformOutput',false);
single_mx_cortex_val=[single_mx_cortex_val{:}];
single_sx_cortex_val=[single_sx_cortex_val{:}];


 p_hpc=p_hpc(~cellfun('isempty',p_hpc));
 p_hpc=[p_hpc{:}];
 q_hpc=q_hpc(~cellfun('isempty',q_hpc));
 q_hpc=[q_hpc{:}];
 p_hpc=p_hpc(~cellfun('isempty',p_hpc));
 q_hpc=q_hpc(~cellfun('isempty',q_hpc));
 
  p_cortex=p_cortex(~cellfun('isempty',p_cortex));
 p_cortex=[p_cortex{:}];
 q_cortex=q_cortex(~cellfun('isempty',q_cortex));
 q_cortex=[q_cortex{:}];
 p_cortex=p_cortex(~cellfun('isempty',p_cortex));
 q_cortex=q_cortex(~cellfun('isempty',q_cortex));


%  if k==1 %No Learning
%      P.nl.('hpc')={p_hpc;p_cohfos_hpc;p_single_hpc};
%      P.nl.('pfc')={p_cortex;p_cohfos_cortex;p_single_cortex};
%     
%      Q.nl.('hpc')={q_hpc;q_cohfos_hpc;q_single_hpc};
%      Q.nl.('pfc')={q_cortex;q_cohfos_cortex;q_single_cortex};
%      
%  else
%      P.plusmaze.('hpc')={p_hpc;p_cohfos_hpc;p_single_hpc};
%      P.plusmaze.('pfc')={p_cortex;p_cohfos_cortex;p_single_cortex};
%     
%      Q.plusmaze.('hpc')={q_hpc;q_cohfos_hpc;q_single_hpc};
%      Q.plusmaze.('pfc')={q_cortex;q_cohfos_cortex;q_single_cortex};
%  end
%      P.(strrep(labelconditions2{k},'-','_')).(label1{1})={p_hpc;p_cohfos_hpc;p_single_hpc};
%      P.(strrep(labelconditions2{k},'-','_')).(label1{3})={p_cortex;p_cohfos_cortex;p_single_cortex};
%     
%      Q.(strrep(labelconditions2{k},'-','_')).(label1{1})={q_hpc;q_cohfos_hpc;q_single_hpc};
%      Q.(strrep(labelconditions2{k},'-','_')).(label1{3})={q_cortex;q_cohfos_cortex;q_single_cortex};
     P.(strrep(labelconditions2{k},'-','_')).(label1{1})={p_cohfos_hpc;p_single_hpc;p_hpc};
     P.(strrep(labelconditions2{k},'-','_')).(label1{3})={p_cohfos_cortex;p_single_cortex;p_cortex};
    
     Q.(strrep(labelconditions2{k},'-','_')).(label1{1})={q_cohfos_hpc;q_single_hpc;q_hpc};
     Q.(strrep(labelconditions2{k},'-','_')).(label1{3})={q_cohfos_cortex;q_single_cortex;q_cortex};
     
 %xo
progress_bar(k,length(g),f)
    cd ..    
    end
 xo
%% 
% GET ALL RIPPLES.
win_size=50;
%HPC COHFOS
s=1;
w=1;
[values_spec,n1]=getval_spectra_All(P,Q,labelconditions2,label1,s,w,win_size);
TT=table;
% TT.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl values_spec.plusmaze values_spec.novelty values_spec.for])];
% TT.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'PFC Baseline'};{'PAR Baseline'};{'HPC Plusmaze'};{'PFC Plusmaze'};{'PAR Plusmaze'};{'HPC Novelty'};{'PFC Novelty'};{'PAR Novelty'};{'HPC Foraging'};{'PFC Foraging'};{'PAR Foraging'}];    
TT.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl(:,1) values_spec.plusmaze(:,1) values_spec.novelty(:,1) values_spec.for(:,1) values_spec.nl(:,2) values_spec.plusmaze(:,2) values_spec.novelty(:,2) values_spec.for(:,2) values_spec.nl(:,3) values_spec.plusmaze(:,3) values_spec.novelty(:,3) values_spec.for(:,3)])];
TT.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'HPC Plusmaze'};{'HPC Novelty'};{'HPC Foraging'};{'PFC Baseline'};{'PFC Plusmaze'};{'PFC Novelty'};{'PFC Foraging'};{'PAR Baseline'};{'PAR Plusmaze'};{'PAR Novelty'};{'PAR Foraging'}];    

% % %PAR COHFOS
s=1;
w=3;
[values_spec,n2]=getval_spectra_All(P,Q,labelconditions2,label1,s,w,win_size);
TT1=table;
% TT1.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl values_spec.plusmaze values_spec.novelty values_spec.for])];
% TT1.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'PFC Baseline'};{'PAR Baseline'};{'HPC Plusmaze'};{'PFC Plusmaze'};{'PAR Plusmaze'};{'HPC Novelty'};{'PFC Novelty'};{'PAR Novelty'};{'HPC Foraging'};{'PFC Foraging'};{'PAR Foraging'}];    
TT1.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl(:,1) values_spec.plusmaze(:,1) values_spec.novelty(:,1) values_spec.for(:,1) values_spec.nl(:,2) values_spec.plusmaze(:,2) values_spec.novelty(:,2) values_spec.for(:,2) values_spec.nl(:,3) values_spec.plusmaze(:,3) values_spec.novelty(:,3) values_spec.for(:,3)])];
TT1.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'HPC Plusmaze'};{'HPC Novelty'};{'HPC Foraging'};{'PFC Baseline'};{'PFC Plusmaze'};{'PFC Novelty'};{'PFC Foraging'};{'PAR Baseline'};{'PAR Plusmaze'};{'PAR Novelty'};{'PAR Foraging'}];    

%HPC singles
s=2;
w=1;
[values_spec,n3]=getval_spectra_All(P,Q,labelconditions2,label1,s,w,win_size);
TT2=table;
% TT2.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl values_spec.plusmaze values_spec.novelty values_spec.for])];
% TT2.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'PFC Baseline'};{'PAR Baseline'};{'HPC Plusmaze'};{'PFC Plusmaze'};{'PAR Plusmaze'};{'HPC Novelty'};{'PFC Novelty'};{'PAR Novelty'};{'HPC Foraging'};{'PFC Foraging'};{'PAR Foraging'}];    
TT2.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl(:,1) values_spec.plusmaze(:,1) values_spec.novelty(:,1) values_spec.for(:,1) values_spec.nl(:,2) values_spec.plusmaze(:,2) values_spec.novelty(:,2) values_spec.for(:,2) values_spec.nl(:,3) values_spec.plusmaze(:,3) values_spec.novelty(:,3) values_spec.for(:,3)])];
TT2.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'HPC Plusmaze'};{'HPC Novelty'};{'HPC Foraging'};{'PFC Baseline'};{'PFC Plusmaze'};{'PFC Novelty'};{'PFC Foraging'};{'PAR Baseline'};{'PAR Plusmaze'};{'PAR Novelty'};{'PAR Foraging'}];    

%PAR singles
s=2;
w=3;
[values_spec,n4]=getval_spectra_All(P,Q,labelconditions2,label1,s,w,win_size);
TT3=table;
% TT3.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl values_spec.plusmaze values_spec.novelty values_spec.for])];
% TT3.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'PFC Baseline'};{'PAR Baseline'};{'HPC Plusmaze'};{'PFC Plusmaze'};{'PAR Plusmaze'};{'HPC Novelty'};{'PFC Novelty'};{'PAR Novelty'};{'HPC Foraging'};{'PFC Foraging'};{'PAR Foraging'}];    
TT3.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl(:,1) values_spec.plusmaze(:,1) values_spec.novelty(:,1) values_spec.for(:,1) values_spec.nl(:,2) values_spec.plusmaze(:,2) values_spec.novelty(:,2) values_spec.for(:,2) values_spec.nl(:,3) values_spec.plusmaze(:,3) values_spec.novelty(:,3) values_spec.for(:,3)])];
TT3.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'HPC Plusmaze'};{'HPC Novelty'};{'HPC Foraging'};{'PFC Baseline'};{'PFC Plusmaze'};{'PFC Novelty'};{'PFC Foraging'};{'PAR Baseline'};{'PAR Plusmaze'};{'PAR Novelty'};{'PAR Foraging'}];    

Total=[n1; n3; n4]

t1=repmat({'x'},[1 13]);

tab=[TT;t1;TT1;t1;TT2;t1;TT3];
%%

if win_size== 25
writetable(tab,strcat('spec_ALL_values_25_rat_', num2str(Rat),'_' ,num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:Z50')  
save('Total.mat','Total')
end

if win_size== 50
writetable(tab,strcat('spec_ALL_values_rat_', num2str(Rat),'_' ,num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:Z50')  
end
 
%%
%Corrected:
%s: 1 for cohfos, 2 for singles.
%w:1 for hpc centered, 3 for par centered.
%% Find minimum number of ripples per type.

%HPC COHFOS
s=1;
w=1;
 n1=min([length(P.(labelconditions2{1}).(label1{w}){s}) length(P.(labelconditions2{2}).(label1{w}){s})...
        length(P.(labelconditions2{3}).(label1{w}){s}) length(P.(labelconditions2{4}).(label1{w}){s})]);
%PAR COHFOS
s=1;
w=3;
 n2=min([length(P.(labelconditions2{1}).(label1{w}){s}) length(P.(labelconditions2{2}).(label1{w}){s})...
        length(P.(labelconditions2{3}).(label1{w}){s}) length(P.(labelconditions2{4}).(label1{w}){s})]);

%HPC singles
s=2;
w=1;
 n3=min([length(P.(labelconditions2{1}).(label1{w}){s}) length(P.(labelconditions2{2}).(label1{w}){s})...
        length(P.(labelconditions2{3}).(label1{w}){s}) length(P.(labelconditions2{4}).(label1{w}){s})]);

%PAR singles
s=2;
w=3;
 n4=min([length(P.(labelconditions2{1}).(label1{w}){s}) length(P.(labelconditions2{2}).(label1{w}){s})...
        length(P.(labelconditions2{3}).(label1{w}){s}) length(P.(labelconditions2{4}).(label1{w}){s})]);
[n1 n2 n3 n4]
N=min([n1 n2 n3 n4]);

%% Find values
random_hfo=1;


win_size=50;
rand_first_run=0; %If you run for the first time.
same_nr_types=0; %Same N number across types

if same_nr_types==0
    N=[];
end
%HPC COHFOS
s=1;
w=1;
[values_spec,n1]=getval_spectra(P,Q,labelconditions2,label1,s,w,win_size,same_nr_types,N,random_hfo,rand_first_run,tr);
TT=table;
% TT.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl values_spec.plusmaze values_spec.novelty values_spec.for])];
% TT.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'PFC Baseline'};{'PAR Baseline'};{'HPC Plusmaze'};{'PFC Plusmaze'};{'PAR Plusmaze'};{'HPC Novelty'};{'PFC Novelty'};{'PAR Novelty'};{'HPC Foraging'};{'PFC Foraging'};{'PAR Foraging'}];    
TT.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl(:,1) values_spec.plusmaze(:,1) values_spec.novelty(:,1) values_spec.for(:,1) values_spec.nl(:,2) values_spec.plusmaze(:,2) values_spec.novelty(:,2) values_spec.for(:,2) values_spec.nl(:,3) values_spec.plusmaze(:,3) values_spec.novelty(:,3) values_spec.for(:,3)])];
TT.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'HPC Plusmaze'};{'HPC Novelty'};{'HPC Foraging'};{'PFC Baseline'};{'PFC Plusmaze'};{'PFC Novelty'};{'PFC Foraging'};{'PAR Baseline'};{'PAR Plusmaze'};{'PAR Novelty'};{'PAR Foraging'}];    

%PAR COHFOS
s=1;
w=3;
[values_spec,n2]=getval_spectra(P,Q,labelconditions2,label1,s,w,win_size,same_nr_types,N,random_hfo,rand_first_run,tr);
TT1=table;
% TT1.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl values_spec.plusmaze values_spec.novelty values_spec.for])];
% TT1.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'PFC Baseline'};{'PAR Baseline'};{'HPC Plusmaze'};{'PFC Plusmaze'};{'PAR Plusmaze'};{'HPC Novelty'};{'PFC Novelty'};{'PAR Novelty'};{'HPC Foraging'};{'PFC Foraging'};{'PAR Foraging'}];    
TT1.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl(:,1) values_spec.plusmaze(:,1) values_spec.novelty(:,1) values_spec.for(:,1) values_spec.nl(:,2) values_spec.plusmaze(:,2) values_spec.novelty(:,2) values_spec.for(:,2) values_spec.nl(:,3) values_spec.plusmaze(:,3) values_spec.novelty(:,3) values_spec.for(:,3)])];
TT1.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'HPC Plusmaze'};{'HPC Novelty'};{'HPC Foraging'};{'PFC Baseline'};{'PFC Plusmaze'};{'PFC Novelty'};{'PFC Foraging'};{'PAR Baseline'};{'PAR Plusmaze'};{'PAR Novelty'};{'PAR Foraging'}];    

%HPC singles
s=2;
w=1;
[values_spec,n3]=getval_spectra(P,Q,labelconditions2,label1,s,w,win_size,same_nr_types,N,random_hfo,rand_first_run,tr);
TT2=table;
% TT2.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl values_spec.plusmaze values_spec.novelty values_spec.for])];
% TT2.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'PFC Baseline'};{'PAR Baseline'};{'HPC Plusmaze'};{'PFC Plusmaze'};{'PAR Plusmaze'};{'HPC Novelty'};{'PFC Novelty'};{'PAR Novelty'};{'HPC Foraging'};{'PFC Foraging'};{'PAR Foraging'}];    
TT2.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl(:,1) values_spec.plusmaze(:,1) values_spec.novelty(:,1) values_spec.for(:,1) values_spec.nl(:,2) values_spec.plusmaze(:,2) values_spec.novelty(:,2) values_spec.for(:,2) values_spec.nl(:,3) values_spec.plusmaze(:,3) values_spec.novelty(:,3) values_spec.for(:,3)])];
TT2.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'HPC Plusmaze'};{'HPC Novelty'};{'HPC Foraging'};{'PFC Baseline'};{'PFC Plusmaze'};{'PFC Novelty'};{'PFC Foraging'};{'PAR Baseline'};{'PAR Plusmaze'};{'PAR Novelty'};{'PAR Foraging'}];    

%PAR singles
s=2;
w=3;
[values_spec,n4]=getval_spectra(P,Q,labelconditions2,label1,s,w,win_size,same_nr_types,N,random_hfo,rand_first_run,tr);
TT3=table;
% TT3.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl values_spec.plusmaze values_spec.novelty values_spec.for])];
% TT3.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'PFC Baseline'};{'PAR Baseline'};{'HPC Plusmaze'};{'PFC Plusmaze'};{'PAR Plusmaze'};{'HPC Novelty'};{'PFC Novelty'};{'PAR Novelty'};{'HPC Foraging'};{'PFC Foraging'};{'PAR Foraging'}];    
TT3.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.nl(:,1) values_spec.plusmaze(:,1) values_spec.novelty(:,1) values_spec.for(:,1) values_spec.nl(:,2) values_spec.plusmaze(:,2) values_spec.novelty(:,2) values_spec.for(:,2) values_spec.nl(:,3) values_spec.plusmaze(:,3) values_spec.novelty(:,3) values_spec.for(:,3)])];
TT3.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'HPC Plusmaze'};{'HPC Novelty'};{'HPC Foraging'};{'PFC Baseline'};{'PFC Plusmaze'};{'PFC Novelty'};{'PFC Foraging'};{'PAR Baseline'};{'PAR Plusmaze'};{'PAR Novelty'};{'PAR Foraging'}];    

[n1 n2 n3 n4]

t1=repmat({'x'},[1 13]);

tab=[TT;t1;TT1;t1;TT2;t1;TT3];
%%
if random_hfo==0

    if same_nr_types==0
        if win_size== 25
        writetable(tab,strcat('spec_values_25_rat_', num2str(Rat),'_' ,num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:Z50')  
        end

        if win_size== 50
        writetable(tab,strcat('spec_values_rat_', num2str(Rat),'_' ,num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:Z50')  
        end
    else
        if win_size== 25
        writetable(tab,strcat('spec_values_SameNR_25_rat_', num2str(Rat),'_' ,num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:Z50')  
        end

        if win_size== 50
        writetable(tab,strcat('spec_values_SameNR_rat_', num2str(Rat),'_' ,num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:Z50')  
        end
    end

else

    if same_nr_types==0
        if win_size== 25
        writetable(tab,strcat('spec_rand_values_25_rat_', num2str(Rat),'_' ,num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:Z50')  
        end

        if win_size== 50
        writetable(tab,strcat('spec_rand_values_rat_', num2str(Rat),'_' ,num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:Z50')  
        end
    else
        if win_size== 25
        writetable(tab,strcat('spec_rand_values_SameNR_25_rat_', num2str(Rat),'_' ,num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:Z50')  
        end

        if win_size== 50
        writetable(tab,strcat('spec_rand_values_SameNR_rat_', num2str(Rat),'_' ,num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:Z50')  
        end
    end

end
%%
HPC_cohfos




PAR_cohfos




HPC_singles




PAR_singles

%%
%HPC specs
%HPC cohfos
% xo
same_nr_types=1; %Same N number across types
if same_nr_types==0
    N=[];
end
%s: 2 for single, 1 for cohfos
%w:1 for hpc centered, 3 for par centered.
s=1;
w=1;
plot_spectra(P,Q,labelconditions2,label1,s,w,same_nr_types,N)
if same_nr_types==1
printing(['Spec_HPC_cohfos_SameNR_rat' num2str(Rat) '_' num2str(tr(2))])
else
printing(['Spec_HPC_cohfos_rat' num2str(Rat) '_' num2str(tr(2))])    
end
close all
% TT=table;
% TT.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.baseline values_spec.plusmaze])];
% TT.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'PFC Baseline'};{'PAR Baseline'};{'HPC Plusmaze'};{'PFC Plusmaze'};{'PAR Plusmaze'}];    


s=1;
w=3;
plot_spectra(P,Q,labelconditions2,label1,s,w,same_nr_types,N)
%printing(['Spec_PAR_cohfos_rat' num2str(Rat) '_' num2str(tr(2))])
if same_nr_types==1
printing(['Spec_PAR_cohfos_SameNR_rat' num2str(Rat) '_' num2str(tr(2))])
else
printing(['Spec_PAR_cohfos_rat' num2str(Rat) '_' num2str(tr(2))])    
end
close all
% TT1=table;
% TT1.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.baseline values_spec.plusmaze])];
% TT1.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'PFC Baseline'};{'PAR Baseline'};{'HPC Plusmaze'};{'PFC Plusmaze'};{'PAR Plusmaze'}];    

s=2;
w=1;
plot_spectra(P,Q,labelconditions2,label1,s,w,same_nr_types,N)
% printing(['Spec_HPC_single_rat' num2str(Rat) '_' num2str(tr(2))])
if same_nr_types==1
printing(['Spec_HPC_single_SameNR_rat' num2str(Rat) '_' num2str(tr(2))])
else
printing(['Spec_HPC_single_rat' num2str(Rat) '_' num2str(tr(2))])    
end
close all
% TT2=table;
% TT2.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.baseline values_spec.plusmaze])];
% TT2.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'PFC Baseline'};{'PAR Baseline'};{'HPC Plusmaze'};{'PFC Plusmaze'};{'PAR Plusmaze'}];    


s=2;
w=3;
plot_spectra(P,Q,labelconditions2,label1,s,w,same_nr_types,N)
% printing(['Spec_PAR_single_rat' num2str(Rat) '_' num2str(tr(2))])
if same_nr_types==1
printing(['Spec_PAR_single_SameNR_rat' num2str(Rat) '_' num2str(tr(2))])
else
printing(['Spec_PAR_single_rat' num2str(Rat) '_' num2str(tr(2))])    
end
close all
% TT3=table;
% TT3.Variables=    [[{'100-250Hz'};{'100-150Hz'};{'150-200Hz'};{'200-250Hz'}] num2cell([values_spec.baseline values_spec.plusmaze])];
% TT3.Properties.VariableNames=[{'Range'};{'HPC Baseline'};{'PFC Baseline'};{'PAR Baseline'};{'HPC Plusmaze'};{'PFC Plusmaze'};{'PAR Plusmaze'}];    

xo
% t1=repmat({'x'},[1 7]);
% 
% tab=[TT;t1;TT1;t1;TT2;t1;TT3];
% writetable(tab,strcat('spec_values_rat_', num2str(Rat),'_' ,num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:Z50')    

%%
same_nr_types=1; %Same N number across types
if same_nr_types==0
    N=[];
end

s=1;
w=1;
plot_spec_traces(P,Q,labelconditions2,label1,s,w,same_nr_types,N)
if same_nr_types==1
printing(['SpecTraces_SameNR_HPC_cohfos_rat' num2str(Rat) '_' num2str(tr(2))])    
else
printing(['SpecTraces_HPC_cohfos_rat' num2str(Rat) '_' num2str(tr(2))])    
end
close all

s=1;
w=3;
plot_spec_traces(P,Q,labelconditions2,label1,s,w,same_nr_types,N)
if same_nr_types==1
printing(['SpecTraces_SameNR_PAR_cohfos_rat' num2str(Rat) '_' num2str(tr(2))])        
else
printing(['SpecTraces_PAR_cohfos_rat' num2str(Rat) '_' num2str(tr(2))])    
end
close all

s=2;
w=1;
plot_spec_traces(P,Q,labelconditions2,label1,s,w,same_nr_types,N)
if same_nr_types==1
printing(['SpecTraces_SameNR_HPC_single_rat' num2str(Rat) '_' num2str(tr(2))])    
else
printing(['SpecTraces_HPC_single_rat' num2str(Rat) '_' num2str(tr(2))])
end
close all

s=2;
w=3;
plot_spec_traces(P,Q,labelconditions2,label1,s,w,same_nr_types,N)
if same_nr_types==1
printing(['SpecTraces_SameNR_PAR_single_rat' num2str(Rat) '_' num2str(tr(2))])    
else
printing(['SpecTraces_PAR_single_rat' num2str(Rat) '_' num2str(tr(2))])    
end
close all

%%


for l=1:length(q)
    plot(q{l}(1,:))
    hold on
end



