
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

%Declare empty cell arrays
Mono6=cell(length(S9),1);
Mono9=cell(length(S9),1);
Mono12=cell(length(S9),1);
Mono17=cell(length(S9),1);

Bip9=cell(length(S9),1);
Bip12=cell(length(S9),1);
Bip17=cell(length(S9),1);

%Filtering
for i=1:length(S9)
    
Bip9{i}=filtfilt(b1,a1,S9{i});    
Bip12{i}=filtfilt(b1,a1,S12{i});
Bip17{i}=filtfilt(b1,a1,S17{i});

Mono6{i}=filtfilt(b1,a1,V6{i});
Mono9{i}=filtfilt(b1,a1,V9{i});
Mono12{i}=filtfilt(b1,a1,V12{i});
Mono17{i}=filtfilt(b1,a1,V17{i});

end
'Bandpass performed'


s17=nan(length(S9),1);
swr17=cell(length(S9),3);
s217=nan(length(S9),1);
swr217=cell(length(S9),3);

rep=5; %Number of thresholds+1

%thr=140;
% % thr=linspace(max(signal)/(2.^(4)),max(signal),rep);
% % thr=sort(thr,'descend');
%thr=180;

%%

for i=1:length(S9)
    
signal=Bip17{i}*(1/0.195);
signal2=Mono17{i}*(1/0.195);

% signal_array=[Mono17{i} Mono12{i} Mono9{i} Mono6{i}];
% signal_array2=[V17{i} V12{i} V9{i} V6{i}];
% signal_arrayQ=[envelope1(Mono17{i}) envelope1(Mono12{i}) envelope1(Mono9{i}) envelope1(Mono6{i})];
signal_array=[Mono17{i} Mono12{i} Mono9{i}];
signal_array2=[V17{i} V12{i} V9{i} ];
signal_arrayQ=[envelope1(Mono17{i}) envelope1(Mono12{i}) envelope1(Mono9{i})];


ti=(0:length(signal)-1)*(1/fn); %IN SECONDS

%thr=linspace(max(signal)/(2.^(rep-1)),max(signal),rep);
%thr=sort(thr,'descend');

%Thresholds for Bipolar recording of Hippocampus. 
thr=[max(signal) max(signal)/2 max(signal)/4 max(signal)/8 max(signal)/16];
thr=round(thr);

%Thresholds for Monopolar recording of Hippocampus. 
thr2=[max(signal2) max(signal2)/2 max(signal2)/4 max(signal2)/8 max(signal2)/16];
thr2=round(thr2);

%[thr]=opt_thr(signal,thr);
% thr=max(signal)/2
% [S1, E1, M1] = findRipplesLisa(signal, ti.', thr() , (thr(1))*(1/2), []);
% [S2, E2, M2] = findRipplesLisa(signal, ti.', thr , (thr)*(1/2), []);
% [S3, E3, M3] = findRipplesLisa(signal, ti.', thr , (thr)*(1/2), []);
% [S4, E4, M4] = findRipplesLisa(signal, ti.', thr , (thr)*(1/2), []);
% [S5, E5, M5] = findRipplesLisa(signal, ti.', thr , (thr)*(1/2), []);
for k=1:rep-1
%     error('stop here')

[S{k}, E{k}, M{k}] = findRipplesLisa(signal, ti.', thr(k+1) , (thr(k+1))*(1/2), []);

% [no_rip]=no_ripples(ti,S{k},E{k})
% [no_rip(:,k)]=no_ripples(ti,S{k},E{k})

%K=4 has shown to give too many ripples and not large enough no ripple
%windows. 

if k==1 || k==2 || k==3
[no{i,k},no2{i,k},noQ{i,k}]=no_ripples(ti,S{k},E{k},ro,signal_array,signal_array2,signal_arrayQ);
end


% [pks]=no_ripples(ti,S{k},E{k},ro);

% ch=sig1(1:2:7);
% cch=ch{1};

s17(i,k)=length(M{k});
swr17{i,1,k}=S{k};
swr17{i,2,k}=E{k};
swr17{i,3,k}=M{k};

% 
% [S2{k}, E2{k}, M2{k}] = findRipplesLisa(signal2, ti.', thr2(k+1) , (thr2(k+1))*(1/2), []);
% s217(i,k)=length(M2{k});
% swr217{i,1,k}=S2{k};
% swr217{i,2,k}=E2{k};
% swr217{i,3,k}=M2{k};


end

% s17(i)=length(M);
% swr17{i,1}=S;
% swr17{i,2}=E;
% swr17{i,3}=M;

% ti=(0:length(signal2)-1)*(1/fn); %IN SECONDS
% % [thr]=opt_thr(signal,thr);
% [S2, E2, M2] = findRipplesLisa(signal2, ti.', thr , (thr)*(1/3), []);
% s217(i)=length(M2);
% swr217{i,1}=S2;
% swr217{i,2}=E2;
% swr217{i,3}=M2;


% i/length(S9)
disp(strcat('Progress:',num2str(round(i*100/length(S9))),'%'))
pause(.1)
end

%%
%error('Stop here please')

% Windowing
for ind=1:size(s17,2)
veamos{:,ind}=find(s17(:,ind)~=0);  %Epochs with ripples detected
carajo{:,:,ind}=swr17(veamos{:,ind},:,ind);

% veamos2{:,ind}=find(s217(:,ind)~=0);  %Epochs with ripples detected
% carajo2{:,:,ind}=swr217(veamos2{:,ind},:,ind);
end

%Proceed to rearrange.m
%  Windowing using Monopolar

% veamos2=find(s217~=0);  %Epochs with ripples detected
% carajo2=swr217(veamos2,:);
%end

 su=sum(cellfun('length', no));

su1=cell(0);
su2=cell(0);
su3=cell(0);

su1_2=cell(0);
su2_2=cell(0);
su3_2=cell(0);

su1_Q=cell(0);
su2_Q=cell(0);
su3_Q=cell(0);


%error('stop here please')
for he=1:length(no)
%     if no{he,1}~= 0
su1=[su1;no{he,1}];
su2=[su2;no{he,2}];
su3=[su3;no{he,3}];

su1_2=[su1_2;no2{he,1}];
su2_2=[su2_2;no2{he,2}];
su3_2=[su3_2;no2{he,3}];

su1_Q=[su1_Q;noQ{he,1}];
su2_Q=[su2_Q;noQ{he,2}];
su3_Q=[su3_Q;noQ{he,3}];

%     end
end

if length(su1)>100
su1=su1(1:100);
end
if length(su2)>100
su2=su2(1:100);
end
if length(su3)>100
su3=su3(1:100);
end

%SU=[su1 su2 su3];
SU={su1 su2 su3};

if length(su1_2)>100
su1_2=su1_2(1:100);
end
if length(su2_2)>100
su2_2=su2_2(1:100);
end
if length(su3_2)>100
su3_2=su3_2(1:100);
end

%SU2=[su1_2 su2_2 su3_2];
SU2={su1_2 su2_2 su3_2};

if length(su1_Q)>100
su1_Q=su1_Q(1:100);
end
if length(su2_Q)>100
su2_Q=su2_Q(1:100);
end
if length(su3_Q)>100
su3_Q=su3_Q(1:100);
end

% SUQ=[su1_Q su2_Q su3_Q];
SUQ={su1_Q su2_Q su3_Q};
