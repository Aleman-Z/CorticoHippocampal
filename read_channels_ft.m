addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
addpath('/home/raleman/Documents/GitHub/CorticoHippocampal')
addpath('/home/raleman/Documents/internship')


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

labelconditions=[
    {'PlusMaze'}
     'Novelty_1'
     'Novelty 2'
     'Foraging 1'
     'Foraging 2'
    ];
%%
cd('/home/raleman/Documents/internship/26')
addpath /home/raleman/Documents/internship/fieldtrip-master/
InitFieldtrip()

cd('/home/raleman/Documents/internship/26')
%% Select experiment to perform. 
inter=0;
granger=0;
%
for iii=3:length(nFF)
%for iii=1:1
    
 clearvars -except nFF iii labelconditions inter granger 
%for iii=1:4

cd('/home/raleman/Documents/internship/26')
cd(nFF{iii})

art=0;

Ro=[1200];
ro=Ro;

%run('load_data.m')
%run('new_load_data.m')
% error('stop')
if ro==1200 && inter==0 || granger==1
run('newest_load_data.m')
else
run('newest_load_data_only_ripple.m')
end
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

%Number of ripples per threshold.
ripple=sum(s17);
% ripple2=sum(s217);


 % Monopolar signals only
%Ro=[200 500];

%for i=1:length(Ro)
%i=1;
    
 %for level=1:length(ripple);
 for level=1:length(ripple)-1;
   
%   allscreen()
  %[p,q,timecell,cfs,f]=getwin(carajo,veamos,sig1,sig2,label1,label2,ro);
  %Get p and q.
  %Get averaged time signal. 
[p,q,timecell,Q,~,~]=getwin2(carajo{:,:,level},veamos{level},sig1,sig2,label1,label2,ro,ripple(level),thr(level+1));
% SUS=SU(:,level).';

if ro==1200 && inter==0 || granger==1
SUS=SU{level}.';
% SUS2=SU2(:,level).';
SUS2=SU2{level}.';
%SUQ2=SUQ(:,level).';
SUQ2=SUQ{level}.';

SUStimecell=timecell(1:length(SUS));
SUS2timecell=timecell(1:length(SUS2));
SUQ2timecell=timecell(1:length(SUQ2));

P1_SUS=avg_samples(SUS,SUStimecell);
P2_SUS=avg_samples(SUS2,SUS2timecell);

end
%p is wideband signal. 
%q is bandpassed signal. 
%timecell are the time labels. 
%Q is the envelope of the Bandpassed signal.  

% [p2,q2,timecell2,Q2,~,~]=getwin2(carajo2{:,:,level},veamos2{level},sig1,sig2,label1,label2,ro,ripple2(level),thr2(level+1));

%close all
%P1 bandpassed
%P2 widepassdw
% error('stop here please')

%Finding .mat files 
Files=dir(fullfile(cd,'*.mat'));

if ro==1200 
    if sum(strcmp({Files.name}, strcat('randnum2_',num2str(level),'.mat')))
      load(strcat('randnum2_',num2str(level),'.mat'))
    else

      ran=randi(length(p),100,1);
      save(strcat('randnum2_',num2str(level)),'ran')

    end

else
     if sum(strcmp({Files.name}, strcat('randnum17_',num2str(level),'.mat')))
      load(strcat('randnum17_',num2str(level),'.mat'))
    else

      ran=randi(length(p),100,1);
      save(strcat('randnum17_',num2str(level)),'ran')

    end
    
end


% 
% ran=randi(length(p),100,1);
%load(strcat('randnum2_',num2str(level),'.mat'))
p=p([ran]);
q=q([ran]);
Q=Q([ran]);
timecell=timecell([ran]);
 
% p2=p2([ran]);
% q2=q2([ran]);
% Q2=Q2([ran]);
% timecell2=timecell2([ran]);

% p=p(1:100);
% q=q(1:100);
% Q=Q(1:100);
% timecell=timecell(1:100);

P1=avg_samples(q,timecell);
P2=avg_samples(p,timecell);

% SUStimecell=timecell(1:length(SUS));
% SUS2timecell=timecell(1:length(SUS2));
% SUQ2timecell=timecell(1:length(SUQ2));
% 
% P1_SUS=avg_samples(SUS,SUStimecell);
% P2_SUS=avg_samples(SUS2,SUS2timecell);

% P12=avg_samples(q2,timecell2);
% P22=avg_samples(p2,timecell2);

% save(strcat('randnum2_',num2str(level)),'ran')

