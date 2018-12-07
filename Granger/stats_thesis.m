ord=10;
f=waitbar(0,'Please wait...');
for kk=1:length(q)
    
    progress_bar(kk,length(q),f)
%function [granger,granger1,granger_cond]=gc_paper(q,timecell,label,ro,ord,freqrange)
fn=1000;
%data1.trial=q{1};
data1.trial=q(kk);

data1.time= create_timecell(ro,1); %Might have to change this one 
data1.fsample=fn;
data1.label=cell(3,1);
data1.label{1}='Hippocampus';
data1.label{2}='Parietal';
data1.label{3}='PFC';
%data1.label{4}='Reference';

%Parametric model
 [granger1]=createauto(data1,ord); %this is the good one .
 GRGR_base{kk}=granger1.grangerspctrm;
 [granger]=createauto_np(data1,[0:2:300]);
 GRGRNP_base{kk}=granger.grangerspctrm;
end

%% COMPARE GRGR and GRGR_base
NU1=[];
NU2=[];

for j=1:length(GRGR);
nu1=GRGR{j};
nu1=squeeze(nu1(3,2,:));
nu2=GRGR_base{j};
nu2=squeeze(nu2(3,2,:));

NU1=[NU1 nu1];
NU2=[NU2 nu2];
end

%%
% NU2=NU2(:,1:667);

for j=1:size(NU1,1) % All frequencies. 

%Wilcoxon rank sum test
[p,h,~] = ranksum(detrend(NU1(j,:)),detrend(NU2(j,:)));
P(j)=p;
H(j)=h;

%kruskalwallis
pp = kruskalwallis([detrend(NU1(j,:)).' detrend(NU2(j,:)).' ],[],'off');
PP(j)=pp;

%kstest2
[h,p] = kstest2(detrend(NU1(j,:)),detrend(NU2(j,:)));
PPP(j)=p;
end
%%
%al=0.000000005;
al=0.05;

allscreen()
subplot(1,3,1)
stripes((P<al), 0.2, g1_f)
xlim([0 300])

subplot(1,3,2)
stripes((PP<al), 0.2, g1_f)
xlim([0 300])


subplot(1,3,3)
stripes((PPP<al), 0.2, g1_f)
xlim([0 300])
%% NON PARAMETRIC STATISTICS 
%% COMPARE GRGR and GRGR_base
NU1=[];
NU2=[];

for j=1:length(GRGRNP);
nu1=GRGRNP{j};
nu1=squeeze(nu1(2,1,:));
nu2=GRGRNP_base{j};
nu2=squeeze(nu2(2,1,:));

NU1=[NU1 nu1];
NU2=[NU2 nu2];
end

%%
% NU2=NU2(:,1:667);

for j=1:size(NU1,1) % All frequencies. 

%Wilcoxon rank sum test
[p,h,~] = ranksum(detrend(NU1(j,:)),detrend(NU2(j,:)));
P(j)=p;
H(j)=h;

%kruskalwallis
pp = kruskalwallis([detrend(NU1(j,:)).' detrend(NU2(j,:)).' ],[],'off');
PP(j)=pp;

%kstest2
[h,p] = kstest2(detrend(NU1(j,:)),detrend(NU2(j,:)));
PPP(j)=p;

[~,~,stats] = anova2([NU1(j,:).' NU2(j,:).' ],1,'off');
c = multcompare(stats,'Display','off');
PE(j)=c(end);


end

%%
figure()
plot(g_f,PE<0.05)

%%

%%
[~,~,stats] = anova2([(squeeze(g{1}(1,3,:))) (squeeze(g{4}(1,3,:))) ],151,'off')
c = multcompare(stats);
PE=c(end)

%%




%%
%al=0.000000005;
al=0.00005;

allscreen()
subplot(1,3,1)
stripes((P<al), 0.2, g1_f)
xlim([0 300])

subplot(1,3,2)
stripes((PP<al), 0.2, g1_f)
xlim([0 300])


subplot(1,3,3)
stripes((PPP<al), 0.2, g1_f)
xlim([0 300])





%%
al=0.00000000000001;


ey=(PP<al);


