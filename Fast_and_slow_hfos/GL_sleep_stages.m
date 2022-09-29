%% GL_hfos_counts

% Main code for detection of fast and slow, coocur and single hfos.
% Generates hfos counts from Figure 1 and 2 respectively.
% Requires 'load_me_first.mat' loaded first. /home/adrian/Documents/GitHub/CorticoHippocampal/Fast_and_slow_hfos
clear variables
cd('/home/adrian/Documents/GitHub/CorticoHippocampal/Fast_and_slow_hfos')
load('load_me_first.mat')
%% Find location of downsampled data

close all
% dname=uigetdir([],'Select folder with Matlab data containing all rats.');
%dname='/home/adrian/Dropbox/jukebox/Documents/Plusmaze_downsampled';
%dname='/media/adrian/6aa1794c-0320-4096-a7df-00ab0ba946dc/Plusmaze_downsampled/Data_plusmaze';
dname='/home/adrian/Dropbox/jukebox/Documents/Plusmaze_downsampled'
cd(dname)

%cd('/home/adrian/Documents/Plusmaze_downsampled')
%/home/adrian/Dropbox/jukebox/Documents/Plusmaze_downsampled

%%
%Select rat ID
opts.Resize = 'on';
opts.WindowStyle = 'modal';
opts.Interpreter = 'tex';
prompt=strcat('\bf Select a rat#. Options:','{ }',num2str(rats));
answer = inputdlg(prompt,'Input',[2 30],{''},opts);
Rat=str2num(answer{1});
cd(num2str(Rat))
tr=getfield(T,strcat('Rat',num2str(Rat)));%Thresholds 
%%
xx={'PAR'}; %Posterior Parietal cortex used to detect hfos. 
fn=1000; %Sampling frequency

%% Get folder names
labelconditions=getfolder;
labelconditions=labelconditions.';
g=labelconditions;
%% Parameters 
multiplets=[{'singlets'} {'doublets'} {'triplets'} {'quatruplets'} {'pentuplets'} {'sextuplets'} {'septuplets'} {'octuplets'} {'nonuplets'}];
iii=1;
%%
f=waitbar(0,'Please wait...');
    for k=1:length(g)
        cd(g{k})
%xo
%Load sleep scoring
A = dir('*states*.mat');
A={A.name};

if  ~isempty(A)
       cellfun(@load,A);
else
      error('No Scoring found')    
end


%% Plot cortical ripples histogram across 4 hours.

vec_trans=(states==4);
vec_rem=(states==5);
vec_nrem=(states==3);
vec_wake=not(vec_trans) & not(vec_rem) & not(vec_nrem);
% labels=(0:1:length(states)-1);

%Amount in minutes
vec_wake=sum(vec_wake)/60;
vec_nrem=sum(vec_nrem)/60;
vec_trans=sum(vec_trans)/60;
vec_rem=sum(vec_rem)/60;


sleep(:,k)=[vec_wake;vec_nrem;vec_trans;vec_rem]



%%

    cd ..    
    end
xo        
%% Generate tables and save values into spreadsheets.

%%
%Sleep
    TT=table;
    %TT.Variables=    [[{'Count'};{'Rate'};{'Duration'};{'Average Frequency'};{'Instantaneous Frequency'};{'Amplitude'}] num2cell([count_cohfo_cortex;rate_cohfo_cortex;dura_cohfo_cortex;fa_cohfo_cortex;fi_cohfo_cortex; amp_cohfo_cortex])];
    TT.Variables=sleep;
    TT.Properties.VariableNames=g;
    
    writetable(TT,'Sleep_stages_R24.xls')
 
