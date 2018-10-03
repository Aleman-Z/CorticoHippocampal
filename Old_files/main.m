%% "Project: Large scale interactions in the cortico-hippocampal network" 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%STUDENT: Ramiro Adrián Alemán Zapata. Master Student @ TU Eindhoven. 
%ADVISOR: Francesco Battaglia. Donders Institute of Brain, Cognition and
%Behaviour. Radboud University. 
%2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% AIM:
% The aim of this study is to perform an analysis, comparison and classification of the electrical
% activity in the brain regions involved in the memory consolidation process, which occurs during the
% NREM sleep stage and involves a particular hippocampal oscillatory pattern called the Sharp Wave ripple.
 
% INPUT DATA:
% 32 Channels of brain signals were recorded over a period of 4 hours with a sampling frequency of
% 20kHz for different tasks that involved learning, memory and sleep. Each of the channels
% corresponded to a different brain area, of which we are mainly interested in the Prefrontal Cortex
% (PFC), the Parietal lobe and the Hippocampus (Channels 9, 12 and 17 for Rat #26).


% REQUIRED FUNCTIONS:
%load_open_ephys_data_faster()
%And more to come
%% LOADING DATA OF 3 MAIN CHANNELS AND REFERENCE
fs=20000; %Sampling frequency of acquisition.  

%Reference
[data6m, timestamps6, ~] = load_open_ephys_data_faster('100_CH6_merged.continuous');
%PFC
[data9m, ~, ~] = load_open_ephys_data_faster('100_CH9_merged.continuous');
%Parietal lobe
[data12m, ~, ~] = load_open_ephys_data_faster('100_CH12_merged.continuous');
%Hippocampus
[data17m, ~, ~] = load_open_ephys_data_faster('100_CH17_merged.continuous');

%Load states vectors 
load('rat26_plusmaze_base_2016-03-08_10-24-41-states.mat');
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
%% Correlation among non referenced signals (NO ICA yet)

%Correlation vectors 
K1=zeros(length(V9),1);
K2=zeros(length(V9),1);
K3=zeros(length(V9),1);
K4=zeros(length(V9),1);
K5=zeros(length(V9),1);
K6=zeros(length(V9),1);


for epoch=1:length(V9)
c1=corrcoef(detrend(V17{epoch}),detrend(V9{epoch}));
c1=c1(2);
K1(epoch)=c1;% HIPPOCAMPUS AND PFC
c2=corrcoef(detrend(V17{epoch}),detrend(V12{epoch}));
c2=c2(2);
K2(epoch)=c2;%HIPPOCAMPUS AND PARIETAL
c3=corrcoef(detrend(V12{epoch}),detrend(V9{epoch}));
c3=c3(2);
K3(epoch)=c3;%PARIETAL AND PFC

c4=corrcoef(detrend(V6{epoch}),detrend(V9{epoch}));
c4=c4(2);
K4(epoch)=c4;%Reference and PFC

c5=corrcoef(detrend(V6{epoch}),detrend(V12{epoch}));
c5=c5(2);
K5(epoch)=c5;%Reference and Parietal 

c6=corrcoef(detrend(V6{epoch}),detrend(V17{epoch}));
c6=c6(2);
K6(epoch)=c6;%Reference and Hippocampus
end
%% Visualizing high correlations
plot(K6)
xlabel('epoch #')
ylabel('Correlation coefficient')
title('Correlation between Hippocampus and Reference')
grid on


%% Plotting results
plot(K1)
hold on
plot(K2)
plot(K3)
plot(K4)
plot(K5)
plot(K6)
xlabel('Epoch #')
ylabel('Correlation coefficient')
grid on
legend('Hip. vs PFC','Hip vs Parietal','Parietal vs PFC','Reference vs PFC','Reference vs Parietal','Reference vs Hip. ')
title('Correlation Coefficients among channels')
%% Correlation between monopolar and bipolar signals


%Correlation vectors 
K9=zeros(length(V9),1);
K12=zeros(length(V9),1);
K17=zeros(length(V9),1);


for epoch=1:length(V9)
c1=corrcoef(detrend(V9{epoch}),detrend(S9{epoch}));
c1=c1(2);
K9(epoch)=c1;% MONO AND BIPOLAR PFC
c2=corrcoef(detrend(V12{epoch}),detrend(S12{epoch}));
c2=c2(2);
K12(epoch)=c2;%MONO AND BIPOLAR PARIETAL LOBE
c3=corrcoef(detrend(V17{epoch}),detrend(S17{epoch}));
c3=c3(2);
K17(epoch)=c3;%MONO AND BIPOLAR HIPPOCAMPUS
end
%% Plotting results
plot(K9)
hold on
plot(K12)
plot(K17,'-k')

xlabel('Epoch #')
ylabel('Correlation coefficient')
grid on
legend('PFC','Parietal','Hippocampus')
title('Correlation Coefficients between monopolar and bipolar signals')


%% Correlation between bipolar signals


%Correlation vectors 
K18=zeros(length(V9),1);
K19=zeros(length(V9),1);
K20=zeros(length(V9),1);


for epoch=1:length(V9)
c1=corrcoef(detrend(S9{epoch}),detrend(S12{epoch}));
c1=c1(2);
K18(epoch)=c1;% PFC VS PARIETAL
c2=corrcoef(detrend(S9{epoch}),detrend(S17{epoch}));
c2=c2(2);
K19(epoch)=c2;%PFC VS HIPPOCAMPUS
c3=corrcoef(detrend(S17{epoch}),detrend(S12{epoch}));
c3=c3(2);
K20(epoch)=c3;%PARIETAL VS HIPPOCAMPUS
end

%% Plotting results
plot(K18)
hold on
plot(K19)
plot(K20,'-k')

xlabel('Epoch #')
ylabel('Correlation coefficient')
grid on
legend('PFC VS PARIETAL','PFC VS HIP','PARIETAL VS HIP')
title('Correlation Coefficients between bipolar signals')

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


%% Correlation between bipolar signals. 
%Correlation vectors 
K18=zeros(length(B9),1);
K19=zeros(length(B9),1);
K20=zeros(length(B9),1);


for epoch=1:length(V9)
c1=corrcoef(detrend(B9{epoch}),detrend(B12{epoch}));
c1=c1(2);
K18(epoch)=c1;% PFC VS PARIETAL
c2=corrcoef(detrend(B9{epoch}),detrend(B17{epoch}));
c2=c2(2);
K19(epoch)=c2;%PFC VS HIPPOCAMPUS
c3=corrcoef(detrend(B17{epoch}),detrend(B12{epoch}));
c3=c3(2);
K20(epoch)=c3;%PARIETAL VS HIPPOCAMPUS
end

%% Plotting results for correlation between Original+ ICA bipolar signals
plot(K18)
hold on
plot(K19)
plot(K20,'-k')

xlabel('Epoch #')
ylabel('Correlation coefficient')
grid on
legend('PFC VS PARIETAL','PFC VS HIP','PARIETAL VS HIP')
title('Correlation Coefficients between bipolar signals')


%% Plot ICA monopolar
i=1
l=5000;
figure('units','normalized','outerposition',[0 0 1 1])
VK=[V6 V9 V12 V17];
checa=VK(i,:);
checale=[checa{1,1} checa{1,2} checa{1,3} checa{1,4}];
checale=checale';

VK1=[R6 R9 R12 R17];
checa1=VK1(i,:);
if checa1{1,4}~=0
checale1=[checa1{1,1} ;checa1{1,2}; checa1{1,3} ;checa1{1,4}];
else
   checa1{1,4}= checa1{1,1}*0;
   checale1=[checa1{1,1} ;checa1{1,2}; checa1{1,3} ;checa1{1,4}];
end
%
subplot(2,4,1)
plot((1:length(checale(1,1:l))),checale(1,1:l))
title(strcat('Mixed Reference'))
xlabel('Samples')
ylabel('uV')
subplot(2,4,2)
plot(checale(2,1:l))
title('Mixed PFC')
xlabel('Samples')
ylabel('uV')
subplot(2,4,3)
plot(checale(3,1:l))
title('Mixed Parietal')
xlabel('Samples')
ylabel('uV')
subplot(2,4,4)
plot(checale(4,1:l))
title('Mixed Hippocampus')
xlabel('Samples')
ylabel('uV')
mtit(strcat('Epoch',num2str(i)),'fontsize',14,'color',[1 0 0])


subplot(2,4,5)
plot(checale1(1,1:l))
title('ICA Reference')
xlabel('Samples')
ylabel('uV')
subplot(2,4,6)
plot(checale1(2,1:l))
title('ICA PFC')
xlabel('Samples')
ylabel('uV')
subplot(2,4,7)
plot(checale1(3,1:l))
title('ICA Parietal')
xlabel('Samples')
ylabel('uV')
subplot(2,4,8)
plot(checale1(4,1:l))
title('ICA Hippocampus')
xlabel('Samples')
ylabel('uV')
%% ICA on original bipolar signals S


SS9=cell(length(V6),1);
SS12=cell(length(V6),1);
SS17=cell(length(V6),1);

%conta=0;

for i=1:length(B12)
SK=[S9 S12 S17];
checa=SK(i,:)
checale=[checa{1,1} checa{1,2} checa{1,3}];
checale=checale';

%[A1 B]=fastica(checale); 
[A1 B]=fastica(checale,'approach','symm');
sources=B*checale;
[newvec]=orderICA(checale, sources);
% [newvec]=newsorter(checale, sources); %Sorts independent components (C6 C9 C12 C17)
SS9{i}=newvec(1,:);
SS12{i}=newvec(2,:);
si=size(newvec);
%if si(1)==3
                                   % % R17{i}=newvec(4,:);
SS17{i}=newvec(3,:);

%  else
% SS17{i}=0;
% conta=conta+1;
% end
i
end
% checale=checale';
% %%
%%
save('SS9.mat','SS9');
save('SS12.mat','SS12');
save('SS17.mat','SS17');
%%
SS9=load('SS9.mat');
SS9=SS9.SS9;

SS12=load('SS12.mat');
SS12=SS12.SS12;

SS17=load('SS17.mat');
SS17=SS17.SS17;

%% ICA on original bipolar signals S (JUST S9 and S12)


SSS9=cell(length(V6),1);
SSS12=cell(length(V6),1);

conta=0;

for i=1:length(B12)
SK=[S9 S12];
checa=SK(i,:)
checale=[checa{1,1} checa{1,2}];
checale=checale';

%[A1 B]=fastica(checale); 
[A1 B]=fastica(checale,'approach','symm');
sources=B*checale;
[newvec]=orderICA(checale, sources);
%[newvec]=newsorter2(checale, sources); %Sorts independent components (C6 C9 C12 C17)
SSS9{i}=newvec(1,:);
SSS12{i}=newvec(2,:);
si=size(newvec);
% if si(1)==3
% % % R17{i}=newvec(4,:);
% SS17{i}=newvec(3,:);
% 
%  else
% SS17{i}=0;
% conta=conta+1;
% end
i
end
% checale=checale';
%%
save('SSS9.mat','SSS9');
save('SSS12.mat','SSS12');
%%
SSS9=load('SSS9.mat');
SSS9=SSS9.SSS9;

SSS12=load('SSS12.mat');
SSS12=SSS12.SSS12;


%% Correlation between ICA bipolar signals. 
%Correlation vectors 
KK18=zeros(length(S9),1);
KK19=zeros(length(S9),1);
KK20=zeros(length(S9),1);


for epoch=1:length(V9)
c1=corrcoef(detrend(SS9{epoch}),detrend(SS12{epoch}));
c1=c1(2);
KK18(epoch)=c1;% PFC VS PARIETAL
if SS17{epoch}~=0
c2=corrcoef(detrend(SS9{epoch}),detrend(SS17{epoch}));
c2=c2(2);

else
 c2=nan;   
end
KK19(epoch)=c2;%PFC VS HIPPOCAMPUS
if SS17{epoch}~=0
c3=corrcoef(detrend(SS17{epoch}),detrend(SS12{epoch}));
c3=c3(2);
else
    c3=nan;
end
KK20(epoch)=c3;%PARIETAL VS HIPPOCAMPUS
end
%%
%% Plotting results for correlation between ICA bipolar signals
plot(KK18)
hold on
plot(KK19)
plot(KK20,'-k')

xlabel('Epoch #')
ylabel('Correlation coefficient')
grid on
legend('PFC VS PARIETAL','PFC VS HIP','PARIETAL VS HIP')
title('Correlation Coefficients between bipolar signals')
%%
%% Plotting Original bipolar signals and Origianl bipolar+ICA
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
plot(SS9{i,1})
xlabel('Samples')
ylabel('uV')
title('Bipolar+ICA PFC')
subplot(2,3,5)
plot(SS12{i,1})
xlabel('Samples')
ylabel('uV')
title('Bipolar+ICA Parietal')
subplot(2,3,6)
plot(SS17{i,1})
xlabel('Samples')
ylabel('uV')
title('Bipolar+ICA Hippocampus')
% legend('PFC','Parietal','Hippocampus')
mtit(strcat('Epoch',num2str(i)),'fontsize',14,'color',[1 0 0],'position',[.5 .45 ])
%%
%% ICA on monopolar signals.WITHOUT HIPPOCAMPUS 

%New monopolar signals
RR6=cell(length(V6),1);%NREM Reference signals
RR9=cell(length(V6),1);%NREM Reference signals
RR12=cell(length(V6),1);%NREM Reference signals
%RR17=cell(length(V6),1);%NREM Reference signals

%New Bipolar signals
BBB9=cell(length(V6),1);
BBB12=cell(length(V6),1);
% B17=cell(length(V6),1);


for i=1:length(V6)
VK=[V6 V9 V12];
checa=VK(i,:)
checale=[checa{1,1} checa{1,2} checa{1,3} ];
checale=checale';

%[A1 B]=fastica(checale);
[A1 B]=fastica(checale,'approach','symm');

sources=B*checale;
[newvec]=orderICA(checale, sources);
% [newvec]=newsorter(checale, sources); %Sorts independent components (C6 C9 C12 C17)
RR6{i}=newvec(1,:);
RR9{i}=newvec(2,:);
si=size(newvec);
if si(1)==3

RR12{i}=newvec(3,:);

else
RR12{i}=0;    
end
i
%Bipolar
BBB9{i}=RR9{i}-RR6{i};
BBB12{i}=RR12{i}-RR6{i};
%B17{i}=R17{i}-R6{i};
end
% checale=checale';
% %%

% RR9=R9;
% RR12=R12;
% BBB9=B9;
% BBB12=B12;
%%
% % % %% Adding ICA without Hippocampus AND without Reference
% % % %New monopolar signals
% % % %R6=cell(length(V6),1);%NREM Reference signals
% % % RRR9=cell(length(V6),1);%NREM Reference signals
% % % RRR12=cell(length(V6),1);%NREM Reference signals
% % % % R17=cell(length(V6),1);%NREM Reference signals
% % % 
% % % %New Bipolar signals
% % % BBBB9=cell(length(V6),1);
% % % BBBB12=cell(length(V6),1);
% % % % B17=cell(length(V6),1);
% % % 
% % % 
% % % for i=1:length(V6)
% % % VK=[V9 V12];
% % % checa=VK(i,:)
% % % checale=[checa{1,1} checa{1,2} ];
% % % checale=checale';
% % % 
% % % [A1 B]=fastica(checale);
% % % 
% % % sources=B*checale;
% % % [newvec]=newsorter2(checale, sources); %Sorts independent components (C6 C9 C12 C17)
% % % 
% % % RRR9{i}=newvec(1,:);
% % % si=size(newvec);
% % % RRR12{i}=newvec(2,:);
% % % 
% % % % if si(1)==2
% % % % 
% % % % R12{i}=newvec(3,:);
% % % % 
% % % % else
% % % % R12{i}=0;    
% % % % end
% % % i
% % % %Bipolar
% % % B9{i}=R9{i}-R6{i};
% % % B12{i}=R12{i}-R6{i};
% % % %B17{i}=R17{i}-R6{i};
% % % end
% % % % checale=checale';
% % % % %%
% % % 
% % % RRR9=R9;
% % % RRR12=R12;
% % % BBBB9=B9;
% % % BBBB12=B12;
% % % 



%% PFC and Parietal: Monopolar or Bipolar?
%Compare SNR 
%R9 and R12 : Monopolar+ICA
%V9 and V12: Monopolar 
%S9 and S12: Bipolar
%B9 and B12: ICA+Bipolar 
nR9=nan(length(R9),1);
nR12=nan(length(R9),1);
nV9=nan(length(R9),1);
nV12=nan(length(R9),1);
nS9=nan(length(R9),1);
nS12=nan(length(R9),1);
nB9=nan(length(R9),1);
nB12=nan(length(R9),1);

nRR9=nan(length(R9),1);
nRR12=nan(length(R9),1);
nBBB9=nan(length(R9),1);
nBBB12=nan(length(R9),1);

nSS12=nan(length(R9),1);
nSS9=nan(length(R9),1);

nSSS12=nan(length(R9),1);
nSSS9=nan(length(R9),1);


contame=0;
for i=1:length(R9)
nR9(i)=snr(R9{i,1});
nR12(i)=snr(R12{i,1});
nV9(i)=snr(V9{i,1});
nV12(i)=snr(V12{i,1});
nS9(i)=snr(S9{i,1});
nS12(i)=snr(S12{i,1});
nB9(i)=snr(B9{i,1});
nB12(i)=snr(B12{i,1});


nRR9(i)=snr(RR9{i,1});
if RR12{i,1}~=0
nRR12(i)=snr(RR12{i,1});
else
 nRR12(i)=nan(1);
end
nBBB9(i)=snr(BBB9{i,1});
nBBB12(i)=snr(BBB12{i,1});

nSS9(i)=snr(SS9{i,1});
nSS12(i)=snr(SS12{i,1});

nSSS9(i)=snr(SSS9{i,1});
nSSS12(i)=snr(SSS12{i,1});


end

% 
% RR9=R9;
% RR12=R12;
% BBB9=B9;
% BBB12=B12;



% 
% 
% plot(nR9)
% hold on
% plot(nR12)
% plot(nV9)
% plot(nV12)
% plot(nS9)
% plot(nS12)
% plot(nB9)
% plot(nB12)

%%
vector=[nanmean(nR9) nanmean(nR12); mean(nV9) mean(nV12); mean(nS9) mean(nS12); mean(nB9) mean(nB12); nanmean(nRR9) ...
nanmean(nRR12); nanmean(nBBB9) nanmean(nBBB12); nanmean(nSS9) nanmean(nSS12); nanmean(nSSS9) nanmean(nSSS12)];



% nanmean(nRR9)
% nanmean(nRR12)
% nanmean(nBBB9)
% nanmean(nBBB12)

c=categorical({'Monopolar+ICA','Monopolar','Bipolar','Bipolar of ICA','Monopolar+ICA (NH)','Bipolar of ICA(NH)','Bipolar:ICA of Bipolar','Bipolar:ICA of Bipolar (NH)'})
bar(c,vector)
grid on
ylabel('Decibels')
title('SNR per configuration for PFC and Parietal lobe')
legend('PFC','Parietal lobe')
ylim([-10.5 -8])
% nanmean(nRR9)
% nanmean(nRR12)
% nanmean(nBBB9)
% nanmean(nBBB12)
% 
% nRR9(i)=snr(RR9{i,1});
% nRR12(i)=snr(RR12{i,1});
% nBBB9(i)=snr(BBB9{i,1});
% nBBB12(i)=snr(BBB12{i,1});
%%
%% PFC and Parietal: Monopolar or Bipolar? COMPARE CORRELATIONS
%Compare SNR 
%R9 and R12 : Monopolar and ICA
%V9 and V12: Monopolar 
%S9 and S12: Bipolar
%B9 and B12: ICA and Bipolar 
nR9=nan(length(R9),1);
nR12=nan(length(R9),1);
nV9=nan(length(R9),1);
nV12=nan(length(R9),1);
nS9=nan(length(R9),1);
nS12=nan(length(R9),1);
nB9=nan(length(R9),1);
nB12=nan(length(R9),1);

nRR9=nan(length(R9),1);
nRR12=nan(length(R9),1);
nBBB9=nan(length(R9),1);
nBBB12=nan(length(R9),1);

nSS12=nan(length(R9),1);
nSS9=nan(length(R9),1);

nSSS12=nan(length(R9),1);
nSSS9=nan(length(R9),1);

contame=0;
for i=1:length(R9)
naco=corrcoef(R9{i,1},R12{i,1});
nR9(i)=naco(2);
naco=corrcoef(V9{i,1},V12{i,1});
nV9(i)=naco(2);

naco=corrcoef(S9{i,1},S12{i,1});
nS9(i)=naco(2);

naco=corrcoef(B9{i,1},B12{i,1});
nB9(i)=naco(2);

if length(RR12{i,1})~=1
naco=corrcoef(RR9{i,1},RR12{i,1});
nRR9(i)=naco(2);
else 
nRR9(i)=nan;
end

naco=corrcoef(BBB9{i,1},BBB12{i,1});
nBBB9(i)=naco(2);

naco=corrcoef(SS9{i,1},SS12{i,1});
nSS9(i)=naco(2);

naco=corrcoef(SSS9{i,1},SSS12{i,1});
nSSS9(i)=naco(2);


end
%%
vector=[nanmean(nR9) ; mean(nV9) ; mean(nS9) ; mean(nB9) ; nanmean(nRR9) ...
; nanmean(nBBB9) ;nanmean(nSS9); nanmean(nSSS9)];

% nanmean(nRR9)
% nanmean(nRR12)
% nanmean(nBBB9)
% nanmean(nBBB12)

c=categorical({'Monopolar+ICA','Monopolar','Bipolar','Bipolar of ICA','Monopolar+ICA (NH)','Bipolar of ICA(NH)','Bipolar:ICA of bipolar','Bipolar:ICA of bipolar (NH)'})
bar(c,vector,'b')
grid on
ylabel('Correlation coefficient')
title('Correlation for PFC and Parietal among configurations')
legend('Correlation PFC/Parietal')



%% Adding ICA without Hippocampus
%Update> IGNORE THIS
%New monopolar signals
R6=cell(length(V6),1);%NREM Reference signals
R9=cell(length(V6),1);%NREM Reference signals
R12=cell(length(V6),1);%NREM Reference signals
R17=cell(length(V6),1);%NREM Reference signals

%New Bipolar signals
B9=cell(length(V6),1);
B12=cell(length(V6),1);
% B17=cell(length(V6),1);


for i=1:length(V6)
VK=[V6 V9 V12];
checa=VK(i,:)
checale=[checa{1,1} checa{1,2} checa{1,3} ];
checale=checale';

[A1 B]=fastica(checale);

sources=B*checale;
[newvec]=orderICA(checale, sources); %Sorts independent components (C6 C9 C12 C17)
%[newvec]=newsorter(checale, sources); %Sorts independent components (C6 C9 C12 C17)
R6{i}=newvec(1,:);
R9{i}=newvec(2,:);
si=size(newvec);
if si(1)==3

R12{i}=newvec(3,:);

else
R12{i}=0;    
end
i
%Bipolar
B9{i}=R9{i}-R6{i};
B12{i}=R12{i}-R6{i};
%B17{i}=R17{i}-R6{i};
end
% checale=checale';
% %%

RR9=R9;
RR12=R12;
BBB9=B9;
BBB12=B12;



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
%% Bandpass filter 
fn=1000;

Mono17=cell(63,1);
Bip17=cell(63,1);

Mono9=cell(63,1);
MonoR9=cell(63,1);
Bip9=cell(63,1);
BipSSS9=cell(63,1);

Mono12=cell(63,1);
MonoR12=cell(63,1);
Bip12=cell(63,1);
BipSSS12=cell(63,1);

% Mono6=cell(63,1);
for i=1:63
Bip17{i}=filtfilt(b1,a1,S17{i});
Mono17{i}=filtfilt(b1,a1,V17{i});
Mono6{i}=filtfilt(b1,a1,V6{i});

Bip9{i}=filtfilt(b1,a1,S9{i});
BipSSS9{i}=filtfilt(b1,a1,SSS9{i});
Mono9{i}=filtfilt(b1,a1,V9{i});
MonoR9{i}=filtfilt(b1,a1,R9{i});

Bip12{i}=filtfilt(b1,a1,S12{i});
BipSSS12{i}=filtfilt(b1,a1,SSS12{i});
Mono12{i}=filtfilt(b1,a1,V12{i});
MonoR12{i}=filtfilt(b1,a1,R12{i});


end


%% Artifact removal with Wavelet transform
% N=fix(log2(length(Bip17{i})));
% % [C,L] = wavedec(X,N,'db8')
% %xdMODWT = wden(X,'modwtsqtwolog','s','mln',N,'sym4');
%   [xdy]=wden(Bip17{i},'sqtwolog','s','sln',N,'db8');

%%
epoch=7;
X=V9;

N=fix(log2(length(X{epoch})));
N=12;
[C,L] = wavedec(X{epoch},N,'db8')
%xdMODWT = wden(X,'modwtsqtwolog','s','mln',N,'sym4');
  [xdy]=wden(X{epoch},'sqtwolog','s','sln',N,'db8');
%%
plot(Bip17{epoch})
hold on
plot(xdy)
  
  snr(Bip17{epoch})
  snr(xdy)
  
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
% subplot(1,3,3)
% plot((1:length(xdy))*(1/fn),xdy);
% % ylim([-20 20])
% xlabel('Time (s)')
% ylabel('uV')
% grid on
% title('Bipolar Hippocampus+Wavelet')

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
[S, E, M] = findRipplesLisa(signal, t.', 200 , 200*(1/3), []);
%%
plot(signal)
hold on
plot([ones(1,length(signal))]*45,'Linewidth',2)
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
grid minor
%%

%% Common ripples 
conta=0;
newM=cell(63,1);
ele=nan(63,1);
for i=1:63

newM{i}=intersect(swr217{i,3},swr17{i,3});
ele(i)=length(newM{i});
conta=conta+length(newM{i})
end

%% Windowing
veamos=find(s17~=0);  %Epochs with ripples detected
carajo=swr17(veamos,:);

veamos2=find(s217~=0);  %Epochs with ripples detected
carajo2=swr217(veamos2,:);

[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Bip17,S17);
[TI2,TN2, cellx2,cellr2,to2,tu2]=win(carajo2,veamos2,Mono17,V17);

veamos3=find(ele~=0);  %Epochs with ripples detected
carajo3=newM(veamos3,:);
car=[carajo3 carajo3 carajo3];
[TI3,TN3, cellx3,cellr3,to3,tu3]=win(car,veamos3',Bip17,S17);
%%

% 

[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Mono9,V9);
[p3 p4]=eta(cellx,cellr)

hold on
[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Bip17,V17);

[p3 p4]=eta(cellx,cellr)


% count=0;
% 
% clear TI TN cellx cellr tu to
% 
% for index=1:length(carajo)
% % index=3;
% 
% checa=carajo(index,:);
% maxch=checa{3};
% 
% %200 ms window before and after= 400+1
% max1=maxch-(200/1000);
% max2=maxch+(200/1000);
% 
% max1s=max1*(fn);
% max2s=max2*(fn);
% 
% %Start and end of SWR 
% mu1=checa{1}*(fn);
% mu2=checa{2}*(fn);
% %
% epoch=veamos(index);
% 
% % signal=M17{epoch};
% signal=Bip17{epoch};
% signalwave=S17{epoch};
% t=(0:length(signal)-1)*(1/fn); %IN SECONDS
% 
% lm=length(maxch);
% 
% %
% 
% for ii=1:lm
% tn=t(round(max1s(1,ii)):round(max2s(1,ii))); %Window length
% ti=t(round(mu1(1,ii)):round(mu2(1,ii))); %Ripple length
% 
% %Windows
% sn=signal(round(max1s(1,ii)):round(max2s(1,ii)));
% sn1=signalwave(round(max1s(1,ii)):round(max2s(1,ii)));
% 
% %Ripples
% sno1=signal(round(mu1(1,ii)):round(mu2(1,ii)));
% sno2=signalwave(round(mu1(1,ii)):round(mu2(1,ii)));
% 
% count=count+1;
% %Windows
% cellx{count,1}=sn1;
% cellr{count,1}=sn;
% %Ripples
% tu{count,:}=sno1;
% to{count,:}=sno2;
% %Times
% TN{count,:}=tn;
% TI{count,:}=ti;
% 
% end
% 
% % tn=t(max1s:max2s);
% % sn=signal(max1s:max2s);
% % sn1=signalwave(max1s:max2s);    
% end
%%
[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Bip17,V17);


[p3 p4]=eta(cellx,cellr)


%% Plotting wideband and SWR in 400 ms windows. 
%Bipolar
epoch=37;


figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
plot(TN{epoch,1},cellx{epoch,1}*(1/0.195))
hold on
plot(TI{epoch,1},to{epoch,1}*(1/0.195),'-r')
xlabel('time (sec)')
ylabel('uV')
title(strcat('Wide band #',num2str(epoch)))
grid on


subplot(1,2,2)

plot(TN{epoch,1},cellr{epoch,1}*(1/0.195))
hold on
plot(TI{epoch,1},tu{epoch,1}*(1/0.195),'-r')


xlabel('time (sec)')
ylabel('uV')
title(strcat('SWR #',num2str(epoch)))
grid on

%% Plotting wideband and SWR in 400 ms windows. 
%Monopolar
epoch=3;


figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1)
plot(TN2{epoch,1},cellx2{epoch,1}*(1/0.195))
hold on
plot(TI2{epoch,1},to2{epoch,1}*(1/0.195),'-r')
xlabel('time (sec)')
ylabel('uV')
title(strcat('Wide band #',num2str(epoch)))
grid on


subplot(1,2,2)

plot(TN2{epoch,1},cellr2{epoch,1}*(1/0.195))
hold on
plot(TI2{epoch,1},tu2{epoch,1}*(1/0.195),'-r')


xlabel('time (sec)')
ylabel('uV')
title(strcat('SWR #',num2str(epoch)))
grid on


%% Event-triggered average
%Bipolar
avex=cell2mat(cellx');
avex=avex.';
wide=mean(avex);

aver=cell2mat(cellr');
aver=aver.';
rip=mean(aver);


subplot(1,2,1)
plot(((1:length(wide))*(1/fn))-202/1000,wide*(1/0.195))
grid on
xlim([-200/1000  200/1000])
xlabel('time (sec)')
ylabel('uV')
title('Wide Band Event-triggered Average')

subplot(1,2,2)
plot(((1:length(rip))*(1/fn))-202/1000,rip*(1/0.195))
grid on
xlim([-200/1000  200/1000])
xlabel('time (sec)')
ylabel('uV')
title('SWR Event-triggered Average')
%%
[p5 p6]=eta(cellx2,cellr2)
% hold on
% eta(cellx,cellr)
[p1 p2]=eta(cellx3,cellr3)
hold on
[p3 p4]=eta(cellx,cellr)

%%

[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Mono12,V12);
[p3 p4]=eta(cellx,cellr);
mtit('Parietal','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
%%

[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Mono9,R9);
[p3 p4]=eta(cellx,cellr)
mtit('PFC','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
%% PFC
[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Mono12,V12);
[p3 p4]=eta(cellx,cellr);
%mtit('Parietal','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
hold on
[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Mono12,R12);
[p3 p4]=eta(cellx,cellr);

% hold on
% [TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Mono12,R12);
% [p3 p4]=eta(cellx,cellr);
%% Hippocampus (Eta and spectrogram)
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Bip17,S17);
cellx{37}=cellx{36};
cellr{37}=cellr{36};

[p3 p4]=eta(cellx,cellr);
mtit('Hippocampus (Bipolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)
% 
% generate(carajo,veamos, Bip17,S17,label1,label2)

%%
barplot(p4,p3)

figure('units','normalized','outerposition',[0 0 1 1])
deco(p3,p4)
mtit('Hippocampus (Bipolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

%% Hippocampus (Eta and spectrogram)
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Mono17,V17);
cellx{37}=cellx{36};
cellr{37}=cellr{36};

[p3 p4]=eta(cellx,cellr);
mtit('Hippocampus (Monopolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%%
barplot(p4,p3)
%
figure('units','normalized','outerposition',[0 0 1 1])
deco(p3,p4)
mtit('Hippocampus (Monopolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

%% Parietal 
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Mono12,V12);
cellx{37}=cellx{36};
cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);

%
mtit('Parietal (Monopolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);


barplot2(p4,p3)
barplot3(p4,p3)

%%
figure('units','normalized','outerposition',[0 0 1 1])
deco(p3,p4)
mtit('Parietal (Monopolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
%%
waveplott(p4)
title('Parietal Monopolar Wavelet (250-500)Hz')
%%
% 
% 
% data=p4;
% 
% clear params
% params.tapers=[3 5];
% params.Fs=fn;
% params.err=0;
% params.fpass=[0 300];
% params.pad=3; %-1 means no zero-padding  
% params.trialave=0; %No averaging of trials.
% movingwin=[.02 .002];
% 
% [S,t,f] = mtspecgramc( data, movingwin, params );
% %subplot(1,2,1)
% subplot(2,2,3)
% 
% t=linspace(-0.2,0.2, length(t));
% 
% plotter1(S,t,f)
% title('Spectrogram Wideband')
% 
% data=p3;
% 
% clear params
% params.tapers=[3 5];
% params.Fs=fn;
% params.err=0;
% params.fpass=[100 300];
% params.pad=8; %-1 means no zero-padding  
% params.trialave=0; %No averaging of trials.
% movingwin=[.03 .001];
% 
% [S,t,f] = mtspecgramc( data, movingwin, params );
% %subplot(1,2,2)
% subplot(2,2,4)
% t=linspace(-0.2,0.2, length(t));
% plotter1(S,t,f)
% 
% title('Spectrogram Bandpass')

%%
% hp4 = get(subplot(2,2,4),'Position')
% 
% colorbar('Position', [hp4(1)+hp4(3)+0.001  hp4(2)  0.01  hp4(2)+hp4(3)*2.1])
%%

%%
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,MonoR12,R12);
cellx{37}=cellx{36};
cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);
mtit('Parietal (Mon+ICA)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%%
figure('units','normalized','outerposition',[0 0 1 1])
deco(p3,p4)
mtit('Parietal (Mon+ICA)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
%%

waveplott(p4)
%%
figure('units','normalized','outerposition',[0 0 1 1])

[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Bip12,S12);

cellx{37}=cellx{36};
cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);
mtit('Parietal (Bipolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])


Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%%
figure('units','normalized','outerposition',[0 0 1 1])
deco(p3,p4)
mtit('Parietal (Bipolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
%%

waveplott(p4)
title('Parietal Bipolar Wavelet (250-500)Hz')

%%
figure('units','normalized','outerposition',[0 0 1 1])

[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,BipSSS12,SSS12);
cellx{37}=cellx{36};
cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);
mtit('Parietal (Bip+ICA)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%%
figure('units','normalized','outerposition',[0 0 1 1])
deco(p3,p4)
mtit('Parietal (Bip+ICA)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
%%
waveplott(p4)

%%
%% PFC 
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Mono9,V9);
cellx{37}=cellx{36};
cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);
mtit('PFC (Monopolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%% 
%%
barplot(p4,p3)
%
figure('units','normalized','outerposition',[0 0 1 1])
deco(p3,p4)
mtit('PFC (Monopolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
%%
waveplott(p4)

%%
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,MonoR9,R9);
cellx{37}=cellx{36};
cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);
mtit('PFC (Mon+ICA)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%%
barplot(p4,p3)
%
figure('units','normalized','outerposition',[0 0 1 1])
deco(p3,p4)
mtit('PFC (Mon+ICA)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
%%
waveplott(p4)

%%
figure('units','normalized','outerposition',[0 0 1 1])

[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Bip9,S9);
cellx{37}=cellx{36};
cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);
mtit('PFC (Bipolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%%
barplot(p4,p3)
%
figure('units','normalized','outerposition',[0 0 1 1])
deco(p3,p4)
mtit('PFC (Bipolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

%%
figure('units','normalized','outerposition',[0 0 1 1])

[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,BipSSS9,SSS9);
cellx{37}=cellx{36};
cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);
mtit('PFC (Bip+ICA)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);


barplot2(p4,p3)
barplot3(p4,p3)

%%
barplot(p4,p3)
%
figure('units','normalized','outerposition',[0 0 1 1])
deco(p3,p4)
mtit('PFC (Bip+ICA)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])


%% ETA combinations for common ripples between monopolar and bipolar hippocampus
%% Parietal 
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(car,veamos3,Mono12,V12);
% cellx{37}=cellx{36};
% cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);
mtit('Parietal (Monopolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

% Wn2=[30/(fn/2)]; % Cutoff=500 Hz
% [b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
% p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%%
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(car,veamos3,MonoR12,R12);
% cellx{37}=cellx{36};
% cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);
mtit('Parietal (Mon+ICA)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%%
figure('units','normalized','outerposition',[0 0 1 1])

[TI,TN, cellx,cellr,to,tu]=win(car,veamos3,Bip12,S12);
[p3 p4]=eta(cellx,cellr);
% cellx{37}=cellx{36};
% cellr{37}=cellr{36};
mtit('Parietal (Bipolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);


barplot2(p4,p3)
barplot3(p4,p3)

%%
figure('units','normalized','outerposition',[0 0 1 1])

[TI,TN, cellx,cellr,to,tu]=win(car,veamos3,BipSSS12,SSS12);
% cellx{37}=cellx{36};
% cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);
mtit('Parietal (Bip+ICA)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%%
%% PFC 
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(car,veamos3,Mono9,V9);
% cellx{37}=cellx{36};
% cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);
mtit('PFC (Monopolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
% Wn2=[30/(fn/2)]; % Cutoff=500 Hz
% [b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
% p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%%
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(car,veamos3,MonoR9,R9);
% cellx{37}=cellx{36};
% cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);
mtit('PFC (Mon+ICA)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
% Wn2=[30/(fn/2)]; % Cutoff=500 Hz
% [b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
% p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%%
figure('units','normalized','outerposition',[0 0 1 1])

[TI,TN, cellx,cellr,to,tu]=win(car,veamos3,Bip9,S9);
% cellx{37}=cellx{36};
% cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);
mtit('PFC (Bipolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%%
figure('units','normalized','outerposition',[0 0 1 1])

[TI,TN, cellx,cellr,to,tu]=win(car,veamos3,BipSSS9,SSS9);
% cellx{37}=cellx{36};
% cellr{37}=cellr{36};
[p3 p4]=eta(cellx,cellr);
mtit('PFC (Bip+ICA)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%%
figure('units','normalized','outerposition',[0 0 1 1])
deco(p3,p4)
mtit('PFC (Bip+ICA)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

%%
%% NEW Hippocampus (Eta and spectrogram)
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(car,veamos3,Bip17,S17);
% cellx{37}=cellx{36};
% cellr{37}=cellr{36};

[p3 p4]=eta(cellx,cellr);
mtit('Hippocampus (Bipolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%% NEW Hippocampus (Eta and spectrogram)
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(car,veamos3,Mono17,V17);
% cellx{37}=cellx{36};
% cellr{37}=cellr{36};

[p3 p4]=eta(cellx,cellr);
mtit('Hippocampus (Monopolar)','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

Wn2=[30/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
p4=filtfilt(b2,a2,p4);

barplot2(p4,p3)
barplot3(p4,p3)

%% REFERENCE analysis
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Mono6,V6);
cellx{37}=cellx{36};
cellr{37}=cellr{36};

[p3 p4]=eta(cellx,cellr);
mtit('Reference','fontsize',14,'color',[1 0 0],'position',[.5 1 ])

% Wn2=[30/(fn/2)]; % Cutoff=500 Hz
% [b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
% p4=filtfilt(b2,a2,p4);


barplot2(p4,p3)
barplot3(p4,p3)
%%
%% REFERENCE analysis
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(car,veamos3,Mono6,V6);
% cellx{37}=cellx{36};
% cellr{37}=cellr{36};

[p3 p4]=eta(cellx,cellr);
mtit('Reference','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
% 
% Wn2=[30/(fn/2)]; % Cutoff=500 Hz
% [b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
% p4=filtfilt(b2,a2,p4);


barplot2(p4,p3)
barplot3(p4,p3)
%% Trying out the bump wavelet
fn=1000;
data=p4;

[cfs,f] = cwt(data,fn,'TimeBandwidth',35);

%subplot(1,2,1)
subplot(1,2,1)

t=linspace(-0.2,0.2, length(cfs));

%t=linspace(-0.5,0.5, length(cfs));
helperCWTTimeFreqPlot(cfs,t,f,'surf','CWT of Quadratic Chirp','Seconds','Hz')
%plotter1(S,t,f)
title('Spectrogram Wideband (High frequency resolution)')
% xticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5])
% xticklabels({'-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5'})
%ylim([3.5 30])
%ylim([5 20])
ylim([5.4 22])



[cfs,f] = cwt(data,'amor',fn);

%subplot(1,2,1)
subplot(1,2,2)

t=linspace(-0.2,0.2, length(cfs));

%t=linspace(-0.5,0.5, length(cfs));
helperCWTTimeFreqPlot(cfs,t,f,'surf','CWT of Quadratic Chirp','Seconds','Hz')
%plotter1(S,t,f)
title('Spectrogram Wideband (High frequency resolution)')
% xticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5])
% xticklabels({'-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5'})
%ylim([3.5 30])
%ylim([5 20])
ylim([5.4 22])


%% Wavelet test
T=3;

t=1/256:1/256:T;

XXX=sin(2*pi*5*t);

plot(XXX)

fs=265;

T=12;

t1=1/fs:1/fs:T/4;

S1=2*sin(2*pi*.5*t1);

S2=sin(2*pi*6*t1);

S3=4*cos(2*pi*20*t1);

S4=cos(2*pi*80*t1);

S=[S1 S2 S3 S4];

plot(S)
%%
name='haar';

N = wmaxlev(length(p4),name)
N=5;
[C,L] = wavedec(p4,N,name);

[D1, D2, D3, D4,D5 ] = detcoef(C,L,[1 2 3 4 5]);


figure('units','normalized','outerposition',[0 0 1 1])

cellnames={'250Hz-500 Hz';'125Hz-250 Hz';'60Hz-125 Hz';'30Hz-60Hz';'15Hz-30Hz' };


for i=1:N
subplot(N,1,i)
% plot(linspace(-0.2,0.2,length(D1)),D1,'')
plot(linspace(-0.2,0.2,length(eval(strcat('D',num2str(i))))),eval(strcat('D',num2str(i))),'LineWidth',2)
title(cellnames{i})
grid on
xlabel('Time(sec)')
ylabel('uV')
end

%%
data=D1;

clear params
params.tapers=[3 5];
params.Fs=fn;
params.err=0;
params.fpass=[0 300];
params.pad=3; %-1 means no zero-padding  
params.trialave=0; %No averaging of trials.
movingwin=[.02 .002];

[S,t,f] = mtspecgramc( data, movingwin, params );
%subplot(1,2,1)
% subplot(2,2,3)

t=linspace(-0.2,0.2, length(t));

plotter1(S,t,f)
title('Spectrogram Wideband')

waveplott(p4)