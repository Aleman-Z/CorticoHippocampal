function plot_all(folder)

str2=cell(13,1);
str2{1,1}='/home/raleman/Documents/internship/Lisa_files/data/PT1';
str2{2,1}='/home/raleman/Documents/internship/Lisa_files/data/PT2';
str2{3,1}='/home/raleman/Documents/internship/Lisa_files/data/PT3';
str2{4,1}='/home/raleman/Documents/internship/Lisa_files/data/PT4';
str2{5,1}='/home/raleman/Documents/internship/Lisa_files/data/PT5';

str2{6,1}='/home/raleman/Documents/internship/Lisa_files/data/PT5_1';
str2{7,1}='/home/raleman/Documents/internship/Lisa_files/data/PT5_2';
str2{8,1}='/home/raleman/Documents/internship/Lisa_files/data/PT5_3';
str2{9,1}='/home/raleman/Documents/internship/Lisa_files/data/PT5_4';
str2{10,1}='/home/raleman/Documents/internship/Lisa_files/data/PT5_5';
str2{11,1}='/home/raleman/Documents/internship/Lisa_files/data/PT5_6';

str2{12,1}='/home/raleman/Documents/internship/Lisa_files/data/Presleep1';
str2{13,1}='/home/raleman/Documents/internship/Lisa_files/data/Presleep2';

%str2{6,1}='/home/raleman/Documents/internship/Lisa_files/data/PT6';



% cd('/media/raleman/My Book/ObjectSpace/rat_1/study_day_2_OR/post_trial1_2017-09-25_11-26-43');
cd(str2{folder,1});



load('V9.mat')
load('V17.mat')
fn=1000;

Wn1=[300/(fn/2)]; % Cutoff=500 Hz
[b1,a1] = butter(3,Wn1,'low'); %Filter coefficients for LPF
V17=filtfilt(b1,a1,V17);
V9=filtfilt(b1,a1,V9);

% % 

V9n=outlier(V9);
V17n=outlier(V17);
% 
% V9n=V9;
% V17n=V17;

fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=500 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients for LPF

Mono17=filtfilt(b1,a1,V17n);
Mono9=filtfilt(b1,a1,V9n);


% [peakVals,peakLocs]=findpeaks(signal,'sortstr','descend');

%Ripple detection 
signal=Mono17*(1/0.195);
thr=165;
t=(0:length(signal)-1)*(1/fn); %IN SECONDS
[S, E, M] = findRipplesLisa(signal, t, thr , thr*(1/2), []);
% 
% remshort=E-S;
% %remindex=(remshort>0.06);
% remindex=(remshort>0.08);

% M=M(remindex);

ripples=length(M);
NUM=[200 500];
%num=500;


for i=1:2
num=NUM(i);    
label1='Hippocampus';
label2=strcat('Thr:',num2str(thr));
%Mono17=Mono17*(1/0.195);
%V17n=V17n*(1/0.195);


[cellx,cellr]=winL(M,Mono17,V17n,num,1000);

% [cellr, cellx]=remover(cellr, cellx);
%[cellr, cellx]=remover(cellr, cellx);


[cellx,cellr]=clean(cellx,cellr);

allscreen
[p3 ,p4,avex]=eta(cellx,cellr,num,1000);
mtit(strcat(label1),'fontsize',14,'color',[1 0 0],'position',[.5 1 ])
mtit(strcat(' (',label2,')'),'fontsize',14,'color',[1 0 0],'position',[.5 0.8 ])
mtit(strcat('Events:',num2str(ripples)),'fontsize',14,'color',[1 0 0],'position',[.5 0.6 ])


barplot2(p4,p3,num,1000)

[cfs,f]=barplot3(p4,p3,num);
saveas(gcf,strcat(num2str(num),'XXnHippo','.png'));

%Save PFC 
label1='PFC';
label2=strcat('Thr:',num2str(thr));
Mono9=Mono9*(1/0.195);
V9n=V9n*(1/0.195);

[cellx,cellr]=winL(M,Mono9,V9n,num,1000);
[cellx,cellr]=clean(cellx,cellr);

allscreen
[p3 ,p4]=eta(cellx,cellr,num,1000);
mtit(strcat(label1),'fontsize',14,'color',[1 0 0],'position',[.5 1 ])
mtit(strcat(' (',label2,')'),'fontsize',14,'color',[1 0 0],'position',[.5 0.8 ])
mtit(strcat('Events:',num2str(ripples)),'fontsize',14,'color',[1 0 0],'position',[.5 0.6 ])

barplot2(p4,p3,num,1000)

[cfs,f]=barplot3(p4,p3,num);
saveas(gcf,strcat(num2str(num),'XXnPFC','.png'));
% error('stop')




end

% close all
end