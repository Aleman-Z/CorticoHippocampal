clear all
close all
clc 

acer=0;

%%
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

for Rat=1:1
rats=[26 27 21];
jay=Rat;
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
     'PlusMaze'
                }
     
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
    %'Baseline_1'}
    %'Baseline_2'
    %'Baseline_3'
    'PlusMaze_1'} 
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
% labelconditions=[
%     {    
%      'Learning Baseline'
%                 }
%      
%      '45minLearning'
%      'Novelty_2'
%      't-maze'
%      'Post t-maze'
%     ];
labelconditions=[
    {    
 %    'Baseline 1'
 %               }
     
 %    'Baseline 2'
     'Novelty 1'
                }
     'Novelty 2'
     'PlusMaze'
    ];
    
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
granger=0;
%Select length of window in seconds:
ro=[1200];
coher=0;
selectripples=0;
mergebaseline=0;
notch=1;
nrem=3;
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
if Rat==26 || Rat==27
   stt=4; 
else
    stt=3;
end

for iii=stt:length(nFF)

    
 clearvars -except nFF iii labelconditions inter granger Rat ro label1 label2 coher selectripples acer mergebaseline nr_27 nr_26 co_26 co_27 nrem notch



%for level=1:length(ripple)-1;    
 for level=1:1
     
for w=1:1

if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

    
    cd(nFF{iii})
lepoch=2;

% error('stop here')

