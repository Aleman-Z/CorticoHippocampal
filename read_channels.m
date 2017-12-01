addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
addpath('/home/raleman/Documents/GitHub/CorticoHippocampal')
addpath('/home/raleman/Documents/internship')


nFF=[
   % {'rat26_Base_II_2016-03-24'                         }
   % {'rat26_Base_II_2016-03-24_09-47-13'                }
   % {'rat26_Base_II_2016-03-24_12-55-58'                }
   % {'rat26_Base_II_2016-03-24_12-57-57'                }
    
    {'rat26_nl_base_III_2016-03-30_10-32-57'            }
    {'rat26_nl_base_II_2016-03-28_10-40-19'             }
    {'rat26_nl_baseline2016-03-01_11-01-55'             }
    {'rat26_plusmaze_base_2016-03-08_10-24-41'}]
%%
for iii=1:length(nFF)
%for iii=4
    
cd('/home/raleman/Documents/internship/26')
cd(nFF{iii})
%
art=0;

%run('load_data.m')
run('new_load_data.m')

% Rearrange (clean)

%Make labels
label1=cell(7,1);
label1{1}='Hippocampus';
label1{2}='Hippocampus';
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

sig1=cell(7,1);

sig1{1}=Mono17;
sig1{2}=Bip17;
sig1{3}=Mono12;
sig1{4}=Bip12;
sig1{5}=Mono9;
sig1{6}=Bip9;
sig1{7}=Mono6;


sig2=cell(7,1);

sig2{1}=V17;
sig2{2}=S17;
sig2{3}=V12;
% sig2{4}=R12;
sig2{4}=S12;
%sig2{6}=SSS12;
sig2{5}=V9;
% sig2{7}=R9;
sig2{6}=S9;
%sig2{10}=SSS9;
sig2{7}=V6;
 
% ripple=length(M);
ripple=sum(s17);

ripple2=sum(s217);
%

% SWR from Bipolar Hippocampus
Num=500;
for i=1:length(sig2)
% % % % % % % % % % % %     allscreen()
% % % % % % % % % % % % [p3, p5,cellx,cellr]=generate(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i},Num);

% [p,q,timecell]=newgetwin(cellx,cellr,p3,Num);
% q=cut(q);
% p=cut(p);
% timecell=cut(timecell);
% gc(q,timecell,'Bandpassed',Num);

% % % % % % % % % % % % % mtit(strcat('Events:',num2str(ripple)),'fontsize',14,'color',[1 0 0],'position',[.5 0.8 ])
% % % % % % % % % % % % % labelthr=strcat('Thr:',num2str(thr));
% % % % % % % % % % % % % mtit(strcat(' (',labelthr,')'),'fontsize',14,'color',[1 0 0],'position',[.5 0.9 ])


% error('stop')
%cd NewFolderSinFiltro
%cd More_Ripples
%cd Spectrograms_Threshold_45
%cd borrame
%cd hola
%cd RED

% % % % % % % % % % % % % % % % string=strcat('OPT',num2str(Num),'_WAV_thr_Hipp_bipolar',num2str(thr),label1{i},label2{i},'.png');
% % % % % % % % % % % % % % % % saveas(gcf,string)

%cd ..     
% [D1, D2, D3, D4,D5 ]=deco(p3,p5);
% plotwave(D1, D2, D3, D4,D5)
% mtit(strcat(label1{i},' (',label2{i},')'),'fontsize',14,'color',[1 0 0],'position',[.5 1 ])
% cd WaveDec
% string=strcat('200_WD_',label1{i},label2{i},'.png');
% saveas(gcf,string)
% cd ..     
% % % % % % % 
allscreen()
[p3, p5]=generate(carajo2,veamos2, sig1{i},sig2{i},label1{i},label2{i},Num);
mtit(strcat('Events:',num2str(ripple2)),'fontsize',14,'color',[1 0 0],'position',[.5 0.8 ])
labelthr=strcat('Thr:',num2str(thr));
mtit(strcat(' (',labelthr,')'),'fontsize',14,'color',[1 0 0],'position',[.5 0.9 ])
% % % % % % % % % % % 
% % % % % % % % % % % cd hola
% % % % % % % % % % % 
string=strcat(num2str(Num),'POT_WAV_thr_Hipp_monopolar',num2str(thr),label1{i},label2{i},'.png');
saveas(gcf,string)
% % % % cd ..     


end
close all
end

%%
cd('/home/raleman/Documents/internship/26')
addpath /home/raleman/Documents/internship/fieldtrip-master/
InitFieldtrip()

cd('/home/raleman/Documents/internship/26')
% iii=1
% cd(nFF{iii})

%%
for iii=1:length(nFF)
%for iii=4
    
cd('/home/raleman/Documents/internship/26')
cd(nFF{iii})

 % Monopolar signals only
%Ro=[200 500];
Ro=[500];
for i=1:length(Ro)
%i=1;
  ro=Ro(i);  
  allscreen()
  %[p,q,timecell,cfs,f]=getwin(carajo,veamos,sig1,sig2,label1,label2,ro);
  [p,q,timecell,cfs,f]=getwin(carajo,veamos,sig1,sig2,label1,label2,ro,ripple,thr);

  close all
   q=cut(q);
   p=cut(p);
  timecell=cut(timecell);
%   [Fxy3, Fyx3]=BS(p,q);
%   BS_thr(Fxy3,Fyx3,0.1);
  

  
  %autotest(q,timecell,'Bandpassed',ro)
  
   gc(q,timecell,'Bandpassed',ro)
   
 string=strcat(num2str(ro),'_GC_','Monopolar','Bandpassed','.png');
%cd Nuevo
%cd Spectrograms_Threshold_45
%cd testGC
% cd ARorder

fig=gcf;
fig.InvertHardcopy='off';
saveas(gcf,string)
%cd ..  
 close all
 
 %autotest(p,timecell,'Widepassed',ro)
 gc(p,timecell,'Widepass',ro)

string=strcat(num2str(ro),'_GC_','Monopolar','Widepass','.png');
%cd Nuevo
%cd Spectrograms_Threshold_45
%cd testGC
%cd ARorder
fig=gcf;
fig.InvertHardcopy='off';

saveas(gcf,string)
%cd ..  
 close all
 
end
end
