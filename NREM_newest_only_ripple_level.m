function [ripple2,timeasleep,DEMAIS,y1]=NREM_newest_only_ripple_level(level,nrem,notch,w,lepoch)
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
load('transitions.mat')
%Load Monopolar signals
% Fline=[50 100 150 200 250 300];


V17=load('data17m.mat');
%Monopolar
V17=V17.data17m;
%V17=V17/max(V17);
V17=filtfilt(b2,a2,V17);
%NO NEED OF NOTCH FILTER FOR HIPPOCAMPUS
%UPDATE: Actually does need one!
%V17=flipud(filter(Hcas,flipud(filter(Hcas,V17))));
if size(V17,1)<size(V17,2)
    V17=V17.';
end

if notch==1
Fline=[50 100 150 200 250.5 300];

[V17] = ft_notch(V17.', fn,Fline,1,2);
%V17=V17/median(V17);
V17=V17.';
end

%Bandpassed versions
Mono17=filtfilt(b1,a1,V17); 
%NREM extraction
[V17,~]=reduce_data(V17,transitions,1000,nrem);
[Mono17,~]=reduce_data(Mono17,transitions,1000,nrem);


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

%Might need to comment this:
chtm=median(cellfun(@max,Mono17))*(1/0.195); %Minimum maximum value among epochs.

%Median is used to account for any artifact/outlier. 
DEMAIS=linspace(floor(chtm/16),floor(chtm),30);
%DEMAIS=linspace((chtm/16),(chtm),30);
rep=length(DEMAIS);


signal2=cellfun(@(equis) times((1/0.195), equis)  ,Mono17,'UniformOutput',false);
ti=cellfun(@(equis) linspace(0, length(equis)-1,length(equis))*(1/fn) ,signal2,'UniformOutput',false);



%Find ripples
% for k=1:rep-1
for k=1:rep-2
% k=level;
[S2x,E2x,M2x] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2.', DEMAIS(k+1), (DEMAIS(k+1))*(1/2), [] ), signal2,ti,'UniformOutput',false);    
swr172(:,:,k)=[S2x E2x M2x];
s172(:,k)=cellfun('length',S2x);
k
end

RipFreq2=sum(s172)/(timeasleep*(60)); %RIpples per second. 

%To display number of events use:
ripple2=sum(s172); %When using same threshold per epoch.
%ripple when using different threshold per epoch. 
 
%Adjustment to prevent decrease 
DEMAIS2=DEMAIS;
DEMAIS=DEMAIS(2:end-1);
% size(DEMAIS)
% size(ripple2)
%%
% [p]=polyfit(DEMAIS,ripple2,3);
% y1=polyval(p,DEMAIS);

[p,S,mu]=polyfit(DEMAIS,ripple2,9);
y1=polyval(p,DEMAIS,[],mu);
% [p,S,mu]=polyfit(DEMAIS(2:end),ripple2(2:end),10);
% y1=polyval(p,DEMAIS(2:end),[],mu);

end