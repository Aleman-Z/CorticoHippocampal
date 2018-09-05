close all
acer=1;
% rat24base=1;
DUR{1}='1sec';
DUR{2}='10sec';
Block{1}='complete';
Block{2}='block1';
Block{3}='block2';
mergebaseline=0; %Make sure base's while loop condition is never equal to 2.
FiveHun=2; % Options: 0 all, 1 current, 2 1000?
%meth=1;
rat26session3=0; %Swaps session 1 for session 3 on Rat 26.
rat27session3=0; %Swaps session 1 for session 3 on Rat 26.
rippletable=0;
sanity=0;
quinientos=0;
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
for meth=4:4
for RAT=3:3
 if meth==4
    s=struct; 
 end  
  base=2; %This should be 1  
% for base=1:2 %Baseline numeration.     
while base<=2 %Should be 1 for MERGEDBASELINES otherwise 2.
riptable=zeros(4,3);        
for rat24base=2:2
 
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

% xo
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
if rat27session3==1
    if strcmp(nFF{1}, 'rat27_nl_base_2016-03-28_15-01-17')
    NFF=[ {'rat27_nl_base_III_2016-03-30_14-36-57'   }];
    end
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
%  NFF=[];
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
 
% if Rat==24
%     cd(nFF{1})
% end

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
% 
% if Rat==26 && rat26session3==1
% Base=[{'Baseline3'} {'Baseline2'}];
% end
% 
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
if Rat ~=24
    if base==2
        nFF{1}=NFF{1};
    end
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
for iii=2:length(nFF) %Should start with 2!
%xo
if acer==0
    cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
end
 
% if Rat==24
%     cd(nFF{1})
% end

if dura==2
    cd('10sec')
end
%xo

