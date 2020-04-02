%% Find location
close all
clear variables
dname=uigetdir([],'Select folder with Matlab data of trial');
cd(dname)

%%
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

xx = inputdlg({'Cortical area (PAR or PFC)'},...
              'Type your selection', [1 50],{'PAR'}); 


%PFC=dir('*PFC*.mat');
PFC=dir(strcat('*',xx{1},'*.mat'));
PFC=PFC.name;
PFC=load(PFC);
% PFC=PFC.PFC;
PFC=getfield(PFC,xx{1});
PFC=PFC.*(0.195);



A = dir('*states*.mat');
A={A.name};

cellfun(@load,A);


    %Convert signal to 1 sec epochs.
    e_t=1;
    e_samples=e_t*(1000); %fs=1kHz
    ch=length(HPC);
    nc=floor(ch/e_samples); %Number of epochs
    NC=[];
    NC2=[];
    
    for kk=1:nc    
      NC(:,kk)= HPC(1+e_samples*(kk-1):e_samples*kk);
      NC2(:,kk)= PFC(1+e_samples*(kk-1):e_samples*kk);
    end
    
    vec_bin=states;
    vec_bin(vec_bin~=3)=0;
    vec_bin(vec_bin==3)=1;
    %Cluster one values:
    v2=ConsecutiveOnes(vec_bin);
    
    v_index=find(v2~=0);
    v_values=v2(v2~=0);

%     
%     ver=NC(:, v_index(1):v_index(1)+(v_values(1,1)-1));
%     v{1}=reshape(A, numel(A), 1);
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


%% Find largest epoch.
max_length=cellfun(@length,v_hpc);
nrem_epoch=find(max_length==max(max_length)==1);
%% Pop up window
f=figure();
movegui(gcf,'center');
f.Position=[f.Position(1) f.Position(2) 350 f.Position(4)/3];
movegui(gcf,'center');

%Checkboxes
manual_select = uicontrol('Style','checkbox','String','Manual selection of threshold','Position',[10 f.Position(4)-30 250 20],'Value',1);
manual_select.FontSize=11;
% aver_trial = uicontrol('Style','checkbox','String','Average trials','Position',[10 f.Position(4)-60 200 20]);
% aver_trial.FontSize=11;

set(f, 'NumberTitle', 'off', ...
    'Name', 'Select an option');

%Push button
c = uicontrol;
c.String = 'Continue';
c.FontSize=10;
c.Position=[f.Position(1)/7 c.Position(2)-10 f.Position(3)/2 c.Position(4)];

%Callback
c.Callback='uiresume(gcbf)';
uiwait(gcf); 
% scoring=scoring.Value;
manual_select=manual_select.Value;
% aver_trial=aver_trial.Value;
close(f);

%%
if manual_select==0
    D1=4.*std(signal2_hpc{nrem_epoch}) 
    D2=4.*std(signal2_pfc{nrem_epoch})
else
%%
    prompt = {'Select a threshold value for HPC'};
    dlgtitle = 'Threshold HPC';
    definput = {'70'};
    % opts.Interpreter = 'tex';
    answer = inputdlg(prompt,dlgtitle,[1 40],definput);
    D1=str2num(answer{1}) 
    %100 for Rat 26


    prompt = {['Select a threshold value for',' ',xx{1}]};
    dlgtitle = ['Threshold',' ',xx{1}]; %'Threshold PFC';
    definput = {'40'};
    % opts.Interpreter = 'tex';
    answer = inputdlg(prompt,dlgtitle,[1 40],definput);
    D2=str2num(answer{1}) 
