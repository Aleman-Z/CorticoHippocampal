close all
clear all
clc
%OS main
fs=20000; %Sampling frequency of acquisition.  
acer=1;
addingpath(acer);

%HPC, PFC, EEG FRONTAL, EEG PARIETAL.
channels.Rat1 = [ 46 11 6 5];
channels.Rat3 = [ 31 49 [] 54];
channels.Rat4 = [ 37 34 [] []];
channels.Rat6 = [ 2 33 34 36];
channels.Rat9 = [ 49 30 3 9];
channels.Rat11 = [ 11 45 55 56];

%%
for RAT=1:4 %4
rats=[1 3 4 6]; %First drive
Rat=rats(RAT); 


labelconditions=[
    { 
    
    'OD'}
    'OR'
    'CON'    
    'OR_N'
    ];

for iii=1:4 %Up to 4 conditions. 
    
[BB]=select_folder(Rat,iii,labelconditions);
cd(BB)       
[str1,str2]=select_trial('post',Rat);    
f=waitbar(0,'Please wait...');
for num=1:length(str1)
    progress_bar(num,length(str1),f)
    cd(str1{num,1});
    %xo
    [ax1, ~, ~] = load_open_ephys_data_faster('100_AUX1.continuous');
    [ax2, ~, ~] = load_open_ephys_data_faster('100_AUX2.continuous');
    [ax3, ~, ~] = load_open_ephys_data_faster('100_AUX3.continuous');
   
    % Verifying time
     l=length(ax1); %samples
    % t=l*(1/fs); %  2.7276e+03  seconds
    % Equivalent to 45.4596 minutes
    t=1:l;
    t=t*(1/fs);

    sos=ax1.^2+ax2.^2+ax3.^2;    
    clear ax1 ax2 ax3 

    Wn=[500/(fs/2) ]; % Cutoff=500 Hz
    [b,a] = butter(3,Wn); %Filter coefficients for LPF
    
    sos=filtfilt(b,a,sos);
    sos=decimator(sos,20);

vr=getfield(channels,strcat('Rat',num2str(Rat)));%Electrode channels. 

%strcat('100_CH',num2str(vr(1)),'.continuous')

%Hippocampus
[V17, ~, ~] = load_open_ephys_data_faster(strcat('100_CH',num2str(vr(1)),'.continuous'));    
V17=filtfilt(b,a,V17);
V17=decimator(V17,20);

%PFC
[V9, ~, ~] = load_open_ephys_data_faster(strcat('100_CH',num2str(vr(2)),'.continuous'));
V9=filtfilt(b,a,V9);
V9=decimator(V9,20);

cd(strcat('F:\Lisa_files\',num2str(Rat)))

if ~exist(labelconditions{iii}, 'dir')
   mkdir(labelconditions{iii})
end
cd(labelconditions{iii})

if ~exist(str2{num}, 'dir')
   mkdir(str2{num})
end

cd(str2{num})

 save('V9.mat','V9')
 save('V17.mat','V17')
 save('sos.mat','sos')
    
 
 cd(strcat('F:\ephys\rat',num2str(Rat),'\',BB))
%     %%
%    [vtr]=findsleep(sos,median(sos)/100,t); %Threshold. 0.006
%
%     plot(sos(100000/2:400000))
%     hold on
%     stripes((vtr(100000/2:400000)),0.5)
    %%
%     vin=find(vtr~=1);

% xo
% [a1,a2] = unique(vtr);
% 
% [G,ID] = findgroups(vtr);
% out = double(diff([~vtr(1);vtr(:)]) == 1);
% v = accumarray(cumsum(out).*vtr(:)+1,1);
% out(out == 1) = v(2:end);
    
    %Create transition matrix
%    xo
        
        
    
end

end

end