%for w=1:size(P2,1)-1
for w=1:size(P2,1)
% %     error('stop here')
% run('plot_no_ripples.m')
% string=strcat('NEW_SPEC_',label1{2*w-1},'_','NORIP',num2str(level),'.png');
% %saveas(gcf,string)
% close all
% 
% baseline1=[-1, -0.8];
% baseline2=[0.8, 1];
% 
% run('plot_ripples.m')
% 
% string=strcat('NEW_SPEC_',label1{2*w-1},'_',num2str(level),'.png');
% %saveas(gcf,string)

%     error('stop here')

% error('stop here')
%%

if iii>=4 && inter==1
run('plot_inter_conditions.m')
string=strcat('NEW2_inter_conditions_',label1{2*w-1},'_',num2str(level),'.png');
saveas(gcf,string)
end

if ro==1700
run('plot_pre_post.m')
string=strcat('NEW2_pre_post_',label1{2*w-1},'_',num2str(level),'.png');
saveas(gcf,string)
end

if ro==1200 && inter==0 && granger==0
run('plot_both.m')
% string=strcat('NEW2_between_',label1{2*w-1},'_',num2str(level),'.png');
 string=strcat('NEW2_NoRip_',label1{2*w-1},'_',num2str(level),'.png');
 saveas(gcf,string)
end

close all

if w==1 && granger==1
% allscreen()    
% [granger]=barplot_GC(cut(q),cut(timecell),[100:20:300])
% title(strcat('Time-Frequency Granger Causality (Bandpassed: 100-300 Hz)',' THR:',num2str(thr(level))))
% 
% string=strcat('TFGC_','Bandpass_',num2str(level),'.png');
% saveas(gcf,string)
% close all


allscreen()    
[coh]=barplot_COH(q,timecell,[100:2:300])
title('Time-Frequency Coherence (Bandpassed: 100-300 Hz)')
string=strcat('NEW_TFCOH_','Bandpass_Ripple_',num2str(level),'.png');
saveas(gcf,string)
close all

allscreen()    
[coh]=barplot_COH(SUS,SUStimecell,[100:2:300])
title('Time-Frequency Coherence (Bandpassed: 100-300 Hz)')
string=strcat('NEW_TFCOH_','Bandpass_NoRipple_',num2str(level),'.png');
saveas(gcf,string)
close all

% allscreen()
% [granger]=barplot_GC(cut(p),cut(timecell),[2:2:30])
% title('Time-Frequency Granger Causality (Wideband)')
% string=strcat('TFGC_','Wideband_',num2str(level),'.png');
% saveas(gcf,string)
% close all

allscreen()
[coh]=barplot_COH(p,timecell,[1:1:30])
title('Time-Frequency Coherence (Wideband)')
string=strcat('NEW_TFCOH_','Wideband_Ripple_',num2str(level),'.png');
saveas(gcf,string)
close all


allscreen()
[coh]=barplot_COH(SUS2,SUS2timecell,[1:1:30])
title('Time-Frequency Coherence (Wideband)')
string=strcat('NEW_TFCOH_','Wideband_NoRipple_',num2str(level),'.png');
saveas(gcf,string)
close all


%allscreen()
gc(Q,timecell,'Envelope',ro)
string=strcat('NEW_GC_','Envelope_Ripples_',num2str(level),'.png');
saveas(gcf,string)
close all

%Here onwards (2)

%allscreen()
gc(SUQ2,SUQ2timecell,'Envelope',ro)
string=strcat('NEW_GC_','Envelope_NoRipples_',num2str(level),'.png');
saveas(gcf,string)
close all


%allscreen()
gc(p,timecell,'Widepass',ro)
string=strcat('NEW_GC_','Widepass_Ripples_',num2str(level),'.png');
saveas(gcf,string)
close all

%allscreen()
gc(SUS2,SUS2timecell,'Widepass',ro)
string=strcat('NEW_GC_','Widepass_No_Ripples_',num2str(level),'.png');
saveas(gcf,string)
close all


%allscreen()
gc(q,timecell,'Bandpassed',ro)
string=strcat('NEW_GC_','Bandpassed_Ripples_',num2str(level),'.png');
saveas(gcf,string)
close all

%allscreen()
gc(SUS,SUStimecell,'Bandpassed',ro)
string=strcat('NEW_GC_','Bandpassed_NoRipples_',num2str(level),'.png');
saveas(gcf,string)
close all

w=size(P2,1);
end


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
