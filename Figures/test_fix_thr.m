acer=1;
% rat24base=1;
DUR{1}='1sec';
DUR{2}='10sec';
Block{1}='complete';
Block{2}='block1';
Block{3}='block2';
mergebaseline=0;
FiveHun=2; % Options: 0 all, 1 current, 2 1000?
%meth=1;
rat26session3=0; %Swaps session 1 for session 3 on Rat 26.
%%
if acer==0
addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
addpath(genpath('/home/raleman/Documents/GitHub/CorticoHippocampal'))
addpath(genpath('/home/raleman/Documents/GitHub/ADRITOOLS'))
addpath('/home/raleman/Documents/internship')
else
addpath('D:\internship\analysis-tools-master'); %Open Ephys data loader.
addpath(genpath('C:\Users\addri\Documents\internship\CorticoHippocampal'))
addpath(genpath('C:\Users\addri\Documents\GitHub\ADRITOOLS'))
%addpath(('C:\Users\addri\Documents\internship\CorticoHippocampal'))
   
end
%%
%Rat=26;
meth=4;
for RAT=2:2
  base=2;  
% for base=1:2 %Baseline numeration.     
while base<=2
for rat24base=1:2
 
  if RAT~=3 && rat24base==2
      break
  end

for dura=1:1 %Starts with 1
    
rats=[26 27 24 21];
Rat=rats(RAT);    
    
