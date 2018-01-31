%This one requires running data from Non Learning condition

cd('/home/raleman/Documents/internship/27')
cd(nFF{2})

run('newest_load_data_nl.m')

%ran=randi(length(p),100,1);
sig1_nl=cell(7,1);

sig1_nl{1}=Mono17_nl;
sig1_nl{2}=Bip17_nl;
sig1_nl{3}=Mono12_nl;
sig1_nl{4}=Bip12_nl;
sig1_nl{5}=Mono9_nl;
sig1_nl{6}=Bip9_nl;
sig1_nl{7}=Mono6_nl;


sig2_nl=cell(7,1);

sig2_nl{1}=V17_nl;
sig2_nl{2}=S17_nl;
sig2_nl{3}=V12_nl;
% sig2{4}=R12;
sig2_nl{4}=S12_nl;
%sig2{6}=SSS12;
sig2_nl{5}=V9_nl;
% sig2{7}=R9;
sig2_nl{6}=S9_nl;
%sig2{10}=SSS9;
sig2_nl{7}=V6_nl;
 
% ripple=length(M);

%Number of ripples per threshold.
ripple_nl=sum(s17_nl);

[p_nl,q_nl,timecell_nl,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),thr_nl(level+1));

load(strcat('randnum2_',num2str(level),'.mat'))
ran_nl=ran;
%ran_nl=randi(length(p_nl),100,1);

p_nl=p_nl([ran_nl]);
q_nl=q_nl([ran_nl]);
timecell_nl=timecell_nl([ran_nl]);

%Need: P1, P2 ,p, q. 
P1_nl=avg_samples(q_nl,timecell_nl);
P2_nl=avg_samples(p_nl,timecell_nl);

cd('/home/raleman/Documents/internship/27')
cd(nFF{iii})

%%
%Plot both: No ripples and Ripples. 
allscreen()
subplot(3,4,1)
plot(timecell_nl{1},P2_nl(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('Wide Band NO Learning')
win1=[min(P2_nl(w,:)) max(P2_nl(w,:)) min(P2(w,:)) max(P2(w,:))];
win1=[(min(win1)) round(max(win1))];
ylim(win1)

%%
subplot(3,4,3)
plot(timecell_nl{1},P1_nl(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('High Gamma NO Learning')

win2=[min(P1_nl(w,:)) max(P1_nl(w,:)) min(P1(w,:)) max(P1(w,:))];
win2=[(min(win2)) round(max(win2))];
ylim(win2)

%%

subplot(3,4,2)
plot(timecell{1},P2(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title(strcat('Wide Band',{' '},labelconditions{iii-3}))
ylim(win1)

%%
subplot(3,4,4)
plot(timecell{1},P1(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
%title('High Gamma RIPPLE')
title(strcat('High Gamma',{' '},labelconditions{iii-3}))
ylim(win2)

%% Time Frequency plots
% Calculate Freq1 and Freq2
toy = [-1.2:.01:1.2];
freq1=justtesting(p_nl,timecell_nl,[1:0.5:30],w,10,toy);
freq2=justtesting(p,timecell,[1:0.5:30],w,0.5,toy);
% Calculate zlim

cfg              = [];
cfg.channel      = freq1.label{w};
[ zmin1, zmax1] = ft_getminmax(cfg, freq1);
[zmin2 zmax2] = ft_getminmax(cfg, freq2);

zlim=[min([zmin1 zmin2]) max([zmax1 zmax2])];

%%
cfg              = [];
 cfg.zlim=zlim;
cfg.channel      = freq1.label{w};
cfg.colormap=colormap(jet(256));

%%
subplot(3,4,5)
ft_singleplotTFR(cfg, freq1); 
% freq1=justtesting(p_nl,timecell_nl,[1:0.5:30],w,10)
title('Wide Band NO Learning')
xlim([-1 1])
%%
subplot(3,4,6)
ft_singleplotTFR(cfg, freq2); 

% freq2=justtesting(p,timecell,[1:0.5:30],w,0.5)
%title('Wide Band RIPPLE')
title(strcat('Wide Band',{' '},labelconditions{iii-3}))

xlim([-1 1])

%%
%
[stats]=stats_between_trials(freq1,freq2,label1,w);
% 
 subplot(3,4,10)
% 
cfg = [];
cfg.channel = label1{2*w-1};
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
cfg.zlim = 'maxabs';
cfg.colorbar       = 'yes';
cfg.colormap=colormap(jet(256));
grid minor
ft_singleplotTFR(cfg, stats);
% title('Condition vs No Learning')
title(strcat(labelconditions{iii-3},' vs No Learning'))

%%
%Calculate Freq3 and Freq4
toy=[-1:.01:1];
freq3=barplot2_ft(q_nl,timecell_nl,[100:1:300],w,toy);
freq4=barplot2_ft(q,timecell,[100:1:300],w,toy);

% Calculate zlim

cfg              = [];
cfg.channel      = freq3.label{w};
[ zmin1, zmax1] = ft_getminmax(cfg, freq3);
[zmin2 zmax2] = ft_getminmax(cfg, freq4);

zlim=[min([zmin1 zmin2]) max([zmax1 zmax2])];

%%
cfg              = [];
 cfg.zlim=zlim;
cfg.channel      = freq3.label{w};
cfg.colormap=colormap(jet(256));

%%
subplot(3,4,7)
ft_singleplotTFR(cfg, freq3); 
% freq3=barplot2_ft(q_nl,timecell_nl,[100:1:300],w);
title('High Gamma NO Learning')
%%

subplot(3,4,8)
% freq4=barplot2_ft(q,timecell,[100:1:300],w)
%freq=justtesting(q,timecell,[100:1:300],w,0.5)
%title('High Gamma RIPPLE')
ft_singleplotTFR(cfg, freq4); 
title(strcat('High Gamma',{' '},labelconditions{iii-3}))

%%

[stats1]=stats_between_trials(freq3,freq4,label1,w);
% %
 subplot(3,4,12)
cfg = [];
cfg.channel = label1{2*w-1};
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
cfg.zlim = 'maxabs';
cfg.colorbar       = 'yes';
cfg.colormap=colormap(jet(256));
grid minor
ft_singleplotTFR(cfg, stats1);
%title('Ripple vs No Ripple')
title(strcat(labelconditions{iii-3},' vs No Learning'))


mtit(strcat('Events:',num2str(ripple(level))),'fontsize',14,'color',[1 0 0],'position',[.1 0.2 ])
labelthr=strcat('Thr:',num2str(round(thr(level+1))));
mtit(strcat(labelthr),'fontsize',14,'color',[1 0 0],'position',[.1 0.15 ])

mtit(strcat(label1{2*w-1},' (',label2{1},')'),'fontsize',14,'color',[1 0 0],'position',[.1 0.10 ])