%35 for Rat 26
end
%% SWR in HPC
% D1=70;%THRESHOLD
% xo
k=1;
    [Sx_hpc,Ex_hpc,Mx_hpc] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2, D1, (D1)*(1/2), [] ), signal2_hpc,ti,'UniformOutput',false);
    %Douplets and triplets detection
    for l=1:length(Mx_hpc)
         hfo_sequence=ConsecutiveOnes(diff(Mx_hpc{l})<=0.300);
         %Douplets
         douplets=(hfo_sequence==1);
         Mx_hpc_douplets_1{l}=Mx_hpc{l}(find(douplets));
         Mx_hpc_douplets_2{l}=Mx_hpc{l}(find(douplets)+1);
         Sx_hpc_douplets_1{l}=Sx_hpc{l}(find(douplets));
         Sx_hpc_douplets_2{l}=Sx_hpc{l}(find(douplets)+1);
         Ex_hpc_douplets_1{l}=Ex_hpc{l}(find(douplets));
         Ex_hpc_douplets_2{l}=Ex_hpc{l}(find(douplets)+1);
         
         %Triplets
         triplets=(hfo_sequence==2);
         Mx_hpc_triplets_1{l}=Mx_hpc{l}(find(triplets));
         Mx_hpc_triplets_2{l}=Mx_hpc{l}(find(triplets)+1);
         Mx_hpc_triplets_3{l}=Mx_hpc{l}(find(triplets)+2);
         Sx_hpc_triplets_1{l}=Sx_hpc{l}(find(triplets));
         Sx_hpc_triplets_2{l}=Sx_hpc{l}(find(triplets)+1);
         Sx_hpc_triplets_3{l}=Sx_hpc{l}(find(triplets)+2);
         Ex_hpc_triplets_1{l}=Ex_hpc{l}(find(triplets));
         Ex_hpc_triplets_2{l}=Ex_hpc{l}(find(triplets)+1);
         Ex_hpc_triplets_3{l}=Ex_hpc{l}(find(triplets)+2);
         
           %Quadruplets
         quadruplets=(hfo_sequence==3);
         Mx_hpc_quadruplets_1{l}=Mx_hpc{l}(find(quadruplets));
         Mx_hpc_quadruplets_2{l}=Mx_hpc{l}(find(quadruplets)+1);
         Mx_hpc_quadruplets_3{l}=Mx_hpc{l}(find(quadruplets)+2);
         Mx_hpc_quadruplets_4{l}=Mx_hpc{l}(find(quadruplets)+3);
         
         Sx_hpc_quadruplets_1{l}=Sx_hpc{l}(find(quadruplets));
         Sx_hpc_quadruplets_2{l}=Sx_hpc{l}(find(quadruplets)+1);
         Sx_hpc_quadruplets_3{l}=Sx_hpc{l}(find(quadruplets)+2);
         Sx_hpc_quadruplets_4{l}=Sx_hpc{l}(find(quadruplets)+3);
         
         Ex_hpc_quadruplets_1{l}=Ex_hpc{l}(find(quadruplets));
         Ex_hpc_quadruplets_2{l}=Ex_hpc{l}(find(quadruplets)+1);
         Ex_hpc_quadruplets_3{l}=Ex_hpc{l}(find(quadruplets)+2);
         Ex_hpc_quadruplets_4{l}=Ex_hpc{l}(find(quadruplets)+3);
         
         %Pentuplets
         pentuplets=(hfo_sequence==4);
         Mx_hpc_pentuplets_1{l}=Mx_hpc{l}(find(pentuplets));
         Mx_hpc_pentuplets_2{l}=Mx_hpc{l}(find(pentuplets)+1);
         Mx_hpc_pentuplets_3{l}=Mx_hpc{l}(find(pentuplets)+2);
         Mx_hpc_pentuplets_4{l}=Mx_hpc{l}(find(pentuplets)+3);
         Mx_hpc_pentuplets_5{l}=Mx_hpc{l}(find(pentuplets)+4);
         
         
         Sx_hpc_pentuplets_1{l}=Sx_hpc{l}(find(pentuplets));
         Sx_hpc_pentuplets_2{l}=Sx_hpc{l}(find(pentuplets)+1);
         Sx_hpc_pentuplets_3{l}=Sx_hpc{l}(find(pentuplets)+2);
         Sx_hpc_pentuplets_4{l}=Sx_hpc{l}(find(pentuplets)+3);
         Sx_hpc_pentuplets_5{l}=Sx_hpc{l}(find(pentuplets)+4);

         
         Ex_hpc_pentuplets_1{l}=Ex_hpc{l}(find(pentuplets));
         Ex_hpc_pentuplets_2{l}=Ex_hpc{l}(find(pentuplets)+1);
         Ex_hpc_pentuplets_3{l}=Ex_hpc{l}(find(pentuplets)+2);
         Ex_hpc_pentuplets_4{l}=Ex_hpc{l}(find(pentuplets)+3);         
         Ex_hpc_pentuplets_5{l}=Ex_hpc{l}(find(pentuplets)+4);
         
         
         %Sextuplets
         sextuplets=(hfo_sequence==5);
         Mx_hpc_sextuplets_1{l}=Mx_hpc{l}(find(sextuplets));
         Mx_hpc_sextuplets_2{l}=Mx_hpc{l}(find(sextuplets)+1);
         Mx_hpc_sextuplets_3{l}=Mx_hpc{l}(find(sextuplets)+2);
         Mx_hpc_sextuplets_4{l}=Mx_hpc{l}(find(sextuplets)+3);
         Mx_hpc_sextuplets_5{l}=Mx_hpc{l}(find(sextuplets)+4);
         Mx_hpc_sextuplets_6{l}=Mx_hpc{l}(find(sextuplets)+5);
                  
         Sx_hpc_sextuplets_1{l}=Sx_hpc{l}(find(sextuplets));
         Sx_hpc_sextuplets_2{l}=Sx_hpc{l}(find(sextuplets)+1);
         Sx_hpc_sextuplets_3{l}=Sx_hpc{l}(find(sextuplets)+2);
         Sx_hpc_sextuplets_4{l}=Sx_hpc{l}(find(sextuplets)+3);
         Sx_hpc_sextuplets_5{l}=Sx_hpc{l}(find(sextuplets)+4);
         Sx_hpc_sextuplets_6{l}=Sx_hpc{l}(find(sextuplets)+5);
         
         Ex_hpc_sextuplets_1{l}=Ex_hpc{l}(find(sextuplets));
         Ex_hpc_sextuplets_2{l}=Ex_hpc{l}(find(sextuplets)+1);
         Ex_hpc_sextuplets_3{l}=Ex_hpc{l}(find(sextuplets)+2);
         Ex_hpc_sextuplets_4{l}=Ex_hpc{l}(find(sextuplets)+3);         
         Ex_hpc_sextuplets_5{l}=Ex_hpc{l}(find(sextuplets)+4);
         Ex_hpc_sextuplets_6{l}=Ex_hpc{l}(find(sextuplets)+5);
         
                  %nonuplets
         nonuplets=(hfo_sequence==8);
         Mx_hpc_nonuplets_1{l}=Mx_hpc{l}(find(nonuplets));
         Mx_hpc_nonuplets_2{l}=Mx_hpc{l}(find(nonuplets)+1);
         Mx_hpc_nonuplets_3{l}=Mx_hpc{l}(find(nonuplets)+2);
         Mx_hpc_nonuplets_4{l}=Mx_hpc{l}(find(nonuplets)+3);
         Mx_hpc_nonuplets_5{l}=Mx_hpc{l}(find(nonuplets)+4);
         Mx_hpc_nonuplets_6{l}=Mx_hpc{l}(find(nonuplets)+5);
         Mx_hpc_nonuplets_7{l}=Mx_hpc{l}(find(nonuplets)+6);
         Mx_hpc_nonuplets_8{l}=Mx_hpc{l}(find(nonuplets)+7);
         Mx_hpc_nonuplets_9{l}=Mx_hpc{l}(find(nonuplets)+8);

                  
         Sx_hpc_nonuplets_1{l}=Sx_hpc{l}(find(nonuplets));
         Sx_hpc_nonuplets_2{l}=Sx_hpc{l}(find(nonuplets)+1);
         Sx_hpc_nonuplets_3{l}=Sx_hpc{l}(find(nonuplets)+2);
         Sx_hpc_nonuplets_4{l}=Sx_hpc{l}(find(nonuplets)+3);
         Sx_hpc_nonuplets_5{l}=Sx_hpc{l}(find(nonuplets)+4);
         Sx_hpc_nonuplets_6{l}=Sx_hpc{l}(find(nonuplets)+5);
         Sx_hpc_nonuplets_7{l}=Sx_hpc{l}(find(nonuplets)+6);
         Sx_hpc_nonuplets_8{l}=Sx_hpc{l}(find(nonuplets)+7);
         Sx_hpc_nonuplets_9{l}=Sx_hpc{l}(find(nonuplets)+8);
         
         Ex_hpc_nonuplets_1{l}=Ex_hpc{l}(find(nonuplets));
         Ex_hpc_nonuplets_2{l}=Ex_hpc{l}(find(nonuplets)+1);
         Ex_hpc_nonuplets_3{l}=Ex_hpc{l}(find(nonuplets)+2);
         Ex_hpc_nonuplets_4{l}=Ex_hpc{l}(find(nonuplets)+3);         
         Ex_hpc_nonuplets_5{l}=Ex_hpc{l}(find(nonuplets)+4);
         Ex_hpc_nonuplets_6{l}=Ex_hpc{l}(find(nonuplets)+5);
         Ex_hpc_nonuplets_7{l}=Ex_hpc{l}(find(nonuplets)+6);         
         Ex_hpc_nonuplets_8{l}=Ex_hpc{l}(find(nonuplets)+7);
         Ex_hpc_nonuplets_9{l}=Ex_hpc{l}(find(nonuplets)+8);  
    end    
