%GL_spindles_control
%Detects spindles and computes coocurrence with hfos and ripples.
%Controls by changing timestamps randomly to generate a null-distribution.
% Requires 'load_me_first.mat' loaded first. 

%% Find location
close all
dname=uigetdir([],'Select folder with Matlab data containing all rats.');
cd(dname)
% cd('/home/adrian/Documents/Plusmaze_downsampled')

%%
%Select rat ID
opts.Resize = 'on';
opts.WindowStyle = 'modal';
opts.Interpreter = 'tex';
prompt=strcat('\bf Select a rat#. Options:','{ }',num2str(rats));
answer = inputdlg(prompt,'Input',[2 30],{''},opts);
Rat=str2num(answer{1});
cd(num2str(Rat))
%%
%Cortical regions.
yy={'PAR'};    
xx={'PFC'};  
%Sampling freq.          
fn=1000;
%% Get folder names
labelconditions=getfolder;
labelconditions=labelconditions.';
g=labelconditions;

multiplets=[{'singlets'} {'doublets'} {'triplets'} {'quatruplets'} {'pentuplets'} {'sextuplets'} {'septuplets'} {'octuplets'} {'nonuplets'}];
iii=1;

%%  Select conditions and sessions
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
    close(f);
g={g{logical(boxch)}};    
if sum(cell2mat(cellfun(@(equis1) contains(equis1,'nl'),g,'UniformOutput',false)))==1
g=g([find(cell2mat(cellfun(@(equis1) contains(equis1,labelconditions2{1}),g,'UniformOutput',false)))...
 find(cell2mat(cellfun(@(equis1) contains(equis1,labelconditions2{2}),g,'UniformOutput',false)))...
 find(cell2mat(cellfun(@(equis1) contains(equis1,labelconditions2{3}),g,'UniformOutput',false)))...
 find(cell2mat(cellfun(@(equis1) contains(equis1,labelconditions2{4}),g,'UniformOutput',false)))]);

else
    error('Name issue')
end

%Get thresholds for event detection.
tr=getfield(T,strcat('Rat',num2str(Rat)));%Thresholds 

%%
f=waitbar(0,'Please wait...');
    for k=1:length(g)
        cd(g{k})
CORTEX=dir(strcat('*',xx{1},'*.mat'));
if isempty(CORTEX)
    g=g(~contains(g,g{k}));
    cd ..
    progress_bar(k,length(g),f)
    break
end
CORTEX=CORTEX.name;
CORTEX=load(CORTEX);
CORTEX=getfield(CORTEX,xx{1});
CORTEX=CORTEX.*(0.195);

A = dir('*states*.mat');
A={A.name};

if  ~isempty(A)
       cellfun(@load,A);
else
      error('No Scoring found')    
end

%Find PFC Spindles
clear Ex_cortex Sx_cortex Mx_cortex
[ripple,~,~,Mx_cortex,timeasleep,sig_cortex,Ex_cortex,Sx_cortex,...
  ~,~,~,~,~, ...
  ]=gui_findspindlesYASA(CORTEX,states,xx,multiplets,fn);

si=sig_cortex(~cellfun('isempty',sig_cortex));
si=[si{:}];

%PRE POST ANALYSIS
% [Sx_pre,Mx_pre,Ex_pre,Sx_post,Mx_post,Ex_post]=cellfun(@(equis1,equis2,equis3) pre_post_spindle(equis1,equis2,equis3) ,Sx_cortex,Mx_cortex,Ex_cortex ,'UniformOutput',false);

