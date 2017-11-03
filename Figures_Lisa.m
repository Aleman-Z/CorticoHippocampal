%% Figures for Lisa's experiment.  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%STUDENT: Ramiro Adrián Alemán Zapata. Master Student @ TU Eindhoven. 
%ADVISOR: Francesco Battaglia. Donders Institute of Brain, Cognition and
%Behaviour. Radboud University. 
%2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INPUT DATA:
% 32 Channels of brain signals were recorded over a period of 4 hours with a sampling frequency of
% 20kHz for different tasks that involved learning, memory and sleep. Each of the channels
% corresponded to a different brain area, of which we are mainly interested in the Prefrontal Cortex
% (PFC), the Parietal lobe and the Hippocampus (Channels 9, 12 and 17 for Rat #26).


% REQUIRED FUNCTIONS:
%load_open_ephys_data_faster()
%And more to come
%% LOADING DATA OF 2 MAIN CHANNELS AND REFERENCE
fs=20000; %Sampling frequency of acquisition.  

addpath('/home/raleman/Documents/MATLAB/analysis-tools-master')  
addpath('/home/raleman/Documents/GitHub/CorticoHippocampal')  


%%
cd('/media/raleman/My Book/ObjectSpace/rat_1/study_day_2_OR/post_trial1_2017-09-25_11-26-43');

[data9m, ~, ~] = load_open_ephys_data_faster('100_CH14.continuous');
[data17m, ~, ~] = load_open_ephys_data_faster('100_CH46.continuous');
% Loading accelerometer data
[ax1, ~, ~] = load_open_ephys_data_faster('100_AUX1.continuous');
[ax2, ~, ~] = load_open_ephys_data_faster('100_AUX2.continuous');
[ax3, ~, ~] = load_open_ephys_data_faster('100_AUX3.continuous');

% Verifying time
 l=length(ax1); %samples
% t=l*(1/fs); %  2.7276e+03  seconds
% Equivalent to 45.4596 minutes
t=1:l;
t=t*(1/fs);

sos=ax1.^2+ax2.^2+ax3.^2;
clear ax1 ax2 ax3 

%%
% close all
%[vtr]=findsleep(sos,0.006,t); %post_trial2
[vtr]=findsleep(sos,0.006,t); %post_trial3

%%
vin=find(vtr~=1);
tvin=vin*(1/fs);

C9=data9m(vin).*(0.195);
C17=data17m(vin).*(0.195);

clear data17m data9m
%%
cd('/home/raleman/Documents/internship/Lisa_files/data/PT1')
save('C9.mat','C9')
save('C17.mat','C17')


%% FINITO





% %%
% [ax4, ~, ~] = load_open_ephys_data_faster('100_AUX4.continuous');
% [ax5, ~, ~] = load_open_ephys_data_faster('100_AUX5.continuous');
% [ax6, ~, ~] = load_open_ephys_data_faster('100_AUX6.continuous');
%% Shorten
% ax1=ax1(1:10000000);
% ax2=ax2(1:10000000);
% ax3=ax3(1:10000000);
%%
% close all
% findsleep(ax3,0.006,t)

%%
% plot(t,ax1)
% hold on
% plot(t,ax1d)
% legend('AUX1','AUX1 (detrended)')
% 
% xlabel('Time(sec)')
% ylabel('Magnitude')
% grid minor
% title('Comparison between original and detrended data')

%%
plot(t,thr,'Color','k')
% plot(t,eax1(1:end))
% plot(t,ax3(1:end))

xlabel('Time(sec)')
ylabel('Magnitude')
grid minor
title('Accelerometer data')
%xlim([100 110])
%legend('AUX1','AUX2','AUX3')
% %%
% di=da(1:20);
% area(1:length(di),di)
% %%
% hist(da,1000)

%%
plot(t,ax1(1:end))
hold on
plot(t,ax2(1:end))
plot(t,ax3(1:end))

xlabel('Time(sec)')
ylabel('Magnitude')
grid minor
title('Accelerometer data')
legend('AUX1','AUX2','AUX3')
%%
plot(t,ax4(1:end))
hold on
plot(t,ax5(1:end))
plot(t,ax6(1:end))

xlabel('Time(sec)')
ylabel('Magnitude')
grid minor
title('Accelerometer data')
legend('AUX4','AUX5','AUX6')

%%
sos=ax1.^2+ax2.^2+ax3.^2;
clear ax1 ax2 ax3 

%%
% close all
%[vtr]=findsleep(sos,0.006,t); %post_trial2
[vtr]=findsleep(sos,0.006,t); %post_trial3

%%
vin=find(vtr~=1);
tvin=vin*(1/fs);

C9=data9m(vin).*(0.195); %Sleep+Correction factor
C17=data17m(vin).*(0.195); %Sleep+Correction factor

clear data17m data9m
%%
cd('/home/raleman/Documents/internship/Lisa_files/data/PT3')
save('C9.mat','C9')
save('C17.mat','C17')

%%
C6{i}=data6m(round(probemos(1)):round(probemos(2))).*(0.195); %CORRECTION FACTOR 
C9{i}=data9m(round(probemos(1)):round(probemos(2))).*(0.195); %CORRECTION FACTOR

%ax1s=ax1(vin);

%plot(ax1s)
%%
% so=ax4.^2+ax5.^2+ax6.^2;
%%
plot(t,sos(1:end))
hold on
plot(t,so(1:end))

xlabel('Time(sec)')
ylabel('Magnitude')
grid minor
title('Resulting Vector for Accelerometer data')
legend('AUX1,AUX2,AUX3', 'AUX4,AUX5,AUX6')
%%
plot(t,sos(1:end),'Color',[1 0.3 0])

xlabel('Time(sec)')
ylabel('Magnitude')
grid minor
title('Resultant Vector for Accelerometer data')
%%
plot(t,(sos(1:end)),'Color',[1 0.3 0])

xlabel('Time(sec)')
ylabel('Magnitude')
grid minor
title('Resultant Vector for Accelerometer data')


%% Extract only NREM signals. (1 for awake, 3 for NREM)
c=find(transitions(:,1)==3); 
newtrans=transitions(c,2:3); %Only use the NREM times. 
transamp=newtrans.*(fs); %Convert to seconds

%Defining void vectors to save NREM signals. 
C6=cell(length(transamp),1);%NREM Reference signals
C9=cell(length(transamp),1);%NREM Reference signals
C12=cell(length(transamp),1);%NREM Reference signals
C17=cell(length(transamp),1);%NREM Reference signals

T6=cell(length(transamp),1);% NREM Reference timestamps (Identical for all channels)
tiempo=nan(length(transamp),1); %Time duration per epoch

%Extract signals per channel and time  
for i=1:length(transamp)
probemos=transamp(i,:);
C6{i}=data6m(round(probemos(1)):round(probemos(2))).*(0.195); %CORRECTION FACTOR 
C9{i}=data9m(round(probemos(1)):round(probemos(2))).*(0.195); %CORRECTION FACTOR
C12{i}=data12m(round(probemos(1)):round(probemos(2))).*(0.195); %CORRECTION FACTOR
C17{i}=data17m(round(probemos(1)):round(probemos(2))).*(0.195); %CORRECTION FACTOR

T6{i}=timestamps6(round(probemos(1)):round(probemos(2)));
tiempo(i)=length(C6{i})*(1/fs); %Seconds
end

% Saving data for future use
save('T6.mat','T6');
save('C6.mat','C6');
save('C9.mat','C9');
save('C12.mat','C12');
save('C17.mat','C17');
save('tiempo.mat','tiempo');
%% Load saved NREM data (Avoids running previous code)
%Reference
C6=load('C6.mat');
C6=C6.C6;
%PFC
C9=load('C9.mat');
C9=C9.C9;
%Parietal
C12=load('C12.mat');
C12=C12.C12;
%Hippocampus
C17=load('C17.mat');
C17=C17.C17;
%Timestamps 
T6=load('T6.mat');
T6=T6.T6;
%Time lenght per epoch
tiempo=load('tiempo.mat');
tiempo=tiempo.tiempo;
fs=20000; % Sampling frequency. 

%% Downsampling x20

Wn=[500/(fs/2) ]; % Cutoff=500 Hz
[b,a] = butter(3,Wn); %Filter coefficients for LPF
V9=cell(length(C12),1);
V6=cell(length(C12),1);
V12=cell(length(C12),1);
V17=cell(length(C12),1);
S9=cell(length(C12),1);
S12=cell(length(C12),1);
S17=cell(length(C12),1);

for i=1:length(C12)
%Monipolar    
V9{i,1}=filtfilt(b,a,C9{i,1});
V9{i,1}=decimator(V9{i,1},20).';
V6{i,1}=filtfilt(b,a,C6{i,1});
V6{i,1}=decimator(V6{i,1},20).';
V12{i,1}=filtfilt(b,a,C12{i,1});
V12{i,1}=decimator(V12{i,1},20).';
V17{i,1}=filtfilt(b,a,C17{i,1});
V17{i,1}=decimator(V17{i,1},20).';

%Bipolar
S9{i,1}=V9{i,1}-V6{i,1};
S12{i,1}=V12{i,1}-V6{i,1};
S17{i,1}=V17{i,1}-V6{i,1};
end
fn=1000; %New sampling frequency
%%
%Bipolar
save('S17.mat','S17');
save('S12.mat','S12');
save('S9.mat','S9');

%Monopolar
save('V17.mat','V17');
save('V12.mat','V12');
save('V9.mat','V9');
save('V6.mat','V6');

%%
S17=load('S17.mat');
S17=S17.S17;

S12=load('S12.mat');
S12=S12.S12;

S9=load('S9.mat');
S9=S9.S9;

V17=load('V17.mat');
V17=V17.V17;

V12=load('V12.mat');
V12=V12.V12;

V9=load('V9.mat');
V9=V9.V9;

V6=load('V6.mat');
V6=V6.V6;

%% ICA on monopolar signals. (Takes a little while, better load precomputed Rs and Bs)

%New monopolar signals
R6=cell(length(V6),1);%NREM Reference signals
R9=cell(length(V6),1);%NREM Reference signals
R12=cell(length(V6),1);%NREM Reference signals
R17=cell(length(V6),1);%NREM Reference signals

%New Bipolar signals
B9=cell(length(V6),1);
B12=cell(length(V6),1);
B17=cell(length(V6),1);


for i=1:length(V6)
VK=[V6 V9 V12 V17];
checa=VK(i,:)
checale=[checa{1,1} checa{1,2} checa{1,3} checa{1,4}];
checale=checale';

%[A1 B]=fastica(checale);
[A1 B]=fastica(checale,'approach','symm');

sources=B*checale;

[newvec]=orderICA(checale, sources);
%
% for i=1:4
%     subplot(4,2,2*i)
%     plot(newvec(i,:))
%     
%     subplot(4,2,2*i-1)
%     plot(checale(i,:))
% end
%
% [newvec]=sorter(checale, sources); %Sorts independent components (C6 C9 C12 C17)
R6{i}=newvec(1,:);
R9{i}=newvec(2,:);
R12{i}=newvec(3,:);
% si=size(newvec);
% if si(1)==4
R17{i}=newvec(4,:);
% else
% R17{i}=0;    
%end
i
%Bipolar
B9{i}=R9{i}-R6{i};
B12{i}=R12{i}-R6{i};
B17{i}=R17{i}-R6{i};
end
% checale=checale';
% %%
%% ICA RESULTS
%Monopolar
save('R6.mat','R6');
save('R9.mat','R9');
save('R12.mat','R12');
save('R17.mat','R17');
%Bipolar
save('B9.mat','B9');
save('B12.mat','B12');
save('B17.mat','B17');
%% Load ICA results
B9=load('B9.mat');
B9=B9.B9;

B12=load('B12.mat');
B12=B12.B12;

B17=load('B17.mat');
B17=B17.B17;

R6=load('R6.mat');
R6=R6.R6;

R9=load('R9.mat');
R9=R9.R9;

R12=load('R12.mat');
R12=R12.R12;

R17=load('R17.mat');
R17=R17.R17;

%% Plotting Original and ICA bipolar signals
i=1;

subplot(2,3,1)
plot(S9{i,1})
xlabel('Samples')
ylabel('uV')
title('Original Bipolar PFC')
subplot(2,3,2)
plot(S12{i,1})
xlabel('Samples')
ylabel('uV')

title('Original Bipolar Parietal')
subplot(2,3,3)
plot(S17{i,1})
xlabel('Samples')
ylabel('uV')
title('Original Bipolar Hippocampus')
subplot(2,3,4)
plot(B9{i,1})
xlabel('Samples')
ylabel('uV')
title('ICA Bipolar PFC')
subplot(2,3,5)
plot(B12{i,1})
xlabel('Samples')
ylabel('uV')
title('ICA Bipolar Parietal')
subplot(2,3,6)
plot(B17{i,1})
xlabel('Samples')
ylabel('uV')
title('ICA Bipolar Hippocampus')
% legend('PFC','Parietal','Hippocampus')
mtit(strcat('Epoch',num2str(i)),'fontsize',14,'color',[1 0 0],'position',[.5 .45 ])

%% Hippocampus: Monopolar or Bipolar?
%Monopolar signal: V17
%Bipolar signal: S17

%% Band pass design 
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=500 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients for LPF
%% Bandpass filter 
fn=1000;

Mono17=cell(63,1);
Bip17=cell(63,1);
Mono12=cell(63,1);
Mono9=cell(63,1);


for i=1:63
Bip17{i}=filtfilt(b1,a1,S17{i});
Mono17{i}=filtfilt(b1,a1,V17{i});
Mono6{i}=filtfilt(b1,a1,V6{i});
Mono9{i}=filtfilt(b1,a1,V9{i});
Mono12{i}=filtfilt(b1,a1,V12{i});

end

  
%%
epoch=1;
subplot(1,2,1)
plot((1:length(Mono17{epoch}))*(1/fn),Mono17{epoch});
%ylim([-20 20])
title('Monopolar Hippocampus')
xlabel('Time (s)')
ylabel('uV')
grid on
subplot(1,2,2)
plot((1:length(Bip17{epoch}))*(1/fn),Bip17{epoch});
%ylim([-80 60])
xlabel('Time (s)')
ylabel('uV')
grid on
title('Bipolar Hippocampus')
% 

%%
snrB=nan(length(Bip17),1);
snrM=nan(length(Bip17),1);
snrcof=nan(length(Bip17),1);
snrcofref=nan(length(Bip17),1);

for i=1:length(Bip17)
snrB(i)=snr(Bip17{i});
snrM(i)=snr(Mono17{i}); 
%naco=corrcoef(Bip17{i},Mono17{i});
naco=corrcoef(Bip17{i},Mono6{i});
snrcof(i)=naco(2);
naco=corrcoef(Mono17{i},Mono6{i});
snrcofref(i)=naco(2);

end

plot(snrcof)
hold on
plot(snrcofref)
grid on
title('Correlation between Hippocampus Bipolar and Monopolar signal with Reference ')
legend('Bipolar vs Reference','Monopolar vs Reference')
% plot(snrB)
% hold on
% plot(snrM)
mean(snrB)
mean(snrM)
%% SWR detection 

epoch=62;
signal=Bip17{epoch}*(1/0.195);
%signalwave=S17{epoch}*(1/0.195);
% signalwave=S17{epoch};

t=(0:length(signal)-1)*(1/fn); %IN SECONDS
[S, E, M] = findRipplesLisa(signal, t.', 100 , 100*(1/3), []);
%%
plot(signal)
hold on
plot([ones(1,length(signal))]*200,'Linewidth',2)
xlabel('Samples')
ylabel('Magnitude')
grid minor
title('Threshold for Ripple detection')
%%
%%
s17=nan(63,1);
swr17=cell(63,3);


for i=1:63
    
signal=Bip17{i}*(1/0.195);
signal2=Mono17{i}*(1/0.195);

ti=(0:length(signal)-1)*(1/fn); %IN SECONDS
[S, E, M] = findRipplesLisa(signal, ti.', 200 , (200)*(1/3), []);
s17(i)=length(M);
swr17{i,1}=S;
swr17{i,2}=E;
swr17{i,3}=M;

[S2, E2, M2] = findRipplesLisa(signal2, ti.', 200 , (200)*(1/3), []);
s217(i)=length(M2);
swr217{i,1}=S2;
swr217{i,2}=E2;
swr217{i,3}=M2;


i
end
%%
stem(s17,'Linewidth',2)

hold on
stem(s217,'Linewidth',2)
% legend('Monopolar')
xlabel('epoch #')
% grid on
ylabel('Number of ripples')
title('Ripple Detection per configuration')

legend('Bipolar', 'Monopolar')
%%

% %% Common ripples 
% conta=0;
% newM=cell(63,1);
% ele=nan(63,1);
% for i=1:63
% 
% newM{i}=intersect(swr217{i,3},swr17{i,3});
% ele(i)=length(newM{i});
% conta=conta+length(newM{i})
% end

%% Windowing
veamos=find(s17~=0);  %Epochs with ripples detected
carajo=swr17(veamos,:);

