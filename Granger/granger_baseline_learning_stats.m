

function granger_baseline_learning_stats(g,g_f,labelconditions,freqrange,GRGRNP,GRGRNP_base,AL)
allscreen()
 
F= [1 2; 1 3; 2 3] ;

lab=cell(6,1);

lab{1}='HPC -> PAR';
lab{2}='PAR -> HPC';

lab{3}='HPC -> PFC';
lab{4}='PFC -> HPC';

lab{5}='PAR -> PFC';
lab{6}='PFC -> PAR';
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
NU1=[];
NU2=[];

for jj=1:length(GRGRNP);
nu1=GRGRNP{jj};
nu1=squeeze(nu1(f(1),f(2),:));
nu2=GRGRNP_base{jj};
nu2=squeeze(nu2(f(1),f(2),:));

NU1=[NU1 nu1];
NU2=[NU2 nu2];
end

for jj=1:size(NU1,1) % All frequencies. 

%Wilcoxon rank sum test
[p,h,~] = ranksum(detrend(NU1(jj,:)),detrend(NU2(jj,:)));
P(jj)=p;
H(jj)=h;

%kruskalwallis
pp = kruskalwallis([detrend(NU1(jj,:)).' detrend(NU2(jj,:)).' ],[],'off');
PP(jj)=pp;

%kstest2
[h,p] = kstest2(detrend(NU1(jj,:)),detrend(NU2(jj,:)));
PPP(jj)=p;

[~,~,stats] = anova2([NU1(jj,:).' NU2(jj,:).' ],1,'off');
c = multcompare(stats,'Display','off');
PE(jj)=c(end);


end






 subplot(3,2,2*j-1)
%  plot(granger1.freq, squeeze(granger1.grangerspctrm(f(1),f(2),:)),'Color',[1 0 0])
% hold on
 plot(g_f, squeeze(g{1}(f(1),f(2),:)),'LineWidth',2,'Color',[0.5 0.5 0.5])
 hold on
 %plot(g_f, squeeze(g{2}(f(1),f(2),:)),'LineWidth',2)
 %plot(g_f, squeeze(g{3}(f(1),f(2),:)),'LineWidth',2)
 plot(g_f, squeeze(g{4}(f(1),f(2),:)),'LineWidth',2,'Color',[0 0 0])
 
 area(g_f,PP<AL)
alpha(0.2)
 
 xlim(freqrange)
 ylim([0 mmax])
 
 %grid minor
 xlabel('Frequency (Hz)')
 ylabel('G-causality')
 title(lab{2*j-1})
% legend('Parametric: AR(10)','Non-P:Multitaper')
%if j==1
% legend(labelconditions)
%end
NU1=[];
NU2=[];

for jj=1:length(GRGRNP);
nu1=GRGRNP{jj};
nu1=squeeze(nu1(f(2),f(1),:));
nu2=GRGRNP_base{jj};
nu2=squeeze(nu2(f(2),f(1),:));

NU1=[NU1 nu1];
NU2=[NU2 nu2];
end

for jj=1:size(NU1,1) % All frequencies. 

%Wilcoxon rank sum test
[p,h,~] = ranksum(detrend(NU1(jj,:)),detrend(NU2(jj,:)));
P(jj)=p;
H(jj)=h;

%kruskalwallis
pp = kruskalwallis([detrend(NU1(jj,:)).' detrend(NU2(jj,:)).' ],[],'off');
PP(jj)=pp;

%kstest2
[h,p] = kstest2(detrend(NU1(jj,:)),detrend(NU2(jj,:)));
PPP(jj)=p;

[~,~,stats] = anova2([NU1(jj,:).' NU2(jj,:).' ],1,'off');
c = multcompare(stats,'Display','off');
PE(jj)=c(end);


end
 













subplot(3,2,2*j)
%  plot(granger1.freq, squeeze(granger1.grangerspctrm(f(2),f(1),:)),'Color',[1 0 0])
%  hold on
 plot(g_f, squeeze(g{1}(f(2),f(1),:)),'LineWidth',2,'Color',[0.5 0.5 0.5])
 hold on
 %plot(g_f, squeeze(g{2}(f(2),f(1),:)),'LineWidth',2)
 %plot(g_f, squeeze(g{3}(f(2),f(1),:)),'LineWidth',2)
 plot(g_f, squeeze(g{4}(f(2),f(1),:)),'LineWidth',2,'Color',[0 0 0])

 
 area(g_f,PP<AL)
alpha(0.2)
 
 xlim(freqrange)
 %grid minor
 xlabel('Frequency (Hz)')
 ylabel('G-causality')
%legend('Parametric: AR(10)','Non-P:Multitaper')
if j==1
labcon=[labelconditions(1);labelconditions(4)]    
labcon=['Control';labelconditions(4)]
legend(labcon,'Location','best') %Might have to change to default. 
end
title(lab{2*j})
 ylim([0 mmax])
 
 end
 
end