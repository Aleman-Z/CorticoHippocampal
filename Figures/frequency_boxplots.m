close all
acer=0;
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
ripdur=0; % Duration of ripples. 
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
for RAT=1:1
 if meth==4
    s=struct; 
 end  
  base=2; %This should be 1  
% for base=1:2 %Baseline numeration.     
while base<=2 %Should be 1 for MERGEDBASELINES otherwise 2.
riptable=zeros(4,3);        
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

nFF=nFF([1 4 3 2]);
labelconditions=labelconditions([1 4 3 2]);


%Rat 24
% if Rat==24
%     myColorMap = jet(length(nFF));                                                                                                                                                                                    
% end

 
for block_time=0:0 %Should start with 0
for iii=1:length(nFF) %Should start with 2!
%for iii=1:1 %Should start with 2!
%for vert=2:length(nFF)
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

if iii==2 && sanity==1
%Get number of ripples
FolderRip=[{'all_ripples'} {'500'} {'1000'}];
            Method=[{'Method2' 'Method3' 'Method4'}];
if Rat==26
Base=[{'Baseline1'} {'Baseline2'} {'Baseline3'}];
end
%             else
%             Base=[{'Baseline2'} {'Baseline1'} {'Baseline3'}];    
%             end
if Rat==26 && rat26session3==1
Base=[{'Baseline3'} {'Baseline2'}];
end

if Rat==27 
Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
end

if Rat==27 && rat27session3==1
Base=[{'Baseline2'} {'Baseline3'}];% We run Baseline 2 first, cause it is the one we prefer.    
end

            folder=strcat(Base{base},'_',FolderRip{FiveHun+1},'_',Method{meth-1});
%xo
cd(folder)
%look for randrip.
b=struct2cell(dir)

if ~any(ismember(b(1,:),'randrip.mat'))

load('NumberRipples.mat')
vr=getfield(s,Base{base});
vr=min(vr(:,1));
    
randrip=randi(1000,[1,vr]);
save('randrip.mat','randrip');

%xo
else
 load('randrip.mat')   
