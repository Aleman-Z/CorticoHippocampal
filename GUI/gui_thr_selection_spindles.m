%gui_threshold_ripples
%% Find location
clear variables
close all
dname=uigetdir([],'Select folder with Matlab data of trial');
cd(dname)

%%
%Band pass filter design:
fn=1000; % New sampling frequency. 
% Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=100-300 Hz
% Wn1=[9/(fn/2) 20/(fn/2)]; % Cutoff=100-300 Hz
  Wn1=[5/(fn/2) 20/(fn/2)]; % Cutoff=100-300 Hz

% % Wn1=[50/(fn/2) 80/(fn/2)]; 
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

%LPF 300 Hz:
fn=1000; % New sampling frequency. 
% Wn1=[320/(fn/2)]; % Cutoff=320 Hz
Wn1=[0.3/(fn/2) 300/(fn/2)]; % Cutoff=320 Hz
[b2,a2] = butter(3,Wn1,'bandpass'); %Filter coefficients

Wn3=[9/(fn/2) 20/(fn/2)]; % Cutoff=100-300 Hz
[b3,a3] = butter(3,Wn3,'bandpass'); %Filter coefficients

%Brain region combinations.
list = {'HPC & PFC','HPC & PAR','PAR & PFC'}; %,'PFC & PAR'
[optionlist] = listdlg('PromptString',{'Select brain areas.'},'SelectionMode','single','ListString',list,'InitialValue',3);
switch optionlist
    case 1
      yy={'HPC'};       
      xx={'PFC'};
    case 2
      yy={'HPC'};    
      xx={'PAR'};  
    case 3
      yy={'PAR'};    
      xx={'PFC'};  
       
%     case 4
%       yy={'PFC'};    
%       xx={'PAR'};  
        
end

% 
% xx = inputdlg({'Cortical area (PAR or PFC)'},...
%               'Type your selection', [1 50]); 


HPC=dir(strcat('*',yy{1},'*.mat'));
HPC=HPC.name;
HPC=load(HPC);
HPC=getfield(HPC,yy{1});
HPC=HPC.*(0.195);


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
Mono_hpc=cellfun(@(equis) wavelet_bandpass(equis), V_hpc ,'UniformOutput',false); %100-300 Hz
signal3_hpc=cellfun(@(equis) times((1/0.195), equis)  ,Mono_hpc,'UniformOutput',false); %Remove convertion factor for ripple detection
Mono_hpc=cellfun(@(equis) filtfilt(b1,a1,equis), V_hpc ,'UniformOutput',false); %100-300 Hz
signal2_hpc=cellfun(@(equis) times((1/0.195), equis)  ,Mono_hpc,'UniformOutput',false); %Remove convertion factor for ripple detection

% Wn3=[9/(fn/2) 20/(fn/2)]; % Cutoff=100-300 Hz
% [b3,a3] = butter(3,Wn3,'bandpass'); %Filter coefficients
Mono_hpc=cellfun(@(equis) filtfilt(b3,a3,equis), V_hpc ,'UniformOutput',false); %100-300 Hz
signal4_hpc=cellfun(@(equis) (times((1/0.195), equis))  ,Mono_hpc,'UniformOutput',false); %Remove convertion factor for ripple detection



V_pfc=cellfun(@(equis) filtfilt(b2,a2,equis), v_pfc ,'UniformOutput',false);
Mono_pfc=cellfun(@(equis) wavelet_bandpass(equis), V_pfc ,'UniformOutput',false); %100-300 Hz
signal3_pfc=cellfun(@(equis) times((1/0.195), equis)  ,Mono_pfc,'UniformOutput',false); %Remove convertion factor for ripple detection
Mono_pfc=cellfun(@(equis) filtfilt(b1,a1,equis), V_pfc ,'UniformOutput',false); %100-300 Hz
signal2_pfc=cellfun(@(equis) times((1/0.195), equis)  ,Mono_pfc,'UniformOutput',false); %Remove convertion factor for ripple detection

% Wn1=[9/(fn/2) 20/(fn/2)]; % Cutoff=100-300 Hz
% [b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
Mono_pfc=cellfun(@(equis) filtfilt(b3,a3,equis), V_pfc ,'UniformOutput',false); %100-300 Hz
signal4_pfc=cellfun(@(equis) (times((1/0.195), equis))  ,Mono_pfc,'UniformOutput',false); %Remove convertion factor for ripple detection

fn=1000;

ti=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,signal2_hpc,'UniformOutput',false);
% ti_pfc=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,signal2_pfc,'UniformOutput',false);


% %% Find largest epoch.
% max_length=cellfun(@length,v_hpc);
% nrem_epoch=find(max_length==max(max_length)==1);

%%
% %% Find largest epoch.
max_length=cellfun(@length,v_hpc);
nrem_epoch=find(max_length==max(max_length)==1);
nrem_epoch=nrem_epoch(1);

    D1=4.*std(signal4_hpc{nrem_epoch}) +mean(signal4_hpc{nrem_epoch});
    D2=4.*std(signal4_pfc{nrem_epoch})+mean(signal4_pfc{nrem_epoch});
clear max_length nrem_epoch

