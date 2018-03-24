function [sig1,sig2,ripple2,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple
%{
LOAD DATA, easy and quick. 

The V signals are the monopolar recordings of the 4 channels. 

The S signals are the bipolar recordings which have been substracted the
reference signal (V6)
%}

%Load Bipolar signals
S17=load('S17.mat');
S17=S17.S17;

S12=load('S12.mat');
S12=S12.S12;

S9=load('S9.mat');
S9=S9.S9;


%Load Monopolar signals

V17=load('V17.mat');
V17=V17.V17;

V12=load('V12.mat');
V12=V12.V12;

V9=load('V9.mat');
V9=V9.V9;

V6=load('V6.mat');
V6=V6.V6;
'Loaded channels'

%Total amount of time spent sleeping:
timeasleep=sum(cellfun('length',V9))*(1/1000)/60; % In minutes
%save('timeasleep.mat','timeasleep')

%Band pass filter design:
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=500 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

% Bandpass filtering:

% %Declare empty cell arrays
% Mono6=cell(length(S9),1);
% Mono9=cell(length(S9),1);
% Mono12=cell(length(S9),1);
% Mono17=cell(length(S9),1);
% 
% Bip9=cell(length(S9),1);
% Bip12=cell(length(S9),1);
% Bip17=cell(length(S9),1);

%
Mono6=cellfun(@(equis) filtfilt(b1,a1,equis), V6 ,'UniformOutput',false);
Mono9=cellfun(@(equis) filtfilt(b1,a1,equis), V9 ,'UniformOutput',false);
Mono12=cellfun(@(equis) filtfilt(b1,a1,equis), V12 ,'UniformOutput',false);
Mono17=cellfun(@(equis) filtfilt(b1,a1,equis), V17 ,'UniformOutput',false);


Bip9=cellfun(@(equis) filtfilt(b1,a1,equis), S9 ,'UniformOutput',false);
Bip12=cellfun(@(equis) filtfilt(b1,a1,equis), S12 ,'UniformOutput',false);
Bip17=cellfun(@(equis) filtfilt(b1,a1,equis), S17 ,'UniformOutput',false);



%Filtering
% for i=1:length(S9)
%     
% Bip9{i}=filtfilt(b1,a1,S9{i});    
% Bip12{i}=filtfilt(b1,a1,S12{i});
% Bip17{i}=filtfilt(b1,a1,S17{i});
% 
% Mono6{i}=filtfilt(b1,a1,V6{i});
% Mono9{i}=filtfilt(b1,a1,V9{i});
% Mono12{i}=filtfilt(b1,a1,V12{i});
% Mono17{i}=filtfilt(b1,a1,V17{i});
% 
% end
'Bandpass performed'



% s17=nan(length(S9),1);
% swr17=cell(length(S9),3);
% s217=nan(length(S9),1);
% swr217=cell(length(S9),3);

rep=5; %Number of thresholds+1

%thr=140;
% % thr=linspace(max(signal)/(2.^(4)),max(signal),rep);
% % thr=sort(thr,'descend');
%thr=180;

%%
%THR=nan(length(S9),5);
%%%% CHTM=nan(length(S9),1);

chtm=median(cellfun(@max,Bip17))*(1/0.195); %Minimum maximum value among epochs.         
% chtm2=min(cellfun(@max,Mono17))*(1/0.195); %Minimum maximum value among epochs.
CHTM=floor([chtm chtm/2 chtm/4 chtm/8 chtm/16]);

%Scale magnitude,create time vector
signal=cellfun(@(equis) times((1/0.195), equis)  ,Bip17,'UniformOutput',false);
signal2=cellfun(@(equis) times((1/0.195), equis)  ,Mono17,'UniformOutput',false);
ti=cellfun(@(equis) linspace(0, length(equis)-1,length(equis))*(1/fn) ,signal,'UniformOutput',false);

%Find ripples
for k=1:rep-1
[S2x,E2x,M2x] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2.', CHTM(k+1), (CHTM(k+1))*(1/2), [] ), signal,ti,'UniformOutput',false);    
swr172(:,:,k)=[S2x E2x M2x];
s172(:,k)=cellfun('length',S2x);
k
end

% % % 
% % % for i=1:length(S9)  %For each NREM epoch
% % %     
% % % signal=Bip17{i}*(1/0.195);
% % % signal2=Mono17{i}*(1/0.195);
% % % 
% % % % signal_array=[Mono17{i} Mono12{i} Mono9{i} Mono6{i}];
% % % % signal_array2=[V17{i} V12{i} V9{i} V6{i}];
% % % % signal_arrayQ=[envelope1(Mono17{i}) envelope1(Mono12{i}) envelope1(Mono9{i}) envelope1(Mono6{i})];
% % % % % % % % % % % signal_array=[Mono17{i} Mono12{i} Mono9{i}];
% % % % % % % % % % % signal_array2=[V17{i} V12{i} V9{i} ];
% % % % % % % % % % % signal_arrayQ=[envelope1(Mono17{i}) envelope1(Mono12{i}) envelope1(Mono9{i})];
% % % 
% % % 
% % % ti=(0:length(signal)-1)*(1/fn); %IN SECONDS
% % % 
% % % %thr=linspace(max(signal)/(2.^(rep-1)),max(signal),rep);
% % % %thr=sort(thr,'descend');
% % % 
% % % %Thresholds for Bipolar recording of Hippocampus. 
% % % 
% % % % thr=[max(signal) max(signal)/2 max(signal)/4 max(signal)/8 max(signal)/16];
% % % % thr=round(thr);
% % % % THR(i,:)=thr;
% % % 
% % % % thr=[chtm chtm/2 chtm/4 chtm/8 chtm/16];
% % % % thr=round(thr);
% % % % THR(i,:)=thr;
% % % 
% % % %Thresholds for Monopolar recording of Hippocampus. 
% % % % thr2=[max(signal2) max(signal2)/2 max(signal2)/4 max(signal2)/8 max(signal2)/16];
% % % % thr2=round(thr2);
% % % 
% % % %[thr]=opt_thr(signal,thr);
% % % % thr=max(signal)/2
% % % % [S1, E1, M1] = findRipplesLisa(signal, ti.', thr() , (thr(1))*(1/2), []);
% % % % [S2, E2, M2] = findRipplesLisa(signal, ti.', thr , (thr)*(1/2), []);
% % % % [S3, E3, M3] = findRipplesLisa(signal, ti.', thr , (thr)*(1/2), []);
% % % % [S4, E4, M4] = findRipplesLisa(signal, ti.', thr , (thr)*(1/2), []);
% % % % [S5, E5, M5] = findRipplesLisa(signal, ti.', thr , (thr)*(1/2), []);
% % % for k=1:rep-1
% % % %     error('stop here')
% % % 
% % % %[S{k}, E{k}, M{k}] = findRipplesLisa(signal, ti.', thr(k+1) , (thr(k+1))*(1/2), []);
% % % [S2{k}, E2{k}, M2{k}] = findRipplesLisa(signal, ti.', CHTM(k+1) , (CHTM(k+1))*(1/2), []);
% % % 
% % % % [no_rip]=no_ripples(ti,S{k},E{k})
% % % % [no_rip(:,k)]=no_ripples(ti,S{k},E{k})
% % % 
% % % %K=4 has shown to give too many ripples and not large enough no ripple
% % % %windows. 
% % % 
% % % % if k==1 || k==2 || k==3
% % % % [no{i,k},no2{i,k},noQ{i,k}]=no_ripples(ti,S{k},E{k},ro,signal_array,signal_array2,signal_arrayQ);
% % % % end
% % % 
% % % 
% % % % [pks]=no_ripples(ti,S{k},E{k},ro);
% % % 
% % % % ch=sig1(1:2:7);
% % % % cch=ch{1};
% % % 
% % % % s17(i,k)=length(M{k});
% % % % swr17{i,1,k}=S{k};
% % % % swr17{i,2,k}=E{k};
% % % % swr17{i,3,k}=M{k};
% % % 
% % % s172(i,k)=length(M2{k});
% % % swr172{i,1,k}=S2{k};
% % % swr172{i,2,k}=E2{k};
% % % swr172{i,3,k}=M2{k};
% % % 
% % % % 
% % % % [S2{k}, E2{k}, M2{k}] = findRipplesLisa(signal2, ti.', thr2(k+1) , (thr2(k+1))*(1/2), []);
% % % % s217(i,k)=length(M2{k});
% % % % swr217{i,1,k}=S2{k};
% % % % swr217{i,2,k}=E2{k};
% % % % swr217{i,3,k}=M2{k};
% % % 
% % % 
% % % end
% % % 
% % % % s17(i)=length(M);
% % % % swr17{i,1}=S;
% % % % swr17{i,2}=E;
% % % % swr17{i,3}=M;
% % % 
% % % % ti=(0:length(signal2)-1)*(1/fn); %IN SECONDS
% % % % % [thr]=opt_thr(signal,thr);
% % % % [S2, E2, M2] = findRipplesLisa(signal2, ti.', thr , (thr)*(1/3), []);
% % % % s217(i)=length(M2);
% % % % swr217{i,1}=S2;
% % % % swr217{i,2}=E2;
% % % % swr217{i,3}=M2;
% % % 
% % % 
% % % % i/length(S9)
% % % disp(strcat('Progress:',num2str(round(i*100/length(S9))),'%'))
% % % pause(.01)
% % % end


% s17n=s17;
% 
% RipFreq=sum(s17)/(timeasleep*(60));
RipFreq2=sum(s172)/(timeasleep*(60));


% save('THR.mat','THR')
% save('RipFreq.mat','RipFreq')
% save('s17n.mat','s17n')

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

%Proceed to rearrange.m
%  Windowing using Monopolar

% veamos2=find(s217~=0);  %Epochs with ripples detected
% carajo2=swr217(veamos2,:);
%end

%  su=sum(cellfun('length', no));
% 
% su1=cell(0);
% su2=cell(0);
% su3=cell(0);
% 
% su1_2=cell(0);
% su2_2=cell(0);
% su3_2=cell(0);
% 
% su1_Q=cell(0);
% su2_Q=cell(0);
% su3_Q=cell(0);


%error('stop here please')
% for he=1:length(no)
% %     if no{he,1}~= 0
% su1=[su1;no{he,1}];
% su2=[su2;no{he,2}];
% su3=[su3;no{he,3}];
% 
% su1_2=[su1_2;no2{he,1}];
% su2_2=[su2_2;no2{he,2}];
% su3_2=[su3_2;no2{he,3}];
% 
% su1_Q=[su1_Q;noQ{he,1}];
% su2_Q=[su2_Q;noQ{he,2}];
% su3_Q=[su3_Q;noQ{he,3}];
% 
% %     end
% end

% if length(su1)>100
% su1=su1(1:100);
% end
% if length(su2)>100
% su2=su2(1:100);
% end
% if length(su3)>100
% su3=su3(1:100);
% end
% 
% %SU=[su1 su2 su3];
% SU={su1 su2 su3};
% 
% if length(su1_2)>100
% su1_2=su1_2(1:100);
% end
% if length(su2_2)>100
% su2_2=su2_2(1:100);
% end
% if length(su3_2)>100
% su3_2=su3_2(1:100);
% end

%SU2=[su1_2 su2_2 su3_2];
% SU2={su1_2 su2_2 su3_2};
% 
% if length(su1_Q)>100
% su1_Q=su1_Q(1:100);
% end
% if length(su2_Q)>100
% su2_Q=su2_Q(1:100);
% end
% if length(su3_Q)>100
% su3_Q=su3_Q(1:100);
% end

% SUQ=[su1_Q su2_Q su3_Q];
% SUQ={su1_Q su2_Q su3_Q};
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
ripple=ripple2;

end