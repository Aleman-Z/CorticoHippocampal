%gui_threshold_ripples
%% Find location
close all
dname=uigetdir([],'Select folder with Matlab data of trial');
cd(dname)

%%
%Band pass filter design:
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=100-300 Hz
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

PFC=dir('*PFC*.mat');
PFC=PFC.name;
PFC=load(PFC);
PFC=PFC.PFC;
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





%%
prompt = {'Select a threshold value for HPC'};
dlgtitle = 'Threshold HPC';
definput = {'100'};
% opts.Interpreter = 'tex';
answer = inputdlg(prompt,dlgtitle,[1 40],definput);
D1=str2num(answer{1}) 
%100 for Rat 26


prompt = {'Select a threshold value for PFC'};
dlgtitle = 'Threshold PFC';
definput = {'30'};
% opts.Interpreter = 'tex';
answer = inputdlg(prompt,dlgtitle,[1 40],definput);
D2=str2num(answer{1}) 
%35 for Rat 26

%% SWR in HPC
%D1=100;%THRESHOLD
k=1;
    [Sx_hpc,Ex_hpc,Mx_hpc] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2, D1, (D1)*(1/2), [] ), signal2_hpc,ti,'UniformOutput',false);    
    swr_hpc(:,:,k)=[Sx_hpc Ex_hpc Mx_hpc];
    s_hpc(:,k)=cellfun('length',Sx_hpc);
%% Cortical ripples
%D2=35;%THRESHOLD
    [Sx_pfc,Ex_pfc,Mx_pfc] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2, D2, (D2)*(1/2), [] ), signal2_pfc,ti,'UniformOutput',false);    
    swr_pfc(:,:,k)=[Sx_pfc Ex_pfc Mx_pfc];
    s_pfc(:,k)=cellfun('length',Sx_pfc);%% Cortical ripples

%%
% Find max and plot
max_length=cellfun(@length,v_hpc);



hpc=V_hpc{max_length==max(max_length)};
pfc=V_pfc{max_length==max(max_length)};

% plot((1:length(hpc))./1000./60,5.*zscore(hpc)+100,'Color','blue')
% hold on
% plot((1:length(pfc))./1000./60,5.*zscore(pfc)+150,'Color','red')
% xlabel('Time (Minutes)')
plot((1:length(hpc))./1000,5.*zscore(hpc)+100,'Color','blue')
hold on
plot((1:length(pfc))./1000,5.*zscore(pfc)+150,'Color','red')
xlabel('Time (Seconds)')

yticks([100 150])
yticklabels({'HPC','PFC'})
% a = get(gca,'YTickLabel');
% set(gca,'YTickLabel',a,'FontName','Times','fontsize',12)
b=gca;
b.FontSize=12;


n=find(max_length==max(max_length));
stem([swr_hpc{n,3}],ones(length([swr_hpc{n}]),1).*200,'Color','blue')
stem([swr_pfc{n,3}],ones(length([swr_pfc{n}]),1).*200,'Color','red')%Seconds

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
title('PFC (100-300 Hz)')
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


