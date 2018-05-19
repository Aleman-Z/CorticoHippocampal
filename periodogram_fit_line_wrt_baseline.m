close all
clear all
acer=0;

%
if acer==0
addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
addpath('/home/raleman/Documents/GitHub/CorticoHippocampal')
addpath('/home/raleman/Documents/internship')
else
addpath('D:\internship\analysis-tools-master'); %Open Ephys data loader.
addpath('C:\Users\Welt Meister\Documents\Donders\CorticoHippocampal\CorticoHippocampal')
   
end
%%
%Rat=26;

for experiment=2:2
for Rat=3:3
rats=[26 27 21];
Rat=rats(Rat);    
if Rat==26
nFF=[
%    {'rat26_Base_II_2016-03-24'                         }
%    {'rat26_Base_II_2016-03-24_09-47-13'                }
%    {'rat26_Base_II_2016-03-24_12-55-58'                }
%    {'rat26_Base_II_2016-03-24_12-57-57'                }
    
   
    {'rat26_nl_base_III_2016-03-30_10-32-57'            }
    {'rat26_nl_base_II_2016-03-28_10-40-19'             }
    {'rat26_nl_baseline2016-03-01_11-01-55'             }
    {'rat26_plusmaze_base_2016-03-08_10-24-41'}
    
    
    
    {'rat26_novelty_I_2016-04-12_10-05-55'          }
    {'rat26_novelty_II_2016-04-13_10-23-29'             }
    {'rat26_for_2016-03-21_10-38-54'                    }
    {'rat26_for_II_2016-03-23_10-49-50'                 }
    
    ];

% labelconditions=[
%     {'Baseline_1' 
%      'Baseline_2'}
%      'Baseline_3'
%      'PlusMaze'
%      'Novelty_1'
%      'Novelty_2'
%      'Foraging_1'
%      'Foraging_2'
%     ];

labelconditions=[
    { 
    
    'Baseline_1'}
    'Baseline_2'
    'Baseline_3'
     'PlusMaze'    
     'Novelty_1'
     'Novelty_2'
     'Foraging_1'
     'Foraging_2'
    ];


end
if Rat==27
nFF=[
    {'rat27_nl_base_2016-03-28_15-01-17'                   }
    {'rat27_NL_baseline_2016-02-26_12-50-26'               }
    {'rat27_nl_base_III_2016-03-30_14-36-57'               }
    
    {'rat27_plusmaze_base_2016-03-14_14-52-48'             }
    {'rat27_plusmaze_base_II_2016-03-24_14-10-08'          }
    
    {'rat27_for_2016-03-21_15-03-05'                       }
    {'Rat27_for_II_2016-03-23_15-06-59'                    }
    
    %{'rat27_novelty_II_2016-04-13_14-37-58'                }  %NO .MAT files found. 
    %{'rat27_novelty_II_2016-04-13_16-29-42'                } %No (complete).MAT files found.
    {'rat27_novelty_I_2016-04-11_14-34-55'                 }
  
%     {'rat27_plusmaze_dis_2016-03-10_14-35-18'              }
%     {'rat27_plusmaze_dis_II_2016-03-16_14-36-07'           }
%     {'rat27_plusmaze_dis_II_2016-03-18_14-46-24'           }
%     {'rat27_plusmaze_jit_2016-03-08_14-46-31'              }
%     {'rat27_plusmaze_jit_II_2016-03-16_15-02-27'           }
%     {'rat27_plusmaze_swrd_qPCR_2016-04-15_14-28-41'        }
%     {'rat27_watermaze_dis_morning_2016-04-06_10-18-36'     }
%     {'rat27_watermaze_jitter_afternoon_2016-04-06_15-41-51'}  
    ]

labelconditions=[
    { 
    'Baseline_1'}
    'Baseline_2'
    'Baseline_3'
    'PlusMaze_1'
    'PlusMaze_2'
    
    'Foraging_1'
    
     'Foraging_2'
     'Novelty_1'
    
    
     
    ];

    
end

if Rat==21
 
 nFF=[  
    {'2015-11-27_13-50-07 5h baseline'             }
    {'rat21 baselin2015-12-11_12-52-58'            }
    {'rat21_learningbaseline2_2015-12-10_15-24-17' }
    {'rat21with45minlearning_2015-12-02_14-25-12'  }
    %{'rat21t_maze_2015-12-14_13-29-07'             }
    {'rat21 post t-maze 2015-12-14_13-30-52'       }
    
];

%%
labelconditions=[
    {    
     'Learning Baseline'
                }
     
     '45minLearning'
     'Novelty_2'
     't-maze'
     'Post t-maze'
    ];
    
end
 


%% Go to main directory
if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
    addpath /home/raleman/Documents/internship/fieldtrip-master/
cd /home/raleman/Documents/internship/fieldtrip-master

    InitFieldtrip()

    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
    clc
