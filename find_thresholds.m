%% RAT 27!

addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
addpath('/home/raleman/Documents/GitHub/CorticoHippocampal')
addpath('/home/raleman/Documents/internship')

nFF=[
    {'rat27_nl_base_2016-03-28_15-01-17'                   }
    {'rat27_NL_baseline_2016-02-26_12-50-26'               }
    {'rat27_nl_base_III_2016-03-30_14-36-57'               }
    
    {'rat27_for_2016-03-21_15-03-05'                       }
    {'Rat27_for_II_2016-03-23_15-06-59'                    }
    
    %{'rat27_novelty_II_2016-04-13_14-37-58'                }  %NO .MAT files found. 
    %{'rat27_novelty_II_2016-04-13_16-29-42'                } %No (complete).MAT files found.
    {'rat27_novelty_I_2016-04-11_14-34-55'                 }
    {'rat27_plusmaze_base_2016-03-14_14-52-48'             }
    {'rat27_plusmaze_base_II_2016-03-24_14-10-08'          }
%     {'rat27_plusmaze_dis_2016-03-10_14-35-18'              }
%     {'rat27_plusmaze_dis_II_2016-03-16_14-36-07'           }
%     {'rat27_plusmaze_dis_II_2016-03-18_14-46-24'           }
%     {'rat27_plusmaze_jit_2016-03-08_14-46-31'              }
%     {'rat27_plusmaze_jit_II_2016-03-16_15-02-27'           }
%     {'rat27_plusmaze_swrd_qPCR_2016-04-15_14-28-41'        }
%     {'rat27_watermaze_dis_morning_2016-04-06_10-18-36'     }
%     {'rat27_watermaze_jitter_afternoon_2016-04-06_15-41-51'}  
    ]
%%
labelconditions=[
    {'Foraging 1' }
    
     'Foraging 2'
     'Novelty_1'
     'PlusMaze 1'
    'PlusMaze 2']

%%

cd('/home/raleman/Documents/internship/27')
addpath /home/raleman/Documents/internship/fieldtrip-master/

InitFieldtrip()

cd('/home/raleman/Documents/internship/27')
%%

% Rfreq_2 =nan(length(nFF),4);
% MeanTHR_2=nan(length(nFF),5);
% SumS17_2=nan(length(nFF),4);
% TimeA_2=nan(length(nFF),1);


for iii=2:3

% for iii=7:length(nFF)

%for iii=1:length(nFF)
%for iii=1:1
    
%  clearvars -except nFF iii labelconditions inter granger Rfreq MeanTHR Sum
%for iii=1:4

cd('/home/raleman/Documents/internship/27')
cd(nFF{iii})

art=0;

Ro=[1200];
ro=Ro;

run('testing_optimal.m')
% Rearrange (clean)

% 
% Rfreq_2(iii,:)=RipFreq;
% MeanTHR_2(iii,:)=mean(THR);    
% SumS17_2(iii,:)=sum(s17);
% TimeA_2(iii,:)=timeasleep;


end



