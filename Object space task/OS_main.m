close all
clear all
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

for num=1:length(str1)
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
    [vtr]=findsleep(sos,0.006,t); %post_trial3
%     vin=find(vtr~=1);

[a1,a2] = unique(vtr);

[G,ID] = findgroups(vtr);
% out = double(diff([~vtr(1);vtr(:)]) == 1);
% v = accumarray(cumsum(out).*vtr(:)+1,1);
% out(out == 1) = v(2:end);
    
    clear ax1 ax2 ax3 
    %Create transition matrix
    xo
        
vr=getfield(channels,strcat('Rat',num2str(Rat)));%Electrode channels. 

%strcat('100_CH',num2str(vr(1)),'.continuous')

%Hippocampus
    [data17m, ~, ~] = load_open_ephys_data_faster(strcat('100_CH',num2str(vr(1)),'.continuous'));    
% %PFC
%     [data9m, ~, ~] = load_open_ephys_data_faster(strcat('100_CH',num2str(vr(2)),'.continuous'));
        
    
end

end



end