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
%%
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
%%
SS9=load('SS9.mat');
SS9=SS9.SS9;

SS12=load('SS12.mat');
SS12=SS12.SS12;

SS17=load('SS17.mat');
SS17=SS17.SS17;
%%
SSS9=load('SSS9.mat');
SSS9=SSS9.SSS9;

SSS12=load('SSS12.mat');
SSS12=SSS12.SSS12;
%% Band pass design 
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=500 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients for LPF
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

%%
s17=nan(63,1);
swr17=cell(63,3);


for i=1:63
    
signal=Bip17{i}*(1/0.195);
signal2=Mono17{i}*(1/0.195);

ti=(0:length(signal)-1)*(1/fn); %IN SECONDS
[S, E, M] = findRipplesLisa(signal, ti.', 100 , (100)*(1/3), []);
s17(i)=length(M);
swr17{i,1}=S;
swr17{i,2}=E;
swr17{i,3}=M;

[S2, E2, M2] = findRipplesLisa(signal2, ti.', 100 , (100)*(1/3), []);
s217(i)=length(M2);
swr217{i,1}=S2;
swr217{i,2}=E2;
swr217{i,3}=M2;


i
end

veamos=find(s17~=0);  %Epochs with ripples detected
carajo=swr17(veamos,:);
%%
stem(s17)
hold on
stem(s217)