%Get averaged time signal.
% [sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    

load('vq1.mat');

%For experiments requiring the same rate of occurrence among conditions. 
[sig1,sig2,ripple,carajo,veamos,RIPFREQ2,timeasleep]=nrem_fixed_thr(vq,nrem,notch,w,lepoch);
%USE THIS OF THE OLD AND ORIGINAL HISTOGRAM WITH DIFFERENT RATE OF
%OCURRENCE. 
% [sig1,sig2,ripple,carajo,veamos,CHTM,RIPFREQ2,timeasleep]=nrem_newest_only_ripple_level_backup(level,nrem,notch,w,lepoch);

%[p,q,timecell,~,~,~]=getwin2(carajo{:,:,1},veamos{1},sig1,sig2,label1,label2,ro,ripple(1),CHTM(level+1));
% error('stop')

consig=carajo{1};
consig=consig(:,3); %I think it should be the ripple peak. 
aver=cellfun(@(x) diff(x), consig,'UniformOutput',false);
aver=[aver{:}];
Aver=aver;
histogram(Aver,'Normalization','probability','BinWidth',0.1)
xlim([0 4])
grid minor
hold on


%GET NO Learning 1
if acer==0
cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
% cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))    
cd(strcat('D:\internship\',num2str(Rat)))
end

cd(nFF{1})


load('vq1.mat');
%For experiments requiring the same rate of occurrence among conditions. 
[sig1,sig2,ripple,carajo,veamos,RipFreq2,timeasleep]=nrem_fixed_thr(vq,nrem,notch,w,lepoch);


%[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    
%[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=nrem_newest_only_ripple_level(level,nrem,notch,w,lepoch);
consig=carajo{1};
consig=consig(:,2);
aver=cellfun(@(x) diff(x), consig,'UniformOutput',false);
aver=[aver{:}];

histogram(aver,'Normalization','probability','BinWidth',0.1); xlim([0 4])
alpha(0.4)
if Rat==26 || Rat==27 
legend(labelconditions{iii-3},'Baseline 1')
else
legend(labelconditions{iii-2},'Baseline 1')    
end

xlabel('Time(sec)')
ylabel('Probability of occurence')
title('Histogram of interripple occurence')

dim = [.6 .5 .3 .1];
if Rat==26 || Rat==27 
str = strcat('Rate of occurence for',{' '},labelconditions{iii-3},':',{' '},num2str(RIPFREQ2),{' '});
else
str = strcat('Rate of occurence for',{' '},labelconditions{iii-2},':',{' '},num2str(RIPFREQ2),{' '});    
end

annotation('textbox',dim,'String',str)

dim = [.6 .6 .3 .1];
str = strcat('Rate of occurence for',{' '},'Baseline 1',':',{' '},num2str(RipFreq2),{' '});
annotation('textbox',dim,'String',str)


string=strcat('Histograms_',label1{2*w-1},'_','Baseline1','.png');
% error('stop')

if acer==0
    cd(strcat('/home/raleman/Dropbox/Histograms/',num2str(Rat)))
else    
    cd(strcat('C:\Users\Welt Meister\Dropbox\Histograms/',num2str(Rat)))
end

if Rat==26 || Rat==27
if exist(labelconditions{iii-3})~=7
(mkdir(labelconditions{iii-3}))
end
cd((labelconditions{iii-3}))
else
if exist(labelconditions{iii-2})~=7
(mkdir(labelconditions{iii-2}))
end
cd((labelconditions{iii-2}))
    
end
saveas(gcf,string)

string=strcat('Histograms_',label1{2*w-1},'_','Baseline1','.fig');
saveas(gcf,string)

close all


%GET NO Learning 2
if acer==0
cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
% cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))    
cd(strcat('D:\internship\',num2str(Rat)))
end

%cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
cd(nFF{2})


load('vq1.mat');
%For experiments requiring the same rate of occurrence among conditions. 
[sig1,sig2,ripple,carajo,veamos,RipFreq2,timeasleep]=nrem_fixed_thr(vq,nrem,notch,w,lepoch);

% %[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    
% [sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=nrem_newest_only_ripple_level(level,nrem,notch,w,lepoch);

consig=carajo{1};
consig=consig(:,2);
aver=cellfun(@(x) diff(x), consig,'UniformOutput',false);
aver=[aver{:}];

histogram(Aver,'Normalization','probability','BinWidth',0.1)
xlim([0 4])
grid minor
hold on

histogram(aver,'Normalization','probability','BinWidth',0.1); xlim([0 4])
alpha(0.4)

if Rat==26 || Rat==27
legend(labelconditions{iii-3},'Baseline 2')
else
legend(labelconditions{iii-2},'Baseline 2')
end

xlabel('Time(sec)')
ylabel('Probability of occurence')
title('Histogram of interripple occurence')

dim = [.6 .5 .3 .1];
if Rat==26 || Rat==27
str = strcat('Rate of occurence for',{' '},labelconditions{iii-3},':',{' '},num2str(RIPFREQ2),{' '});
else
str = strcat('Rate of occurence for',{' '},labelconditions{iii-2},':',{' '},num2str(RIPFREQ2),{' '});    
end
annotation('textbox',dim,'String',str)

dim = [.6 .6 .3 .1];
str = strcat('Rate of occurence for',{' '},'Baseline 2',':',{' '},num2str(RipFreq2),{' '});
annotation('textbox',dim,'String',str)


string=strcat('Histograms_',label1{2*w-1},'_','Baseline2','.png');

if acer==0
    cd(strcat('/home/raleman/Dropbox/Histograms/',num2str(Rat)))
else    
    cd(strcat('C:\Users\Welt Meister\Dropbox\Histograms/',num2str(Rat)))
end

if Rat==26 || Rat==27

if exist(labelconditions{iii-3})~=7
(mkdir(labelconditions{iii-3}))
end
cd((labelconditions{iii-3}))
else
if exist(labelconditions{iii-2})~=7
(mkdir(labelconditions{iii-2}))
end
cd((labelconditions{iii-2}))
    
end
saveas(gcf,string)

string=strcat('Histograms_',label1{2*w-1},'_','Baseline2','.fig');
saveas(gcf,string)

close all

if Rat~=21
%GET NO Learning 3
%cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
if acer==0
cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
% cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))    
cd(strcat('D:\internship\',num2str(Rat)))
end

cd(nFF{3})


load('vq1.mat');
%For experiments requiring the same rate of occurrence among conditions. 
[sig1,sig2,ripple,carajo,veamos,RipFreq2,timeasleep]=nrem_fixed_thr(vq,nrem,notch,w,lepoch);


% %[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    
% [sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=nrem_newest_only_ripple_level(level,nrem,notch,w,lepoch);


consig=carajo{1};
consig=consig(:,2);
aver=cellfun(@(x) diff(x), consig,'UniformOutput',false);
aver=[aver{:}];

histogram(Aver,'Normalization','probability','BinWidth',0.1)
xlim([0 4])
grid minor
hold on

histogram(aver,'Normalization','probability','BinWidth',0.1); xlim([0 4])
alpha(0.4)
legend(labelconditions{iii-3},'Baseline 3')
xlabel('Time(sec)')
ylabel('Probability of occurence')
title('Histogram of interripple occurence')

dim = [.6 .5 .3 .1];
str = strcat('Rate of occurence for',{' '},labelconditions{iii-3},':',{' '},num2str(RIPFREQ2),{' '});
annotation('textbox',dim,'String',str)

dim = [.6 .6 .3 .1];
str = strcat('Rate of occurence for',{' '},'Baseline 3',':',{' '},num2str(RipFreq2),{' '});
annotation('textbox',dim,'String',str)


string=strcat('Histograms_',label1{2*w-1},'_','Baseline3','.png');

if acer==0
    cd(strcat('/home/raleman/Dropbox/Histograms/',num2str(Rat)))
else    
    cd(strcat('C:\Users\Welt Meister\Dropbox\Histograms/',num2str(Rat)))
end


if exist(labelconditions{iii-3})~=7
(mkdir(labelconditions{iii-3}))
end
cd((labelconditions{iii-3}))

saveas(gcf,string)


string=strcat('Histograms_',label1{2*w-1},'_','Baseline3','.fig');
saveas(gcf,string)
end
close all





end

end


end
%%
end
%end