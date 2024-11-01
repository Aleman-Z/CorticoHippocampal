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

for Rat=26:26
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


else
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

for iii=4:length(nFF)

    
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
    %Get averaged time signal.
% [sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    
[sig1,sig2,ripple,carajo,veamos,CHTM,RIPFREQ2,timeasleep]=nrem_newest_only_ripple_level(level,nrem,notch,w,lepoch);
[p,q,timecell,~,~,~]=getwin2(carajo{:,:,1},veamos{1},sig1,sig2,label1,label2,ro,ripple(1),CHTM(level+1));
% error('stop')

[ran]=rip_select(q);
q=q(ran);

    for j=1:length(q)
        FF(j,1) = (max(q{j}(1,:))-median(q{j}(1,:)))/std(q{j}(1,:));         
    end

histogram(FF(not(Isoutlier(FF))),'Normalization','probability','BinWidth',0.5)
xlim([0 20])
grid minor
hold on

pd = fitdist(FF(not(Isoutlier(FF))),'Normal');
y = pdf(pd,0:0.5:30);
plot(0:0.5:30,y/2,'LineWidth',1.5,'Color','k','LineStyle','--')



%GET NO Learning 1
if acer==0
cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
% cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))    
cd(strcat('D:\internship\',num2str(Rat)))
end

cd(nFF{1})
%[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    
[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=nrem_newest_only_ripple_level(level,nrem,notch,w,lepoch);

[p,q,timecell,~,~,~]=getwin2(carajo{:,:,1},veamos{1},sig1,sig2,label1,label2,ro,ripple(1),CHTM(level+1));
% error('stop')

[ran]=rip_select(q);
q=q(ran);

    for j=1:length(q)
        F(j,1) = (max(q{j}(1,:))-median(q{j}(1,:)))/std(q{j}(1,:));         
    end


histogram(F(not(Isoutlier(F))),'Normalization','probability','BinWidth',0.5)
pd = fitdist(F(not(Isoutlier(F))),'Normal');
y = pdf(pd,0:0.5:30);
plot(0:0.5:30,y/2,'LineWidth',1.5,'Color','k','LineStyle','-')

% consig=carajo{1};
% consig=consig(:,2);
% aver=cellfun(@(x) diff(x), consig,'UniformOutput',false);
% aver=[aver{:}];

% histogram(aver,'Normalization','probability','BinWidth',0.1); xlim([0 4])
alpha(0.4)
% legend(labelconditions{iii-3},'Baseline 1')
legend(labelconditions{iii-3},strcat(labelconditions{iii-3},' (fit)'),'Baseline 1','Baseline 1 (fit)')

xlabel('Number of Standard Deviations wrt. Amplitude Median')
ylabel('Probability of occurence')
title('Histogram of Ripple amplitude')
% 
% dim = [.6 .5 .3 .1];
% str = strcat('Rate of occurence for',{' '},labelconditions{iii-3},':',{' '},num2str(RIPFREQ2),{' '});
% annotation('textbox',dim,'String',str)
% 
% dim = [.6 .6 .3 .1];
% str = strcat('Rate of occurence for',{' '},'Baseline 1',':',{' '},num2str(RipFreq2),{' '});
% annotation('textbox',dim,'String',str)


string=strcat('Histograms_Amp_',label1{2*w-1},'_','Baseline1','.png');

if acer==0
    cd(strcat('/home/raleman/Dropbox/Histograms_Amp2/',num2str(Rat)))
else    
    cd(strcat('C:\Users\Welt Meister\Dropbox\Histograms_Amp2/',num2str(Rat)))
end


if exist(labelconditions{iii-3})~=7
(mkdir(labelconditions{iii-3}))
end
cd((labelconditions{iii-3}))

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
%[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    
[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=nrem_newest_only_ripple_level(level,nrem,notch,w,lepoch);

[p,q,timecell,~,~,~]=getwin2(carajo{:,:,1},veamos{1},sig1,sig2,label1,label2,ro,ripple(1),CHTM(level+1));
% error('stop')

[ran]=rip_select(q);
q=q(ran);

    for j=1:length(q)
        F(j,1) = (max(q{j}(1,:))-median(q{j}(1,:)))/std(q{j}(1,:));         
    end
    
histogram(FF(not(Isoutlier(FF))),'Normalization','probability','BinWidth',0.5)
xlim([0 20])
grid minor
hold on
pd = fitdist(FF(not(Isoutlier(FF))),'Normal');
y = pdf(pd,0:0.5:30);
plot(0:0.5:30,y/2,'LineWidth',1.5,'Color','k','LineStyle','--')


histogram(F(not(Isoutlier(F))),'Normalization','probability','BinWidth',0.5)
pd = fitdist(F(not(Isoutlier(F))),'Normal');
y = pdf(pd,0:0.5:30);
plot(0:0.5:30,y/2,'LineWidth',1.5,'Color','k','LineStyle','-')

alpha(0.4)

legend(labelconditions{iii-3},strcat(labelconditions{iii-3},' (fit)'),'Baseline 2','Baseline 2 (fit)')
xlabel('Number of Standard Deviations wrt. Amplitude Median')
ylabel('Probability of occurence')
title('Histogram of Ripple amplitude')

% dim = [.6 .5 .3 .1];
% str = strcat('Rate of occurence for',{' '},labelconditions{iii-3},':',{' '},num2str(RIPFREQ2),{' '});
% annotation('textbox',dim,'String',str)

% dim = [.6 .6 .3 .1];
% str = strcat('Rate of occurence for',{' '},'Baseline 2',':',{' '},num2str(RipFreq2),{' '});
% annotation('textbox',dim,'String',str)


string=strcat('Histograms_Amp_',label1{2*w-1},'_','Baseline2','.png');

if acer==0
    cd(strcat('/home/raleman/Dropbox/Histograms_Amp2/',num2str(Rat)))
else    
    cd(strcat('C:\Users\Welt Meister\Dropbox\Histograms_Amp2/',num2str(Rat)))
end


if exist(labelconditions{iii-3})~=7
(mkdir(labelconditions{iii-3}))
end
cd((labelconditions{iii-3}))

saveas(gcf,string)

string=strcat('Histograms_Amp',label1{2*w-1},'_','Baseline2','.fig');
saveas(gcf,string)

close all

%GET NO Learning 3
%cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
if acer==0
cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
% cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))    
cd(strcat('D:\internship\',num2str(Rat)))
end

cd(nFF{3})
%[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    
[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=nrem_newest_only_ripple_level(level,nrem,notch,w,lepoch);

[p,q,timecell,~,~,~]=getwin2(carajo{:,:,1},veamos{1},sig1,sig2,label1,label2,ro,ripple(1),CHTM(level+1));
% error('stop')

[ran]=rip_select(q);
q=q(ran);

    for j=1:length(q)
        F(j,1) = (max(q{j}(1,:))-median(q{j}(1,:)))/std(q{j}(1,:));         
    end

% histogram(FF,'Normalization','probability','BinWidth',0.5)
% 
% xlim([0 30])
% grid minor
% hold on
% 
% histogram(F,'Normalization','probability','BinWidth',0.5)
histogram(FF(not(Isoutlier(FF))),'Normalization','probability','BinWidth',0.5)
xlim([0 20])
grid minor
hold on
pd = fitdist(FF(not(Isoutlier(FF))),'Normal');
y = pdf(pd,0:0.5:30);
plot(0:0.5:30,y/2,'LineWidth',1.5,'Color','k','LineStyle','--')


histogram(F(not(Isoutlier(F))),'Normalization','probability','BinWidth',0.5)
pd = fitdist(F(not(Isoutlier(F))),'Normal');
y = pdf(pd,0:0.5:30);
plot(0:0.5:30,y/2,'LineWidth',1.5,'Color','k','LineStyle','-')

alpha(0.4)

legend(labelconditions{iii-3},strcat(labelconditions{iii-3},' (fit)'),'Baseline 3','Baseline 3 (fit)')
xlabel('Number of Standard Deviations wrt. Amplitude Median')
ylabel('Probability of occurence')
title('Histogram of Ripple amplitude')


% 
% consig=carajo{1};
% consig=consig(:,2);
% aver=cellfun(@(x) diff(x), consig,'UniformOutput',false);
% aver=[aver{:}];

%histogram(Aver,'Normalization','probability','BinWidth',0.1)
% xlim([0 4])
% grid minor
% hold on
% 
% % histogram(aver,'Normalization','probability','BinWidth',0.1); xlim([0 4])
% alpha(0.4)
% legend(labelconditions{iii-3},'Baseline 3')
% xlabel('Number of Standard Deviations wrt. Amplitude Median')
% ylabel('Probability of occurence in 1000 largest ripples')
% title('Histogram of Ripple amplitude')

% dim = [.6 .5 .3 .1];
% str = strcat('Rate of occurence for',{' '},labelconditions{iii-3},':',{' '},num2str(RIPFREQ2),{' '});
% annotation('textbox',dim,'String',str)
% 
% dim = [.6 .6 .3 .1];
% str = strcat('Rate of occurence for',{' '},'Baseline 3',':',{' '},num2str(RipFreq2),{' '});
% annotation('textbox',dim,'String',str)


string=strcat('Histograms_Amp_',label1{2*w-1},'_','Baseline3','.png');

if acer==0
    cd(strcat('/home/raleman/Dropbox/Histograms_Amp2/',num2str(Rat)))
else    
    cd(strcat('C:\Users\Welt Meister\Dropbox\Histograms_Amp2/',num2str(Rat)))
end


if exist(labelconditions{iii-3})~=7
(mkdir(labelconditions{iii-3}))
end
cd((labelconditions{iii-3}))

saveas(gcf,string)


string=strcat('Histograms_Amp',label1{2*w-1},'_','Baseline3','.fig');
saveas(gcf,string)
close all





end

end


end
%%
end
%end