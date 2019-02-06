
%{
LOAD DATA, easy and quick. 

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



% if art==1
% 
%     % Removing artifacts. 
%     S9n=cell(length(V6),1);
%     S12n=cell(length(V6),1);
%     S17n=cell(length(V6),1);
% 
%     B9n=cell(length(V6),1);
%     B12n=cell(length(V6),1);
%     B17n=cell(length(V6),1);
% 
%     V6n=cell(length(V6),1);
%     V9n=cell(length(V6),1);
%     V12n=cell(length(V6),1);
%     V17n=cell(length(V6),1);
% 
%     R6n=cell(length(V6),1);
%     R9n=cell(length(V6),1);
%     R12n=cell(length(V6),1);
%     R17n=cell(length(V6),1);
% 
%         for i=1:length(V6)
%         %Original Bipolar
%         pro=S9{i};
%         S9n{i,1}=outlier(pro,2.5);
%         pro=S12{i};
%         S12n{i,1}=outlier(pro,2.5);
%         pro=S17{i};
%         S17n{i,1}=outlier(pro,1.5);
% 
%         %Bipolar after ICA
%         pro=B9{i};
%         B9n{i,1}=outlier(pro,2.5);
%         pro=B12{i};
%         B12n{i,1}=outlier(pro,2.5);
%         pro=B17{i};
%         B17n{i,1}=outlier(pro,2.5);
% 
%         %Original Monopolar
%         pro=V6{i};
%         V6n{i,1}=outlier(pro,2.5);
%         pro=V9{i};
%         V9n{i,1}=outlier(pro,2.5);
%         pro=V12{i};
%         V12n{i,1}=outlier(pro,2.5);
%         pro=V17{i};
%         V17n{i,1}=outlier(pro,1.5);
% 
%         %Monopolar after ICA
%         pro=R6{i};
%         R6n{i,1}=outlier(pro,2.5);
%         pro=R9{i};
%         R9n{i,1}=outlier(pro,2.5);
%         pro=R12{i};
%         R12n{i,1}=outlier(pro,2.5);
%         pro=R17{i};
%         R17n{i,1}=outlier(pro,2.5);
% 
%         end
% 
%     S9=S9n;
%     S12=S12n;
%     S17=S17n;
% 
%     B9=B9n;
%     B12=B12n;
%     B17=B17n;
% 
%     V6=V6n;
%     V9=V9n;
%     V12=V12n;
%     V17=V17n;
% 
%     R6=R6n;
%     R9=R9n;
%     R12=R12n;
%     R17=R17n;
%     
%     'Artifact detection performed'
% end

%Band pass filter design:
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=500 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

% Bandpass filtering:

% % % %Declare empty cell arrays
% % % Mono6_nl=cell(length(S9_nl),1);
% % % Mono9_nl=cell(length(S9_nl),1);
% % % Mono12_nl=cell(length(S9_nl),1);
% % % Mono17_nl=cell(length(S9_nl),1);
% % % 
% % % Bip9_nl=cell(length(S9_nl),1);
% % % Bip12_nl=cell(length(S9_nl),1);
% % % Bip17_nl=cell(length(S9_nl),1);
% % % 
% % % %Filtering
% % % for i=1:length(S9_nl)
% % %     
% % % Bip9_nl{i}=filtfilt(b1,a1,S9_nl{i});    
% % % Bip12_nl{i}=filtfilt(b1,a1,S12_nl{i});
% % % Bip17_nl{i}=filtfilt(b1,a1,S17_nl{i});
% % % 
% % % Mono6_nl{i}=filtfilt(b1,a1,V6_nl{i});
% % % Mono9_nl{i}=filtfilt(b1,a1,V9_nl{i});
% % % Mono12_nl{i}=filtfilt(b1,a1,V12_nl{i});
% % % Mono17_nl{i}=filtfilt(b1,a1,V17_nl{i});
% % % 
% % % end

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

%thr=140;
% % thr=linspace(max(signal)/(2.^(4)),max(signal),rep);
% % thr=sort(thr,'descend');
%thr=180;

%%
%CHTM2=nan(length(S9_nl),1);
chtm2=median(cellfun(@max,Bip17_nl))*(1/0.195); %Minimum maximum value among epochs.         
CHTM2=floor([chtm2 chtm2/2 chtm2/4 chtm2/8 chtm2/16]);

%Scale magnitude,create time vector
signal_nl=cellfun(@(equis) times((1/0.195), equis)  ,Bip17_nl,'UniformOutput',false);
signal2_nl=cellfun(@(equis) times((1/0.195), equis)  ,Mono17_nl,'UniformOutput',false);
ti_nl=cellfun(@(equis) linspace(0, length(equis)-1,length(equis))*(1/fn) ,signal_nl,'UniformOutput',false);

%Find ripples
for k=1:rep-1
[S2x_nl,E2x_nl,M2x_nl] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2.', CHTM2(k+1), (CHTM2(k+1))*(1/2), [] ), signal_nl,ti_nl,'UniformOutput',false);    
swr17_nl(:,:,k)=[S2x_nl E2x_nl M2x_nl];
s17_nl(:,k)=cellfun('length',S2x_nl);
k
end




% % % for i=1:length(S9_nl)
% % %     
% % % signal_nl=Bip17_nl{i}*(1/0.195);
% % % signal2_nl=Mono17_nl{i}*(1/0.195);
% % % 
% % % % signal_array=[Mono17{i} Mono12{i} Mono9{i} Mono6{i}];
% % % % signal_array2=[V17{i} V12{i} V9{i} V6{i}];
% % % % signal_arrayQ=[envelope1(Mono17{i}) envelope1(Mono12{i}) envelope1(Mono9{i}) envelope1(Mono6{i})];
% % % signal_array_nl=[Mono17_nl{i} Mono12_nl{i} Mono9_nl{i}];
% % % signal_array2_nl=[V17_nl{i} V12_nl{i} V9_nl{i} ];
% % % %signal_arrayQ=[envelope1(Mono17{i}) envelope1(Mono12{i}) envelope1(Mono9{i})];
% % % 
% % % 
% % % ti_nl=(0:length(signal_nl)-1)*(1/fn); %IN SECONDS
% % % 
% % % %thr=linspace(max(signal)/(2.^(rep-1)),max(signal),rep);
% % % %thr=sort(thr,'descend');
% % % 
% % % %Thresholds for Bipolar recording of Hippocampus. 
% % % % % % % % % % % % % % thr_nl=[max(signal_nl) max(signal_nl)/2 max(signal_nl)/4 max(signal_nl)/8 max(signal_nl)/16];
% % % % % % % % % % % % % % thr_nl=round(thr_nl);
% % % 
% % % % %Thresholds for Monopolar recording of Hippocampus. 
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
% % % %[S_nl{k}, E_nl{k}, M_nl{k}] = findRipplesLisa(signal_nl, ti_nl.', thr_nl(k+1) , (thr_nl(k+1))*(1/2), []);
% % % [S_nl{k}, E_nl{k}, M_nl{k}] = findRipplesLisa(signal_nl, ti_nl.', CHTM2(k+1) , (CHTM2(k+1))*(1/2), []);
% % % 
% % % % [no_rip]=no_ripples(ti,S{k},E{k})
% % % % [no_rip(:,k)]=no_ripples(ti,S{k},E{k})
% % % 
% % % %K=4 has shown to give too many ripples and not large enough no ripple
% % % %windows. 
% % % 
% % % 
% % % 
% % % % [pks]=no_ripples(ti,S{k},E{k},ro);
% % % 
% % % % ch=sig1(1:2:7);
% % % % cch=ch{1};
% % % 
% % % s17_nl(i,k)=length(M_nl{k});
% % % swr17_nl{i,1,k}=S_nl{k};
% % % swr17_nl{i,2,k}=E_nl{k};
% % % swr17_nl{i,3,k}=M_nl{k};
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
% % % disp(strcat('Progress:',num2str(round(i*100/length(S9_nl))),'%'))
% % % pause(.01)
% % % end

timeasleep2=sum(cellfun('length',V9_nl))*(1/1000)/60; % In minutes
RipFreq3=sum(s17_nl)/(timeasleep2*(60));

ripple3=sum(s17_nl); %When using same threshold per epoch.


%%
%error('Stop here please')

% Windowing
for ind=1:size(s17_nl,2)
veamos_nl{:,ind}=find(s17_nl(:,ind)~=0);  %Epochs with ripples detected
carajo_nl{:,:,ind}=swr17_nl(veamos_nl{:,ind},:,ind);

% veamos2{:,ind}=find(s217(:,ind)~=0);  %Epochs with ripples detected
% carajo2{:,:,ind}=swr217(veamos2{:,ind},:,ind);
end