% for Rat=26:26
if Rat==26
nFF=[
%    {'rat26_Base_II_2016-03-24'                         }
%    {'rat26_Base_II_2016-03-24_09-47-13'                }
%    {'rat26_Base_II_2016-03-24_12-55-58'                }
%    {'rat26_Base_II_2016-03-24_12-57-57'                }
    
   
%   {'rat26_nl_base_III_2016-03-30_10-32-57'            }
 %    {'rat26_nl_base_II_2016-03-28_10-40-19'             }
     {'rat26_nl_baseline2016-03-01_11-01-55'             }
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

if strcmp(nFF{1},'rat26_nl_baseline2016-03-01_11-01-55') && rat26session3==1
   nFF{1}='rat26_nl_base_III_2016-03-30_10-32-57'; 
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

%% Check if experiment has been run before.
if acer==0
    cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
end

if Rat==24
    cd(nFF{1})
end

if dura==2
    cd('10sec')
end
%xo
% 
% %Ignore this for a moment
% FolderRip=[{'all_ripples'} {'500'} {'1000'}];
% if Rat==26
% Base=[{'Baseline1'} {'Baseline2'}];
% end
% if Rat==27 
% Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
% end
% 
% if meth==1
% Folder=strcat(Base{base},'_',FolderRip{FiveHun+1});
% else
% Method=[{'Method2' 'Method3' 'Method4'}];
% Folder=strcat(Base{base},'_',FolderRip{FiveHun+1},'_',Method{meth-1});    
% end
% 
% if exist(Folder)==7 && base==1
% base=base+1;
% end
%%
% Use other baseline, beware when using mergebaseline
if base==2
    nFF{1}=NFF{1};
end

if base==3
    break
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
% inter=1;
%Select length of window in seconds:
if dura==1
ro=[1200];
else
ro=[10200];    
end
% coher=0;
% selectripples=1;
notch=0;
nrem=3;
myColorMap = jet(8);
% Score=1;
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

 
for block_time=0:0 %Should start with 0
%for iii=2:length(nFF) %Should start with 2!
for iii=2:2 %Should start with 2!

    %xo
if acer==0
    cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
end

if Rat==24
    cd(nFF{1})
end

if dura==2
    cd('10sec')
end


if iii>length(nFF)
    break
end

% string=strcat('Spec_',labelconditions{iii},'_',label1{2*2-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
% if exist(string, 'file') == 2
% string=strcat('Spec_',labelconditions{iii},'_',label1{2*3-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');    
%       if exist(string, 'file') == 2
%            iii=iii+1;
%       end
% end
%  clearvars -except nFF iii labelconditions inter granger Rat ro label1 label2 coher selectripples acer mergebaseline nr_27 nr_26 co_26 co_27 nrem notch myColorMap



%for level=1:length(ripple)-1;    
 %for level=1:1
     
lepoch=2;

 level=1;
 
%Get averaged time signal.
% [sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);
% if strcmp(labelconditions{iii},'Baseline') || strcmp(labelconditions{iii},'PlusMaze')
% [ripple,timeasleep,DEMAIS,y1]=NREM_newest_only_ripple_level(level,nrem,notch,w,lepoch,Score);
% else
% xo
%[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=NREM_get_ripples(level,nrem,notch,w,lepoch,Score)
% [Sig1,Sig2,Ripple,Carajo,Veamos,CHTM2,RipFreq22,Timeasleep]=newest_only_ripple_level(level,lepoch)

if meth==4
if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

cd(nFF{1})

[timeasleep]=find_thr_base;
ror=2000/timeasleep;

    if acer==0
        cd(strcat('/home/raleman/Dropbox/Figures/Figure2/',num2str(Rat)))
    else
          %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
          cd(strcat('C:\Users\addri\Dropbox\Figures\Figure2\',num2str(Rat)))   
    end
    

if Rat==26
Base=[{'Baseline1'} {'Baseline2'}];
end

if Rat==26 && rat26session3==1
Base=[{'Baseline3'} {'Baseline2'}];
end

if Rat==27
Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
end

%openfig('Ripples_per_condition_best.fig')
openfig(strcat('Ripples_per_condition_',Base{base},'.fig'))

h = gcf; %current figure handle
axesObjs = get(h, 'Children');  %axes handles
dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes

ydata=dataObjs{2}(8).YData;
xdata=dataObjs{2}(8).XData;
% figure()
% plot(xdata,ydata)
chtm = interp1(ydata,xdata,ror);
% hax=axes; 
% line([SP SP],get(gcf,'YLim'),'Color',[1 1 1])
line([chtm chtm], [-0.5 3],'Color',[0 0 0],'LineStyle','--');
txt1 = strcat(num2str(chtm,'% 10.2f'),'{ }','\rightarrow');
text(chtm,1.5,txt1,'HorizontalAlignment','right')
%legend('Threshold')
h=legend('Baseline','Baseline (fit)','Plusmaze','Plusmaze (fit)','Novelty','Novelty (fit)','Foraging','Foraging (fit)','Threshold') 

if acer==0
    cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
end
 xo

FolderRip=[{'all_ripples'} {'500'} {'1000'}];
if Rat==26
Base=[{'Baseline1'} {'Baseline2'}];
end

if Rat==26 && rat26session3==1
Base=[{'Baseline3'} {'Baseline2'}];
end

if Rat==27
Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
end

if meth==1
folder=strcat(Base{base},'_',FolderRip{FiveHun+1});
else
Method=[{'Method2' 'Method3' 'Method4'}];
folder=strcat(Base{base},'_',FolderRip{FiveHun+1},'_',Method{meth-1});    
end
cd(folder)

string=strcat('Ripples_per_condition_',Base{base},'.pdf');
figure_function(gcf,[],string,[]);
string=strcat('Ripples_per_condition_',Base{base},'.eps');
print(string,'-depsc')    
string=strcat('Ripples_per_condition_',Base{base},'.fig');
saveas(gcf,string)

% if acer==0
%     cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
% else
%     cd(strcat('D:\internship\',num2str(Rat)))
% end
% 
% cd(nFF{iii})
%     [sig1,sig2,ripple,carajo,veamos,RipFreq2,timeasleep,~]=nrem_fixed_thr_Vfiles(chtm,notch);
% CHTM=[chtm chtm];
% end
% 
% %Nose=[Nose RipFreq2];
% 
% 
% if acer==0
%     cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
% else
%     cd(strcat('D:\internship\',num2str(Rat)))
% end
% 
% cd(nFF{1}) %Baseline
% 
% %run('newest_load_data_nl.m')
% %[sig1_nl,sig2_nl,ripple2_nl,carajo_nl,veamos_nl,CHTM_nl]=newest_only_ripple_nl;
% 
% if meth==1
% [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,RipFreq3,timeasleep2]=newest_only_ripple_level_ERASETHIS(level);
% end
% 
% if meth==2
%     [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,RipFreq3,timeasleep2]=median_std;    
% end
% 
% if meth==3
% chtm=load('vq_loop2.mat');
% chtm=chtm.vq;
%     [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq3,timeasleep2,~]=nrem_fixed_thr_Vfiles(chtm,notch);
% CHTM2=[chtm chtm];
% end
% 
% if meth==4
% [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq3,timeasleep2,~]=nrem_fixed_thr_Vfiles(chtm,notch);
% CHTM2=[chtm chtm];
% end

%%

% xo
% end
%  save('thresholdfile.mat','ripple','timeasleep','DEMAIS','y1');                                                                                                                                                                                                                                                                                                                                               
%%
end

if iii==length(nFF)
   break 
end

end
% xo
end


end

%%
%clearvars -except acer Rat
end
%spec_loop_improve(RAT,block_time);
%save in right folder

%xo
clearvars -except RAT acer DUR Block mergebaseline FiveHun meth block_time base
if base>=2
    break
end
base=2;
end
base=1;

end
% end
