function [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,RipFreq3,timeasleep2]=newest_only_ripple_nl_level(level)
%{
LOAD DATA, easy and quick. 
timeasleep2=sum(cellfun('length',V9_nl))*(1/1000)/60; % In minutes
RipFreq3=sum(s17_nl)/(timeasleep2*(60));

The V signals are the monopolar recordings of the 4 channels. 

The S signals are the bipolar recordings which have been substracted the
reference signal (V6)
%}

%Load Bipolar signals
S17=load('S17.mat');
S17_nl=S17.S17;

S12=load('S12.mat');
S12_nl=S12.S12;

S9=load('S9.mat');
S9_nl=S9.S9;


%Load Monopolar signals

V17=load('V17.mat');
V17_nl=V17.V17;

V12=load('V12.mat');
V12_nl=V12.V12;

V9=load('V9.mat');
V9_nl=V9.V9;

V6=load('V6.mat');
V6_nl=V6.V6;
'Loaded channels'

timeasleep2=sum(cellfun('length',V9_nl))*(1/1000)/60 % In minutes

%Band pass filter design:
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=500 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

% Bandpass filtering:

Mono6_nl=cellfun(@(equis) filtfilt(b1,a1,equis), V6_nl ,'UniformOutput',false);
Mono9_nl=cellfun(@(equis) filtfilt(b1,a1,equis), V9_nl ,'UniformOutput',false);
Mono12_nl=cellfun(@(equis) filtfilt(b1,a1,equis), V12_nl ,'UniformOutput',false);
Mono17_nl=cellfun(@(equis) filtfilt(b1,a1,equis), V17_nl ,'UniformOutput',false);


Bip9_nl=cellfun(@(equis) filtfilt(b1,a1,equis), S9_nl ,'UniformOutput',false);
Bip12_nl=cellfun(@(equis) filtfilt(b1,a1,equis), S12_nl ,'UniformOutput',false);
Bip17_nl=cellfun(@(equis) filtfilt(b1,a1,equis), S17_nl ,'UniformOutput',false);


'Bandpass performed'

s17_nl=nan(length(S9_nl),1);
swr17_nl=cell(length(S9_nl),3);
s217_nl=nan(length(S9_nl),1);
swr217_nl=cell(length(S9_nl),3);

rep=5; %Number of thresholds+1


%%
%CHTM2=nan(length(S9_nl),1);
chtm2=median(cellfun(@max,Bip17_nl))*(1/0.195); %Minimum maximum value among epochs.         
CHTM2=floor([chtm2 chtm2/2 chtm2/4 chtm2/8 chtm2/16]);

%Scale magnitude,create time vector
signal_nl=cellfun(@(equis) times((1/0.195), equis)  ,Bip17_nl,'UniformOutput',false);
signal2_nl=cellfun(@(equis) times((1/0.195), equis)  ,Mono17_nl,'UniformOutput',false);
ti_nl=cellfun(@(equis) linspace(0, length(equis)-1,length(equis))*(1/fn) ,signal_nl,'UniformOutput',false);

%Find ripples
%for k=1:rep-1
%for k=1:rep-2
k=level
[S2x_nl,E2x_nl,M2x_nl] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2.', CHTM2(k+1), (CHTM2(k+1))*(1/2), [] ), signal_nl,ti_nl,'UniformOutput',false);    
swr17_nl(:,:,1)=[S2x_nl E2x_nl M2x_nl];
s17_nl(:,1)=cellfun('length',S2x_nl);
k
%end
%%%%%%%%%CHECK HERE
% % % % % % % % % % % timeasleep2=sum(cellfun('length',V9_nl))*(1/1000)/60; % In minutes
RipFreq3=sum(s17_nl)/(timeasleep2*(60));

ripple3=sum(s17_nl); %When using same threshold per epoch.


%%
%error('Stop here please')

% Windowing
for ind=1:size(s17_nl,2)
veamos_nl{:,ind}=find(s17_nl(:,ind)~=0);  %Epochs with ripples detected
carajo_nl{:,:,ind}=swr17_nl(veamos_nl{:,ind},:,ind);

end

sig1_nl=cell(7,1);

sig1_nl{1}=Mono17_nl;
sig1_nl{2}=Bip17_nl;
sig1_nl{3}=Mono12_nl;
sig1_nl{4}=Bip12_nl;
sig1_nl{5}=Mono9_nl;
sig1_nl{6}=Bip9_nl;
sig1_nl{7}=Mono6_nl;


sig2_nl=cell(7,1);

sig2_nl{1}=V17_nl;
sig2_nl{2}=S17_nl;
sig2_nl{3}=V12_nl;
% sig2{4}=R12;
sig2_nl{4}=S12_nl;
%sig2{6}=SSS12;
sig2_nl{5}=V9_nl;
% sig2{7}=R9;
sig2_nl{6}=S9_nl;
%sig2{10}=SSS9;
sig2_nl{7}=V6_nl;
 
% ripple=length(M);

%Number of ripples per threshold.
ripple_nl=sum(s17_nl);



timeasleep2
end