% 
% string1=strcat('Spec_',labelconditions{iii},'_',label1{2*2-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
% string2=strcat('Spec_',labelconditions{iii},'_',label1{2*3-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
% 
% 
% while exist(string1, 'file')==2 && exist(string2, 'file')==2
% iii=iii+1;
% 
% if iii>length(nFF)
%     break
% end
%    string1=strcat('Spec_',labelconditions{iii},'_',label1{2*2-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
%    string2=strcat('Spec_',labelconditions{iii},'_',label1{2*3-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
% 
% end

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
%xo     
if Rat==26 || Rat==24 
Base=[{'Baseline1'} {'Baseline2'}];
end
if Rat==26 && rat26session3==1
Base=[{'Baseline3'} {'Baseline2'}];
end

if Rat==27 
Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
end

if Rat==27 && rat27session3==1
Base=[{'Baseline2'} {'Baseline3'}];% We run Baseline 2 first, cause it is the one we prefer.    
end

FolderRip=[{'all_ripples'} {'500'} {'1000'}];

if meth==1
folder=strcat(Base{base},'_',FolderRip{FiveHun+1});
else
Method=[{'Method2' 'Method3' 'Method4'}];
folder=strcat(Base{base},'_',FolderRip{FiveHun+1},'_',Method{meth-1});    
end

if mergebaseline==1
    if meth==1
    folder=strcat('Merged_',FolderRip{FiveHun+1});
    else
    Method=[{'Method2' 'Method3' 'Method4'}];
    folder=strcat('Merged_',FolderRip{FiveHun+1},'_',Method{meth-1});    
    end
end

if Rat~=24
    if dura==1
    cd(folder)
    end
end


 
% end
%  save('thresholdfile.mat','ripple','timeasleep','DEMAIS','y1');                                                                                                                                                                                                                                                                                                                                               
%%
if rippletable==0
for w=2:3

if sanity~=1
string=strcat('Spec_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');
else
  if quinientos==1
      string=strcat('Control_500_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');    
  else
      string=strcat('Control_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');    
  end
end
% xo
py=openfig(string)
py.Units='normalized';
py.OuterPosition=[0 0 1 1];
%%
subplot(3,4,12)
%%
       
if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

cd(nFF{iii})
lepoch=2;
level=1; 

if meth==1
    [sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level_ERASETHIS(level);
%     [Nsig1,Nsig2,Nripple,Ncarajo,Nveamos,NCHTM,NRipFreq2,Ntimeasleep]=newest_only_ripple_nl_level(level);
end

if meth==2
    [sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=median_std;    
end

if meth==3
chtm=load('vq_loop2.mat');
chtm=chtm.vq;
    [sig1,sig2,ripple,carajo,veamos,RipFreq2,timeasleep,~]=nrem_fixed_thr_Vfiles(chtm,notch);
CHTM=[chtm chtm];
end
%%
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
    

if Rat==26 || Rat==24 
Base=[{'Baseline1'} {'Baseline2'}];
end
if Rat==26 && rat26session3==1
Base=[{'Baseline3'} {'Baseline2'}];
end

if Rat==27 
Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
end

if Rat==27 && rat27session3==1
Base=[{'Baseline2'} {'Baseline3'}];% We run Baseline 2 first, cause it is the one we prefer.    
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
close

%xo
if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

cd(nFF{iii})
    [sig1,sig2,ripple,carajo,veamos,RipFreq2,timeasleep,~]=nrem_fixed_thr_Vfiles(chtm,notch);
CHTM=[chtm chtm];
riptable(iii,1)=ripple;
riptable(iii,2)=timeasleep;
riptable(iii,3)=RipFreq2;

end

%Nose=[Nose RipFreq2];


%% Select time block 
if block_time==1
[carajo,veamos]=equal_time2(sig1,sig2,carajo,veamos,30,0);
ripple=sum(cellfun('length',carajo{1}(:,1))); %Number of ripples after equal times.
end

if block_time==2
[carajo,veamos]=equal_time2(sig1,sig2,carajo,veamos,60,30);
ripple=sum(cellfun('length',carajo{1}(:,1))); %Number of ripples after equal times.
end

%%

%[NSig1,NSig2,NRipple,NCarajo,NVeamos,NCHTM2,NRipFreq22,NTimeasleep]=data_newest_only_ripple_level(level,lepoch)
% if meth==3
% [p,q,~,~,~,~]=getwin2(carajo{:,:,level},veamos{level},sig1,sig2,label1,label2,ro,ripple(level),chtm);        
% else
[p,q,~,~,~,~]=getwin2(carajo{:,:,level},veamos{level},sig1,sig2,label1,label2,ro,ripple(level),CHTM(level+1));    
% end
clear sig1 sig2
%Ripple selection. Memory free. 
% % % % % % % % % % % % % % % % % % % % [ran]=select_rip(p,FiveHun);
% % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % p=p([ran]);
% % % % % % % % % % % % % % % % % % % % q=q([ran]);
if quinientos==1 && iii==2

if acer==0
    cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
end

% if Rat==24
%     cd(nFF{1})
% end

if dura==2
    cd('10sec')
end

folder=strcat(Base{base},'_',FolderRip{FiveHun+1},'_',Method{meth-1});
cd(folder)
load('randrip.mat')
end


if quinientos==0
[ran]=select_rip(p,FiveHun);
p=p([ran]);
q=q([ran]);

else
     if iii~=2
        [ran]=select_quinientos(p,length(randrip)); 
        p=p([ran]);
        q=q([ran]);
     %    ran=1:length(randrip);
     end
end



% xo
if sanity==1 && quinientos==0 

if acer==0
    cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
end

% if Rat==24
%     cd(nFF{1})
% end

if dura==2
    cd('10sec')
end

folder=strcat(Base{base},'_',FolderRip{FiveHun+1},'_',Method{meth-1});
cd(folder)
load('randrip.mat')

if iii~=2
 p=p(randrip);
 q=q(randrip);
end

end

%Q=Q([ran]);
%timecell=timecell([ran]);
[q]=filter_ripples(q,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);
%[p]=filter_ripples(q,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);

P1=avg_samples(q,create_timecell(ro,length(p)));
P2=avg_samples(p,create_timecell(ro,length(p)));
%[ripple,timeasleep,DEMAIS,y1]=NREM_newest_only_ripple_level(level,nrem,notch,w,lepoch,1);    


if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

cd(nFF{1}) %Baseline

%run('newest_load_data_nl.m')
%[sig1_nl,sig2_nl,ripple2_nl,carajo_nl,veamos_nl,CHTM_nl]=newest_only_ripple_nl;

if meth==1
[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,RipFreq3,timeasleep2]=newest_only_ripple_level_ERASETHIS(level);
end

if meth==2
    [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,RipFreq3,timeasleep2]=median_std;    
end

if meth==3
chtm=load('vq_loop2.mat');
chtm=chtm.vq;
    [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq3,timeasleep2,~]=nrem_fixed_thr_Vfiles(chtm,notch);
CHTM2=[chtm chtm];
end

if meth==4
[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq3,timeasleep2,~]=nrem_fixed_thr_Vfiles(chtm,notch);
CHTM2=[chtm chtm];
riptable(1,1)=ripple_nl;
riptable(1,2)=timeasleep2;
riptable(1,3)=RipFreq3;
end

%%

if block_time==1
[carajo_nl,veamos_nl]=equal_time2(sig1_nl,sig2_nl,carajo_nl,veamos_nl,30,0);
ripple_nl=sum(cellfun('length',carajo_nl{1}(:,1)));
end

if block_time==2
[carajo_nl,veamos_nl]=equal_time2(sig1_nl,sig2_nl,carajo_nl,veamos_nl,60,30);
ripple_nl=sum(cellfun('length',carajo_nl{1}(:,1)));    
end

%xo   
        
%%
%xo
% h=plot_inter_conditions_33(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch);
if sanity==1
plot_inter_high_improve(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,randrip);    
else
plot_inter_high_improve(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos);    
end
%h=plot_inter_conditions_filtering(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer);

%%

%error('stop')
if acer==0
    cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
end

% if Rat==24
%     cd(nFF{1})
% end

if dura==2
    cd('10sec')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
if Rat~=24
    if dura==1
    cd(folder)
    end
end
%xo
if sanity==1
    if quinientos==1
        string=strcat('Control_500_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');
        saveas(gcf,string)
        string=strcat('Control_500_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
        figure_function(gcf,[],string,[]);
        string=strcat('Control_500_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.eps');
        print(string,'-depsc')
    else
        string=strcat('Control_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');
        saveas(gcf,string)
        string=strcat('Control_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
        figure_function(gcf,[],string,[]);
        string=strcat('Control_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.eps');
        print(string,'-depsc')
    end
    
else
string=strcat('Spec_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');
saveas(gcf,string)
string=strcat('Spec_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
figure_function(gcf,[],string,[]);
string=strcat('Spec_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.eps');
print(string,'-depsc')
    
end

close all

%%

end
end
%end

if iii==length(nFF)
   break 
end

end

end

%%
%clearvars -except acer Rat
end
xo
if meth==4

    if Rat==26
    Base=[{'Baseline1'} {'Baseline2'}];
    end
    if Rat==26 && rat26session3==1
    Base=[{'Baseline3'} {'Baseline2'}];
    end

    if Rat==27 
    Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
    end
    
    if Rat==27 && rat27session3==1
    Base=[{'Baseline2'} {'Baseline3'}];% We run Baseline 2 first, cause it is the one we prefer.    
    end

    [s.(Base{base})]=riptable;
end

end
%xo
% % % % % if rippletable==0
% % % % % spec_loop_improve(RAT,block_time);
% % % % % %save in right folder
% % % % % list = dir();
% % % % % list([list.isdir]) = [];
% % % % % list={list.name};
% % % % % FolderRip=[{'all_ripples'} {'500'} {'1000'}];
% % % % % if Rat==26
% % % % % Base=[{'Baseline1'} {'Baseline2'}];
% % % % % end
% % % % % if Rat==26 && rat26session3==1
% % % % % Base=[{'Baseline3'} {'Baseline2'}];
% % % % % end
% % % % % 
% % % % % if Rat==27 
% % % % % Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
% % % % % end
% % % % % 
% % % % % if Rat==27 && rat27session3==1
% % % % %    Base=[{'Baseline2'} {'Baseline3'}];% We run Baseline 2 first, cause it is the one we prefer.    
% % % % % end
% % % % % 
% % % % % if meth==1
% % % % % folder=strcat(Base{base},'_',FolderRip{FiveHun+1});
% % % % % else
% % % % % Method=[{'Method2' 'Method3' 'Method4'}];
% % % % % folder=strcat(Base{base},'_',FolderRip{FiveHun+1},'_',Method{meth-1});    
% % % % % end
% % % % % 
% % % % % if mergebaseline==1
% % % % %     if meth==1
% % % % %     folder=strcat('Merged','_',FolderRip{FiveHun+1});
% % % % %     else
% % % % %     Method=[{'Method2' 'Method3' 'Method4'}];
% % % % %     folder=strcat('Merged','_',FolderRip{FiveHun+1},'_',Method{meth-1});    
% % % % %     end
% % % % % end
% % % % % 
% % % % % if exist(folder)~=7
% % % % % (mkdir(folder))
% % % % % end
% % % % % 
% % % % % for nmd=1:length(list)
% % % % % movefile (list{nmd}, folder)
% % % % % end
% % % % % 
% % % % % 
% % % % % clearvars -except RAT acer DUR Block mergebaseline FiveHun meth block_time base rat26session3 rat27session3
% % % % % end
if base>=2
    break
end
base=2;
end
%xo

base=1;

end
end
