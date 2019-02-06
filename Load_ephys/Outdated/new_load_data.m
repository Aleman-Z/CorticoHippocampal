%Load data, easy and quick. Make art=1 to include Artifact detection. 

%
S17=load('S17.mat');
S17=S17.S17;

S12=load('S12.mat');
S12=S12.S12;

S9=load('S9.mat');
S9=S9.S9;

V17=load('V17.mat');
V17=V17.V17;

V12=load('V12.mat');
V12=V12.V12;

V9=load('V9.mat');
V9=V9.V9;

V6=load('V6.mat');
V6=V6.V6;
'Loaded channels'

if art==1

    % Removing artifacts. 
    S9n=cell(length(V6),1);
    S12n=cell(length(V6),1);
    S17n=cell(length(V6),1);

    B9n=cell(length(V6),1);
    B12n=cell(length(V6),1);
    B17n=cell(length(V6),1);

    V6n=cell(length(V6),1);
    V9n=cell(length(V6),1);
    V12n=cell(length(V6),1);
    V17n=cell(length(V6),1);

    R6n=cell(length(V6),1);
    R9n=cell(length(V6),1);
    R12n=cell(length(V6),1);
    R17n=cell(length(V6),1);

        for i=1:length(V6)
        %Original Bipolar
        pro=S9{i};
        S9n{i,1}=outlier(pro,2.5);
        pro=S12{i};
        S12n{i,1}=outlier(pro,2.5);
        pro=S17{i};
        S17n{i,1}=outlier(pro,1.5);

        %Bipolar after ICA
        pro=B9{i};
        B9n{i,1}=outlier(pro,2.5);
        pro=B12{i};
        B12n{i,1}=outlier(pro,2.5);
        pro=B17{i};
        B17n{i,1}=outlier(pro,2.5);

        %Original Monopolar
        pro=V6{i};
        V6n{i,1}=outlier(pro,2.5);
        pro=V9{i};
        V9n{i,1}=outlier(pro,2.5);
        pro=V12{i};
        V12n{i,1}=outlier(pro,2.5);
        pro=V17{i};
        V17n{i,1}=outlier(pro,1.5);

        %Monopolar after ICA
        pro=R6{i};
        R6n{i,1}=outlier(pro,2.5);
        pro=R9{i};
        R9n{i,1}=outlier(pro,2.5);
        pro=R12{i};
        R12n{i,1}=outlier(pro,2.5);
        pro=R17{i};
        R17n{i,1}=outlier(pro,2.5);

        end

    S9=S9n;
    S12=S12n;
    S17=S17n;

    B9=B9n;
    B12=B12n;
    B17=B17n;

    V6=V6n;
    V9=V9n;
    V12=V12n;
    V17=V17n;

    R6=R6n;
    R9=R9n;
    R12=R12n;
    R17=R17n;
    
    'Artifact detection performed'
end

fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=500 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients for LPF

% Bandpass filter 

Mono6=cell(length(S9),1);
Mono9=cell(length(S9),1);
Mono12=cell(length(S9),1);
Mono17=cell(length(S9),1);

Bip9=cell(length(S9),1);
Bip12=cell(length(S9),1);
Bip17=cell(length(S9),1);


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

%thr=140;
thr=200;
%thr=180;
%%

for i=1:length(S9)
    
signal=Bip17{i}*(1/0.195);
signal2=Mono17{i}*(1/0.195);

ti=(0:length(signal)-1)*(1/fn); %IN SECONDS
%[thr]=opt_thr(signal,thr);
% thr=max(signal)/2
[S, E, M] = findRipplesLisa(signal, ti.', thr , (thr)*(1/3), []);
s17(i)=length(M);
swr17{i,1}=S;
swr17{i,2}=E;
swr17{i,3}=M;

ti=(0:length(signal2)-1)*(1/fn); %IN SECONDS
% [thr]=opt_thr(signal,thr);
[S2, E2, M2] = findRipplesLisa(signal2, ti.', thr , (thr)*(1/3), []);
s217(i)=length(M2);
swr217{i,1}=S2;
swr217{i,2}=E2;
swr217{i,3}=M2;


i/length(S9)
end

% Windowing
veamos=find(s17~=0);  %Epochs with ripples detected
carajo=swr17(veamos,:);

%Proceed to rearrange.m
%  Windowing using Monopolar

veamos2=find(s217~=0);  %Epochs with ripples detected
carajo2=swr217(veamos2,:);
%end