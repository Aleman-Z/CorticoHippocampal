

function granger_paper4_stripes(g,g_f,labelconditions,freqrange)
allscreen()
 
F= [1 2; 1 3; 2 3] ;

lab=cell(6,1);

lab{1}='HPC -> Parietal';
lab{2}='Parietal -> HPC';

lab{3}='HPC -> PFC';
lab{4}='PFC -> HPC';

lab{5}='Parietal -> PFC';
lab{6}='PFC -> Parietal';
% 
%  k=1; %Condition 1.  
 for j=1:3
     
 f=F(j,:);

 mmax1=max([max(squeeze(g{1}(f(1),f(2),:))) max(squeeze(g{2}(f(1),f(2),:))) ...
     max(squeeze(g{3}(f(1),f(2),:))) max(squeeze(g{4}(f(1),f(2),:)))]);

 mmax2=max([max(squeeze(g{1}(f(2),f(1),:))) max(squeeze(g{2}(f(2),f(1),:))) ...
     max(squeeze(g{3}(f(2),f(1),:))) max(squeeze(g{4}(f(2),f(1),:)))]);
 
 mmax=max([mmax1 mmax2]);
%

 subplot(3,2,2*j-1)
%  plot(granger1.freq, squeeze(granger1.grangerspctrm(f(1),f(2),:)),'Color',[1 0 0])
% hold on
 plot(g_f, squeeze(g{1}(f(1),f(2),:)),'LineWidth',2)
 hold on
 plot(g_f, squeeze(g{2}(f(1),f(2),:)),'LineWidth',2)
 plot(g_f, squeeze(g{3}(f(1),f(2),:)),'LineWidth',2)
 plot(g_f, squeeze(g{4}(f(1),f(2),:)),'LineWidth',2)
 
 xlim(freqrange)
 ylim([0 mmax])
 
 grid minor
 xlabel('Frequency (Hz)')
 ylabel('G-causality')
 title(lab{2*j-1})
% legend('Parametric: AR(10)','Non-P:Multitaper')
%if j==1
% legend(labelconditions)
%end
 subplot(3,2,2*j)
%  plot(granger1.freq, squeeze(granger1.grangerspctrm(f(2),f(1),:)),'Color',[1 0 0])
%  hold on
 plot(g_f, squeeze(g{1}(f(2),f(1),:)),'LineWidth',2)
 hold on
 plot(g_f, squeeze(g{2}(f(2),f(1),:)),'LineWidth',2)
 plot(g_f, squeeze(g{3}(f(2),f(1),:)),'LineWidth',2)
 plot(g_f, squeeze(g{4}(f(2),f(1),:)),'LineWidth',2)

 
 xlim(freqrange)
 grid minor
 xlabel('Frequency (Hz)')
 ylabel('G-causality')
%legend('Parametric: AR(10)','Non-P:Multitaper')
if j==1
legend(labelconditions,'Location','best') %Might have to change to default. 
end
title(lab{2*j})
 ylim([0 mmax])
 
 end
 
end