%% SWR in HPC
% D1=70;%THRESHOLD
minpeak=4;
k=1; %xo
    %[Sx_hpc,Ex_hpc,Mx_hpc] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2, D1, (D1)*(1/2), [] ), signal2_hpc,ti,'UniformOutput',false);
%    [Sx_hpc,Ex_hpc,Mx_hpc] =cellfun(@(equis1,equis2) findSpindlesLisa(equis1, equis2, D1, (D1)*(1/2), fn), signal3_hpc,ti,'UniformOutput',false);    
    [Sx_hpc,Ex_hpc,Mx_hpc] =cellfun(@(equis1,equis2,equis3) findSpindlesWithPeaks(equis1, equis2,equis3, D1, (D1)*(0.75), fn,minpeak), signal4_hpc,signal2_hpc,ti,'UniformOutput',false);    

    swr_hpc(:,:,k)=[Sx_hpc Ex_hpc Mx_hpc];
    s_hpc(:,k)=cellfun('length',Sx_hpc);
%% Cortical ripples
%D2=35;%THRESHOLD
%     [Sx_pfc,Ex_pfc,Mx_pfc] =cellfun(@(equis1,equis2) findRipplesLisa2020(equis1, equis2, D2, (D2)*(1/2), [] ), signal2_pfc,ti,'UniformOutput',false);    
%     [Sx_pfc,Ex_pfc,Mx_pfc] =cellfun(@(equis1,equis2) findSpindlesLisa(equis1, equis2, D2, (D2)*(1/2), fn), signal3_pfc,ti,'UniformOutput',false);    
    [Sx_pfc,Ex_pfc,Mx_pfc] =cellfun(@(equis1,equis2,equis3) findSpindlesWithPeaks(equis1, equis2,equis3, D2, (D2)*(0.75), fn,minpeak), signal4_pfc,signal2_pfc,ti,'UniformOutput',false);    

    swr_pfc(:,:,k)=[Sx_pfc Ex_pfc Mx_pfc];
    s_pfc(:,k)=cellfun('length',Sx_pfc);%% Cortical ripples

%%
signal2_hpc=signal4_hpc;
signal2_pfc=signal4_pfc;

% Find max and plot
%xo
%LARGEST EPOCH.
% max_length=cellfun(@length,v_hpc);

%EPOCH WITH MORE CORTICAL RIPPLES.
max_length=cellfun(@length,swr_pfc(:,1));

% hpc=V_hpc{max_length==max(max_length)};
% pfc=V_pfc{max_length==max(max_length)};
% hpc2=signal2_hpc{max_length==max(max_length)};
% pfc2=signal2_pfc{max_length==max(max_length)};
n=find(max_length==max(max_length));
%%
%n=n(1);
 n=66;
% n=68;
% n=67
% n=58;
% n=48;%35;%48
hpc=V_hpc{n};
pfc=V_pfc{n};
hpc2=[(signal2_hpc{n})];
pfc2=[(signal2_pfc{n})];

% hpc2=[0 ;diff(angle(hilbert(signal2_hpc{n})))];
% pfc2=[0; diff(angle(hilbert(signal2_pfc{n})))];



% plot((1:length(hpc))./1000./60,5.*zscore(hpc)+100,'Color','blue')
% hold on
% plot((1:length(pfc))./1000./60,5.*zscore(pfc)+150,'Color','red')
% xlabel('Time (Minutes)')
allscreen()
plot((1:length(hpc))./1000,5.*zscore(hpc)+100,'Color','blue')
hold on
plot((1:length(pfc))./1000,5.*zscore(pfc)+150,'Color','red')
xlabel('Time (Seconds)')
xbounds = xlim;
set(gca,'XTick',[xbounds(1):0.5:xbounds(2)]);

yticks([100 150 220 290])
% yticklabels({'HPC',xx{1},'HPC (100-300Hz)',[xx{1} '(100-300Hz)']})
yticklabels({yy{1},xx{1},[yy{1} ' (9-20Hz)'],[xx{1} ' (9-20Hz)']})

% a = get(gca,'YTickLabel');
% set(gca,'YTickLabel',a,'FontName','Times','fontsize',12)
b=gca;
b.FontSize=12;
 plot((1:length(hpc2))./1000,5.*zscore(hpc2)+220,'Color','blue')
        plot((1:length(pfc2))./1000,5.*zscore(pfc2)+290,'Color','red')

if ~isempty([swr_hpc{n,3}])
     stem([swr_hpc{n,3}],ones(length([swr_hpc{n}]),1).*350,'Color','blue')
    for j=1:length([swr_hpc{n,3}])
    x = [swr_hpc{n,1}(j) swr_hpc{n,2}(j) swr_hpc{n,2}(j) swr_hpc{n,1}(j)];
    y = [0 0 350 350];
    patch(x,y,'blue'); alpha(0.2)
    end
end
if ~isempty([swr_pfc{n,3}])

stem([swr_pfc{n,3}],ones(length([swr_pfc{n}]),1).*350,'Color','red')%Seconds

    for j=1:length([swr_pfc{n,3}])
    x = [swr_pfc{n,1}(j) swr_pfc{n,2}(j) swr_pfc{n,2}(j) swr_pfc{n,1}(j)];
    y = [0 0 350 350];
    patch(x,y,'red'); alpha(0.2)
    end

end

title('Traces')
% xlim([85 88])