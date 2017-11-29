cd('/media/raleman/My Book/SWRDisruptionPlusMaze/rat_26')

% getdir=dir;
% A_cell = struct2cell(getdir);
% A_cell=A_cell(1,:);
% A_cell=A_cell.';

%%
d = dir(cd);
isub = [d(:).isdir]; %# returns logical vector
nF = {d(isub).name}';
nF(ismember(nF,{'.','..'})) = [];

%%
cd('/home/raleman/Documents/internship/26')
%%
for i=1:length(nF)
    mkdir([nF{i}])
end
%%
% d = dir(cd);
% isub = [d(:).isdir]; %# returns logical vector
% isub=not(isub);
% nameFolds = {d(isub).name}';
% % nameFolds(ismember(nameFolds,{'.','..'})) = [];

%%
nFF=[
   % {'rat26_Base_II_2016-03-24'                         }
   % {'rat26_Base_II_2016-03-24_09-47-13'                }
   % {'rat26_Base_II_2016-03-24_12-55-58'                }
   % {'rat26_Base_II_2016-03-24_12-57-57'                }
    
    {'rat26_nl_base_III_2016-03-30_10-32-57'            }
    {'rat26_nl_base_II_2016-03-28_10-40-19'             }
    {'rat26_nl_baseline2016-03-01_11-01-55'             }]
 %%
 Files=dir(fullfile(cd,'*.mat')) 
 %% Get data 
% g=cell(length(getdir),1)
% g{:,1}=getdir.name;
addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
addpath('/home/raleman/Documents/GitHub/CorticoHippocampal')
%cd('/home/raleman/Documents/internship')
cd('/media/raleman/My Book/SWRDisruptionPlusMaze/rat_26')
%%
cd('/media/raleman/My Book/SWRDisruptionPlusMaze/rat_26')

%for iii=3:length(nFF)
    cd(nFF{iii})
    %clear all
    %Find .mat files
    Files=dir(fullfile(cd,'*.mat'));

    for ii=1:length(Files)
    load(Files(ii).name)
    end
     'Channel 6'  
%   
    [V6,~]=save_samples('100_CH6.continuous',transitions);
    
    cd('/home/raleman/Documents/internship/26')
    cd(nFF{iii})
    save('V6.mat','V6')
    clear V6
    
    %
    cd('/media/raleman/My Book/SWRDisruptionPlusMaze/rat_26')
    cd(nFF{iii})

    'Channel 9'
    
    [V9,~]=save_samples('100_CH9.continuous',transitions);

    cd('/home/raleman/Documents/internship/26')
    cd(nFF{iii})
    save('V9.mat','V9')
    clear V9
%
    cd('/media/raleman/My Book/SWRDisruptionPlusMaze/rat_26')
    cd(nFF{iii})

    'Channel 12'
    
    [V12,tiempo]=save_samples('100_CH12.continuous',transitions);
    
    cd('/home/raleman/Documents/internship/26')
    cd(nFF{iii})
    save('V12.mat','V12')
    clear V12
    
cd('/media/raleman/My Book/SWRDisruptionPlusMaze/rat_26')
cd(nFF{iii})

'Channel 17'

[V17,~]=save_samples('100_CH17.continuous',transitions);

cd('/home/raleman/Documents/internship/26')
cd(nFF{iii})
save('V17.mat','V17')
clear V17

%cd('/media/raleman/My Book/SWRDisruptionPlusMaze/rat_26')



clear all
a=dir(fullfile(cd,'*.mat'))

for ii=1:length(a)
load(a(ii).name)
end

'Bipolar recordings'
for j=1:length(V9)
S9{j,1}=V9{j,1}-V6{j,1};
S12{j,1}=V12{j,1}-V6{j,1};
S17{j,1}=V17{j,1}-V6{j,1};
end

save('S9.mat','S9')
save('S12.mat','S12')
save('S17.mat','S17')


%end
% END OF CODE

%% Reading data
cd('/home/raleman/Documents/internship/26')
i=1;
cd(nFF{i})


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
%%
%% Band pass design 
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=500 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients for LPF
% Bandpass filter 
fn=1000;

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

%%
s17=nan(length(S9),1);
swr17=cell(length(S9),3);
%thr=140;
thr=200;
%thr=180;


for i=1:length(S9)
    
signal=Bip17{i}*(1/0.195);
signal2=Mono17{i}*(1/0.195);

ti=(0:length(signal)-1)*(1/fn); %IN SECONDS
[S, E, M] = findRipplesLisa(signal, ti.', thr , (thr)*(1/3), []);
s17(i)=length(M);
swr17{i,1}=S;
swr17{i,2}=E;
swr17{i,3}=M;

ti=(0:length(signal2)-1)*(1/fn); %IN SECONDS
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


%%
cd('/media/raleman/My Book/SWRDisruptionPlusMaze/rat_26')
cd(nFF{1})

[V17,tiempo]=save_samples('100_CH17_merged.continuous',transitions);

cd('/home/raleman/Documents/internship/26')
cd(nFF{1})
save('V17.mat','V17')
clear V17
%%
clear all
a=dir(fullfile(cd,'*.mat'))

for ii=1:length(a)
load(a(ii).name)
end

for j=1:length(V9)
S9{j,1}=V9{j,1}-V6{j,1};
S12{j,1}=V12{j,1}-V6{j,1};
S17{j,1}=V17{j,1}-V6{j,1};
end

save('S9.mat','S9')
save('S12.mat','S12')
save('S17.mat','S17')


%%
%Reference
[data6m, ~, ~] = load_open_ephys_data_faster('100_CH6_merged.continuous');
%%
[C6,tiempo]=reduce_data(data6m,transitions);
clear data6m
[V6]=downsampling(C6);
clear C6


