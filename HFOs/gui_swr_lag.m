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
 ro=1200;
[ripple,RipFreq,rip_duration,Mx_cortex,timeasleep,sig_cortex,Ex_cortex,Sx_cortex,...
  p_cortex,q_cortex,cont_cortex,sig_pq_cortex ...
  ]=gui_findripples_spec(CORTEX,states,xx,tr,PFC,HPC,fn,ro);
%xo

si=sig_cortex(~cellfun('isempty',sig_cortex));
si=[si{:}];

si_pq=sig_pq_cortex(~cellfun('isempty',sig_pq_cortex));
si_pq=[si_pq{:}];

Q_cortex=q_cortex(~cellfun('isempty',q_cortex));
Q_cortex=[Q_cortex{:}];

[~,~,~,~,~,~,~,~,si_mixed,~]=hfo_specs(si,timeasleep,0,Rat,tr);

void_index=find(cellfun('isempty',Q_cortex));

%All par HFOS splitted in slow and fast.
Q_cortex_g1=Q_cortex(si_mixed.i1(~ismember(si_mixed.i1,void_index)));
Q_cortex_g2=Q_cortex(si_mixed.i2(~ismember(si_mixed.i2,void_index)));

%% HPC     

[ripple,RipFreq,rip_duration,Mx_hpc,timeasleep,sig_hpc,Ex_hpc,Sx_hpc,...
  p_hpc,q_hpc,cont_hpc ...
]=gui_findripples_spec(HPC,states,{'HPC'},tr,PFC,CORTEX,fn,ro);

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
 

% xo
%% Mixed distribution (Average freq) coHFOs
Mx_cortex_g1=Mx_cortex;
Mx_cortex_g2=Mx_cortex;
Ex_cortex_g1=Ex_cortex;
Ex_cortex_g2=Ex_cortex;
Sx_cortex_g1=Sx_cortex;
Sx_cortex_g2=Sx_cortex;

row=si_mixed.i1;
cont=0;
for ll=1:length(Mx_cortex)
% cont=cont+length(Mx_cortex{ll});

    if ~isempty(Mx_cortex{ll})

        for lll=1:length(Mx_cortex{ll})
            cont=cont+1;
    %         xo

            if ~ismember(cont,row)
                Mx_cortex_g1{ll}(lll)=NaN;
                Ex_cortex_g1{ll}(lll)=NaN;
                Sx_cortex_g1{ll}(lll)=NaN;
                
            else
                Mx_cortex_g2{ll}(lll)=NaN;
                Ex_cortex_g2{ll}(lll)=NaN;
                Sx_cortex_g2{ll}(lll)=NaN;

            end

        end
         Mx_cortex_g1{ll}=Mx_cortex_g1{ll}(~isnan(Mx_cortex_g1{ll}));
         Mx_cortex_g2{ll}=Mx_cortex_g2{ll}(~isnan(Mx_cortex_g2{ll}));

         Ex_cortex_g1{ll}=Ex_cortex_g1{ll}(~isnan(Ex_cortex_g1{ll}));
         Ex_cortex_g2{ll}=Ex_cortex_g2{ll}(~isnan(Ex_cortex_g2{ll}));
         Sx_cortex_g1{ll}=Sx_cortex_g1{ll}(~isnan(Sx_cortex_g1{ll}));
         Sx_cortex_g2{ll}=Sx_cortex_g2{ll}(~isnan(Sx_cortex_g2{ll}));
         
         
    end

end

[cohfos1_g1,cohfos2_g1]=cellfun(@(equis1,equis2) co_hfo(equis1,equis2),Mx_hpc,Mx_cortex_g1,'UniformOutput',false);
[cohfos1_g2,cohfos2_g2]=cellfun(@(equis1,equis2) co_hfo(equis1,equis2),Mx_hpc,Mx_cortex_g2,'UniformOutput',false);

%Single HFOs Cortex
v2_g1=cellfun(@(equis1,equis2) single_hfo_get_sample(equis1,equis2),Mx_cortex_g1,cohfos2_g1,'UniformOutput',false);
%Single HFOs Cortex
v2_g2=cellfun(@(equis1,equis2) single_hfo_get_sample(equis1,equis2),Mx_cortex_g2,cohfos2_g2,'UniformOutput',false);


[p_cohfos_cortex_g1,q_cohfos_cortex_g1,p_single_cortex_g1,q_single_cortex_g1,use_me_g1]=get_window_slowfast(Mx_cortex,Sx_cortex,Ex_cortex, cohfos2_g1,p_cortex,q_cortex,v2_g1);
[p_cohfos_cortex_g2,q_cohfos_cortex_g2,p_single_cortex_g2,q_single_cortex_g2,use_me_g2]=get_window_slowfast(Mx_cortex,Sx_cortex,Ex_cortex, cohfos2_g2,p_cortex,q_cortex,v2_g2);


