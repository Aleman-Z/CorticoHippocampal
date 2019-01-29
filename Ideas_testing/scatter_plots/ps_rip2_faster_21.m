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

for iii=3:length(nFF)

    
 clearvars -except nFF iii labelconditions inter granger Rat ro label1 label2 coher selectripples acer mergebaseline nr_27 nr_26 co_26 co_27 nrem notch



%for level=1:length(ripple)-1;    
 for level=1:1
     
for w=2:3

if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end
%     error('stop')
cd(nFF{iii})
lepoch=2;
%  error('stop')   
%Get averaged time signal.
% [sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    
[sig1,sig2,ripple,carajo,veamos,CHTM,~,~]=nrem_newest_only_ripple_level_backup(level,nrem,notch,w,lepoch);
[~,q,~,~,~,~]=getwin2(carajo{:,:,1},veamos{1},sig1,sig2,label1,label2,ro,ripple(1),CHTM(level+1));
clear sig1 sig2 carajo
[p_h,p_par]=ps_rip2(q,w);%Should always be bandpassed. Thus q. 

p_h=(p_h)-median(p_h);
p_par=(p_par)-median(p_par);

scatter(p_h,p_par,'filled','r');
hold on

ajalas=isoutlier(p_h);
ajalas=not(ajalas);
P_h=p_h(ajalas);
P_par=p_par(ajalas);

clear p_h p_par q


%GET NO Learning 1
if acer==0
cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
% cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))    
cd(strcat('D:\internship\',num2str(Rat)))
end
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
cd(nFF{1})
%[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    
[sig1,sig2,ripple,carajo,veamos,CHTM,~,~]=nrem_newest_only_ripple_level_backup(level,nrem,notch,w,lepoch);
[~,q_1,~,~,~,~]=getwin2(carajo{:,:,1},veamos{1},sig1,sig2,label1,label2,ro,ripple(1),CHTM(level+1));

clear sig1 sig2 carajo veamos
[p1_h,p1_par]=ps_rip2(q_1,w);%Should always be bandpassed. Thus q. 

p1_h=(p1_h)-median(p1_h);
p1_par=(p1_par)-median(p1_par);

scatter(p1_h,p1_par,'filled','b');
hold on

ajalas=isoutlier(p1_h);
ajalas=not(ajalas);
P1_h=p1_h(ajalas);
P1_par=p1_par(ajalas);

clear p1_h p1_par q_1




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
[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=nrem_newest_only_ripple_level_backup(level,nrem,notch,w,lepoch);

[~,q_2,~,~,~,~]=getwin2(carajo{:,:,1},veamos{1},sig1,sig2,label1,label2,ro,ripple(1),CHTM(level+1));

clear sig1 sig2 carajo veamos
[p2_h,p2_par]=ps_rip2(q_2,w);%Should always be bandpassed. Thus q. 

p2_h=(p2_h)-median(p2_h);
p2_par=(p2_par)-median(p2_par);

hold on
scatter(p2_h,p2_par,'filled','g');

ajalas=isoutlier(p2_h);
ajalas=not(ajalas);
P2_h=p2_h(ajalas);
P2_par=p2_par(ajalas);

clear p2_h p2_par q_2



h1=lsline;

L(:,:) = [h1(1).XData.' h1(1).YData.'];
plot(L(:,1),L(:,2),'r')

L(:,:) = [h1(2).XData.' h1(2).YData.'];
plot(L(:,1),L(:,2),'b')

L(:,:) = [h1(3).XData.' h1(3).YData.'];
plot(L(:,1),L(:,2),'g')

legend(labelconditions{iii},labelconditions{1},labelconditions{2})

%Slopes
ve1=(h1(1).YData(2)-h1(1).YData(1))/(h1(1).XData(2)-h1(1).XData(1));
ve1=num2str(ve1);

ve2=(h1(2).YData(2)-h1(2).YData(1))/(h1(2).XData(2)-h1(2).XData(1));
ve2=num2str(ve2);

ve3=(h1(3).YData(2)-h1(3).YData(1))/(h1(3).XData(2)-h1(3).XData(1));
ve3=num2str(ve3);

ve1=strcat(labelconditions{iii},{':  '},ve1);
ve2=strcat(labelconditions{1},{':  '},ve2);
ve3=strcat(labelconditions{2},{':  '},ve3);

txt1=[ve1;ve2;ve3];

dim = [.6 .5 .3 .22];
% str = strcat('Rate of occurence for',{' '},'Baseline 3',':',{' '},num2str(RipFreq2),{' '});
str=txt1;
annotation('textbox',dim,'String',str)
%End of slopes

set(gca,'Color','k')

xlabel('Hippocampal Power')
ylabel(strcat(label1{2*w-1},{' '},'Power'))
grid minor
 alpha(.5)

title('Bandpassed signals')


%%
string=strcat('Scatter_',label1{2*w-1},'_',num2str(level),'.png');

    cd(strcat('/home/raleman/Dropbox/New_Scatter3/',num2str(Rat)))
if exist(labelconditions{iii})~=7
(mkdir(labelconditions{iii}))
end
cd((labelconditions{iii}))

saveas(gcf,string)
string=strcat('Scatter_',label1{2*w-1},'_',num2str(level),'.fig');
saveas(gcf,string)

close all

%% WITHOUT OUTLIERS
% ajalas=isoutlier(p_h);
% ajalas=not(ajalas);
% P_h=p_h(ajalas);
% P_par=p_par(ajalas);


% ajalas=isoutlier(p1_h);
% ajalas=not(ajalas);
% P1_h=p1_h(ajalas);
% P1_par=p1_par(ajalas);

% ajalas=isoutlier(p2_h);
% ajalas=not(ajalas);
% P2_h=p2_h(ajalas);
% P2_par=p2_par(ajalas);

% ajalas=isoutlier(p3_h);
% ajalas=not(ajalas);
% P3_h=p3_h(ajalas);
% P3_par=p3_par(ajalas);
%% Median normalization 

P_h=(P_h)-median(P_h);
P1_h=(P1_h)-median(P1_h);
P2_h=(P2_h)-median(P2_h);
%P3_h=(P3_h)-median(P3_h);

P_par=(P_par)-median(P_par);
P1_par=(P1_par)-median(P1_par);
P2_par=(P2_par)-median(P2_par);
%P3_par=(P3_par)-median(P3_par);
%%
%%
 scatter(P_h,P_par,'filled','r');
%scatter(P_h,P_par,'r');

hold on
 scatter(P1_h,P1_par,'filled','b');
%scatter(P1_h,P1_par,'b');
% 
scatter(P2_h,P2_par,'filled','g');

%scatter(P2_h,P2_par,'g');

%% scatter(P3_h,P3_par,'filled','y');
%scatter(P3_h,P3_par,'y');

h1=lsline;

L(:,:) = [h1(1).XData.' h1(1).YData.'];
plot(L(:,1),L(:,2),'r')

L(:,:) = [h1(2).XData.' h1(2).YData.'];
plot(L(:,1),L(:,2),'b')

L(:,:) = [h1(3).XData.' h1(3).YData.'];
plot(L(:,1),L(:,2),'g')

legend(labelconditions{iii},labelconditions{1},labelconditions{2})

%Slopes
ve1=(h1(1).YData(2)-h1(1).YData(1))/(h1(1).XData(2)-h1(1).XData(1));
ve1=num2str(ve1);

ve2=(h1(2).YData(2)-h1(2).YData(1))/(h1(2).XData(2)-h1(2).XData(1));
ve2=num2str(ve2);

ve3=(h1(3).YData(2)-h1(3).YData(1))/(h1(3).XData(2)-h1(3).XData(1));
ve3=num2str(ve3);


ve1=strcat(labelconditions{iii},{':  '},ve1);
ve2=strcat(labelconditions{1},{':  '},ve2);
ve3=strcat(labelconditions{2},{':  '},ve3);

txt1=[ve1;ve2;ve3];

dim = [.6 .5 .3 .22];
% str = strcat('Rate of occurence for',{' '},'Baseline 3',':',{' '},num2str(RipFreq2),{' '});
str=txt1;
annotation('textbox',dim,'String',str)
%End of slopes

set(gca,'Color','k')

xlabel('Hippocampal Power')
ylabel(strcat(label1{2*w-1},{' '},'Power'))
grid minor
 alpha(.5)

title('Bandpassed signals')
%%
string=strcat('Scatter_No_Outlier_',label1{2*w-1},'_',num2str(level),'.png');

    cd(strcat('/home/raleman/Dropbox/New_Scatter3/',num2str(Rat)))
if exist(labelconditions{iii})~=7
(mkdir(labelconditions{iii}))
end
cd((labelconditions{iii}))

saveas(gcf,string)
string=strcat('Scatter_No_Outlier_',label1{2*w-1},'_',num2str(level),'.fig');
saveas(gcf,string)

close all




end

end


end
%%
end
%end
