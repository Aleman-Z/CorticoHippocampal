

function granger_paper(granger,granger1,condition)
allscreen()
 
F= [1 2; 1 3; 2 3] ;

lab=cell(6,1);

lab{1}='Hippo -> Parietal';
lab{2}='Parietal -> Hippo';

lab{3}='Hippo -> PFC';
lab{4}='PFC -> Hippo';

lab{5}='Parietal -> PFC';
lab{6}='PFC -> Parietal';

   
 for j=1:3
     
 f=F(j,:);
 mmax1=[max(squeeze(granger1.grangerspctrm(f(1),f(2),:))) max(squeeze(granger.grangerspctrm(f(1),f(2),:)))];
 mmax1=max(mmax1);

 mmax2=[max(squeeze(granger1.grangerspctrm(f(2),f(1),:))) max(squeeze(granger.grangerspctrm(f(2),f(1),:)))];
 mmax2=max(mmax2);
 mmax=max([mmax1 mmax2]);
%
 
 subplot(3,2,2*j-1)
 plot(granger1.freq, squeeze(granger1.grangerspctrm(f(1),f(2),:)),'Color',[1 0 0])
 hold on
 plot(granger.freq, squeeze(granger.grangerspctrm(f(1),f(2),:)),'Color',[0 0 1])
 xlim([0 300])
 ylim([0 mmax])
 
 grid minor
 xlabel('Frequency (Hz)')
 ylabel('G-causality')
 title(lab{2*j-1})
% legend('Parametric: AR(10)','Non-P:Multitaper')
 legend('Baseline',condition)

 subplot(3,2,2*j)
 plot(granger1.freq, squeeze(granger1.grangerspctrm(f(2),f(1),:)),'Color',[1 0 0])
 hold on
 plot(granger.freq, squeeze(granger.grangerspctrm(f(2),f(1),:)),'Color',[0 0 1])
 xlim([0 300])
 grid minor
 xlabel('Frequency (Hz)')
 ylabel('G-causality')
%legend('Parametric: AR(10)','Non-P:Multitaper')
 legend('Baseline',condition)
 
title(lab{2*j})
 ylim([0 mmax])
 
 end
 
end