%     Sx_hpc=Sx_hpc_douplets_1; 
%     Ex_hpc= Ex_hpc_douplets_1;
%     Mx_hpc=Mx_hpc_douplets_1;
    
    swr_hpc(:,:,k)=[Sx_hpc Ex_hpc Mx_hpc];
    s_hpc(:,k)=cellfun('length',Sx_hpc);
    
    %Douplets
    swr_hpc_douplets_1(:,:,k)=[Sx_hpc_douplets_1.' Ex_hpc_douplets_1.' Mx_hpc_douplets_1.'];
    swr_hpc_douplets_2(:,:,k)=[Sx_hpc_douplets_2.' Ex_hpc_douplets_2.' Mx_hpc_douplets_2.'];

    %Triplets
    swr_hpc_triplets_1(:,:,k)=[Sx_hpc_triplets_1.' Ex_hpc_triplets_1.' Mx_hpc_triplets_1.'];
    swr_hpc_triplets_2(:,:,k)=[Sx_hpc_triplets_2.' Ex_hpc_triplets_2.' Mx_hpc_triplets_2.'];
    swr_hpc_triplets_3(:,:,k)=[Sx_hpc_triplets_3.' Ex_hpc_triplets_3.' Mx_hpc_triplets_3.'];
    
    
    %Quadruplets
    swr_hpc_quadruplets_1(:,:,k)=[Sx_hpc_quadruplets_1.' Ex_hpc_quadruplets_1.' Mx_hpc_quadruplets_1.'];
    swr_hpc_quadruplets_2(:,:,k)=[Sx_hpc_quadruplets_2.' Ex_hpc_quadruplets_2.' Mx_hpc_quadruplets_2.'];
    swr_hpc_quadruplets_3(:,:,k)=[Sx_hpc_quadruplets_3.' Ex_hpc_quadruplets_3.' Mx_hpc_quadruplets_3.'];
    swr_hpc_quadruplets_4(:,:,k)=[Sx_hpc_quadruplets_4.' Ex_hpc_quadruplets_4.' Mx_hpc_quadruplets_4.'];

    
    %Pentuplets
    swr_hpc_pentuplets_1(:,:,k)=[Sx_hpc_pentuplets_1.' Ex_hpc_pentuplets_1.' Mx_hpc_pentuplets_1.'];
    swr_hpc_pentuplets_2(:,:,k)=[Sx_hpc_pentuplets_2.' Ex_hpc_pentuplets_2.' Mx_hpc_pentuplets_2.'];
    swr_hpc_pentuplets_3(:,:,k)=[Sx_hpc_pentuplets_3.' Ex_hpc_pentuplets_3.' Mx_hpc_pentuplets_3.'];
    swr_hpc_pentuplets_4(:,:,k)=[Sx_hpc_pentuplets_4.' Ex_hpc_pentuplets_4.' Mx_hpc_pentuplets_4.'];
    swr_hpc_pentuplets_5(:,:,k)=[Sx_hpc_pentuplets_5.' Ex_hpc_pentuplets_5.' Mx_hpc_pentuplets_5.'];
    
    %Sextuplets
    swr_hpc_sextuplets_1(:,:,k)=[Sx_hpc_sextuplets_1.' Ex_hpc_sextuplets_1.' Mx_hpc_sextuplets_1.'];
    swr_hpc_sextuplets_2(:,:,k)=[Sx_hpc_sextuplets_2.' Ex_hpc_sextuplets_2.' Mx_hpc_sextuplets_2.'];
    swr_hpc_sextuplets_3(:,:,k)=[Sx_hpc_sextuplets_3.' Ex_hpc_sextuplets_3.' Mx_hpc_sextuplets_3.'];
    swr_hpc_sextuplets_4(:,:,k)=[Sx_hpc_sextuplets_4.' Ex_hpc_sextuplets_4.' Mx_hpc_sextuplets_4.'];
    swr_hpc_sextuplets_5(:,:,k)=[Sx_hpc_sextuplets_5.' Ex_hpc_sextuplets_5.' Mx_hpc_sextuplets_5.'];
    swr_hpc_sextuplets_6(:,:,k)=[Sx_hpc_sextuplets_6.' Ex_hpc_sextuplets_6.' Mx_hpc_sextuplets_6.'];

    %nonuplets
    swr_hpc_nonuplets_1(:,:,k)=[Sx_hpc_nonuplets_1.' Ex_hpc_nonuplets_1.' Mx_hpc_nonuplets_1.'];
    swr_hpc_nonuplets_2(:,:,k)=[Sx_hpc_nonuplets_2.' Ex_hpc_nonuplets_2.' Mx_hpc_nonuplets_2.'];
    swr_hpc_nonuplets_3(:,:,k)=[Sx_hpc_nonuplets_3.' Ex_hpc_nonuplets_3.' Mx_hpc_nonuplets_3.'];
    swr_hpc_nonuplets_4(:,:,k)=[Sx_hpc_nonuplets_4.' Ex_hpc_nonuplets_4.' Mx_hpc_nonuplets_4.'];
    swr_hpc_nonuplets_5(:,:,k)=[Sx_hpc_nonuplets_5.' Ex_hpc_nonuplets_5.' Mx_hpc_nonuplets_5.'];
    swr_hpc_nonuplets_6(:,:,k)=[Sx_hpc_nonuplets_6.' Ex_hpc_nonuplets_6.' Mx_hpc_nonuplets_6.'];
    swr_hpc_nonuplets_7(:,:,k)=[Sx_hpc_nonuplets_7.' Ex_hpc_nonuplets_7.' Mx_hpc_nonuplets_7.'];
    swr_hpc_nonuplets_8(:,:,k)=[Sx_hpc_nonuplets_8.' Ex_hpc_nonuplets_8.' Mx_hpc_nonuplets_8.'];
    swr_hpc_nonuplets_9(:,:,k)=[Sx_hpc_nonuplets_9.' Ex_hpc_nonuplets_9.' Mx_hpc_nonuplets_9.'];    
%% Cortical ripples
%D2=35;%THRESHOLD
    [Sx_pfc,Ex_pfc,Mx_pfc] =cellfun(@(equis1,equis2) findRipplesLisa2020(equis1, equis2, D2, (D2)*(1/2), [] ), signal2_pfc,ti,'UniformOutput',false);    
    swr_pfc(:,:,k)=[Sx_pfc Ex_pfc Mx_pfc];
    s_pfc(:,k)=cellfun('length',Sx_pfc);%% Cortical ripples

%%
% Find longuest epoch and plot
% max_length=cellfun(@length,v_hpc);
% N=max_length==max(max_length);

%Largest amount of PAR HFOS
max_length=cellfun(@length,swr_pfc(:,1));
N=max_length==max(max_length);

%Largest amount of HPC QUAD
max_length=cellfun(@length,swr_hpc_quadruplets_1(:,1));
N=max_length==max(max_length);

%Largest amount of HPC pentuplets
max_length=cellfun(@length,swr_hpc_pentuplets_1(:,1));
N=max_length==max(max_length);

%Largest amount of HPC sextuplets
max_length=cellfun(@length,swr_hpc_sextuplets_1(:,1));
N=max_length==max(max_length);

%Largest amount of HPC sextuplets
max_length=cellfun(@length,swr_hpc_nonuplets_1(:,1));
N=max_length==max(max_length);

hpc=V_hpc{N};
pfc=V_pfc{N};
hpc2=signal2_hpc{N};
pfc2=signal2_pfc{N};
n=find(N);

% plot((1:length(hpc))./1000./60,5.*zscore(hpc)+100,'Color','blue')
% hold on
% plot((1:length(pfc))./1000./60,5.*zscore(pfc)+150,'Color','red')
% xlabel('Time (Minutes)')
%%
xo
%%
prompt = {'Select window length (msec):','Brain area:'};
dlgtitle = 'Input';
dims = [1 35];
definput = {'100','PAR'};
answer = inputdlg(prompt,dlgtitle,dims,definput);
 win_len=str2num(answer{1});
 BR=answer{2};
 %%
close all
plot((1:length(hpc))./1000,5.*zscore(hpc)+100,'Color','black')
hold on
plot((1:length(pfc))./1000,5.*zscore(pfc)+150,'Color','black')
xlabel('Time (Seconds)')


plot((1:length(hpc2))./1000,5.*zscore(hpc2)+220,'Color','black')
plot((1:length(pfc2))./1000,5.*zscore(pfc2)+290,'Color','black')


yticks([100 150 220 290])
yticklabels({'HPC',xx{1},'HPC (Bandpassed)',[xx{1} '(Bandpassed)']})
% a = get(gca,'YTickLabel');
% set(gca,'YTickLabel',a,'FontName','Times','fontsize',12)
b=gca;
b.FontSize=12;
% n=find(max_length==max(max_length));

%  n=find((cellfun('length',swr_pfc(:,1)))==max(cellfun('length',swr_pfc(:,1))))

if strcmp(BR,'PAR')
    sn=swr_pfc{n,3};
else
    sn=swr_hpc{n,3};
end

if isempty(sn)
    errordlg('No HFOs found','Error');
    xo
end

prompt = {['Select HFO ID number. Max value:' num2str(length(sn))]};
dlgtitle = 'Input';
dims = [1 35];
definput = {'1'};
answer2 = inputdlg(prompt,dlgtitle,dims,definput);
answer2=str2num(answer2{1});
 

% n=find(max_length==max(max_length));
%  n=find((cellfun('length',swr_pfc(:,1)))==max(cellfun('length',swr_pfc(:,1))))

stem([swr_hpc{n,3}],ones(length([swr_hpc{n}]),1).*250,'Color','blue') %(HPC)
stem([swr_pfc{n,3}],ones(length([swr_pfc{n}]),1).*250,'Color','red')%Seconds (Cortex)
% title('Raw traces')

xlim([sn(answer2)-win_len/1000 sn(answer2)+win_len/1000])
%%
plot((1:length(hpc))./1000,5.*zscore(hpc)+100,'Color','black')
hold on
plot((1:length(pfc))./1000,5.*zscore(pfc)+125,'Color','black')
xlabel('Time (Seconds)')

xlim([sn(answer2)-win_len/1000 sn(answer2)+win_len/1000])
title('Raw signal')

yticks([100 125])
yticklabels({'HPC',xx{1}})
%% Not z-scored amplitude.
subplot(4,1,2)
plot((1:length(hpc))./1000,(hpc),'Color','black')
%hold on
xlabel('Time (Seconds)')
title('Raw signal HPC')
xlim([sn(answer2)-win_len/1000 sn(answer2)+win_len/1000])
ylabel('\muV')

subplot(4,1,1)
plot((1:length(pfc))./1000,(pfc),'Color','black')
xlabel('Time (Seconds)')
title('Raw signal PAR')
xlim([sn(answer2)-win_len/1000 sn(answer2)+win_len/1000])
ylabel('\muV')

subplot(4,1,4)
plot((1:length(hpc))./1000,(hpc2),'Color','black')
%hold on
xlabel('Time (Seconds)')
title('Bandpassed signal HPC')
xlim([sn(answer2)-win_len/1000 sn(answer2)+win_len/1000])
ylabel('\muV')

subplot(4,1,3)
plot((1:length(pfc))./1000,(pfc2),'Color','black')
xlabel('Time (Seconds)')
title('Bandpassed signal PAR')
ylabel('\muV')

xlim([sn(answer2)-win_len/1000 sn(answer2)+win_len/1000])


% 
% yticks([100 125])
% yticklabels({'HPC',xx{1}})
%%
%printing(['All_coocur_' num2str(answer2)])
printing(['All_HPC_single_' num2str(answer2)])

% printing(['Raw_coocur_' num2str(answer2)])


% printing(['Raw_single_HPC_' num2str(answer2)])
%%
close all
plot((1:length(hpc2))./1000,5.*zscore(hpc2)+100,'Color','black')
hold on
plot((1:length(pfc2))./1000,5.*zscore(pfc2)+200,'Color','black')
xlabel('Time (Seconds)')

xlim([sn(answer2)-win_len/1000 sn(answer2)+win_len/1000])
title('Bandpassed signal')
yticks([100 200])
yticklabels({'HPC',xx{1}})


%%
% printing('Filtered_coccur_10')
% printing(['Filtered_single_HPC_' num2str(answer2)])
printing(['Filtered_coocur_' num2str(answer2)])

%%
xo
%% Douplets
win_len=300;
close all
plot((1:length(hpc))./1000,5.*zscore(hpc)+100,'Color','black')
hold on
plot((1:length(pfc))./1000,5.*zscore(pfc)+150,'Color','black')
xlabel('Time (Seconds)')


plot((1:length(hpc2))./1000,5.*zscore(hpc2)+220,'Color','black')
plot((1:length(pfc2))./1000,5.*zscore(pfc2)+290,'Color','black')


yticks([100 150 220 290])
yticklabels({'HPC',xx{1},'HPC (Bandpassed)',[xx{1} '(Bandpassed)']})
% a = get(gca,'YTickLabel');
% set(gca,'YTickLabel',a,'FontName','Times','fontsize',12)
b=gca;
b.FontSize=12;
% n=find(max_length==max(max_length));

%  n=find((cellfun('length',swr_pfc(:,1)))==max(cellfun('length',swr_pfc(:,1))))

if strcmp(BR,'PAR')
    sn=swr_pfc{n,3};
else
    sn=swr_hpc_douplets_1{n,3};
end

if isempty(sn)
    errordlg('No HFOs found','Error');
    xo
end

prompt = {['Select HFO ID number. Max value:' num2str(length(sn))]};
dlgtitle = 'Input';
dims = [1 35];
definput = {'1'};
answer2 = inputdlg(prompt,dlgtitle,dims,definput);
answer2=str2num(answer2{1});
 

% n=find(max_length==max(max_length));
%  n=find((cellfun('length',swr_pfc(:,1)))==max(cellfun('length',swr_pfc(:,1))))

stem([swr_hpc_douplets_1{n,3}],ones(length([swr_hpc_douplets_1{n}]),1).*250,'Color','blue') %(HPC)
stem([swr_hpc_douplets_2{n,3}],ones(length([swr_hpc_douplets_2{n}]),1).*250,'Color','green') %(HPC)

stem([swr_pfc{n,3}],ones(length([swr_pfc{n}]),1).*250,'Color','red')%Seconds (Cortex)
% title('Raw traces')

xlim([sn(answer2)-win_len/1000 sn(answer2)+win_len/1000])
%%
%% Triplets
win_len=600;
close all
plot((1:length(hpc))./1000,5.*zscore(hpc)+100,'Color','black')
hold on
plot((1:length(pfc))./1000,5.*zscore(pfc)+150,'Color','black')
xlabel('Time (Seconds)')


plot((1:length(hpc2))./1000,5.*zscore(hpc2)+220,'Color','black')
plot((1:length(pfc2))./1000,5.*zscore(pfc2)+290,'Color','black')


yticks([100 150 220 290])
yticklabels({'HPC',xx{1},'HPC (Bandpassed)',[xx{1} '(Bandpassed)']})
% a = get(gca,'YTickLabel');
% set(gca,'YTickLabel',a,'FontName','Times','fontsize',12)
b=gca;
b.FontSize=12;
% n=find(max_length==max(max_length));

%  n=find((cellfun('length',swr_pfc(:,1)))==max(cellfun('length',swr_pfc(:,1))))

if strcmp(BR,'PAR')
    sn=swr_pfc{n,3};
else
    sn=swr_hpc_triplets_1{n,3};
end

if isempty(sn)
    errordlg('No HFOs found','Error');
    xo
end

prompt = {['Select HFO ID number. Max value:' num2str(length(sn))]};
dlgtitle = 'Input';
dims = [1 35];
definput = {'1'};
answer2 = inputdlg(prompt,dlgtitle,dims,definput);
answer2=str2num(answer2{1});
 

% n=find(max_length==max(max_length));
%  n=find((cellfun('length',swr_pfc(:,1)))==max(cellfun('length',swr_pfc(:,1))))

stem([swr_hpc_triplets_1{n,3}],ones(length([swr_hpc_triplets_1{n}]),1).*250,'Color','blue') %(HPC)
stem([swr_hpc_triplets_2{n,3}],ones(length([swr_hpc_triplets_2{n}]),1).*250,'Color','green') %(HPC)
stem([swr_hpc_triplets_3{n,3}],ones(length([swr_hpc_triplets_3{n}]),1).*250,'Color','cyan') %(HPC)


stem([swr_pfc{n,3}],ones(length([swr_pfc{n}]),1).*250,'Color','red')%Seconds (Cortex)
% title('Raw traces')

xlim([sn(answer2)-win_len/1000 sn(answer2)+win_len/1000])

%% quadruplets
win_len=3*300;
close all
plot((1:length(hpc))./1000,5.*zscore(hpc)+100,'Color','black')
hold on
plot((1:length(pfc))./1000,5.*zscore(pfc)+150,'Color','black')
xlabel('Time (Seconds)')


plot((1:length(hpc2))./1000,5.*zscore(hpc2)+220,'Color','black')
plot((1:length(pfc2))./1000,5.*zscore(pfc2)+290,'Color','black')


yticks([100 150 220 290])
yticklabels({'HPC',xx{1},'HPC (Bandpassed)',[xx{1} '(Bandpassed)']})
% a = get(gca,'YTickLabel');
% set(gca,'YTickLabel',a,'FontName','Times','fontsize',12)
b=gca;
b.FontSize=12;
% n=find(max_length==max(max_length));

%  n=find((cellfun('length',swr_pfc(:,1)))==max(cellfun('length',swr_pfc(:,1))))

if strcmp(BR,'PAR')
    sn=swr_pfc{n,3};
else
    sn=swr_hpc_quadruplets_1{n,3};
end

if isempty(sn)
    errordlg('No HFOs found','Error');
    xo
end

prompt = {['Select HFO ID number. Max value:' num2str(length(sn))]};
dlgtitle = 'Input';
dims = [1 35];
definput = {'1'};
answer2 = inputdlg(prompt,dlgtitle,dims,definput);
answer2=str2num(answer2{1});
 

% n=find(max_length==max(max_length));
%  n=find((cellfun('length',swr_pfc(:,1)))==max(cellfun('length',swr_pfc(:,1))))

stem([swr_hpc_quadruplets_1{n,3}],ones(length([swr_hpc_quadruplets_1{n}]),1).*250,'Color','blue') %(HPC)
stem([swr_hpc_quadruplets_2{n,3}],ones(length([swr_hpc_quadruplets_2{n}]),1).*250,'Color','green') %(HPC)
stem([swr_hpc_quadruplets_3{n,3}],ones(length([swr_hpc_quadruplets_3{n}]),1).*250,'Color','cyan') %(HPC)
stem([swr_hpc_quadruplets_4{n,3}],ones(length([swr_hpc_quadruplets_4{n}]),1).*250,'Color','magenta') %(HPC)


stem([swr_pfc{n,3}],ones(length([swr_pfc{n}]),1).*250,'Color','red')%Seconds (Cortex)
% title('Raw traces')

xlim([sn(answer2)-win_len/1000 sn(answer2)+win_len/1000])
%%
%% pentuplets
win_len=4*300;
close all
plot((1:length(hpc))./1000,5.*zscore(hpc)+100,'Color','black')
hold on
plot((1:length(pfc))./1000,5.*zscore(pfc)+150,'Color','black')
xlabel('Time (Seconds)')


plot((1:length(hpc2))./1000,5.*zscore(hpc2)+220,'Color','black')
plot((1:length(pfc2))./1000,5.*zscore(pfc2)+290,'Color','black')


yticks([100 150 220 290])
yticklabels({'HPC',xx{1},'HPC (Bandpassed)',[xx{1} '(Bandpassed)']})
% a = get(gca,'YTickLabel');
% set(gca,'YTickLabel',a,'FontName','Times','fontsize',12)
b=gca;
b.FontSize=12;
% n=find(max_length==max(max_length));

%  n=find((cellfun('length',swr_pfc(:,1)))==max(cellfun('length',swr_pfc(:,1))))

if strcmp(BR,'PAR')
    sn=swr_pfc{n,3};
else
    sn=swr_hpc_pentuplets_1{n,3};
end

if isempty(sn)
    errordlg('No HFOs found','Error');
    xo
end

prompt = {['Select HFO ID number. Max value:' num2str(length(sn))]};
dlgtitle = 'Input';
dims = [1 35];
definput = {'1'};
answer2 = inputdlg(prompt,dlgtitle,dims,definput);
answer2=str2num(answer2{1});
 

% n=find(max_length==max(max_length));
%  n=find((cellfun('length',swr_pfc(:,1)))==max(cellfun('length',swr_pfc(:,1))))

stem([swr_hpc_pentuplets_1{n,3}],ones(length([swr_hpc_pentuplets_1{n}]),1).*250,'Color','blue') %(HPC)
stem([swr_hpc_pentuplets_2{n,3}],ones(length([swr_hpc_pentuplets_2{n}]),1).*250,'Color','green') %(HPC)
stem([swr_hpc_pentuplets_3{n,3}],ones(length([swr_hpc_pentuplets_3{n}]),1).*250,'Color','cyan') %(HPC)
stem([swr_hpc_pentuplets_4{n,3}],ones(length([swr_hpc_pentuplets_4{n}]),1).*250,'Color','magenta') %(HPC)
stem([swr_hpc_pentuplets_5{n,3}],ones(length([swr_hpc_pentuplets_5{n}]),1).*250,'Color',[1 165/255 0]) %(HPC)


stem([swr_pfc{n,3}],ones(length([swr_pfc{n}]),1).*250,'Color','red')%Seconds (Cortex)
% title('Raw traces')

xlim([sn(answer2)-win_len/1000 sn(answer2)+win_len/1000])
%% sextuplets
win_len=5*300;
close all
plot((1:length(hpc))./1000,5.*zscore(hpc)+100,'Color','black')
hold on
plot((1:length(pfc))./1000,5.*zscore(pfc)+150,'Color','black')
xlabel('Time (Seconds)')


plot((1:length(hpc2))./1000,5.*zscore(hpc2)+220,'Color','black')
plot((1:length(pfc2))./1000,5.*zscore(pfc2)+290,'Color','black')


yticks([100 150 220 290])
yticklabels({'HPC',xx{1},'HPC (Bandpassed)',[xx{1} '(Bandpassed)']})
% a = get(gca,'YTickLabel');
% set(gca,'YTickLabel',a,'FontName','Times','fontsize',12)
b=gca;
b.FontSize=12;
% n=find(max_length==max(max_length));

%  n=find((cellfun('length',swr_pfc(:,1)))==max(cellfun('length',swr_pfc(:,1))))

if strcmp(BR,'PAR')
    sn=swr_pfc{n,3};
else
    sn=swr_hpc_sextuplets_1{n,3};
end

if isempty(sn)
    errordlg('No HFOs found','Error');
    xo
end

prompt = {['Select HFO ID number. Max value:' num2str(length(sn))]};
dlgtitle = 'Input';
dims = [1 35];
definput = {'1'};
answer2 = inputdlg(prompt,dlgtitle,dims,definput);
answer2=str2num(answer2{1});
 

% n=find(max_length==max(max_length));
%  n=find((cellfun('length',swr_pfc(:,1)))==max(cellfun('length',swr_pfc(:,1))))

stem([swr_hpc_sextuplets_1{n,3}],ones(length([swr_hpc_sextuplets_1{n}]),1).*250,'Color','blue') %(HPC)
stem([swr_hpc_sextuplets_2{n,3}],ones(length([swr_hpc_sextuplets_2{n}]),1).*250,'Color','green') %(HPC)
stem([swr_hpc_sextuplets_3{n,3}],ones(length([swr_hpc_sextuplets_3{n}]),1).*250,'Color','cyan') %(HPC)
stem([swr_hpc_sextuplets_4{n,3}],ones(length([swr_hpc_sextuplets_4{n}]),1).*250,'Color','magenta') %(HPC)
stem([swr_hpc_sextuplets_5{n,3}],ones(length([swr_hpc_sextuplets_5{n}]),1).*250,'Color',[1 165/255 0]) %(HPC)
stem([swr_hpc_sextuplets_6{n,3}],ones(length([swr_hpc_sextuplets_6{n}]),1).*250,'Color','blue') %(HPC)


 stem([swr_pfc{n,3}],ones(length([swr_pfc{n}]),1).*300,'Color','red')%Seconds (Cortex)
% title('Raw traces')

xlim([sn(answer2)-win_len/1000 sn(answer2)+win_len/1000])
%% nonuplets
win_len=8*300;
close all
plot((1:length(hpc))./1000,5.*zscore(hpc)+100,'Color','black')
hold on
plot((1:length(pfc))./1000,5.*zscore(pfc)+150,'Color','black')
xlabel('Time (Seconds)')


plot((1:length(hpc2))./1000,5.*zscore(hpc2)+220,'Color','black')
plot((1:length(pfc2))./1000,5.*zscore(pfc2)+290,'Color','black')


yticks([100 150 220 290])
yticklabels({'HPC',xx{1},'HPC (Bandpassed)',[xx{1} '(Bandpassed)']})
% a = get(gca,'YTickLabel');
% set(gca,'YTickLabel',a,'FontName','Times','fontsize',12)
b=gca;
b.FontSize=12;
% n=find(max_length==max(max_length));

%  n=find((cellfun('length',swr_pfc(:,1)))==max(cellfun('length',swr_pfc(:,1))))

if strcmp(BR,'PAR')
    sn=swr_pfc{n,3};
else
    sn=swr_hpc_nonuplets_1{n,3};
end

if isempty(sn)
    errordlg('No HFOs found','Error');
    xo
end

prompt = {['Select HFO ID number. Max value:' num2str(length(sn))]};
dlgtitle = 'Input';
dims = [1 35];
definput = {'1'};
answer2 = inputdlg(prompt,dlgtitle,dims,definput);
answer2=str2num(answer2{1});
 

% n=find(max_length==max(max_length));
%  n=find((cellfun('length',swr_pfc(:,1)))==max(cellfun('length',swr_pfc(:,1))))

stem([swr_hpc_nonuplets_1{n,3}],ones(length([swr_hpc_nonuplets_1{n}]),1).*250,'Color','blue') %(HPC)
stem([swr_hpc_nonuplets_2{n,3}],ones(length([swr_hpc_nonuplets_2{n}]),1).*250,'Color','green') %(HPC)
stem([swr_hpc_nonuplets_3{n,3}],ones(length([swr_hpc_nonuplets_3{n}]),1).*250,'Color','cyan') %(HPC)
stem([swr_hpc_nonuplets_4{n,3}],ones(length([swr_hpc_nonuplets_4{n}]),1).*250,'Color','magenta') %(HPC)
stem([swr_hpc_nonuplets_5{n,3}],ones(length([swr_hpc_nonuplets_5{n}]),1).*250,'Color',[1 165/255 0]) %(HPC)
stem([swr_hpc_nonuplets_6{n,3}],ones(length([swr_hpc_nonuplets_6{n}]),1).*250,'Color','blue') %(HPC)
stem([swr_hpc_nonuplets_7{n,3}],ones(length([swr_hpc_nonuplets_7{n}]),1).*250,'Color','blue') %(HPC)
stem([swr_hpc_nonuplets_8{n,3}],ones(length([swr_hpc_nonuplets_8{n}]),1).*250,'Color','green') %(HPC)
stem([swr_hpc_nonuplets_9{n,3}],ones(length([swr_hpc_nonuplets_9{n}]),1).*250,'Color','cyan') %(HPC)

 stem([swr_pfc{n,3}],ones(length([swr_pfc{n}]),1).*300,'Color','red')%Seconds (Cortex)
% title('Raw traces')

xlim([sn(answer2)-win_len/1000 sn(answer2)+win_len/1000])

%%
answer1 = questdlg('Compute spectrograms?', ...
	'Select one', ...
	'Yes','No','No');
% Handle response
switch answer1
    case 'Yes'
        dessert = 1;
    case 'No'
        dessert = 0;
    otherwise
        xo
end


if dessert==1
%%  Spectrogram HPC

    % figure()
    figure('Name','HPC spectrogram','NumberTitle','off')
    aver=hpc;
    t_aver=1:length(aver);
    t_aver=t_aver-1;
    t_aver=t_aver/1000;
    t_aver={t_aver};

    w=1;
    %toy=[1:60:length(t_aver{1})/1000]; %secs
    toy=[1:0.05:length(t_aver{1})/1000]; %secs %480

    %toy=[-1:.01:1];
    % q={[aver  ].'};
    q={[aver aver aver ].'};

    freq4=barplot2_ft(q,t_aver,[100:2:300],w,toy);
    [freq4]=spectral_correction(freq4);

    cfg              = [];
    %cfg.zlim=zlim; %U might want to uncomment this if you use a smaller step: (Memory purposes)
    cfg.channel      = freq4.label{w};
    cfg.colormap=colormap(jet(256));

    a1=subplot(2,1,1)
    ft_singleplotTFR(cfg, freq4);
    xlim([0 max(t_aver{1})])
    g=title('High Frequencies HPC');
    g.FontSize=12;
    xlabel('Time (s)')
    %ylabel('uV')
    ylabel('Frequency (Hz)')
    % xlim([0.3 0.8])

    a2=subplot(2,1,2)
    plot(t_aver{1},aver)
    xlim([0 max(t_aver{1})])
    colorbar()

    linkaxes([a1 a2],'x')

    %%  Spectrogram Cortical region

    % figure()
    figure('Name',[xx{1} ' spectrogram'],'NumberTitle','off')
    aver=pfc;
    t_aver=1:length(aver);
    t_aver=t_aver-1;
    t_aver=t_aver/1000;
    t_aver={t_aver};

    w=1;
    %toy=[1:60:length(t_aver{1})/1000]; %secs
    toy=[1:0.025:length(t_aver{1})/1000]; %secs %480

    %toy=[-1:.01:1];
    % q={[aver  ].'};
    q={[aver aver aver ].'};

    freq4=barplot2_ft(q,t_aver,[100:2:300],w,toy);
    [freq4]=spectral_correction(freq4);

    cfg              = [];
    %cfg.zlim=zlim; %U might want to uncomment this if you use a smaller step: (Memory purposes)
    cfg.channel      = freq4.label{w};
    cfg.colormap=colormap(jet(256));

    a1=subplot(2,1,1)
    ft_singleplotTFR(cfg, freq4);
    xlim([0 max(t_aver{1})])
    g=title(['High Frequencies ' xx{1}]);
    g.FontSize=12;
    xlabel('Time (s)')
    %ylabel('uV')
    ylabel('Frequency (Hz)')
    % xlim([0.3 0.8])

    a2=subplot(2,1,2)
    plot(t_aver{1},aver)
    xlim([0 max(t_aver{1})])
    colorbar()

    linkaxes([a1 a2],'x')
%%
end


%% Bandpassed signals.
%num_1=0;
figure()
hpc=signal2_hpc{max_length==max(max_length)};
pfc=signal2_pfc{max_length==max(max_length)};
ax1 = subplot(2,1,2)
plot((1:length(hpc))./1000./60,(hpc),'Color','blue')
title('HPC (100-300 Hz)')  
D=ones(1,length(hpc)).*D1;
hold on
plot((1:length(hpc))./1000./60,(D),'Color','black')

% yticks([num_1 (D1)+num_1])
% yticklabels({'HPC',['Thr: ' num2str(D1)]})
stem([swr_hpc{n,3}/60],ones(length([swr_hpc{n}]),1).*250,'Color','black')
xlabel('Time (Minutes)')
b=gca;
b.FontSize=10;

ax2 = subplot(2,1,1)
plot((1:length(pfc))./1000./60,(pfc),'Color','red')
title([xx{1} ' (100-300 Hz)'])
D=ones(1,length(pfc)).*D2;
hold on
plot((1:length(pfc))./1000./60,D,'Color','black')

stem([swr_pfc{n,3}/60],ones(length([swr_pfc{n}]),1).*100,'Color','black')
xlabel('Time (Minutes)')
linkaxes([ax1 ax2 ],'xy')

% b = get(gca,'XTickLabel');
b=gca;
b.FontSize=10;
% set(gca,'XTickLabel',b,'FontName','Times','fontsize',10)
%set(gca,'XTickLabel',b,'FontName','Times','fontsize',10)

% %%  Spectrogram HPC
% 
% figure()
% aver=hpc;
% t_aver=1:length(aver);
% t_aver=t_aver-1;
% t_aver=t_aver/1000;
% t_aver={t_aver};
% 
% w=1;
% %toy=[1:60:length(t_aver{1})/1000]; %secs
% toy=[1:0.5:length(t_aver{1})/1000]; %secs %480
% 
% %toy=[-1:.01:1];
% % q={[aver  ].'};
% q={[aver aver aver ].'};
% 
% freq4=barplot2_ft(q,t_aver,[100:1:300],w,toy);
% [freq4]=spectral_correction(freq4);
% 
% cfg              = [];
% %cfg.zlim=zlim; %U might want to uncomment this if you use a smaller step: (Memory purposes)
% cfg.channel      = freq4.label{w};
% cfg.colormap=colormap(jet(256));
% 
% a1=subplot(2,1,1)
% ft_singleplotTFR(cfg, freq4);
% xlim([0 max(t_aver{1})])
% g=title('High Frequencies');
% g.FontSize=12;
% xlabel('Time (s)')
% %ylabel('uV')
% ylabel('Frequency (Hz)')
% % xlim([0.3 0.8])
% 
% a2=subplot(2,1,2)
% plot(t_aver{1},aver)
% xlim([0 max(t_aver{1})])
% colorbar()
% 
% linkaxes([a1 a2],'x')
% 
% %%  Spectrogram PFC
% 
% figure()
% aver=pfc;
% t_aver=1:length(aver);
% t_aver=t_aver-1;
% t_aver=t_aver/1000;
% t_aver={t_aver};
% 
% w=1;
% %toy=[1:60:length(t_aver{1})/1000]; %secs
% toy=[1:0.5:length(t_aver{1})/1000]; %secs %480
% 
% %toy=[-1:.01:1];
% % q={[aver  ].'};
% q={[aver aver aver ].'};
% 
% freq4=barplot2_ft(q,t_aver,[100:1:300],w,toy);
% [freq4]=spectral_correction(freq4);
% 
% cfg              = [];
% %cfg.zlim=zlim; %U might want to uncomment this if you use a smaller step: (Memory purposes)
% cfg.channel      = freq4.label{w};
% cfg.colormap=colormap(jet(256));
% 
% a1=subplot(2,1,1)
% ft_singleplotTFR(cfg, freq4);
% xlim([0 max(t_aver{1})])
% g=title('High Frequencies');
% g.FontSize=12;
% xlabel('Time (s)')
% %ylabel('uV')
% ylabel('Frequency (Hz)')
% % xlim([0.3 0.8])
% 
% a2=subplot(2,1,2)
% plot(t_aver{1},aver)
% xlim([0 max(t_aver{1})])
% colorbar()
% 
% linkaxes([a1 a2],'x')













%%
% %
% %ax3=subplot(2,1,2)
% plot((1:length(hpc))./1000./60,5.*zscore(hpc),'Color','blue')
% %stem([swr_hpc{n,3}/60],ones(length([swr_hpc{n}]),1).*5,'Color','blue')
% stem([swr_hpc{n,3}/60],ones(length([swr_hpc{n}]),1).*80,'Color','blue')
% title('HPC')
% xlabel('Time (Seconds)')
% 
% ax4=subplot(2,1,1)
% 
% plot((1:length(pfc))./1000./60,5.*zscore(pfc)+150,'Color','red')
% stem([swr_pfc{n,3}/60],ones(length([swr_pfc{n}]),1).*5,'Color','red')
% title('PFC')
% 
% xlabel('Time (Seconds)')

%%



% plot((1:length(hpc))./1000./60,5.*zscore(hpc)+100,'Color','blue')
% hold on
% plot((1:length(pfc))./1000./60,5.*zscore(pfc)+250,'Color',[1 0.5 0])
% xlabel('Time (Seconds)')



%%
% stem([swr_hpc{68}],ones(length([swr_hpc{68}]),1).*200)

% rip_times(:,:,1)=[Sx_hpc Ex_hpc Mx_hpc]; %Stack them    
% %%
% 
% for ind=1:size(s_hpc,2)
% veamos{:,ind}=find(s_hpc(:,ind)~=0);  %Epochs with ripples detected
% cara{:,:,ind}=swr_hpc(veamos{:,ind},:,ind);
% ripples_times{:,:,ind}=rip_times(veamos{:,ind},:,ind);
% 
% % veamos2{:,ind}=find(s217(:,ind)~=0);  %Epochs with ripples detected
% % cara2{:,:,ind}=swr217(veamos2{:,ind},:,ind);
% end
% 
% %%
% %Run ripple detection
% for kk=1:size(signal2_hpc,1)
%    % ti2{kk,1}=(transitions(kk,2):1/1000:transitions(kk,3));
%      ti{kk,1}=linspace(transitions(kk,2),transitions(kk,3),length(signal2_hpc{kk}));
% end
% 
% %%
% plot_traces(sig2,veamos,cara,ti,amp_vec,iii,labelconditions,chtm,include_hpc,cara_hpc,veamos_hpc,chtm_hpc);
% 