SPPC.(strrep(labelconditions2{k},'-','_')).(label1{3})={cohfos1_g1;cohfos2_g1};
FPPC.(strrep(labelconditions2{k},'-','_')).(label1{3})={cohfos1_g2;cohfos2_g2};
% xo
%%
  p_cortex=p_cortex(~cellfun('isempty',p_cortex));
 p_cortex=[p_cortex{:}];
 q_cortex=q_cortex(~cellfun('isempty',q_cortex));
 q_cortex=[q_cortex{:}];
 p_cortex=p_cortex(~cellfun('isempty',p_cortex));
 q_cortex=q_cortex(~cellfun('isempty',q_cortex));

%%
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
     
     
     %Slow/Fast
     
     SP.(strrep(labelconditions2{k},'-','_')).(label1{3})={p_cohfos_cortex_g1;p_single_cortex_g1};
     SQ.(strrep(labelconditions2{k},'-','_')).(label1{3})={q_cohfos_cortex_g1;q_single_cortex_g1};
     
     FP.(strrep(labelconditions2{k},'-','_')).(label1{3})={p_cohfos_cortex_g2;p_single_cortex_g2};
     FQ.(strrep(labelconditions2{k},'-','_')).(label1{3})={q_cohfos_cortex_g2;q_single_cortex_g2};
% p_cohfos_cortex_g1,q_cohfos_cortex_g1,p_single_cortex_g1,q_single_cortex_g1



 %xo
progress_bar(k,length(g),f)
    cd ..    
    
    
%Slow
 celldiff=cellfun(@(equis1,equis2) minus(equis1,equis2),SPPC.(labelconditions2{k}).PAR{1},SPPC.(labelconditions2{k}).PAR{2},'UniformOutput',false);
%  histogram([celldiff{:}],[-0.05:0.01:0.05])
% % histfit([celldiff{:}])
%  xlabel('Seconds wrt PPC ripple')
%  xlim([-0.05 0.05])
%  ylabel('Count')
%  xticks([-0.05:0.01:0.05])
%  printing(['Lag_Slow_' (labelconditions2{k})])
%  close all
%  SSK.(labelconditions2{k})=skewness([celldiff{:}]);
%  SM.(labelconditions2{k})=mean([celldiff{:}]);
 S_values.(labelconditions2{k})=[celldiff{:}];
 S_values.(labelconditions2{k})=S_values.(labelconditions2{k})(use_me_g1);
 SSK(k)=skewness([celldiff{:}]);
 SM(k)=mean([celldiff{:}]);
%Fast
 celldiff=cellfun(@(equis1,equis2) minus(equis1,equis2),FPPC.(labelconditions2{k}).PAR{1},FPPC.(labelconditions2{k}).PAR{2},'UniformOutput',false);
%  histogram([celldiff{:}],[-0.05:0.01:0.05])
% % histfit([celldiff{:}])
%  xlabel('Seconds wrt PPC ripple')
%  xlim([-0.05 0.05])
%  ylabel('Count')
%  xticks([-0.05:0.01:0.05])
%  printing(['Lag_Fast_' (labelconditions2{k})])
%  close all
%  FSK.(labelconditions2{k})=skewness([celldiff{:}]);
%  FM.(labelconditions2{k})=mean([celldiff{:}]);
 F_values.(labelconditions2{k})=[celldiff{:}];
 F_values.(labelconditions2{k})=F_values.(labelconditions2{k})(use_me_g2);
 FSK(k)=skewness([celldiff{:}]);
 FM(k)=mean([celldiff{:}]);      
    end
 %xo
 
 %SLOW
%PAR COHFOS
s=1; %COHFOS
w=3; %PAR

    
[Sval_par,Sval_hpc,Sval_par_mean,Sval_hpc_mean]=time_delay_slowfast(SP,SQ,label1,labelconditions2,w,s,S_values);
[Fval_par,Fval_hpc,Fval_par_mean,Fval_hpc_mean]=time_delay_slowfast(FP,FQ,label1,labelconditions2,w,s,F_values);


% [Sval_par_mean;Sval_hpc_mean;Fval_par_mean;Fval_hpc_mean;]
xo

TT1=table;
TT1.Variables= [Sval_par_mean;Sval_hpc_mean;Fval_par_mean;Fval_hpc_mean;];
TT1.Properties.VariableNames=[labelconditions2(1);labelconditions2(2);labelconditions2(3);labelconditions2(4);];

writetable(TT1,strcat('Timealign_rat_', num2str(Rat),'_' ,num2str(tr(2)),'.xls'),'Sheet',1,'Range','A2:Z50')
%[[{'PAR->PFC'};{'PFC->PAR'};{'PAR->HPC'};{'HPC->PAR'};{'PFC->HPC'};{'HPC->PFC'}] num2cell([FB{1}(:,12) FB{2}(:,12) FB{3}(:,12) FB{4}(:,12)])];

% TT1.Variables=    [[{'PAR->PFC'};{'PFC->PAR'};{'PAR->HPC'};{'HPC->PAR'};{'PFC->HPC'};{'HPC->PFC'}] num2cell([FB{1}(:,12) FB{2}(:,12) FB{3}(:,12) FB{4}(:,12)])];
% TT1.Properties.VariableNames=[{'Direction'};{labelconditions3{1}};{labelconditions3{2}};{labelconditions3{3}};{labelconditions3{4}}];    


