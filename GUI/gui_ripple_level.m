function [ripple2,timeasleep,DEMAIS,y1]=gui_ripple_level(level,nrem,notch,w,lepoch)
%Band pass filter design:
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

%LPF 300 Hz:
fn=1000; % New sampling frequency. 
Wn1=[320/(fn/2)]; % Cutoff=320 Hz
[b2,a2] = butter(3,Wn1); %Filter coefficients

V17=load('V17.mat');
V17=V17.V17;
V17=V17.*(0.195);

A = dir('*states*.mat');
A={A.name};

% if scoring==1 && ~isempty(A)
if  ~isempty(A)
       cellfun(@load,A);
else
%     error('No Scoring found')
%     errordlg( strcat('No Scoring found:',cd),'Error')
    ripple2=[];
    timeasleep=[];
    DEMAIS=[];
    y1=[];
    return
    %,timeasleep,DEMAIS,y1
    
end

[transitions]=sort_scoring(transitions); %
%When no NREM is detected
if isempty(find(transitions(:,1)==3))
%     errordlg( strcat('No NREM detected:',cd),'Error')
    ripple2=[];
    timeasleep=[];
    DEMAIS=[];
    y1=[];
    return    
end

[v17,~]=reduce_data(V17,transitions,1000,3);

%

% V17=filtfilt(b2,a2,V17);
V17=cellfun(@(equis) filtfilt(b2,a2,equis), v17 ,'UniformOutput',false);
Mono17=cellfun(@(equis) filtfilt(b1,a1,equis), V17 ,'UniformOutput',false);

%Total amount of time spent sleeping:
timeasleep=sum(cellfun('length',V17))*(1/1000)/60; % In minutes

%%
%Artifact detection stage
[NC,trackcont]=epocher(Mono17,lepoch);
% ncmax=max(NC)*(1/0.195);
% chtm=median(ncmax);

%ncmax=quantile(NC,0.999)*(1/0.195);
ncmax=max(NC)*(1/0.195);
% chtm=median(ncmax);
av=artifacts(ncmax,10);% Looks for artifacts

if sum(av)~=0 %If artifacts are found
    av=not(av);
    %Add NREM epochs division
    av(trackcont)=0;

    ind=find(diff([0 av])==1);
    [labeledX, numRegions] = bwlabel(av);
    
    % Get lengths of each region
    props = regionprops(labeledX, 'Area', 'PixelList');
    regionLengths = [props.Area];

%     ind2=sort([ind trackcont]);

    newMono=cell(length(ind),1);
    for l=1:length(ind)
        tempmat=NC(:,ind(l):ind(l)+regionLengths(l)-1);
        %size(tempmat,2);
       newMono{l,1}=tempmat(:).';
    end
    Mono17=newMono;
end
%Might need to comment this:
chtm=median(cellfun(@max,Mono17))*(1/0.195); %Minimum maximum value among epochs.

%Median is used to account for any artifact/outlier. 
DEMAIS=linspace(floor(chtm/16),floor(chtm),30);
%DEMAIS=linspace((chtm/16),(chtm),30);
rep=length(DEMAIS);


signal2=cellfun(@(equis) times((1/0.195), equis)  ,Mono17,'UniformOutput',false);
ti=cellfun(@(equis) linspace(0, length(equis)-1,length(equis))*(1/fn) ,signal2,'UniformOutput',false);
%%
%Find ripples
% for k=1:rep-1
for k=1:rep-2
% k=level;
[S2x,E2x,M2x] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2, DEMAIS(k+1), (DEMAIS(k+1))*(1/2), [] ), signal2,ti,'UniformOutput',false);    
swr172(:,:,k)=[S2x E2x M2x];
s172(:,k)=cellfun('length',S2x);
k
end

if isvector(s172)
RipFreq2=(s172)/(timeasleep*(60)); %RIpples per second.         
ripple2=s172;

else
RipFreq2=sum(s172)/(timeasleep*(60)); %RIpples per second.     
%To display number of events use:
ripple2=sum(s172); %When using same threshold per epoch.
%ripple when using different threshold per epoch. 
end

%Adjustment to prevent decrease 
DEMAIS=DEMAIS(2:end-1);


[p,S,mu]=polyfit(DEMAIS,ripple2,10);%9
y1=polyval(p,DEMAIS,[],mu);


end