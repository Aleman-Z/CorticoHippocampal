acer=0;
rat24base=2;

%%
if acer==0
addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
addpath('/home/raleman/Documents/GitHub/CorticoHippocampal')
addpath('/home/raleman/Documents/internship')
else
addpath('D:\internship\analysis-tools-master'); %Open Ephys data loader.
addpath('C:\Users\addri\Documents\internship\CorticoHippocampal')
   
end
%%
%Rat=26;
for RAT=2:2
for base=2:2    
rats=[26 27 21 24];
Rat=rats(RAT);    
    
% for Rat=26:26
if Rat==26
nFF=[
%    {'rat26_Base_II_2016-03-24'                         }
%    {'rat26_Base_II_2016-03-24_09-47-13'                }
%    {'rat26_Base_II_2016-03-24_12-55-58'                }
%    {'rat26_Base_II_2016-03-24_12-57-57'                }
    
   
   {'rat26_nl_base_III_2016-03-30_10-32-57'            }  %Baseline 1 (so-called)
 %    {'rat26_nl_base_II_2016-03-28_10-40-19'             }
 %    {'rat26_nl_baseline2016-03-01_11-01-55'             }
    {'rat26_plusmaze_base_2016-03-08_10-24-41'}
    
    
    
    {'rat26_novelty_I_2016-04-12_10-05-55'          }
%     {'rat26_novelty_II_2016-04-13_10-23-29'             }
    {'rat26_for_2016-03-21_10-38-54'                    }
%     {'rat26_for_II_2016-03-23_10-49-50'                 }
    
    ];

if strcmp(nFF{1},'rat26_nl_baseline2016-03-01_11-01-55')
NFF=[ {'rat26_nl_base_II_2016-03-28_10-40-19'             }];    
end
if strcmp(nFF{1},'rat26_nl_base_II_2016-03-28_10-40-19')
NFF=[ {'rat26_nl_baseline2016-03-01_11-01-55'             }];
end
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
    
    'Baseline'}
%     'Baseline_2'
%     'Baseline_3'
     'PlusMaze'    
     'Novelty'
%      'Novelty_2'
     'Foraging'
%      'Foraging_2'
    ];


end
if Rat==27
nFF=[
    {'rat27_nl_base_2016-03-28_15-01-17'                   } %Baseline 2: Use this one. 
   % {'rat27_NL_baseline_2016-02-26_12-50-26'               }
   % {'rat27_nl_base_III_2016-03-30_14-36-57'               }
    
   {'rat27_plusmaze_base_2016-03-14_14-52-48'             }
   %{'rat27_plusmaze_base_II_2016-03-24_14-10-08'          }
    {'rat27_novelty_I_2016-04-11_14-34-55'                 } 
    {'rat27_for_2016-03-21_15-03-05'                       }
    %{'Rat27_for_II_2016-03-23_15-06-59'                    }
    
    %{'rat27_novelty_II_2016-04-13_14-37-58'                }  %NO .MAT files found. 
    %{'rat27_novelty_II_2016-04-13_16-29-42'                } %No (complete).MAT files found.
   
  
%     {'rat27_plusmaze_dis_2016-03-10_14-35-18'              }
%     {'rat27_plusmaze_dis_II_2016-03-16_14-36-07'           }
%     {'rat27_plusmaze_dis_II_2016-03-18_14-46-24'           }
%     {'rat27_plusmaze_jit_2016-03-08_14-46-31'              }
%     {'rat27_plusmaze_jit_II_2016-03-16_15-02-27'           }
%     {'rat27_plusmaze_swrd_qPCR_2016-04-15_14-28-41'        }
%     {'rat27_watermaze_dis_morning_2016-04-06_10-18-36'     }
%     {'rat27_watermaze_jitter_afternoon_2016-04-06_15-41-51'}  
    ]
%NFF=[{'rat27_NL_baseline_2016-02-26_12-50-26'               }];
if strcmp(nFF{1},'rat27_NL_baseline_2016-02-26_12-50-26')
NFF=[ {  'rat27_nl_base_2016-03-28_15-01-17'           }];    
end
if strcmp(nFF{1}, 'rat27_nl_base_2016-03-28_15-01-17')
NFF=[ {'rat27_NL_baseline_2016-02-26_12-50-26'   }];
end

