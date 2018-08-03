function [sig1,sig2,ripple2,carajo,veamos,CHTM,RipFreq2,timeasleep]=data_newest_only_ripple_level(level,lepoch)
%{
LOAD DATA, easy and quick. 

The V signals are the monopolar recordings of the 4 channels. 

The S signals are the bipolar recordings which have been substracted the
reference signal (V6)
%}

% %Load Bipolar signals
% S17=load('S17.mat');
% S17=S17.S17;
% 
% S12=load('S12.mat');
% S12=S12.S12;
% 
% S9=load('S9.mat');
% S9=S9.S9;


%Load Monopolar signals

% V17=load('V17.mat');
% V17=V17.V17;
% 
% V12=load('V12.mat');
% V12=V12.V12;
% 
% V9=load('V9.mat');
% V9=V9.V9;
% 
% V6=load('V6.mat');
% V6=V6.V6;
V17=load('data17m.mat');
%Monopolar
V17=V17.data17m;

V12=load('data12m.mat');
%Monopolar
V12=V12.data12m;

V9=load('data9m.mat');
%Monopolar
V9=V9.data9m;

V6=load('data6m.mat');
%Monopolar
V6=V6.data6m;

load('transitions.mat')

[V17,~]=reduce_data(V17,transitions,1000,3);
[V12,~]=reduce_data(V12,transitions,1000,3);
[V9,~]=reduce_data(V9,transitions,1000,3);
[V6,~]=reduce_data(V6,transitions,1000,3);



'Loaded channels'

%Total amount of time spent sleeping:
timeasleep=sum(cellfun('length',V9))*(1/1000)/60; % In minutes
%save('timeasleep.mat','timeasleep')

%Band pass filter design:
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=500 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

%LPF 300 Hz:
Wn1=[320/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn1); %Filter coefficients

V6=cellfun(@(equis) filtfilt(b2,a2,equis), V6 ,'UniformOutput',false);
V9=cellfun(@(equis) filtfilt(b2,a2,equis), V9 ,'UniformOutput',false);
V12=cellfun(@(equis) filtfilt(b2,a2,equis), V12 ,'UniformOutput',false);
V17=cellfun(@(equis) filtfilt(b2,a2,equis), V17 ,'UniformOutput',false);

%
Mono6=cellfun(@(equis) filtfilt(b1,a1,equis), V6 ,'UniformOutput',false);
Mono9=cellfun(@(equis) filtfilt(b1,a1,equis), V9 ,'UniformOutput',false);
Mono12=cellfun(@(equis) filtfilt(b1,a1,equis), V12 ,'UniformOutput',false);
Mono17=cellfun(@(equis) filtfilt(b1,a1,equis), V17 ,'UniformOutput',false);

% 
% Bip9=cellfun(@(equis) filtfilt(b1,a1,equis), S9 ,'UniformOutput',false);
% Bip12=cellfun(@(equis) filtfilt(b1,a1,equis), S12 ,'UniformOutput',false);
% Bip17=cellfun(@(equis) filtfilt(b1,a1,equis), S17 ,'UniformOutput',false);



'Bandpass performed'


rep=5; %Number of thresholds+1

%%
[NC]=epocher(Mono17,2);
ncmax=max(NC)*(1/0.195);
% chtm=median(ncmax);
% ncmax=quantile(NC,0.999)*(1/0.195);
chtm=median(ncmax);


%chtm=median(cellfun(@max,Bip17))*(1/0.195); %Minimum maximum value among epochs.
%Median is used to account for any artifact/outlier. 

% chtm2=min(cellfun(@max,Mono17))*(1/0.195); %Minimum maximum value among epochs.
CHTM=floor([chtm chtm/2 chtm/4 chtm/8 chtm/16]);

%Scale magnitude,create time vector
%signal=cellfun(@(equis) times((1/0.195), equis)  ,Bip17,'UniformOutput',false);
signal2=cellfun(@(equis) times((1/0.195), equis)  ,Mono17,'UniformOutput',false);
ti=cellfun(@(equis) linspace(0, length(equis)-1,length(equis))*(1/fn) ,signal2,'UniformOutput',false);

%Find ripples
% for k=1:rep-1
% for k=1:rep-2
k=level;
[S2x,E2x,M2x] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2.', CHTM(k+1), (CHTM(k+1))*(1/2), [] ), signal2,ti,'UniformOutput',false);    
swr172(:,:,1)=[S2x E2x M2x];
s172(:,1)=cellfun('length',S2x);
k
% end

RipFreq2=sum(s172)/(timeasleep*(60));

%To display number of events use:
ripple2=sum(s172); %When using same threshold per epoch.
%ripple when using different threshold per epoch. 

%to display thresholds use CHTM 
% to display rate of occurence use RipFreq2. 
%%
%error('Stop here please')

% Windowing
for ind=1:size(s172,2)
veamos{:,ind}=find(s172(:,ind)~=0);  %Epochs with ripples detected
carajo{:,:,ind}=swr172(veamos{:,ind},:,ind);

% veamos2{:,ind}=find(s217(:,ind)~=0);  %Epochs with ripples detected
% carajo2{:,:,ind}=swr217(veamos2{:,ind},:,ind);
end


sig1=cell(7,1);

sig1{1}=Mono17;
sig1{2}=[];
sig1{3}=Mono12;
sig1{4}=[];
sig1{5}=Mono9;
sig1{6}=[];
sig1{7}=Mono6;


sig2=cell(7,1);

sig2{1}=V17;
sig2{2}=[];
sig2{3}=V12;
% sig2{4}=R12;
sig2{4}=[];
%sig2{6}=SSS12;
sig2{5}=V9;
% sig2{7}=R9;
sig2{6}=[];
%sig2{10}=SSS9;
sig2{7}=V6;
 
% ripple=length(M);
% ripple=sum(s172);

end