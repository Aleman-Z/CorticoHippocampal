function [sig1,sig2,ripple2,carajo,veamos,CHTM,RipFreq2,timeasleep,DEMAIS,y1]=NREM_newest_only_ripple_level(level,nrem,notch,w,lepoch)
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


% % % % % % % % if notch==1
% % % % % % % % %Notch filter bank
% % % % % % % % Wn=[49/(fn/2) 51/(fn/2)]; % Cutoff=50 Hz
% % % % % % % % [B1,A1] = butter(3,Wn,'stop'); %Filter coefficients
% % % % % % % % H1=dfilt.df2t(B1,A1);
% % % % % % % % 
% % % % % % % % Wn=[99/(fn/2) 101/(fn/2)]; % Cutoff=500 Hz
% % % % % % % % [B2,A2] = butter(3,Wn,'stop'); %Filter coefficients
% % % % % % % % H2=dfilt.df2t(B2,A2);
% % % % % % % % 
% % % % % % % % Wn=[149/(fn/2) 151/(fn/2)]; % Cutoff=500 Hz
% % % % % % % % [B3,A3] = butter(3,Wn,'stop'); %Filter coefficients
% % % % % % % % H3=dfilt.df2t(B3,A3);
% % % % % % % % 
% % % % % % % % Wn=[199/(fn/2) 201/(fn/2)]; % Cutoff=500 Hz
% % % % % % % % [B4,A4] = butter(3,Wn,'stop'); %Filter coefficients
% % % % % % % % H4=dfilt.df2t(B4,A4);
% % % % % % % % 
% % % % % % % % Wn=[249/(fn/2) 251/(fn/2)]; % Cutoff=500 Hz
% % % % % % % % [B5,A5] = butter(3,Wn,'stop'); %Filter coefficients
% % % % % % % % H5=dfilt.df2t(B5,A5);
% % % % % % % % 
% % % % % % % % Wn=[299/(fn/2) 301/(fn/2)]; % Cutoff=500 Hz
% % % % % % % % [B6,A6] = butter(3,Wn,'stop'); %Filter coefficients
% % % % % % % % H6=dfilt.df2t(B6,A6);
% % % % % % % % 
% % % % % % % % Hcas=dfilt.cascade(H1,H2,H3,H4,H5,H6);
% % % % % % % % Hcas.PersistentMemory=1;
% % % % % % % % 
% % % % % % % % %Reference filter
% % % % % % % % Wn=[205/(fn/2) 208/(fn/2)]; % Cutoff=500 Hz
% % % % % % % % [B100,A100] = butter(3,Wn,'stop'); %Filter coefficients
% % % % % % % % H100=dfilt.df2t(B100,A100);
% % % % % % % % 
% % % % % % % % %Parietal and PFC filters for 66Hz artifacts and harmonics. 
% % % % % % % % Wn=[65/(fn/2) 67/(fn/2)]; % Cutoff=500 Hz
% % % % % % % % [B7,A7] = butter(3,Wn,'stop'); %Filter coefficients
% % % % % % % % H7=dfilt.df2t(B7,A7);
% % % % % % % % 
% % % % % % % % Wn=[131/(fn/2) 134/(fn/2)]; % Cutoff=500 Hz
% % % % % % % % [B8,A8] = butter(3,Wn,'stop'); %Filter coefficients
% % % % % % % % H8=dfilt.df2t(B8,A8);
% % % % % % % % 
% % % % % % % % Wn=[265/(fn/2) 267/(fn/2)]; % Cutoff=500 Hz
% % % % % % % % [B9,A9] = butter(3,Wn,'stop'); %Filter coefficients
% % % % % % % % H9=dfilt.df2t(B9,A9);
% % % % % % % % 
% % % % % % % % Hcas2=dfilt.cascade(H1,H2,H3,H4,H5,H6,H7,H8,H9);
% % % % % % % % Hcas2.PersistentMemory=1;
% % % % % % % % end