end
cd('..')
end
% xo
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
% if strcmp(labelconditions{iii},'Baseline') || strcmp(labelconditions{iii},'PlusMaze')
% [ripple,timeasleep,DEMAIS,y1]=NREM_newest_only_ripple_level(level,nrem,notch,w,lepoch,Score);
% else
%xo
%[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=NREM_get_ripples(level,nrem,notch,w,lepoch,Score)
% [Sig1,Sig2,Ripple,Carajo,Veamos,CHTM2,RipFreq22,Timeasleep]=newest_only_ripple_level(level,lepoch)
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
%openfig('Ripples_per_condition_best.fig')
openfig(strcat('Ripples_per_condition_',Base{base},'.fig'))

h = figure(1); %current figure handle
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

%%
xo
[p,q,~,~,]=getwin2_new(carajo{:,:,level},veamos{level},sig1,sig2,label1,label2,ro,ripple(level),CHTM(level+1));    

consig=carajo{1};

bon=consig(:,1:2);
C = cellfun(@minus,bon(:,2),bon(:,1),'UniformOutput',false);
C=cell2mat(C.');
data_SEM = std(C)/sqrt( length(C));       % SEM Across Columns
CC{iii,:}=C;
%xo
c=median(C)*1000; %Miliseconds
ccc=mean(C)*1000;
% c=median(c)*1000; %Miliseconds
cc(iii)=c;
cccc(iii)=ccc;

consig=consig(:,3);

aver=cellfun(@(x) diff(x), consig,'UniformOutput',false);
aver=[aver{:}];
Aver{iii,:}=aver;
Sem(iii,:)=data_SEM;


end
%%
xo
for tailed=1:2
%%
if ripdur==1
%%    
% % % d=categorical(labelconditions)
% % % bar(d,cccc)
% % % %ylim([35 50])
% % % title('Median duration of ripples')
% % % ylabel('Time (ms)')
% % % hold on
% % % ylim([40 70])
% % % ee=errorbar(d,cccc,Sem*1000,'.')
% % % ee.Color=[0 0 0]

tvar=CC{1};
CCC{1}=tvar(~isoutlier(tvar));
tvar=CC{2};
CCC{2}=tvar(~isoutlier(tvar));
tvar=CC{3};
CCC{3}=tvar(~isoutlier(tvar));
tvar=CC{4};
CCC{4}=tvar(~isoutlier(tvar));

C = [CCC{1} CCC{2}  CCC{3}  CCC{4}];
grp = [zeros(1,length(CCC{1})),ones(1,length(CCC{2})),2*ones(1,length(CCC{3})),3*ones(1,length(CCC{4}))];

bb=boxplot(C*1000,grp,'Notch','on' );
ylim([0 0.10*1000])

set(bb(7,:),'Visible','off');
ave=gca;
ave.XTickLabel=labelconditions;
ylabel('Time (ms)')

%%
else
%%
if acer==0
    cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
end

if tailed==1
indiv=1;
if indiv~=1
allscreen()
end
for vert=1:length(nFF)
if indiv~=1
subplot(4,1,vert)
end
H=histogram(Aver{vert,:},'BinWidth',0.1)
xlim([0 50])
ylim([0 50])

title(labelconditions{vert})
%grid minor
xlabel('Time(sec)')
% title('Histogram of interripple occurence')
grid off

%xo
%ylim([0 .14])
ytix = get(gca, 'YTick');
% set(gca, 'YTick',ytix, 'YTickLabel',ytix*100)
ylabel('Ripples')
%hold on
if indiv==1
pause(1)
string=strcat('HistogramTail_',labelconditions{vert},'_',Block{block_time+1},'_','.pdf');
figure_function(gcf,[],string,[]);
string=strcat('HistogramTail_',labelconditions{vert},'_',Block{block_time+1},'_','.eps');
print(string,'-depsc')
string=strcat('HistogramTail_',labelconditions{vert},'_',Block{block_time+1},'_','.fig');
saveas(gcf,string)
end
if indiv==1
close all
end
end
%%
else
if indiv~=1    
allscreen()
end
for vert=1:length(nFF)
if indiv~=1
subplot(1,4,vert)    
end
histogram(Aver{vert,:},'Normalization','probability','BinWidth',0.1)
xlim([0 4])
%ylim([0 14])

title(labelconditions{vert})
%grid minor
xlabel('Time(sec)')
% title('Histogram of interripple occurence')
grid off

%xo
ylim([0 .14])
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100)
ylabel('Percentage of occurence')
%hold on
if indiv==1
pause(1)
string=strcat('Histogram_',labelconditions{vert},'_',Block{block_time+1},'_','.pdf');
figure_function(gcf,[],string,[]);
string=strcat('Histogram_',labelconditions{vert},'_',Block{block_time+1},'_','.eps');
print(string,'-depsc')
string=strcat('Histogram_',labelconditions{vert},'_',Block{block_time+1},'_','.fig');
saveas(gcf,string)
    
close all
end
end    
    
%%    


%%
end
end

%%
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
%%
% if sanity~=1
if ripdur~=1
if tailed==1
string=strcat('HistogramTail_','Allconditions','_',Block{block_time+1},'_','.pdf');
figure_function(gcf,[],string,[]);
string=strcat('HistogramTail_','Allconditions','_',Block{block_time+1},'_','.eps');
print(string,'-depsc')
string=strcat('HistogramTail_','Allconditions','_',Block{block_time+1},'_','.fig');
saveas(gcf,string)

else
string=strcat('Histogram_','Allconditions','_',Block{block_time+1},'_','.pdf');
figure_function(gcf,[],string,[]);
string=strcat('Histogram_','Allconditions','_',Block{block_time+1},'_','.eps');
print(string,'-depsc')
string=strcat('Histogram_','Allconditions','_',Block{block_time+1},'_','.fig');
saveas(gcf,string)
    
end
else
string=strcat('RippleDuration_','Allconditions','_',Block{block_time+1},'_','.pdf');
figure_function(gcf,[],string,[]);
string=strcat('RippleDuration_','Allconditions','_',Block{block_time+1},'_','.eps');
print(string,'-depsc')
string=strcat('RippleDuration_','Allconditions','_',Block{block_time+1},'_','.fig');
saveas(gcf,string)
        
end
end
xo
%%
%histogram(aver,'Normalization','probability','BinWidth',0.1); xlim([0 4])

end
end
xo
if iii==length(nFF)
   break 
end

end

end

%%
%clearvars -except acer Rat
end
xo

end
%xo
