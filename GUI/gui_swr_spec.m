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

    close(f);
g={g{logical(boxch)}};    

if sum(cell2mat(cellfun(@(equis1) contains(equis1,'nl'),g,'UniformOutput',false)))==1
    if  find(cell2mat(cellfun(@(equis1) contains(equis1,'nl'),g,'UniformOutput',false))==1)~=1
        g=flip(g);
    end
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


 if k==1 %No Learning
     P.nl.('hpc')={p_hpc;p_cohfos_hpc;p_single_hpc};
     P.nl.('pfc')={p_cortex;p_cohfos_cortex;p_single_cortex};
    
     Q.nl.('hpc')={q_hpc;q_cohfos_hpc;q_single_hpc};
     Q.nl.('pfc')={q_cortex;q_cohfos_cortex;q_single_cortex};
     
 else
     P.plusmaze.('hpc')={p_hpc;p_cohfos_hpc;p_single_hpc};
     P.plusmaze.('pfc')={p_cortex;p_cohfos_cortex;p_single_cortex};
    
     Q.plusmaze.('hpc')={q_hpc;q_cohfos_hpc;q_single_hpc};
     Q.plusmaze.('pfc')={q_cortex;q_cohfos_cortex;q_single_cortex};
 end
 
 %xo
progress_bar(k,length(g),f)
    cd ..    
    end
  xo
%%
%HPC specs
%HPC cohfos

n=min([length(P.nl.hpc{2}) length(P.plusmaze.hpc{2})]);

%Order ripples
p=P.plusmaze.hpc{2}; 
q=Q.plusmaze.hpc{2}; 
% R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,:)))),q));
R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,121-50:121+50)))),q));
[~,r]=sort(R,'descend');
p=p(r);
q=q(r);
p=p(1:n);
q=q(1:n);

%Order ripples
p_nl=P.nl.hpc{2}; 
q_nl=Q.nl.hpc{2}; 
% R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,:)))),q_nl));
R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,121-50:121+50)))),q_nl));
[~,r_nl]=sort(R,'descend');
p_nl=p_nl(r_nl);
q_nl=q_nl(r_nl);
p_nl=p_nl(1:n);
q_nl=q_nl(1:n);


%Max 1000 ripples.
if length(q)>1000
    q=q(1:1000);
    p=p(1:1000);
    q_nl=q_nl(1:1000);
    p_nl=p_nl(1:1000);
end


%%
ro=120;

P1_nl=avg_samples(q_nl,create_timecell(120,length(p)));
P2_nl=avg_samples(p_nl,create_timecell(120,length(p)));

subplot(3,3,1)
plot(P2_nl(1,:))
subplot(3,3,4)
plot(P1_nl(1,:))

P1=avg_samples(q,create_timecell(120,length(p)));
P2=avg_samples(p,create_timecell(120,length(p)));

subplot(3,3,2)
plot(P2(1,:))
subplot(3,3,5)
plot(P1(1,:))
%%
w=1;
h(1)=subplot(3,4,1)
plot(cell2mat(create_timecell(ro,1)),P2_nl(1,:))
title('Wide Band No Learning')
win1=[min(P2_nl(w,:)) max(P2_nl(w,:)) min(P2(w,:)) max(P2(w,:))];
win1=[(min(win1)) round(max(win1))];
ylim(win1)
xlabel('Time (s)')
ylabel('uV')
xlim([-.1 .1])

h(3)=subplot(3,4,3)
plot(cell2mat(create_timecell(ro,1)),P1_nl(w,:))
title('High Gamma No Learning')

win2=[min(P1_nl(w,:)) max(P1_nl(w,:)) min(P1(w,:)) max(P1(w,:))];
win2=[(min(win2)) (max(win2))];
ylim(win2)
xlabel('Time (s)')
ylabel('uV')
xlim([-.1 .1])


h(2)=subplot(3,4,2)
plot(cell2mat(create_timecell(ro,1)),P2(w,:))
title(strcat('Wide Band',{' '},labelconditions2{1}))
ylim(win1)
xlabel('Time (s)')
ylabel('uV')
xlim([-.1 .1])


h(4)=subplot(3,4,4)
plot(cell2mat(create_timecell(ro,1)),P1(w,:))
title(strcat('High Gamma',{' '},labelconditions2{1}))
ylim(win2)
xlabel('Time (s)')
ylabel('uV')
xlim([-.1 .1])


%%
toy=[-.1:.001:.1];

freq3=barplot2_ft(q_nl,create_timecell(ro,length(q_nl)),[100:1:300],[],toy);
freq4=barplot2_ft(q,create_timecell(ro,length(q)),[100:1:300],[],toy);

cfg              = [];
cfg.channel      = freq3.label{1};
[ zmin1, zmax1] = ft_getminmax(cfg, freq3);
[zmin2, zmax2] = ft_getminmax(cfg, freq4);
zlim=[min([zmin1 zmin2]) max([zmax1 zmax2])];

cfg              = [];
cfg.zlim=zlim;
cfg.channel      = freq4.label{1};
cfg.colormap=colormap(jet(256));


%h(1)=subplot(3,4,4*(1-1)+1)
subplot(3,3,7)
ft_singleplotTFR(cfg, freq3); 
g=title('No Learning');
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
ylim([100 250])


%h(2)=subplot(3,4,2)
subplot(3,3,8)
ft_singleplotTFR(cfg, freq4); 
g=title(strcat('Plusmaze'));
g.FontSize=12;
xlabel('Time (s)')
ylabel('Frequency (Hz)')
ylim([100 250])
%%

% 
% cellfun(@mean,q,'UniformOutput',false);
% xo
% 
% q2=cell2mat(q);
% q2=q2(1,:);
% q2=q2.';
% 
% R=reshape(q2,[length(q) size(q{1},2)]);
%  
% 
% q2=cellfun(@(equis1) equis1(:) ,q ,'UniformOutput',false);
% 
% q2=cellfun(@(equis1) {equis1} ,q ,'UniformOutput',false);
% 
% 
% q2=cellfun(@(equis1) equis1{1}(1,:) ,q2 ,'UniformOutput',false);
% 
% 
% 
% aja=cellfun(@(equis1) equis1(:) ,q ,'UniformOutput',false)
% aja=cellfun(@(equis1) aja(:) ,aja ,'UniformOutput',false)
% aja=cellfun(@(equis1) aja(1) ,aja ,'UniformOutput',false)
% 
% 
% cellfun(@(equis1,equis2) equis1(equis2),q, num2cell(ones(size(q))))
% 
% cellfun(@(equis1,equis2) equis1(equis2) ,q, num2cell(ones(size(q))),'UniformOutput',false)
% 
% 
% cellfun(@(equis1) size(equis1),q ,'UniformOutput',false)
% 
% 
% cellfun('size' ,q)
% 
% cellfun(@(equis1,equis2) equis1(equis2),q_cortex,v2,'UniformOutput',false)

max(abs(hilbert(equis1(1,:))))

for l=1:length(q)
    plot(q{l}(1,:))
    hold on
end



