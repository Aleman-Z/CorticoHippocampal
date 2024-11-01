% Equalize number of epochs. 
if Rat==26
PXX{1}=PXX{1}(:,1:2063);
end

if Rat==27
PXX{2}=PXX{2}(:,1:2623);
end

%%
go=30
semilogy(f,PX{1},'Color',myColorMap(1,:),'LineWidth',2); 

hold on
semilogy(f,PX{2},'Color',myColorMap(2,:),'LineWidth',2); 
xlim([0 go])
xlabel('Frequency (Hz)')
%ylabel('10 Log(x)')
ylabel('Power')
title(strcat('Power in NREM',{' '} ,label1{2*w-1} ,{' '},'signals'))

%%
%al=0.000000000001;
%al=0.000000000000001;
al=0.00000000000001;


ey=(PP<al);
ey=ey*1000;

ey(find(ey==0))=.000000002;
% ey(find(ey==1))=100;
% ey(find(ey==0))=2;
%ey(ey==0)=10e-5;

% ey(ey==0)=10e-5;
% ey(ey==0)=0.01;

hold on
rrc=area(f,ey*1000,'FaceColor','none');
set(rrc, 'FaceColor', 'r');
alpha(0.15)
xlim([0 go])


%plot(ey)
set(gca,'yscale','log')
%ylim([10e-3 10e3])

%ylim([10e-4 10e2])
ylim([10e-1 10e2])

legend('Control','PlusMaze')

%%
patch([100 200 200 100], [10e-5 10e-5 10e5 10e5], 'red');
alpha(0.2)

%%
ey(ey==1)=1000000000000000;
ey(ey==0)=1;



%set(gca,'YScale','log')

%%
EY=ey;
EY(EY==0)=10;
fill([f.' fliplr(f).'],[EY*1000  EY*109999],'r')
set(gca,'YScale','log')
%%
fill([x,fliplr(x)],[y1,fliplr(y2)],'r')
%%
%set (gca, 'Yscale', 'log');
% Tresholding p
%%
ey=(PP<al);
% ey(ey==0)=10e-5;
hold on
rrc=area(f,log10(ey*1000),'FaceColor','none');
set(rrc, 'FaceColor', 'r');
alpha(0.2)
xlim([0 go])


%%
go=300
plot(f,PX{1},'Color',myColorMap(1,:),'LineWidth',2); 

hold on
plot(f,PX{2},'Color',myColorMap(2,:),'LineWidth',2); 
xlim([0 go])


%%

for j=1:1025 % All frequencies. 

%Wilcoxon rank sum test
[p,h,~] = ranksum((PXX{1}(j,:)),(PXX{2}(j,:)));
P(j)=p;
H(j)=h;

%kruskalwallis
pp = kruskalwallis([PXX{1}(j,:).' PXX{2}(j,:).' ],[],'off');
PP(j)=pp;

%kstest2
[h,p] = kstest2(PXX{1}(j,:),PXX{2}(j,:));
PPP(j)=p;
end

%%
al=0.05;

plot(f,(P<al))
xlim([0 300])

figure()
plot(f,(PP<al))
xlim([0 300])

figure()
plot(f,(PPP<al))
xlim([0 300])
%%
al=0.001;

allscreen()
subplot(1,2,1)
stripes((P<al), 0.2, f)
xlim([0 300])

subplot(1,2,2)
stripes((PP<al), 0.2, f)
xlim([0 300])

%%
figure()
%al=0.00000000001;
%al=0.000000000001;
al=0.000000000001;


% subplot(1,3,3)
stripes((PP<al), 0.2, f)
xlim([0 300])
%% With detrend

%%

%for j=1:1025 % All frequencies. 
for j=1:size(PXX{1},1) % All frequencies. 

%Wilcoxon rank sum test
[p,h,~] = ranksum(detrend(PXX{1}(j,:)),detrend(PXX{2}(j,:)));
P(j)=p;
H(j)=h;

%kruskalwallis
pp = kruskalwallis([detrend(PXX{1}(j,:).') detrend(PXX{2}(j,:).') ],[],'off');
PP(j)=pp;

%kstest2
%[h,p] = kstest2(detrend(PXX{1}(j,:)),detrend(PXX{2}(j,:))); %Not the right method. 
[h,p] = vartest2(detrend(PXX{1}(j,:)),detrend(PXX{2}(j,:))); %Not the right method. 


PPP(j)=p;
end




%%
%%detrend
%%
figure()
stripes(h,0.2,f)
xlim([0 go])


%%
boxplotnout(PXX{2}(:,1:100).'-PXX{1}(:,1:100).')
%%

stripes((PP<0.05),0.2,f); xlim([0 300])
%%
stripes((PPP<0.05),0.2,f); xlim([0 300])

%%
figure()
stripes((P<0.05),0.2,f); xlim([0 300])
%%



%%
figure()
% [h,p,ci,stats] = ttest2(detrend(PXX{1}).',detrend(PXX{2}).','alpha',0.05);
plot(f,h)
xlim([0 300])
%%
% [p,h,stats] = ranksum(detrend(PXX{1}).',detrend(PXX{2}).');
%%
% [p,tbl,stats] = kruskalwallis(detrend(PXX{1}));

%%
area(f,p)
xlim([0 300])
ylim([0 0.1])

%%
andale=PX{2}-PX{1};

hist(andale,10)
[TF,L,U,C] = isoutlier(andale);

%%
aver=PXX{1};
aver=aver(:,1:100);
%%
boxplot(aver.')
%%
% [p,t,stats] = anova1(ajalas.MPG,ajalas.Origin,'off');
% [c,m,h,nms] = multcompare(stats);
%%