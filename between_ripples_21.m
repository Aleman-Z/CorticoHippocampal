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

for Rat=21:21
if Rat==21
%% 21
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

for iii=5:length(nFF)

    
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
 %error('stop')

consig=carajo{1};
consig=consig(:,2);
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
%[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    
[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=nrem_newest_only_ripple_level(level,nrem,notch,w,lepoch);
consig=carajo{1};
consig=consig(:,2);
aver=cellfun(@(x) diff(x), consig,'UniformOutput',false);
aver=[aver{:}];

histogram(aver,'Normalization','probability','BinWidth',0.1); xlim([0 4])
alpha(0.4)
legend(labelconditions{iii-2},'Baseline 1')
xlabel('Time(sec)')
ylabel('Probability of occurence')
title('Histogram of interripple occurence')

dim = [.6 .5 .3 .1];
str = strcat('Rate of occurence for',{' '},labelconditions{iii-2},':',{' '},num2str(RIPFREQ2),{' '});
annotation('textbox',dim,'String',str)

dim = [.6 .6 .3 .1];
str = strcat('Rate of occurence for',{' '},'Baseline 1',':',{' '},num2str(RipFreq2),{' '});
annotation('textbox',dim,'String',str)


string=strcat('Histograms_',label1{2*w-1},'_','Baseline1','.png');

if acer==0
    cd(strcat('/home/raleman/Dropbox/Histograms/',num2str(Rat)))
else    
    cd(strcat('C:\Users\Welt Meister\Dropbox\Histograms/',num2str(Rat)))
end


if exist(labelconditions{iii-2})~=7
(mkdir(labelconditions{iii-2}))
end
cd((labelconditions{iii-2}))

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
legend(labelconditions{iii-2},'Baseline 1')
xlabel('Time(sec)')
ylabel('Probability of occurence')
title('Histogram of interripple occurence')

dim = [.6 .5 .3 .1];
str = strcat('Rate of occurence for',{' '},labelconditions{iii-2},':',{' '},num2str(RIPFREQ2),{' '});
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


if exist(labelconditions{iii-2})~=7
(mkdir(labelconditions{iii-2}))
end
cd((labelconditions{iii-2}))

saveas(gcf,string)

string=strcat('Histograms_',label1{2*w-1},'_','Baseline2','.fig');
saveas(gcf,string)

close all

% % % % %GET NO Learning 3
% % % % %cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
% % % % if acer==0
% % % % cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
% % % % else
% % % % % cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))    
% % % % cd(strcat('D:\internship\',num2str(Rat)))
% % % % end
% % % % 
% % % % cd(nFF{3})
% % % % %[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    
% % % % [sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=nrem_newest_only_ripple_level(level,nrem,notch,w,lepoch);
% % % % 
% % % % 
% % % % consig=carajo{1};
% % % % consig=consig(:,2);
% % % % aver=cellfun(@(x) diff(x), consig,'UniformOutput',false);
% % % % aver=[aver{:}];
% % % % 
% % % % histogram(Aver,'Normalization','probability','BinWidth',0.1)
% % % % xlim([0 4])
% % % % grid minor
% % % % hold on
% % % % 
% % % % histogram(aver,'Normalization','probability','BinWidth',0.1); xlim([0 4])
% % % % alpha(0.4)
% % % % legend(labelconditions{iii-2},'Baseline 3')
% % % % xlabel('Time(sec)')
% % % % ylabel('Probability of occurence')
% % % % title('Histogram of interripple occurence')
% % % % 
% % % % dim = [.6 .5 .3 .1];
% % % % str = strcat('Rate of occurence for',{' '},labelconditions{iii-2},':',{' '},num2str(RIPFREQ2),{' '});
% % % % annotation('textbox',dim,'String',str)
% % % % 
% % % % dim = [.6 .6 .3 .1];
% % % % str = strcat('Rate of occurence for',{' '},'Baseline 3',':',{' '},num2str(RipFreq2),{' '});
% % % % annotation('textbox',dim,'String',str)
% % % % 
% % % % 
% % % % string=strcat('Histograms_',label1{2*w-1},'_','Baseline3','.png');
% % % % 
% % % % if acer==0
% % % %     cd(strcat('/home/raleman/Dropbox/Histograms/',num2str(Rat)))
% % % % else    
% % % %     cd(strcat('C:\Users\Welt Meister\Dropbox\Histograms/',num2str(Rat)))
% % % % end
% % % % 
% % % % 
% % % % if exist(labelconditions{iii-2})~=7
% % % % (mkdir(labelconditions{iii-2}))
% % % % end
% % % % cd((labelconditions{iii-2}))
% % % % 
% % % % saveas(gcf,string)
% % % % 
% % % % 
% % % % string=strcat('Histograms_',label1{2*w-1},'_','Baseline3','.fig');
% % % % saveas(gcf,string)
% % % % close all





end

end


end
%%
end
%end
