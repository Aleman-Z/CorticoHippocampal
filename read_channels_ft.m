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
cd('/home/raleman/Documents/internship/26')
addpath /home/raleman/Documents/internship/fieldtrip-master/
InitFieldtrip()

cd('/home/raleman/Documents/internship/26')

%%
for iii=1:length(nFF)
%for iii=4
    
cd('/home/raleman/Documents/internship/26')
cd(nFF{iii})

art=0;

%run('load_data.m')
%run('new_load_data.m')
run('newest_load_data.m')

% Rearrange (clean)

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

%%ripple2=sum(s217);

%

 % Monopolar signals only
%Ro=[200 500];
Ro=[1000];

%for i=1:length(Ro)
%i=1;
  ro=Ro;  
 for level=1:length(ripple);
  
  %error('Stop here')
%   allscreen()
  %[p,q,timecell,cfs,f]=getwin(carajo,veamos,sig1,sig2,label1,label2,ro);
  %Get me p and q.
  %Get me averaged time signal. 
[p,q,timecell,Q,~,~]=getwin2(carajo{:,:,level},veamos{level},sig1,sig2,label1,label2,ro,ripple(level),thr(level+1));
%close all
%P1 bandpassed
%P2 widepassdw
%
ran=randi(length(p),100,1);
p=p([ran]);
q=q([ran]);
timecell=timecell([ran]);
P1=avg_samples(q,timecell)
P2=avg_samples(p,timecell)
save(strcat('randnum_',num2str(level)),'ran')

for w=1:size(P2,1)
allscreen()
subplot(3,2,1)
plot(timecell{1},P2(w,:))
xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('Wide Band Event-triggered Average')

subplot(3,2,2)
plot(timecell{1},P1(w,:))
xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('High Gamma power Event-triggered Average')

subplot(3,2,3)
freq=barplot2_ft(p,timecell,[0:.1:30],w)
title('Spectrogram Widepass (High temporal resolution)')

% 
% subplot(3,2,5)
% %freq=barplot3_ft(p,timecell,[0:.1:30],w)
% [stats]=stats_freq(freq,label1{2*w-1},[-0.8, -0.6]);
% grid minor

subplot(3,2,4)
freq=barplot2_ft(q,timecell,[100:1:300],w)
title('Spectrogram Bandpass (High temporal resolution)')

% subplot(3,2,6)
% %freq=barplot3_ft(q,timecell,[100:1:300],w)
% [stats]=stats_freq(freq,label1{2*w-1},[-0.8, -0.6]);
% grid minor
% title('Spectrogram Bandpass (High frequency resolution)')
baseline=[-0.8, -0.6];

subplot(3,2,5)
freq=barplot3_ft(p,timecell,[0:.1:30],w)
[stats]=stats_freq(freq,label1{2*w-1},baseline);
grid minor
%title('Spectrogram Widepass (High frequency resolution)')
title(strcat('Statistical Test with Baseline:', num2str(baseline(1)),' to ',num2str(baseline(2))))

subplot(3,2,6)
freq=barplot3_ft(q,timecell,[100:1:300],w)
[stats]=stats_freq(freq,label1{2*w-1},baseline);
grid minor
%title('Spectrogram Bandpass (High frequency resolution)')
title(strcat('Statistical Test with Baseline: [', num2str(baseline(1)),': ',num2str(baseline(2)),']'))


figure()
baseline=[0.6, 0.8];

subplot(3,2,5)
freq=barplot3_ft(p,timecell,[0:.1:30],w)
[stats]=stats_freq(freq,label1{2*w-1},baseline);
grid minor
%title('Spectrogram Widepass (High frequency resolution)')
title(strcat('Statistical Test with Baseline:', num2str(baseline(1)),' to ',num2str(baseline(2))))

subplot(3,2,6)
freq=barplot3_ft(q,timecell,[100:1:300],w)
[stats]=stats_freq(freq,label1{2*w-1},baseline);
grid minor
%title('Spectrogram Bandpass (High frequency resolution)')
title(strcat('Statistical Test with Baseline: [', num2str(baseline(1)),': ',num2str(baseline(2)),']'))


mtit(strcat('Events:',num2str(ripple(level))),'fontsize',14,'color',[1 0 0],'position',[.5 0.8 ])
labelthr=strcat('Thr:',num2str(round(thr(level+1))));
mtit(strcat(labelthr),'fontsize',14,'color',[1 0 0],'position',[.5 0.9 ])

mtit(strcat(label1{2*w-1},' (',label2{1},')'),'fontsize',14,'color',[1 0 0],'position',[.5 1 ])

string=strcat('SPEC_',label1{2*w-1},'_',num2str(level),'.png');

 % % % % % % % % % fig=gcf;
% % % % % % % % % fig.InvertHardcopy='off';
saveas(gcf,string)


close all
end
%
% chanindx = find(strcmp(freq.label, 'Hippo'));
% figure; imagesc(squeeze(freq.powspctrm(1,chanindx,:,:)));
%

%figure; 

%
% subplot(3,2,4)
% barplot2_ft(q,timecell,[100:1:300],w)


%
% barplot2_ft(q,timecell,[0:.1:30],2)
% figure()
% barplot2_ft(Q,timecell,[0:.01:30],'REF')
% barplot2_ft(Q,timecell,[1:.1:30],'PFC')


%error('stop')
  
  
% % % % % % % % % % % % % % % % % % % % % % % % % CHECALE BIEN  
% % % % % % % % % % % % % % % % % % % % % % % % % %   new_index=1;
% % % % % % % % % % % % % % % % % % % % % % % % % % [TI,TN, cellx,cellr,to,tu]=win(carajo{:,:,level},veamos{level},sig1{new_index},sig2{new_index},ro);
% % % % % % % % % % % % % % % % % % % % % % % % % % [z1,z4]=clean(cellx,cellr);
% % % % % % % % % % % % % % % % % % % % % % % % % % [p3 ,p4]=eta2(z1,z4,ro,1000);

