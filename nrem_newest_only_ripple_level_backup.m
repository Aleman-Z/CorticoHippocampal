function [sig1,sig2,ripple2,carajo,veamos,CHTM,RipFreq2,timeasleep]=nrem_newest_only_ripple_level(level,nrem,notch,w,lepoch)
%{
LOAD DATA, easy and quick. 

The V signals are the monopolar recordings of the 4 channels. 

The S signals are the bipolar recordings which have been substracted the
reference signal (V6)
%}

% % %Load Bipolar signals
% % S17=load('S17.mat');
% % S17=S17.S17;
% % 
% % S12=load('S12.mat');
% % S12=S12.S12;
% % 
% % S9=load('S9.mat');
% % S9=S9.S9;
%Band pass filter design:
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=500 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

%LPF 300 Hz:
fn=1000; % New sampling frequency. 
Wn1=[320/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn1); %Filter coefficients



%Load Sleeping stage classification
load('transitions.mat')
%Load Monopolar signals
% Fline=[50 100 150 200 250 300];

%Reference
V6=load('data6m.mat');
V6=V6.data6m;
V6=filtfilt(b2,a2,V6);
%if w==4 && notch==1
if notch==1
Fline=[50 100 150 207.5 250.5 300];

[V6] = ft_notch(V6.', fn,Fline,1,2);
V6=V6.';

    %    [V6] = ft_preproc_dftfilter(V6.',fn,Fline); 
%    V6=V6.';
 %V6=flipud(filter(H100,flipud(filter(H100,V6))));
end
Mono6=filtfilt(b1,a1,V6); 


V17=load('data17m.mat');
%Monopolar
V17=V17.data17m;
V17=filtfilt(b2,a2,V17);
%NO NEED OF NOTCH FILTER FOR HIPPOCAMPUS
%UPDATE: Actually does need one!
%V17=flipud(filter(Hcas,flipud(filter(Hcas,V17))));

if notch==1
Fline=[50 100 150 200 250.5 300];

[V17] = ft_notch(V17.', fn,Fline,1,2);
V17=V17.';
end

%Bipolar
S17=V17-V6;
%Bandpassed versions
Mono17=filtfilt(b1,a1,V17); 
Bip17=filtfilt(b1,a1,S17);
%NREM extraction
[V17,~]=reduce_data(V17,transitions,1000,nrem);
[S17,~]=reduce_data(S17,transitions,1000,3);
[Mono17,~]=reduce_data(Mono17,transitions,1000,nrem);
[Bip17,~]=reduce_data(Bip17,transitions,1000,3);


V12=load('data12m.mat');
V12=V12.data12m;
V12=filtfilt(b2,a2,V12);
%if w==2 && notch==1
if  notch==1
Fline=[50 100 149 150 200 249.5 250 300 66.5 133.5 266.5];
 
[V12] = ft_notch(V12.', fn,Fline,1,2);
V12=V12.';
    %      [V12] = ft_preproc_dftfilter(V12.',fn,Fline); 
%      V12=V12.'; 
%V12=flipud(filter(Hcas2,flipud(filter(Hcas2,V12))));
end
S12=V12-V6;
Mono12=filtfilt(b1,a1,V12);
Bip12=filtfilt(b1,a1,S12);
[V12,~]=reduce_data(V12,transitions,1000,nrem);
[S12,~]=reduce_data(S12,transitions,1000,3);
[Mono12,~]=reduce_data(Mono12,transitions,1000,nrem);
[Bip12,~]=reduce_data(Bip12,transitions,1000,3);


V9=load('data9m.mat');
V9=V9.data9m;
V9=filtfilt(b2,a2,V9);
%if w==3 && notch==1
if notch==1
%V9=flipud(filter(Hcas2,flipud(filter(Hcas2,V9))));
Fline=[49.5 50 100 150 200 250 300 66.5 133.5 266.5];

[V9] = ft_notch(V9.', fn,Fline,1,2);
V9=V9.';

end
S9=V9-V6;
Mono9=filtfilt(b1,a1,V9);
Bip9=filtfilt(b1,a1,S9);
[V9,~]=reduce_data(V9,transitions,1000,nrem);
[S9,~]=reduce_data(S9,transitions,1000,3);
[Mono9,~]=reduce_data(Mono9,transitions,1000,nrem);
[Bip9,~]=reduce_data(Bip9,transitions,1000,3);


[V6,~]=reduce_data(V6,transitions,1000,nrem);
[Mono6,~]=reduce_data(Mono6,transitions,1000,nrem);

% V12=load('V12.mat');
% V12=V12.V12;
% 
% V9=load('V9.mat');
% V9=V9.V9;
% 
% V6=load('V6.mat');
% V6=V6.V6;
'Loaded channels'

%Total amount of time spent sleeping:
timeasleep=sum(cellfun('length',V9))*(1/1000)/60; % In minutes
%save('timeasleep.mat','timeasleep')


% Bandpass filtering:

%
% % % Mono6=cellfun(@(equis) filtfilt(b1,a1,equis), V6 ,'UniformOutput',false);
% % % Mono9=cellfun(@(equis) filtfilt(b1,a1,equis), V9 ,'UniformOutput',false);
% % % Mono12=cellfun(@(equis) filtfilt(b1,a1,equis), V12 ,'UniformOutput',false);
% % % Mono17=cellfun(@(equis) filtfilt(b1,a1,equis), V17 ,'UniformOutput',false);
% % % 
% % % 
% % % Bip9=cellfun(@(equis) filtfilt(b1,a1,equis), S9 ,'UniformOutput',false);
% % % Bip12=cellfun(@(equis) filtfilt(b1,a1,equis), S12 ,'UniformOutput',false);
% % % Bip17=cellfun(@(equis) filtfilt(b1,a1,equis), S17 ,'UniformOutput',false);



'Bandpass performed'


rep=5; %Number of thresholds+1

%%
[NC]=epocher(Mono17,lepoch);
% ncmax=max(NC)*(1/0.195);
% chtm=median(ncmax);

%ncmax=quantile(NC,0.999)*(1/0.195);
ncmax=max(NC)*(1/0.195);

chtm=median(ncmax);


%chtm=median(cellfun(@max,Bip17))*(1/0.195); %Minimum maximum value among epochs.
%Median is used to account for any artifact/outlier. 

% chtm2=min(cellfun(@max,Mono17))*(1/0.195); %Minimum maximum value among epochs.
CHTM=floor([chtm chtm/2 chtm/4 chtm/8 chtm/16]);

%Scale magnitude,create time vector
% signal=cellfun(@(equis) times((1/0.195), equis)  ,Bip17,'UniformOutput',false);
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
sig1{2}=Bip17;
sig1{3}=Mono12;
sig1{4}=Bip12;
sig1{5}=Mono9;
sig1{6}=Bip9;
sig1{7}=Mono6;


sig2=cell(7,1);

sig2{1}=V17;
sig2{2}=S17;
sig2{3}=V12;
% sig2{4}=R12;
sig2{4}=S12;
%sig2{6}=SSS12;
sig2{5}=V9;
% sig2{7}=R9;
sig2{6}=S9;
%sig2{10}=SSS9;
sig2{7}=V6;
 
% ripple=length(M);
% ripple=sum(s172);

end