else
    cd(strcat('D:\internship\',num2str(Rat)))
    addpath D:\internship\fieldtrip-master
    cd D:\internship\fieldtrip-master
    InitFieldtrip()

    % cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
    cd(strcat('D:\internship\',num2str(Rat)))
    clc
end
%% Select experiment to perform. 
inter=1;
granger=0;
%Select length of window in seconds:
ro=[1200];
coher=0;
selectripples=1;
mergebaseline=1;
nrem=3;
notch=0;
%%

%Make labels
label1=cell(7,1);
label1{1}='Hippocampus';
label1{2}='Hippocampus';
label1{3}='Parietal';
label1{4}='Parietal';
label1{5}='PFC';
label1{6}='PFC';
label1{7}='Reference';

label2=cell(7,1);
label2{1}='Monopolar';
label2{2}='Bipolar';
label2{3}='Monopolar';
label2{4}='Bipolar';
label2{5}='Monopolar';
label2{6}='Bipolar';
label2{7}='Monopolar';

%%

 
    
 %clearvars -except nFF iii labelconditions inter granger Rat ro label1 label2 coher selectripples acer mergebaseline nr_27 nr_26 co_26 co_27 nrem notch


%  for level=1:1
     
for w=1:1

if Rat==21
myColorMap = jet(5);
else
myColorMap = jet(8);    
end
% colormap(myColorMap);
NCount=nan(length(nFF),1);



if Rat==26 || Rat==27
    stt=4;
    ST=stt-1;
else
    stt=3;
    ST=stt-1;
end
% 
% stt=1;
for condition=1:ST

for iii=stt:length(nFF)
%for level=2:2
myColorMap = jet(24);    

% Current condition
if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

 cd(nFF{iii})
    %Get averaged time signal.
S=load('powercoh.mat');
S=struct2cell(S);

% 
%Baseline 1
if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

%cd(nFF{iii})
 cd(nFF{condition})
    %Get averaged time signal.
S1=load('powercoh.mat');
S1=struct2cell(S1);

if experiment==1
[SS,D]=scatter_analysis(S,S1,3,3);
end

if experiment==2
[SS,D]=scatter_analysis(S,S1,6,3);% 6 and 3
end

figure(condition+1)
semilogy(SS,smooth(D),'Color',myColorMap(3*iii,:),'LineWidth',2)
hold on
% semilogy(SS,(D)*0+val)
grid minor
xlim([0 250])

% error('stop')
%      F: [1001×1 double]
%      NC: [2000×2069 double]
%     PPx: [1001×1 double]
%       f: [1001×1 double]
%      nc: [2000×2069 double]
%      px: [1001×1 double]

% 
% %ylim([min(mean(va,2)) 1])
% ylim([0.5 1])
% xlim([0 250])
% % xlabel('Frequency (Hz)')
% % ylabel('Coherence')
% xlabel('Frequency (Hz)','Color','w')
% ylabel('Coherence','Color','w')
% % title('With Ripples vs No Ripples (THR 2)')
% set(gca,'xcolor','w') 
% set(gca,'ycolor','w') 
%  xticks([0 50 100 150 200])
% 
end
legend(labelconditions{stt:end})
set(gca,'Color','k')
grid on
ax = gca;
ax.GridColor = [1, 1, 1];
title('Divergence between Conditions and Baseline')

% error('stop')

if acer==0
    cd(strcat('/home/raleman/Dropbox/Power/Divergence/',num2str(Rat)))
else
      cd(strcat('C:\Users\Welt Meister\Dropbox\Power/Divergence\',num2str(Rat)))   
end

% error('stop')

figure(1)
close

fig=gcf;
fig.InvertHardcopy='off';

% string=strcat('300hz_intra_',label1{2*w-1},'.png');
string=strcat('Divergence_',labelconditions{condition},'.png');
saveas(gcf,string)

string=strcat('Divergence_',labelconditions{condition},'.fig');
saveas(gcf,string)

close all


end

% 
% if acer==0
%     cd(strcat('/home/raleman/Dropbox/Power_Coh/',num2str(Rat)))
% else
%       cd(strcat('C:\Users\Welt Meister\Dropbox\Power_Coh\',num2str(Rat)))   
% end
% 
% fig=figure(condition+1);
% %fig=gcf;
% fig.InvertHardcopy='off';
% 
% % string=strcat('300hz_intra_',label1{2*w-1},'.png');
% string=strcat('NoRipples_',labelconditions{iii},'.png');
% saveas(gcf,string)
% 
% string=strcat('NoRipples_',labelconditions{iii},'.fig');
% saveas(gcf,string)
% 
% close all

%end
% error('stop')

%string=strcat('Power_50B_1850_NOTCH_NREM_',label1{2*w-1},'.png');


% end

end
end
end