%%
%Convert signal to 1 sec epochs.
        e_t=1;
        e_samples=e_t*(fn); %fs=1kHz
        ch=length(CORTEX);
        nc=floor(ch/e_samples); %Number of epochsw
        NC=[];
        for kk=1:nc
          NC(:,kk)= CORTEX(1+e_samples*(kk-1):e_samples*kk);
        end
        %IF NREM vec_bin=1.
        vec_bin=states;
        vec_bin(vec_bin~=3)=0;
        vec_bin(vec_bin==3)=1;
        %Cluster one values:
        v2=ConsecutiveOnes(vec_bin);
        v_index=find(v2~=0);
        v_values=v2(v2~=0);
        clear v
    for epoch_count=1:length(v_index)
    v{epoch_count,1}=reshape(NC(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
    end    
    ti=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,v,'UniformOutput',false);

%%
clear dur_cortex
%Find duration of spindles
for dd=1:length(Mx_cortex)
        dur_cortex{dd}=Ex_cortex{dd}-Sx_cortex{dd};
    if isempty(Sx_cortex{dd})
        Sx_cortex{dd}=nan;
    end

end
dur_cortex=dur_cortex.';
    clear Sr_cortex Er_cortex
% Shuffling timestamps randomly 1000 times    
    rng('default') %Initialize seed for repeatability
    parfor r=1:1000
        ti_rand=cellfun(@(equis) equis(randperm(size(equis, 1))),ti,'UniformOutput',false);
        Sr_cortex{r}=cellfun(@(equis1,equis2,equis3) equis3(findclosest(equis1,equis2)).', ti,Sx_cortex,ti_rand,'UniformOutput',false );
        Er_cortex{r}=cellfun(@(equis1,equis2,equis3,equis4) equis3(findclosest(equis1,equis2)).'+equis4, ti,Sx_cortex,ti_rand,dur_cortex,'UniformOutput',false );
    end

%Change Nans to []
for dd=1:length(Mx_cortex)
    if isnan(Sx_cortex{dd})
        Sx_cortex{dd}=[];
    end

end

%% High Frequency oscillations

CORTEX=dir(strcat('*','PAR','*.mat'));
if isempty(CORTEX)
    g=g(~contains(g,g{k}));
    cd ..
    progress_bar(k,length(g),f)
    break
end
CORTEX=CORTEX.name;
CORTEX=load(CORTEX);
CORTEX=getfield(CORTEX,'PAR');
CORTEX=CORTEX.*(0.195);

A = dir('*states*.mat');
A={A.name};
if  ~isempty(A)
       cellfun(@load,A);
else
      error('No Scoring found')    
end
% Detect HFOs
[ripple_sphfo,~,~,Mx_cortex_sphfo,~,sig_cortex_sphfo,Ex_cortex_sphfo,Sx_cortex_sphfo,...
  ~,~,~,~,~, ...
  ]=gui_findripples(CORTEX,states,{'PAR'},tr,multiplets,fn);


si=sig_cortex_sphfo(~cellfun('isempty',sig_cortex_sphfo));
si=[si{:}];

%Group events in slow and fast HFOs.
[~,~,~,~,~,~,~,~,si_mixed,~]=hfo_specs(si,timeasleep,0,Rat,tr);
%% Determining slow and fast HFOs timestamps.
%Initializing variables
Mx_cortex_g1=Mx_cortex_sphfo;
Mx_cortex_g2=Mx_cortex_sphfo;
Ex_cortex_g1=Ex_cortex_sphfo;
Ex_cortex_g2=Ex_cortex_sphfo;
Sx_cortex_g1=Sx_cortex_sphfo;
Sx_cortex_g2=Sx_cortex_sphfo;

row=si_mixed.i1;
cont=0;
for ll=1:length(Mx_cortex_sphfo)

    if ~isempty(Mx_cortex_sphfo{ll})

        for lll=1:length(Mx_cortex_sphfo{ll})
            cont=cont+1;
 
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

%% Coocur PFC spindle and hfos
[cohfos1_g1,cohfos2_g1]=cellfun(@(equis1,equis2,equis3,equis4,equis5,equis6) co_hfo_spindle(equis1,equis2,equis3,equis4,equis5,equis6),Sx_cortex_g1,Mx_cortex_g1,Ex_cortex_g1,Sx_cortex,Mx_cortex,Ex_cortex,'UniformOutput',false);
[cohfos1_g2,cohfos2_g2]=cellfun(@(equis1,equis2,equis3,equis4,equis5,equis6) co_hfo_spindle(equis1,equis2,equis3,equis4,equis5,equis6),Sx_cortex_g2,Mx_cortex_g2,Ex_cortex_g2,Sx_cortex,Mx_cortex,Ex_cortex,'UniformOutput',false);

Cohfos1_PFC_g1{k}=([cohfos1_g1{:}]);
Cohfos2_PFC_g1{k}=([cohfos2_g1{:}]);
Cohfos1_PFC_g2{k}=([cohfos1_g2{:}]);
Cohfos2_PFC_g2{k}=([cohfos2_g2{:}]);
%% Coocur PFC spindle and shuffled hfos.

parfor r=1:1000
[cohfos1_rand_g1,cohfos2_rand_g1]=cellfun(@(equis1,equis2,equis3,equis4,equis5,equis6) co_hfo_spindle(equis1,equis2,equis3,equis4,equis5,equis6),Sx_cortex_g1,Mx_cortex_g1,Ex_cortex_g1,Sr_cortex{r},Sr_cortex{r},Er_cortex{r},'UniformOutput',false);
[cohfos1_rand_g2,cohfos2_rand_g2]=cellfun(@(equis1,equis2,equis3,equis4,equis5,equis6) co_hfo_spindle(equis1,equis2,equis3,equis4,equis5,equis6),Sx_cortex_g2,Mx_cortex_g2,Ex_cortex_g2,Sr_cortex{r},Sr_cortex{r},Er_cortex{r},'UniformOutput',false);


Cohfos1_PFC_all_g1(k,r)=sum(cellfun('length',cohfos1_rand_g1));
Cohfos1_PFC_unique_g1(k,r)=sum(cellfun(@(equis) length(unique(equis)), cohfos1_rand_g1));
Cohfos2_PFC_all_g1(k,r)=sum(cellfun('length',cohfos2_rand_g1));
Cohfos2_PFC_unique_g1(k,r)=sum(cellfun(@(equis) length(unique(equis)), cohfos2_rand_g1));

Cohfos1_PFC_all_g2(k,r)=sum(cellfun('length',cohfos1_rand_g2));
Cohfos1_PFC_unique_g2(k,r)=sum(cellfun(@(equis) length(unique(equis)), cohfos1_rand_g2));
Cohfos2_PFC_all_g2(k,r)=sum(cellfun('length',cohfos2_rand_g2));
Cohfos2_PFC_unique_g2(k,r)=sum(cellfun(@(equis) length(unique(equis)), cohfos2_rand_g2));
end

%% HPC ripples

CORTEX=dir(strcat('*','HPC','*.mat'));
if isempty(CORTEX)
    g=g(~contains(g,g{k}));
    cd ..
    progress_bar(k,length(g),f)
    break
end
CORTEX=CORTEX.name;
CORTEX=load(CORTEX);
CORTEX=getfield(CORTEX,'HPC');
CORTEX=CORTEX.*(0.195);

A = dir('*states*.mat');
A={A.name};
if  ~isempty(A)
       cellfun(@load,A);
else
      error('No Scoring found')    
end
% Find ripples
[ripple_nhpc,~,~,Mx_nhpc,~,sig_nhpc,Ex_nhpc,Sx_nhpc,...
  ~,~,~,~,~, ...
  ]=gui_findripples(CORTEX,states,{'HPC'},tr,multiplets,fn);

%% Coocur PFC spindle and HPC ripples
[cohfos1_hpc,cohfos2_hpc]=cellfun(@(equis1,equis2,equis3,equis4,equis5,equis6) co_hfo_spindle(equis1,equis2,equis3,equis4,equis5,equis6),Sx_nhpc,Mx_nhpc,Ex_nhpc,Sx_cortex,Mx_cortex,Ex_cortex,'UniformOutput',false);


Cohfos1_PFC_hpc{k}= ([cohfos1_hpc{:}]);
Cohfos2_PFC_hpc{k}= ([cohfos2_hpc{:}]);
%% Coocur PFC spindle and shuffled HPC ripples.

%Shuffle ripples timestamps
 parfor r=1:1000
[cohfos1_rand_hpc,cohfos2_rand_hpc]=cellfun(@(equis1,equis2,equis3,equis4,equis5,equis6) co_hfo_spindle(equis1,equis2,equis3,equis4,equis5,equis6),Sx_nhpc,Mx_nhpc,Ex_nhpc,Sr_cortex{r},Sr_cortex{r},Er_cortex{r},'UniformOutput',false);

Cohfos1_PFC_hpc_all(k,r)=sum(cellfun('length',cohfos1_rand_hpc));
Cohfos1_PFC_hpc_unique(k,r)=sum(cellfun(@(equis) length(unique(equis)), cohfos1_rand_hpc));
Cohfos2_PFC_hpc_all(k,r)=sum(cellfun('length',cohfos2_rand_hpc));
Cohfos2_PFC_hpc_unique(k,r)=sum(cellfun(@(equis) length(unique(equis)), cohfos2_rand_hpc));

[out_rand_pfc]=coccur_multiplets(cohfos2_rand_hpc);
Out_rand_PFC(k,r,:)=(out_rand_pfc(:,2));
end


%% COOCUR SPINDLE-HPC MULTIPLETS
[out_pfc]=coccur_multiplets(cohfos2_hpc);
Out_PFC{k}=out_pfc;

%% PARIETAL SPINDLES.
%Despite variable used is called HPC this is actually Parietal as indicated
%by 'yy'.

HPC=dir(strcat('*',yy{1},'*.mat'));
if isempty(HPC)
    g=g(~contains(g,g{k}));
    cd ..
    progress_bar(k,length(g),f)
    break
end

HPC=HPC.name;
HPC=load(HPC);
HPC=getfield(HPC,yy{1});
HPC=HPC.*(0.195);
% Find Parietal spindle
[ripple,RipFreq,rip_duration,Mx_hpc,timeasleep,sig_hpc,Ex_hpc,Sx_hpc,...
  ripple_multiplets_hpc,RipFreq_multiplets_hpc,rip_duration_multiplets_hpc,sig_multiplets_hpc,Mx_multiplets_hpc...    
  ]=gui_findspindlesYASA(HPC,states,yy,multiplets,fn);


si=sig_hpc(~cellfun('isempty',sig_hpc));
si=[si{:}];

[x,y,z,~,~,~,l,p]=hfo_specs_spindles(si,timeasleep,fn,0);
%PRE POST ANALYSIS
% [Sx_pre,Mx_pre,Ex_pre,Sx_post,Mx_post,Ex_post]=cellfun(@(equis1,equis2,equis3) pre_post_spindle(equis1,equis2,equis3) ,Sx_hpc,Mx_hpc,Ex_hpc ,'UniformOutput',false);

%%

%Convert signal to 1 sec epochs.
        e_t=1;
        e_samples=e_t*(fn); %fs=1kHz
        ch=length(HPC);
        nc=floor(ch/e_samples); %Number of epochsw
        NC=[];
        for kk=1:nc
          NC(:,kk)= HPC(1+e_samples*(kk-1):e_samples*kk);
        end
        vec_bin=states;
        %Use NREM epochs
        vec_bin(vec_bin~=3)=0;
        vec_bin(vec_bin==3)=1;
        %Cluster one values:
        v2=ConsecutiveOnes(vec_bin);
        v_index=find(v2~=0);
        v_values=v2(v2~=0);
        clear v
    for epoch_count=1:length(v_index)
    v{epoch_count,1}=reshape(NC(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
    end    
    ti=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,v,'UniformOutput',false);

%%
%Find duration of spindles
clear dur_hpc
for dd=1:length(Mx_hpc)
        dur_hpc{dd}=Ex_hpc{dd}-Sx_hpc{dd};
    if isempty(Sx_hpc{dd})
        Sx_hpc{dd}=nan;
    end

end
dur_hpc=dur_hpc.';
% Shuffle timestamps of PAR spindles.
    parfor r=1:1000
        ti_rand=cellfun(@(equis) equis(randperm(size(equis, 1))),ti,'UniformOutput',false);
        Sr_hpc{r}=cellfun(@(equis1,equis2,equis3) equis3(findclosest(equis1,equis2)).', ti,Sx_hpc,ti_rand,'UniformOutput',false );
        Er_hpc{r}=cellfun(@(equis1,equis2,equis3,equis4) equis3(findclosest(equis1,equis2)).'+equis4, ti,Sx_hpc,ti_rand,dur_hpc,'UniformOutput',false );
    end

%Change Nans to []
for dd=1:length(Mx_hpc)
    if isnan(Sx_hpc{dd})
        Sx_hpc{dd}=[];
    end
end

%% Find coocurrent PAR spindles and hfos

[cohfos1_g1,cohfos2_g1]=cellfun(@(equis1,equis2,equis3,equis4,equis5,equis6) co_hfo_spindle(equis1,equis2,equis3,equis4,equis5,equis6),Sx_cortex_g1,Mx_cortex_g1,Ex_cortex_g1,Sx_hpc,Mx_hpc,Ex_hpc,'UniformOutput',false);
[cohfos1_g2,cohfos2_g2]=cellfun(@(equis1,equis2,equis3,equis4,equis5,equis6) co_hfo_spindle(equis1,equis2,equis3,equis4,equis5,equis6),Sx_cortex_g2,Mx_cortex_g2,Ex_cortex_g2,Sx_hpc,Mx_hpc,Ex_hpc,'UniformOutput',false);


Cohfos1_PAR_g1{k}=([cohfos1_g1{:}]);
Cohfos2_PAR_g1{k}=([cohfos2_g1{:}]);
Cohfos1_PAR_g2{k}=([cohfos1_g2{:}]);
Cohfos2_PAR_g2{k}=([cohfos2_g2{:}]);

%% Coocur PAR spindle and shuffled hfos.

parfor r=1:1000
[cohfos1_rand_g1,cohfos2_rand_g1]=cellfun(@(equis1,equis2,equis3,equis4,equis5,equis6) co_hfo_spindle(equis1,equis2,equis3,equis4,equis5,equis6),Sx_cortex_g1,Mx_cortex_g1,Ex_cortex_g1,Sr_hpc{r},Sr_hpc{r},Er_hpc{r},'UniformOutput',false);
[cohfos1_rand_g2,cohfos2_rand_g2]=cellfun(@(equis1,equis2,equis3,equis4,equis5,equis6) co_hfo_spindle(equis1,equis2,equis3,equis4,equis5,equis6),Sx_cortex_g2,Mx_cortex_g2,Ex_cortex_g2,Sr_hpc{r},Sr_hpc{r},Er_hpc{r},'UniformOutput',false);


Cohfos1_PAR_all_g1(k,r)=sum(cellfun('length',cohfos1_rand_g1));
Cohfos1_PAR_unique_g1(k,r)=sum(cellfun(@(equis) length(unique(equis)), cohfos1_rand_g1));
Cohfos2_PAR_all_g1(k,r)=sum(cellfun('length',cohfos2_rand_g1));
Cohfos2_PAR_unique_g1(k,r)=sum(cellfun(@(equis) length(unique(equis)), cohfos2_rand_g1));

Cohfos1_PAR_all_g2(k,r)=sum(cellfun('length',cohfos1_rand_g2));
Cohfos1_PAR_unique_g2(k,r)=sum(cellfun(@(equis) length(unique(equis)), cohfos1_rand_g2));
Cohfos2_PAR_all_g2(k,r)=sum(cellfun('length',cohfos2_rand_g2));
Cohfos2_PAR_unique_g2(k,r)=sum(cellfun(@(equis) length(unique(equis)), cohfos2_rand_g2));
end

%% Coocur PAR spindle and HPC ripples
[cohfos1_hpc,cohfos2_hpc]=cellfun(@(equis1,equis2,equis3,equis4,equis5,equis6) co_hfo_spindle(equis1,equis2,equis3,equis4,equis5,equis6),Sx_nhpc,Mx_nhpc,Ex_nhpc,Sx_hpc,Mx_hpc,Ex_hpc,'UniformOutput',false);

Cohfos1_PAR_hpc{k}= ([cohfos1_hpc{:}]);
Cohfos2_PAR_hpc{k}= ([cohfos2_hpc{:}]);

%% Coocur PAR spindle and shuffled HPC ripples.

 parfor r=1:1000
[cohfos1_rand_hpc,cohfos2_rand_hpc]=cellfun(@(equis1,equis2,equis3,equis4,equis5,equis6) co_hfo_spindle(equis1,equis2,equis3,equis4,equis5,equis6),Sx_nhpc,Mx_nhpc,Ex_nhpc,Sr_hpc{r},Sr_hpc{r},Er_hpc{r},'UniformOutput',false);

Cohfos1_PAR_hpc_all(k,r)=sum(cellfun('length',cohfos1_rand_hpc));
Cohfos1_PAR_hpc_unique(k,r)=sum(cellfun(@(equis) length(unique(equis)), cohfos1_rand_hpc));
Cohfos2_PAR_hpc_all(k,r)=sum(cellfun('length',cohfos2_rand_hpc));
Cohfos2_PAR_hpc_unique(k,r)=sum(cellfun(@(equis) length(unique(equis)), cohfos2_rand_hpc));

[out_rand_par]=coccur_multiplets(cohfos2_rand_hpc);
Out_rand_PAR(k,r,:)=(out_rand_par(:,2));
end

%% COOCUR SPINDLE-HPC MULTIPLETS
[out_par]=coccur_multiplets(cohfos2_hpc);
Out_PAR{k}=out_par;

%% HFC HFOs
hfos_hpc(k)=ripple;
hfos_hpc_rate(k)=RipFreq;
hfos_hpc_duration(k)=rip_duration;

%% Coocurent hfos
[cohfos1,cohfos2]=cellfun(@(equis1,equis2,equis3,equis4,equis5,equis6) co_hfo_spindle(equis1,equis2,equis3,equis4,equis5,equis6),Sx_hpc,Mx_hpc,Ex_hpc,Sx_cortex,Mx_cortex,Ex_cortex,'UniformOutput',false);
%Remove repeated values
[cohfos1,cohfos2]=cellfun(@(equis1,equis2) coocur_repeat(equis1,equis2), cohfos1,cohfos2,'UniformOutput',false);

%cohfos1: HPC.
%cohfos2: Cortex.
%Common values:
cohfos_count(k)=sum(cellfun('length',cohfos1));
cohfos_rate(k)=sum(cellfun('length',cohfos1))/(timeasleep*(60));

%%


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

Sig_hpc=sig_hpc(~cellfun('isempty',cohfos1));
Sig_hpc=cellfun(@(equis1,equis2) equis1(equis2),Sig_hpc,coh_samp_hpc,'UniformOutput',false);
Sig_hpc=[Sig_hpc{:}];


[x,y,z,w,h,q,l,p]=hfo_specs_spindles(Sig_hpc,timeasleep,fn,0);
fi_cohfo_hpc(k)=x;
fa_cohfo_hpc(k)=y;
amp_cohfo_hpc(k)=z;
count_cohfo_hpc(k)=w;
rate_cohfo_hpc(k)=h;
dura_cohfo_hpc(k)=q;
auc_cohfo_hpc(k)=l;
p2p_cohfo_hpc(k)=p;

%Single HFOs HPC
v2=cellfun(@(equis1,equis2) single_hfo_get_sample(equis1,equis2),Mx_hpc,cohfos1,'UniformOutput',false);

Sig_hpc_single=cellfun(@(equis1,equis2) equis1(equis2),sig_hpc,v2,'UniformOutput',false);
Sig_hpc_single=[Sig_hpc_single{:}];


[single_mx_hpc_val,single_sx_hpc_val]=cellfun(@(equis1,equis2,equis3) single_hfos_mx(equis1,equis2,equis3),cohfos1,Mx_hpc,Sx_hpc,'UniformOutput',false);
single_mx_hpc_val=[single_mx_hpc_val{:}];
single_sx_hpc_val=[single_sx_hpc_val{:}];

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

%Single HFOs Cortex
v2=cellfun(@(equis1,equis2) single_hfo_get_sample(equis1,equis2),Mx_cortex,cohfos2,'UniformOutput',false);

Sig_cortex_single=cellfun(@(equis1,equis2) equis1(equis2),sig_cortex,v2,'UniformOutput',false);
Sig_cortex_single=[Sig_cortex_single{:}];

[single_mx_cortex_val,single_sx_cortex_val]=cellfun(@(equis1,equis2,equis3) single_hfos_mx(equis1,equis2,equis3),cohfos2,Mx_cortex,Sx_cortex,'UniformOutput',false);
single_mx_cortex_val=[single_mx_cortex_val{:}];
single_sx_cortex_val=[single_sx_cortex_val{:}];

progress_bar(k,length(g),f)
    cd ..    
    end
  xo
%%
save('cohfos_spindles_SWR_24.mat','Cohfos2_PAR_hpc_all','Cohfos2_PAR_hpc_unique','Cohfos2_PFC_hpc_all','Cohfos2_PFC_hpc_unique',...
    'Cohfos1_PAR_hpc_all','Cohfos1_PAR_hpc_unique','Cohfos1_PFC_hpc_all','Cohfos1_PFC_hpc_unique',...
       'Cohfos2_PAR_hpc','Cohfos2_PFC_hpc','Cohfos1_PAR_hpc','Cohfos1_PFC_hpc','Out_rand_PAR','Out_rand_PFC','Out_PAR','Out_PFC')

%% Spindle-HPC ripples. random
 TT=table;
    TT.Variables= [mean(Cohfos2_PAR_hpc_all,2).'; mean(Cohfos2_PAR_hpc_unique,2).';...
       mean(Cohfos2_PFC_hpc_all,2).'; mean(Cohfos2_PFC_hpc_unique,2).'; 
    ] ;
    TT.Properties.VariableNames=[cellfun(@(equis) strrep(equis,'_','-'),labelconditions2.','UniformOutput',false).'].';
                writetable(TT,strcat('hpc_ripple_spindles_random','.xls'),'Sheet',1,'Range','A2:L50')    
%% HPC ripples-spindles-multiplets random
avernum_par=mean(Out_rand_PAR,2);
avernum_par=squeeze(avernum_par);
avernum_par=(avernum_par).';
avernum_pfc=mean(Out_rand_PFC,2);
avernum_pfc=squeeze(avernum_pfc);
avernum_pfc=(avernum_pfc).';


TT=table;
TT.Variables=([avernum_par; [NaN NaN NaN NaN] ;avernum_pfc] );
    TT.Properties.VariableNames=[cellfun(@(equis) strrep(equis,'_','-'),g,'UniformOutput',false).'].';
                writetable(TT,strcat('hpc_ripple_spindles_multiplets_random','.xls'),'Sheet',1,'Range','A2:L50')    
%% Histograms

% PAR ALL
for n=1:4
  histogram(Cohfos2_PAR_hpc_all(n,:),'FaceColor',[0 0 0])
  hold on
    ylabel('Frequency')
    xlabel('Count')
    Y1 = prctile(Cohfos2_PAR_hpc_all(n,:),5)
    Y2 = prctile(Cohfos2_PAR_hpc_all(n,:),95)

    xline(Y1, '-.k','LineWidth',2)
     xline(Y2, '-.k','LineWidth',2)

  xline(cellfun('length',Cohfos2_PAR_hpc(n)), '-r','LineWidth',2)
pause(1)
       close all

end
%%
% PAR unique
for n=1:4
  histogram(Cohfos2_PAR_hpc_unique(n,:),'FaceColor',[0 0 0])
  hold on
    ylabel('Frequency')
    xlabel('Count')
    Y1 = prctile(Cohfos2_PAR_hpc_unique(n,:),5)
    Y2 = prctile(Cohfos2_PAR_hpc_unique(n,:),95)

    xline(Y1, '-.k','LineWidth',2)
    xline(Y2, '-.k','LineWidth',2)

  xline(cell2mat(cellfun(@(equis) length(unique(equis)),Cohfos2_PAR_hpc(n),'UniformOutput',false)), '-r','LineWidth',2)
     xlim([20 160])
     xticks([20:20:160])
      printing(['Spindle_SWR_coocur_control_PAR_unique_Rat' num2str(Rat) '_' labelconditions2{n}])
      close all

end
%%
% PFC ALL
for n=1:4
  histogram(Cohfos2_PFC_hpc_all(n,:),'FaceColor',[0 0 0])
  hold on
    ylabel('Frequency')
    xlabel('Count')
    Y1 = prctile(Cohfos2_PFC_hpc_all(n,:),5)
    Y2 = prctile(Cohfos2_PFC_hpc_all(n,:),95)

    xline(Y1, '-.k','LineWidth',2)
    xline(Y2, '-.k','LineWidth',2)

  xline(cellfun('length',Cohfos2_PFC_hpc(n)), '-r','LineWidth',2)
     xlim([25 350])
     xticks([25:25: 350])
      printing(['Spindle_SWR_coocur_control_PFC_ALL_Rat' num2str(Rat) '_' labelconditions2{n}])
      close all

end

%%
% PFC unique
for n=1:4
  histogram(Cohfos2_PFC_hpc_unique(n,:),'FaceColor',[0 0 0])
  hold on
    ylabel('Frequency')
    xlabel('Count')
    Y1 = prctile(Cohfos2_PFC_hpc_unique(n,:),5)
    Y2 = prctile(Cohfos2_PFC_hpc_unique(n,:),95)

    xline(Y1, '-.k','LineWidth',2)
    xline(Y2, '-.k','LineWidth',2)

  xline(cell2mat(cellfun(@(equis) length(unique(equis)),Cohfos2_PFC_hpc(n),'UniformOutput',false)), '-r','LineWidth',2)
       xlim([25 175])
       xticks([25:25:175])
      printing(['Spindle_SWR_coocur_control_PFC_unique_Rat' num2str(Rat) '_' labelconditions2{n}])
      close all

end   
  %% Spindle-HFOS
labelconditions2=[    {'plusmaze'}
    {'nl'      }
    {'for'     }
    {'novelty' }];
 TT=table;
    TT.Variables= [mean(Cohfos1_PAR_all_g1,2).'; mean(Cohfos1_PAR_all_g2,2).';...
       mean(Cohfos1_PFC_all_g1,2).'; mean(Cohfos1_PFC_all_g2,2).'; 
    ] ;
    TT.Properties.VariableNames=[cellfun(@(equis) strrep(equis,'_','-'),labelconditions2.','UniformOutput',false).'].';
            writetable(TT,strcat('ripple_spindles_random','.xls'),'Sheet',1,'Range','A2:L10')  

%%
% PAR slow
for n=1:4
  histogram(Cohfos1_PAR_all_g1(n,:),'FaceColor',[0 0 0])
  hold on
    ylabel('Frequency')
    xlabel('Count')
    Y1 = prctile(Cohfos1_PAR_all_g1(n,:),5)
    Y2 = prctile(Cohfos1_PAR_all_g1(n,:),95)

    xline(Y1, '-.k','LineWidth',2)
     xline(Y2, '-.k','LineWidth',2)

  xline(cellfun('length',Cohfos1_PAR_g1(n)), '-r','LineWidth',2)
   xlim([0 4])
   printing(['Spindle_hfo_coocur_control_PAR_g1_Rat' num2str(Rat) '_' labelconditions2{n}])
   close all

end

%% PAR Fast
for n=1:4
  histogram(Cohfos1_PAR_all_g2(n,:),'FaceColor',[0 0 0])
   hold on
  
    ylabel('Frequency')
    xlabel('Count')
    Y1 = prctile(Cohfos1_PAR_all_g2(n,:),5)
    Y2 = prctile(Cohfos1_PAR_all_g2(n,:),95)

    xline(Y1, '-.k','LineWidth',2)
    xline(Y2, '-.k','LineWidth',2)

  xline(cellfun('length',Cohfos1_PAR_g2(n)), '-r','LineWidth',2)
  xlim([0 15])
   printing(['Spindle_hfo_coocur_control_PAR_g2_Rat' num2str(Rat) '_' labelconditions2{n}])
   close all
end
 
%% PFC spindles & slow HFOs
for n=1:4

  histogram(Cohfos1_PFC_all_g1(n,:),'FaceColor',[0 0 0])
  hold on
  
    ylabel('Frequency')
    xlabel('Count')
    Y1 = prctile(Cohfos1_PFC_all_g1(n,:),5)
    Y2 = prctile(Cohfos1_PFC_all_g1(n,:),95)

    xline(Y1, '-.k','LineWidth',2)
    xline(Y2, '-.k','LineWidth',2)

  xline(cellfun('length',Cohfos1_PFC_g1(n)), '-r','LineWidth',2)
  xlim([0 4])
  printing(['Spindle_hfo_coocur_control_PFC_g1_Rat' num2str(Rat) '_' labelconditions2{n}])
  close all
end

%% PFC spindles & fast HFOs
  
for n=1:4
  histogram(Cohfos1_PFC_all_g2(n,:),'FaceColor',[0 0 0])
  hold on
    ylabel('Frequency')
    xlabel('Count')
    Y1 = prctile(Cohfos1_PFC_all_g2(n,:),5)
    Y2 = prctile(Cohfos1_PFC_all_g2(n,:),95)

    xline(Y1, '-.k','LineWidth',2)
    xline(Y2, '-.k','LineWidth',2)

  xline(cellfun('length',Cohfos1_PFC_g2(n)), '-r','LineWidth',2)
  xlim([0 13])
  xticks([0:13])
    printing(['Spindle_hfo_coocur_control_PFC_g2_Rat' num2str(Rat) '_' labelconditions2{n}])
  close all

end
%%
save('cohfos_spindles_hfo_24.mat','Cohfos1_PAR_all_g1','Cohfos1_PAR_all_g2','Cohfos1_PFC_all_g1','Cohfos1_PFC_all_g2',...
       'Cohfos1_PAR_g1','Cohfos1_PAR_g2','Cohfos1_PFC_g1','Cohfos1_PFC_g2')