%REDUCE ATTENUATION
% if notch==1
% atten=0.12;
% 
% %Notch filter bank
% Ws=[49.5/(fn/2) 51/(fn/2)]; % Cutoff=50 Hz
% Wp=[46/(fn/2) 53/(fn/2)]; % Cutoff=50 Hz
% [n,Wn] = buttord(Wp,Ws,.1,atten);
% [B1,A1] = butter(n,Wn,'stop'); %Filter coefficients
% H1=dfilt.df2t(B1,A1);
% 
% Ws=[99.5/(fn/2) 101/(fn/2)]; % Cutoff=500 Hz
% Wp=[96/(fn/2) 103/(fn/2)]; % Cutoff=50 Hz
% [n,Wn] = buttord(Wp,Ws,.1,atten);
% [B2,A2] = butter(n,Wn,'stop'); %Filter coefficients
% H2=dfilt.df2t(B2,A2);
% 
% Ws=[149/(fn/2) 151/(fn/2)]; % Cutoff=500 Hz
% Wp=[146/(fn/2) 153/(fn/2)]; % Cutoff=50 Hz
% [n,Wn] = buttord(Wp,Ws,.1,atten);
% [B3,A3] = butter(n,Wn,'stop'); %Filter coefficients
% H3=dfilt.df2t(B3,A3);
% 
% Ws=[198/(fn/2) 201/(fn/2)]; % Cutoff=500 Hz
% Wp=[196/(fn/2) 203/(fn/2)]; % Cutoff=50 Hz
% [n,Wn] = buttord(Wp,Ws,.1,atten);
% [B4,A4] = butter(n,Wn,'stop'); %Filter coefficients
% H4=dfilt.df2t(B4,A4);
% 
% 
% Ws=[249.5/(fn/2) 251/(fn/2)]; % Cutoff=500 Hz
% Wp=[246/(fn/2) 253/(fn/2)]; % Cutoff=50 Hz
% [n,Wn] = buttord(Wp,Ws,.1,atten);
% [B5,A5] = butter(n,Wn,'stop'); %Filter coefficients
% H5=dfilt.df2t(B5,A5);
% 
% Ws=[299.5/(fn/2) 301/(fn/2)]; % Cutoff=500 Hz
% Wp=[296/(fn/2) 303/(fn/2)]; % Cutoff=50 Hz
% [n,Wn] = buttord(Wp,Ws,.1,atten);
% [B6,A6] = butter(n,Wn,'stop'); %Filter coefficients
% H6=dfilt.df2t(B6,A6);
% 
% Hcas=dfilt.cascade(H1,H2,H3,H4,H5,H6);
% Hcas.PersistentMemory=1;
% 
% %Reference filter
% Ws=[205/(fn/2) 208/(fn/2)]; % Cutoff=500 Hz
% Wp=[203/(fn/2) 209/(fn/2)]; % Cutoff=50 Hz
% [n,Wn] = buttord(Wp,Ws,.1,atten);
% [B100,A100] = butter(n,Wn,'stop'); %Filter coefficients
% H100=dfilt.df2t(B100,A100);
% % % % % % % % % 
% %Parietal and PFC filters for 66Hz artifacts and harmonics. 
% Ws=[65/(fn/2) 67/(fn/2)]; % Cutoff=500 Hz
% Wp=[63/(fn/2) 69/(fn/2)]; % Cutoff=50 Hz
% [n,Wn] = buttord(Wp,Ws,.1,atten);
% [B7,A7] = butter(n,Wn,'stop'); %Filter coefficients
% H7=dfilt.df2t(B7,A7);
% % % % % % % % % 
% Ws=[131/(fn/2) 135/(fn/2)]; % Cutoff=500 Hz
% Wp=[129/(fn/2) 136/(fn/2)]; % Cutoff=50 Hz
% [n,Wn] = buttord(Wp,Ws,.1,atten);
% [B8,A8] = butter(n,Wn,'stop'); %Filter coefficients
% H8=dfilt.df2t(B8,A8);
% % % % % % % % % 
% Ws=[265/(fn/2) 268/(fn/2)]; % Cutoff=500 Hz
% Wp=[263/(fn/2) 269/(fn/2)]; % Cutoff=50 Hz
% [n,Wn] = buttord(Wp,Ws,.1,atten);
% [B9,A9] = butter(n,Wn,'stop'); %Filter coefficients
% H9=dfilt.df2t(B9,A9);
% % % % % % % 
% Hcas2=dfilt.cascade(H1,H2,H3,H4,H5,H6,H7,H8,H9);
% Hcas2.PersistentMemory=1;
% 
% end


%Load Sleeping stage classification
load('transitions.mat')
%Load Monopolar signals
% Fline=[50 100 150 200 250 300];

