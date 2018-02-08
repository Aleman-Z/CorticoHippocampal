addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
addpath('/home/raleman/Documents/GitHub/CorticoHippocampal')
addpath('/home/raleman/Documents/internship')


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

labelconditions=[
    {'PlusMaze'}
     'Novelty_1'
     'Novelty 2'
     'Foraging 1'
     'Foraging 2'
    ];
%%
cd('/home/raleman/Documents/internship/26')
addpath /home/raleman/Documents/internship/fieldtrip-master/
InitFieldtrip()

cd('/home/raleman/Documents/internship/26')
%%

Rfreq=nan(length(nFF),4);
MeanTHR=nan(length(nFF),5);
SumS17=nan(length(nFF),4);
TimeA=nan(length(nFF),1);

for iii=1:length(nFF)
%for iii=1:1
    
%  clearvars -except nFF iii labelconditions inter granger Rfreq MeanTHR Sum
%for iii=1:4

cd('/home/raleman/Documents/internship/26')
cd(nFF{iii})

art=0;

Ro=[1200];
ro=Ro;

%run('newest_load_data_only_ripple.m')
run('newest_load_data_only_ripple_chtm.m')

% Rearrange (clean)


% % % Rfreq(iii,:)=RipFreq;
% % Rfreq(iii,:)=RipFreq2;
% % 
% % %MeanTHR(iii,:)=mean(THR);    
% % MeanTHR(iii,:)=CHTM;    
% % %SumS17(iii,:)=sum(s17);
% % SumS17(iii,:)=sum(s172);


TimeA(iii,:)=timeasleep;
Rfreq2(iii,:)=RipFreq2;
MeanTHR2(iii,:)=CHTM;    
SumS172(iii,:)=sum(s172);

end

