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
Files=dir(fullfile('MyFolder','*.mat')) will give you a list of .mat files.
 %% Get data 
% g=cell(length(getdir),1)
% g{:,1}=getdir.name;
addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
addpath('/home/raleman/Documents/GitHub/CorticoHippocampal')
%cd('/home/raleman/Documents/internship')
cd('/media/raleman/My Book/SWRDisruptionPlusMaze/rat_26')
%%
cd(nFF{1})
clear all
%Find .mat files
Files=dir(fullfile(cd,'*.mat'));

for ii=1:length(Files)
load(Files(ii).name)
end


%%
%Reference
[data6m, ~, ~] = load_open_ephys_data_faster('100_CH6.continuous');
[C6,tiempo]=reduce_data(data6m,transitions)
%%
%PFC
[data9m, ~, ~] = load_open_ephys_data_faster('100_CH9.continuous');

[data92m, ~, ~] = load_open_ephys_data_faster('100_CH9_merged.continuous');

%Parietal lobe
[data12m, ~, ~] = load_open_ephys_data_faster('100_CH12.continuous');
%Hippocampus
[data17m, ~, ~] = load_open_ephys_data_faster('100_CH17.continuous');