%Reference
V6=load('data6m.mat');
V6=V6.data6m;
%V6=V6/max(V6);
V6=filtfilt(b2,a2,V6);
%if w==4 && notch==1
if notch==1
Fline=[50 100 150 207.5 250.5 300];

[V6] = ft_notch(V6.', fn,Fline,1,2);
%V6=V6/median(V6);
V6=V6.';

    %    [V6] = ft_preproc_dftfilter(V6.',fn,Fline); 
%    V6=V6.';
 %V6=flipud(filter(H100,flipud(filter(H100,V6))));
end
Mono6=filtfilt(b1,a1,V6); 


V17=load('data17m.mat');
%Monopolar
V17=V17.data17m;
%V17=V17/max(V17);
V17=filtfilt(b2,a2,V17);
%NO NEED OF NOTCH FILTER FOR HIPPOCAMPUS
%UPDATE: Actually does need one!
%V17=flipud(filter(Hcas,flipud(filter(Hcas,V17))));

if notch==1
Fline=[50 100 150 200 250.5 300];

[V17] = ft_notch(V17.', fn,Fline,1,2);
%V17=V17/median(V17);
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
%V12=V12/max(V12);
V12=filtfilt(b2,a2,V12);
%if w==2 && notch==1
if  notch==1
Fline=[50 100 149 150 200 249.5 250 300 66.5 133.5 266.5];
 
[V12] = ft_notch(V12.', fn,Fline,1,2);
%V12=V12/median(V12);
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
% V9=V9/max(V9);
V9=filtfilt(b2,a2,V9);
%if w==3 && notch==1
if notch==1
%V9=flipud(filter(Hcas2,flipud(filter(Hcas2,V9))));
Fline=[49.5 50 100 150 200 250 300 66.5 133.5 266.5];

[V9] = ft_notch(V9.', fn,Fline,1,2);
%V9=V9/median(V9);

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

%chtm=median(cellfun(@max,Mono17))*(1/0.195); %Minimum maximum value among epochs.

%Median is used to account for any artifact/outlier. 
 DEMAIS=linspace(floor(chtm/16),floor(chtm),30);
%DEMAIS=linspace((chtm/16),(chtm),30);
rep=length(DEMAIS);


signal=cellfun(@(equis) times((1/0.195), equis)  ,Bip17,'UniformOutput',false);
signal2=cellfun(@(equis) times((1/0.195), equis)  ,Mono17,'UniformOutput',false);
ti=cellfun(@(equis) linspace(0, length(equis)-1,length(equis))*(1/fn) ,signal2,'UniformOutput',false);


% % % % % % 
% % % % % % 
% % % % % % % chtm2=min(cellfun(@max,Mono17))*(1/0.195); %Minimum maximum value among epochs.
% % % % % % CHTM=floor([chtm chtm/2 chtm/4 chtm/8 chtm/16]);
% % % % % % 
% % % % % % %Scale magnitude,create time vector
% % % % % % signal=cellfun(@(equis) times((1/0.195), equis)  ,Bip17,'UniformOutput',false);
% % % % % % signal2=cellfun(@(equis) times((1/0.195), equis)  ,Mono17,'UniformOutput',false);
% % % % % % ti=cellfun(@(equis) linspace(0, length(equis)-1,length(equis))*(1/fn) ,signal2,'UniformOutput',false);

%Find ripples
% for k=1:rep-1
for k=1:rep-2
% k=level;
[S2x,E2x,M2x] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2.', DEMAIS(k+1), (DEMAIS(k+1))*(1/2), [] ), signal2,ti,'UniformOutput',false);    
swr172(:,:,k)=[S2x E2x M2x];
s172(:,k)=cellfun('length',S2x);
k
end

RipFreq2=sum(s172)/(timeasleep*(60));

%To display number of events use:
ripple2=sum(s172); %When using same threshold per epoch.
%ripple when using different threshold per epoch. 
 
%
DEMAIS2=DEMAIS;
DEMAIS=DEMAIS(2:end-1);
% size(DEMAIS)
% size(ripple2)
%%
% [p]=polyfit(DEMAIS,ripple2,3);
% y1=polyval(p,DEMAIS);

[p,S,mu]=polyfit(DEMAIS,ripple2,9);
y1=polyval(p,DEMAIS,[],mu);
CHTM=[];
% [p,S,mu]=polyfit(DEMAIS(2:end),ripple2(2:end),10);
% y1=polyval(p,DEMAIS(2:end),[],mu);

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