%

% 
% 
% new_index=3;
% [TI,TN, cellx,cellr,to,tu]=win(carajo{:,:,level},veamos{level},sig1{new_index},sig2{new_index},ro);
% [z2,z5]=clean(cellx,cellr);
% [p3 ,p4]=eta2(z2,z5,ro,1000);
% 
% new_index=5;
% [TI,TN, cellx,cellr,to,tu]=win(carajo{:,:,level},veamos{level},sig1{new_index},sig2{new_index},ro);
% [z3,z6]=clean(cellx,cellr);
% [p3 ,p4]=eta2(z3,z6,ro,1000);
% 
% new_index=7;
% [TI,TN, cellx,cellr,to,tu]=win(carajo{:,:,level},veamos{level},sig1{new_index},sig2{new_index},ro);
% [z7,z8]=clean(cellx,cellr);
% [p3 ,p4]=eta2(z7,z8,ro,1000);

%
  
%Use p and q and Q for Granger.
  
% % % % % % % % % % % % % % % % % % % % % % CHECALE BIEN P'AL GRANGER  
% % % % % % % % % % % % % % % % % % % % % %   close all
% % % % % % % % % % % % % % % % % % % % % %    q=cut(q);
% % % % % % % % % % % % % % % % % % % % % %    p=cut(p);
% % % % % % % % % % % % % % % % % % % % % %    %Q=cut(Q);
% % % % % % % % % % % % % % % % % % % % % %    Q=cut(Q);
% % % % % % % % % % % % % % % % % % % % % %   timecell=cut(timecell);
% % % % % % % % % % % % % % % % % % % % % %   


  
%   [Fxy3, Fyx3]=BS(p,q);
%   BS_thr(Fxy3,Fyx3,0.1);
  

  
  %autotest(q,timecell,'Bandpassed',ro)

 %%% CHECALE BIEN 
% % % % % % % % % % % % % % % % % % %  gc(q,timecell,'Bandpassed',ro)
% % % % % % % % % % % % % % % % % % %    
% % % % % % % % % % % % % % % % % % %  string=strcat(num2str(ro),'_GC_','Monopolar','Bandpassed','.png');

 
 
 %cd Nuevo
%cd Spectrograms_Threshold_45
%cd testGC
% cd ARorder

% % % % % % % % % CHECALE
% % % % % % % % % fig=gcf;
% % % % % % % % % fig.InvertHardcopy='off';
% % % % % % % % % saveas(gcf,string)
% % % % % % % % % %cd ..  
% % % % % % % % %  close all
 
 %autotest(p,timecell,'Widepassed',ro)

 %CHECALE
% % % % % % % % % % % % % % % % % % %  gc(p,timecell,'Widepass',ro)
% % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % string=strcat(num2str(ro),'_GC_','Monopolar','Widepass','.png');

%cd Nuevo
%cd Spectrograms_Threshold_45
%cd testGC
%cd ARorder

%%%%%%%%%%%%%%%%%CHECALE
% % % % % % % % % % % % % % % % fig=gcf;
% % % % % % % % % % % % % % % % fig.InvertHardcopy='off';
% % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % saveas(gcf,string)
% % % % % % % % % % % % % % % % %cd ..  
% % % % % % % % % % % % % % % %  close all
% % % % % % % % % % % % % % % %  % Envelope 
% % % % % % % % % % % % % % % %  gc(Q,timecell,'Envelope',ro)
% % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % string=strcat(num2str(ro),'_GC_','Monopolar','Envelope','.png');
% % % % % % % % % % % % % % % % %cd Nuevo
% % % % % % % % % % % % % % % % %cd Spectrograms_Threshold_45
% % % % % % % % % % % % % % % % %cd testGC
% % % % % % % % % % % % % % % % %cd ARorder
% % % % % % % % % % % % % % % % fig=gcf;
% % % % % % % % % % % % % % % % fig.InvertHardcopy='off';
% % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % saveas(gcf,string)
% % % % % % % % % % % % % % % % %cd ..  
% % % % % % % % % % % % % % % %  close all
 
 
%  T = cell2mat(q); 
% [F]=mvgc_adapted(T,fn);
% allscreen()
% plot_granger(F,fn)
% mtit('Monopolar','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
% mtit('Bandpassed','fontsize',14,'color',[1 0 0],'position',[.5 0.75 ])
% mtit(strcat('(+/-',num2str(ro),'ms)'),'fontsize',14,'color',[1 0 0],'position',[.5 0.5 ])
% 
% 
%  T = cell2mat(p); 
% [F]=mvgc_adapted(T,fn);
% allscreen()
% plot_granger(F,fn)
% mtit('Monopolar','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
% mtit('Wideband','fontsize',14,'color',[1 0 0],'position',[.5 0.75 ])
% mtit(strcat('(+/-',num2str(ro),'ms)'),'fontsize',14,'color',[1 0 0],'position',[.5 0.5 ])
% 
%  T = cell2mat(Q); 
% [F]=mvgc_adapted(T,fn);
% allscreen()
% plot_granger(F,fn)
% mtit('Monopolar','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
% mtit('Envelope','fontsize',14,'color',[1 0 0],'position',[.5 0.75 ])
% mtit(strcat('(+/-',num2str(ro),'ms)'),'fontsize',14,'color',[1 0 0],'position',[.5 0.5 ])

end
end
