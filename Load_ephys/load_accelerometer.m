%% Get accelerometer data file names and paths
[file,path] = uigetfile('*.continuous','Select Accelerometer data','MultiSelect','on');
selpath = uigetdir('','Select folder where data will be saved');
%% Get sleep labels. 
cd(path)
fileList = dir('*-states.mat') %Gets states data. 
st=fileList.name;
load(st) %Load states
%%
%% Extract only NREM signals. (1 for awake, 3 for NREM)
fs=20000; %Sampling frequency of acquisition.  
c=find(transitions(:,1)==3); 
newtrans=transitions(c,2:3); %Only use the NREM times. 
transamp=newtrans.*(fs); %Convert from seconds to samples 

%%
%acdata=cell(length(file),1);% Void cell
Vx=cell(length(transamp),length(file));
%Low pass filter design. 
Wn=[500/(fs/2) ]; % Cutoff=500 Hz
[b,a] = butter(3,Wn); %Filter coefficients for LPF

%Load and store 
counter=0;
f=waitbar(counter,'Please wait...');
%%
for j=1:length(file)
[ac, ~, ~]=load_open_ephys_data_faster(file{j}); %Load file
    for k=1:length(transamp)
        probemos=transamp(k,:);
        %Select NREM data
        V=ac(round(probemos(1)):round(probemos(2)));
        %Apply downsampling
        V=filtfilt(b,a,V);
        V=decimator(V,20).';
%         Vx{k,j}=V.^2;
        Vx{k,j}=V;
        counter=counter+1;
        progress_bar(counter,length(file)*length(transamp),f)
    end


%acdata{j,:}
end


%Combine accelerometer data
sos = cellfun( @(A, B, C) A.^2+B.^2+C.^2, Vx(:,1), Vx(:,2), Vx(:,3),'UniformOutput',0);
cd(selpath)
save('sos.mat','sos');

clear variables
%%
for j=1:length(sos)

plot(sos{j})
pause(1)
end