labelconditions=[
    { 
    'Baseline'}
%     'Baseline_2'
%     'Baseline_3'
    'PlusMaze'
%     'PlusMaze_2'
    'Novelty'
    'Foraging'
    
  %   'Foraging_2'
     
    
    
     
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

if Rat==24
nFF=[  
    {'Baseline1'}
%     {'Baseline2'}
%     {'Baseline3'}
%     {'Baseline4'}
    {'Plusmaze1'}
%     {'Plusmaze2'}
   {'Novelty1'}
   {'Foraging1'}
     
]; 
if  rat24base==2
  nFF{1,:}='Baseline2'; 
end

%labelconditions=nFF;
labelconditions=[
    { 
    'Baseline'}
%     'Baseline_2'
%     'Baseline_3'
    'PlusMaze'
%     'PlusMaze_2'
    'Novelty'
    'Foraging'
    
  %   'Foraging_2'
     
    
    
     
    ];



end

if base==2
    nFF{1}=NFF{1};
end
%% Go to main directory
if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
    addpath /home/raleman/Documents/internship/fieldtrip-master/
    InitFieldtrip()

    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
    clc
else
    cd(strcat('D:\internship\',num2str(Rat)))
    addpath D:\internship\fieldtrip-master
    InitFieldtrip()

    % cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
    cd(strcat('D:\internship\',num2str(Rat)))
    clc
end

%% Select experiment to perform. 
inter=1;
%Select length of window in seconds:
ro=[1200];
coher=0;
selectripples=1;
mergebaseline=0;
notch=0; %Might need to be 1.
nrem=3;
myColorMap = jet(8);
Score=1;
%%

%Make labels
label1=cell(7,1);
label1{1}='Hippo';
label1{2}='Hippo';
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
myColorMap = jet(8);                                                                                                                                                                                    
myColorMap =myColorMap([2 4 5 7],:);
myColorMap(2,:)=[0, 204/255, 0];
myColorMap(3,:)=[0.9290, 0.6940, 0.1250];

%Rat 24
% if Rat==24
%     myColorMap = jet(length(nFF));                                                                                                                                                                                    
% end


for iii=1:length(nFF)

    
%  clearvars -except nFF iii labelconditions inter granger Rat ro label1 label2 coher selectripples acer mergebaseline nr_27 nr_26 co_26 co_27 nrem notch myColorMap



%for level=1:length(ripple)-1;    
 %for level=1:1
     
for w=1:1

if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

cd(nFF{iii})
lepoch=2;


level=1;
%Get averaged time signal.
% [sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);
if strcmp(labelconditions{iii},'Baseline') || strcmp(labelconditions{iii},'PlusMaze')
[ripple,timeasleep,DEMAIS,y1]=NREM_newest_only_ripple_level_vx(level,nrem,notch,w,lepoch,Score);
else
[ripple,timeasleep,DEMAIS,y1]=NREM_newest_only_ripple_level_vx(level,nrem,notch,w,lepoch,1);    
end
%  save('thresholdfile.mat','ripple','timeasleep','DEMAIS','y1');                                                                                                                                                                                                                                                                                                                                               
%% IGNORE SMALL THRESHOLD VALUES

if Rat==26 && iii==2 

DEMAIS=DEMAIS(3:end);
ripple=ripple(3:end);
y1=y1(3:end);

[p,S,mu]=polyfit(DEMAIS,ripple,5);
y1=polyval(p,DEMAIS,[],mu);
% plot(y1)

else
    if Rat==27 && iii==2
        DEMAIS=DEMAIS(2:end);
        ripple=ripple(2:end);
        y1=y1(2:end);
    else
        DEMAIS=DEMAIS(1:end);
        ripple=ripple(1:end);
        y1=y1(1:end);
    end

end

if Rat== 24 && iii==6
[p,S,mu]=polyfit(DEMAIS,ripple,7);
y1=polyval(p,DEMAIS,[],mu);    
end
%%
%xo
%%
plot(DEMAIS,ripple/(timeasleep*60),'*','Color',myColorMap(iii,:))
xlabel('Threshold value (uV)')
ylabel('Ripples per second')
%grid minor

hold on
plot(DEMAIS,y1/(timeasleep*60),'LineWidth',2,'Color',myColorMap(iii,:))
title('Rate of ripples per Threshold value')

%%

end

%end


end


set(gca, 'XDir','reverse')
%h=legend('Baseline 1','Baseline 1 (fit)','Baseline 2','Baseline 2 (fit)','Baseline 3','Baseline 3 (fit)',labelconditions{1},strcat(labelconditions{1},'{ }','(fit)'),labelconditions{2},strcat(labelconditions{2},'{ }','(fit)'),labelconditions{3},strcat(labelconditions{3},'{ }','(fit)'),labelconditions{4},strcat(labelconditions{4},'{ }','(fit)'),labelconditions{5},strcat(labelconditions{5},'{ }','(fit)'))

if Rat==24
%h=legend('Baseline 1','Baseline 1 (fit)','Baseline 2','Baseline 2 (fit)','Baseline 3','Baseline 3 (fit)','Baseline 4','Baseline 4 (fit)','Plusmaze 1','Plusmaze 1 (fit)','Plusmaze 2','Plusmaze 2 (fit)')        
h=legend('Baseline','Baseline (fit)','Plusmaze','Plusmaze (fit)','Novelty','Novelty (fit)','Foraging','Foraging (fit)')    

else
h=legend('Baseline','Baseline (fit)','Plusmaze','Plusmaze (fit)','Novelty','Novelty (fit)','Foraging','Foraging (fit)')    
end


set(h,'Location','Northwest')

% h=legend('Baseline 2','Baseline 2 (fit)','Baseline 3','Baseline 3 (fit)','Baseline 4','Baseline 4 (fit)')
% set(h,'Location','Northwest')
ylim([-0.5 3])
xo
if acer==0
    cd(strcat('/home/raleman/Dropbox/Figures/Figure2/',num2str(Rat)))
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd(strcat('C:\Users\addri\Dropbox\Figures\Figure2\',num2str(Rat)))   
end


if Score==2
    cd('new_scoring')
end

if Rat==26
Base=[{'Baseline1'} {'Baseline2'}];
end
if Rat==27 
Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
end
                                                                                                                                                                                                                                            
% if Rat~=24
% string=strcat('Ripples_per_condition_best','.pdf');
% figure_function(gcf,[],string,[]);
% string=strcat('Ripples_per_condition_best','.eps');
% print(string,'-depsc')
% else
string=strcat('Ripples_per_condition_',Base{base},'.pdf');
figure_function(gcf,[],string,[]);
string=strcat('Ripples_per_condition_',Base{base},'.eps');
print(string,'-depsc')    
string=strcat('Ripples_per_condition_',Base{base},'.fig');
saveas(gcf,string)

%end

% string=strcat('Ripples_per_condition_best','.fig');
% saveas(gcf,string)

close all

%%
% clearvars -except acer Rat
end
end
%end
