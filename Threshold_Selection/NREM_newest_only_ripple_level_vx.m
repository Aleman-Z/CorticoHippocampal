function [ripple2,timeasleep,D_thresholds,y1]=NREM_newest_only_ripple_level_vx(level,nrem,notch,w,lepoch,Score)
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



V6=load('V6.mat');
V6=V6.V6;
% V6=filtfilt(b2,a2,V6);
V6=cellfun(@(equis) filtfilt(b2,a2,equis), V6 ,'UniformOutput',false);
%if w==4 && notch==1
if notch==1
Fline=[50 100 150 207.5 250.5 300];

[V6] = ft_notch(V6.', fn,Fline,1,2);
V6=V6.';

    %    [V6] = ft_preproc_dftfilter(V6.',fn,Fline); 
%    V6=V6.';
 %V6=flipud(filter(H100,flipud(filter(H100,V6))));
end
% Mono6=filtfilt(b1,a1,V6); 
Mono6=cellfun(@(equis) filtfilt(b1,a1,equis), V6 ,'UniformOutput',false);

% V17=load('data17m.mat');
% %Monopolar
% V17=V17.data17m;
V17=load('V17.mat');
V17=V17.V17;
% V17=filtfilt(b2,a2,V17);
V17=cellfun(@(equis) filtfilt(b2,a2,equis), V17 ,'UniformOutput',false);
%NO NEED OF NOTCH FILTER FOR HIPPOCAMPUS
%UPDATE: Actually does need one!
%V17=flipud(filter(Hcas,flipud(filter(Hcas,V17))));

if notch==1
Fline=[50 100 150 200 250.5 300];

[V17] = ft_notch(V17.', fn,Fline,1,2);
V17=V17.';
end

%Bipolar
% S17=V17-V6;
% S17=load('S17.mat');
% S17=S17.S17;

%Bandpassed versions
% Mono17=filtfilt(b1,a1,V17); 
Mono17=cellfun(@(equis) filtfilt(b1,a1,equis), V17 ,'UniformOutput',false);
% Bip17=filtfilt(b1,a1,S17);
% Bip17=cellfun(@(equis) filtfilt(b1,a1,equis), S17 ,'UniformOutput',false);

%NREM extraction
% [V17,~]=reduce_data(V17,transitions,1000,nrem);
% [S17,~]=reduce_data(S17,transitions,1000,3);
% [Mono17,~]=reduce_data(Mono17,transitions,1000,nrem);
% [Bip17,~]=reduce_data(Bip17,transitions,1000,3);


% V12=load('data12m.mat');
% V12=V12.data12m;

V12=load('V12.mat');
V12=V12.V12;
% V12=filtfilt(b2,a2,V12);
V12=cellfun(@(equis) filtfilt(b2,a2,equis), V12 ,'UniformOutput',false);

%if w==2 && notch==1
if  notch==1
Fline=[50 100 149 150 200 249.5 250 300 66.5 133.5 266.5];
 
[V12] = ft_notch(V12.', fn,Fline,1,2);
V12=V12.';
    %      [V12] = ft_preproc_dftfilter(V12.',fn,Fline); 
%      V12=V12.'; 
%V12=flipud(filter(Hcas2,flipud(filter(Hcas2,V12))));
end
% S12=V12-V6;
% S12=load('S12.mat');
% S12=S12.S12;
% Mono12=filtfilt(b1,a1,V12);
Mono12=cellfun(@(equis) filtfilt(b1,a1,equis), V12 ,'UniformOutput',false);
% Bip12=filtfilt(b1,a1,S12);
% Bip12=cellfun(@(equis) filtfilt(b1,a1,equis), S12 ,'UniformOutput',false);

% [V12,~]=reduce_data(V12,transitions,1000,nrem);
% [S12,~]=reduce_data(S12,transitions,1000,3);
% [Mono12,~]=reduce_data(Mono12,transitions,1000,nrem);
% [Bip12,~]=reduce_data(Bip12,transitions,1000,3);


% V9=load('data9m.mat');
% V9=V9.data9m;
V9=load('V9.mat');
V9=V9.V9;
%V9=filtfilt(b2,a2,V9);
V9=cellfun(@(equis) filtfilt(b2,a2,equis), V9 ,'UniformOutput',false);

%if w==3 && notch==1
if notch==1
%V9=flipud(filter(Hcas2,flipud(filter(Hcas2,V9))));
Fline=[49.5 50 100 150 200 250 300 66.5 133.5 266.5];

[V9] = ft_notch(V9.', fn,Fline,1,2);
V9=V9.';

end
%S9=V9-V6;
% S9=load('S9.mat');
% S9=S9.S9;
% Mono9=filtfilt(b1,a1,V9);
% Bip9=filtfilt(b1,a1,S9);
Mono9=cellfun(@(equis) filtfilt(b1,a1,equis), V9 ,'UniformOutput',false);
% Bip9=cellfun(@(equis) filtfilt(b1,a1,equis), S9 ,'UniformOutput',false);




%Total amount of time spent sleeping:
timeasleep=sum(cellfun('length',V17))*(1/1000)/60; % In minutes


'Bandpass performed'


% rep=5; %Number of thresholds+1

%%
%Area used for ripple detection.
if strcmp(w,'PFC')
    Mono=Mono9;
end
if strcmp(w,'HPC')
    Mono=Mono17;
end
if strcmp(w,'PAR')
    Mono=Mono12;
end

[NC]=epocher(Mono,lepoch);
% ncmax=max(NC)*(1/0.195);
% chtm=median(ncmax);

%ncmax=quantile(NC,0.999)*(1/0.195);
ncmax=max(NC)*(1/0.195);
% chtm=median(ncmax);

%Might need to comment this:
chtm=median(cellfun(@max,Mono))*(1/0.195); %Minimum maximum value among epochs.

%Median is used to account for any artifact/outlier. 
D_thresholds=linspace(floor(chtm/16),floor(chtm),30);
%D_thresholds=linspace((chtm/16),(chtm),30);
rep=length(D_thresholds);


signal2=cellfun(@(equis) times((1/0.195), equis)  ,Mono,'UniformOutput',false);
ti=cellfun(@(equis) linspace(0, length(equis)-1,length(equis))*(1/fn) ,signal2,'UniformOutput',false);


%Find ripples
% for k=1:rep-1
for k=1:rep-2
% k=level;
[S2x,~,~] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2.', D_thresholds(k+1), (D_thresholds(k+1))*(1/2), [] ), signal2,ti,'UniformOutput',false);    
% swr172(:,:,k)=[S2x E2x M2x];
swr(:,k)=cellfun('length',S2x);
k/rep-2*100
end

RipFreq2=sum(swr)/(timeasleep*(60)); %RIpples per second. 

%To display number of events use:
ripple2=sum(swr); %When using same threshold per epoch.
%ripple when using different threshold per epoch. 
 
%Adjustment to prevent decrease 
D_thresholds=D_thresholds(2:end-1);

[p,S,mu]=polyfit(D_thresholds,ripple2,9);
y1=polyval(p,D_thresholds,[],mu);
% [p,S,mu]=polyfit(D_thresholds(2:end),ripple2(2:end),10);
% y1=polyval(p,D_thresholds(2:end),[],mu);

end