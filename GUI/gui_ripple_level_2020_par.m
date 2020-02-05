function [ripple2,timeasleep,DEMAIS,y1]=gui_ripple_level_2020_par(xx)
%(level,nrem,notch,w,lepoch)
%Band pass filter design:
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

%LPF 300 Hz:
fn=1000; % New sampling frequency. 
Wn1=[320/(fn/2)]; % Cutoff=320 Hz
[b2,a2] = butter(3,Wn1); %Filter coefficients

%PFC=dir('*PAR*.mat');
PFC=dir(strcat('*',xx{1},'*.mat'));
PFC=PFC.name;
PFC=load(PFC);
%PFC=PFC.PFC;
PFC=getfield(PFC,xx{1});
PFC=PFC.*(0.195);

% V17=load('V17.mat');
% V17=V17.V17;
% V17=V17.*(0.195);

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

% [transitions]=sort_scoring(transitions); %
% %When no NREM is detected
% if isempty(find(transitions(:,1)==3))
% %     errordlg( strcat('No NREM detected:',cd),'Error')
%     ripple2=[];
%     timeasleep=[];
%     DEMAIS=[];
%     y1=[];
%     return    
% end

    %Convert signal to 1 sec epochs.
    e_t=1;
    e_samples=e_t*(1000); %fs=1kHz
    ch=length(PFC);
    nc=floor(ch/e_samples); %Number of epochs
    NC=[];
    for kk=1:nc    
      NC(:,kk)= PFC(1+e_samples*(kk-1):e_samples*kk);
    end
    
    vec_bin=states;
    vec_bin(vec_bin~=3)=0;
    vec_bin(vec_bin==3)=1;
    %Cluster one values:
    v2=ConsecutiveOnes(vec_bin);
    
%     %Find shorter vector.
%     if length(v2)<nc
%         min_con=length(v2);
%     else
%         min_con=nc;
%     end
    
    
%     v=cell(length(v2(v2~=0)),1);
    v_index=find(v2~=0);
    v_values=v2(v2~=0);

%     
%     ver=NC(:, v_index(1):v_index(1)+(v_values(1,1)-1));
%     v{1}=reshape(A, numel(A), 1);
for epoch_count=1:length(v_index)
v{epoch_count,1}=reshape(NC(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
end 
    
%     
%     nrem_epochs=(states==3);
%     NC=NC(:,nrem_epochs);
% 
% 
% [v17,~]=reduce_data(V17,transitions,1000,3);

%

% V17=filtfilt(b2,a2,V17);
V=cellfun(@(equis) filtfilt(b2,a2,equis), v ,'UniformOutput',false);
Mono=cellfun(@(equis) filtfilt(b1,a1,equis), V ,'UniformOutput',false);

%Total amount of NREM time:
timeasleep=sum(cellfun('length',V))*(1/1000)/60; % In minutes

%%
%Artifact detection stage
% [NC,trackcont]=epocher(Mono17,lepoch);
% ncmax=max(NC)*(1/0.195);
% av=artifacts(ncmax,10);% Looks for artifacts

% if sum(av)~=0 %If artifacts are found
%     av=not(av);
%     %Add NREM epochs division
%     av(trackcont)=0;
% 
%     ind=find(diff([0 av])==1);
%     [labeledX, numRegions] = bwlabel(av);
%     
%     % Get lengths of each region
%     props = regionprops(labeledX, 'Area', 'PixelList');
%     regionLengths = [props.Area];
% 
% %     ind2=sort([ind trackcont]);
% 
%     newMono=cell(length(ind),1);
%     for l=1:length(ind)
%         tempmat=NC(:,ind(l):ind(l)+regionLengths(l)-1);
%         %size(tempmat,2);
%        newMono{l,1}=tempmat(:).';
%     end
%     Mono17=newMono;
% end
%Might need to comment this:
chtm=median(cellfun(@max,Mono))*(1/0.195); %Minimum maximum value among epochs.

%Median is used to account for any artifact/outlier. 
DEMAIS=linspace(floor(chtm/16),floor(chtm),30);
%DEMAIS=linspace((chtm/16),(chtm),30);
rep=length(DEMAIS);


signal2=cellfun(@(equis) times((1/0.195), equis)  ,Mono,'UniformOutput',false);
% ti=cellfun(@(equis) linspace(0, length(equis)-1,length(equis))*(1/fn) ,signal2,'UniformOutput',false);
ti=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,signal2,'UniformOutput',false);

%%
%Find ripples
    % for k=1:rep-1
    for k=1:rep-2
    % k=level;
        if strcmp(xx{1},'PAR')==1 || strcmp(xx{1},'PFC')==1
                [Sx,Ex,Mx] =cellfun(@(equis1,equis2) findRipplesLisa2020(equis1, equis2, DEMAIS(k+1), (DEMAIS(k+1))*(1/2), [] ), signal2,ti,'UniformOutput',false);           
        else
                [Sx,Ex,Mx] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2, DEMAIS(k+1), (DEMAIS(k+1))*(1/2), [] ), signal2,ti,'UniformOutput',false);    
        end
    
    swr(:,:,k)=[Sx Ex Mx];
    s(:,k)=cellfun('length',Sx);
    k
    end

if isvector(s)
RipFreq2=(s)/(timeasleep*(60)); %RIpples per second.         
ripple2=s;

else
RipFreq2=sum(s)/(timeasleep*(60)); %RIpples per second.     
%To display number of events use:
ripple2=sum(s); %When using same threshold per epoch.
%ripple when using different threshold per epoch. 
end

%Adjustment to prevent decrease 
DEMAIS=DEMAIS(2:end-1);


[p,S,mu]=polyfit(DEMAIS,ripple2,14);%10
y1=polyval(p,DEMAIS,[],mu);


end