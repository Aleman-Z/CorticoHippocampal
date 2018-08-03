function [sig1,sig2,ripple2,carajo,veamos,CHTM,RipFreq2,timeasleep]=NREM_get_ripples(level,nrem,notch,w,lepoch,Score)
%{
LOAD DATA, easy and quick. 

The V signals are the monopolar recordings of the 4 channels. 

The S signals are the bipolar recordings which have been substracted the
reference signal (V6)
%}

%Band pass filter design:
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=500 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

%LPF 300 Hz:
fn=1000; % New sampling frequency. 
Wn1=[320/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn1); %Filter coefficients


%Load Sleeping stage classification
if Score==1
load('transitions.mat')
else
load('transitions2.mat')    
end
%Load Monopolar signals
% Fline=[50 100 150 200 250 300];


V17=load('data17m.mat');
%Monopolar
V17=V17.data17m;
%V17=V17/max(V17);
% V17=filtfilt(b2,a2,V17);

V12=load('data12m.mat');
%Monopolar
V12=V12.data12m;
%V12=V12/max(V12);
% V12=filtfilt(b2,a2,V12);

V9=load('data9m.mat');
%Monopolar
V9=V9.data9m;
%V9=V9/max(V9);
% V9=filtfilt(b2,a2,V9);

V6=load('data6m.mat');
%Monopolar
V6=V6.data6m;
%V6=V6/max(V6);
% V6=filtfilt(b2,a2,V6);



%NO NEED OF NOTCH FILTER FOR HIPPOCAMPUS
%UPDATE: Actually does need one!
%V17=flipud(filter(Hcas,flipud(filter(Hcas,V17))));

%%
if size(V17,1)<size(V17,2)
    V17=V17.';
end

if notch==1
Fline=[50 100 150 200 250.5 300];

[V17] = ft_notch(V17.', fn,Fline,1,2);
%V17=V17/median(V17);
V17=V17.';
end
%%
if size(V12,1)<size(V12,2)
    V12=V12.';
end

if notch==1
Fline=[50 100 150 200 250.5 300];

[V12] = ft_notch(V12.', fn,Fline,1,2);
%V12=V12/median(V12);
V12=V12.';
end
%%
if size(V9,1)<size(V9,2)
    V9=V9.';
end

if notch==1
Fline=[50 100 150 200 250.5 300];

[V9] = ft_notch(V9.', fn,Fline,1,2);
%V9=V9/median(V9);
V9=V9.';
end

%%
if size(V6,1)<size(V6,2)
    V6=V6.';
end

if notch==1
Fline=[50 100 150 200 250.5 300];

[V6] = ft_notch(V6.', fn,Fline,1,2);
%V6=V6/median(V6);
V6=V6.';
end


%%


%Bandpassed versions
Mono17=filtfilt(b1,a1,V17); 
%NREM extraction
[V17,~]=reduce_data(V17,transitions,1000,nrem);
[Mono17,~]=reduce_data(Mono17,transitions,1000,nrem);

Mono12=filtfilt(b1,a1,V12); 
%NREM extraction
[V12,~]=reduce_data(V12,transitions,1000,nrem);
[Mono12,~]=reduce_data(Mono12,transitions,1000,nrem);

Mono9=filtfilt(b1,a1,V9); 
%NREM extraction
[V9,~]=reduce_data(V9,transitions,1000,nrem);
[Mono9,~]=reduce_data(Mono9,transitions,1000,nrem);

Mono6=filtfilt(b1,a1,V6); 
%NREM extraction
[V6,~]=reduce_data(V6,transitions,1000,nrem);
[Mono6,~]=reduce_data(Mono6,transitions,1000,nrem);


'Loaded channels'

%Total amount of time spent sleeping:
timeasleep=sum(cellfun('length',V17))*(1/1000)/60; % In minutes


'Bandpass performed'


rep=5; %Number of thresholds+1

%%
[NC]=epocher(Mono17,lepoch);
% ncmax=max(NC)*(1/0.195);
% chtm=median(ncmax);

%ncmax=quantile(NC,0.999)*(1/0.195);
ncmax=max(NC)*(1/0.195);
chtm=median(ncmax);

% %Might need to comment this:
% chtm=median(cellfun(@max,Mono17))*(1/0.195); %Minimum maximum value among epochs.
% 
% %Median is used to account for any artifact/outlier. 
% DEMAIS=linspace(floor(chtm/16),floor(chtm),30);
% %DEMAIS=linspace((chtm/16),(chtm),30);
% rep=length(DEMAIS);

CHTM=floor([chtm chtm/2 chtm/4 chtm/8 chtm/16]);

signal2=cellfun(@(equis) times((1/0.195), equis)  ,Mono17,'UniformOutput',false);
ti=cellfun(@(equis) linspace(0, length(equis)-1,length(equis))*(1/fn) ,signal2,'UniformOutput',false);



%Find ripples
% for k=1:rep-1
%for k=level
k=level;
[S2x,E2x,M2x] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2.', CHTM(k+1), (CHTM(k+1))*(1/2), [] ), signal2,ti,'UniformOutput',false);    
swr172(:,:,k)=[S2x E2x M2x];
s172(:,k)=cellfun('length',S2x);
k
%end

RipFreq2=sum(s172)/(timeasleep*(60)); %RIpples per second. 

%To display number of events use:
ripple2=sum(s172); %When using same threshold per epoch.
%ripple when using different threshold per epoch. 
 
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



%Adjustment to prevent decrease 
% DEMAIS2=DEMAIS;
% DEMAIS=DEMAIS(2:end-1);
% size(DEMAIS)
% size(ripple2)
%%
% [p]=polyfit(DEMAIS,ripple2,3);
% y1=polyval(p,DEMAIS);
% 
% [p,S,mu]=polyfit(DEMAIS,ripple2,9);
% y1=polyval(p,DEMAIS,[],mu);
% [p,S,mu]=polyfit(DEMAIS(2:end),ripple2(2:end),10);
% y1=polyval(p,DEMAIS(2:end),[],mu);

end