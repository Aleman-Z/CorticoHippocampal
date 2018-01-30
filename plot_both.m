%Plot both: No ripples and Ripples. 
allscreen()
subplot(3,4,1)
plot(timecell{1},P2_SUS(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('Wide Band NO RIPPLE')


subplot(3,4,3)
plot(timecell{1},P1_SUS(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('High Gamma NO RIPPLE')

subplot(3,4,2)
plot(timecell{1},P2(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('Wide Band RIPPLE')

subplot(3,4,4)
plot(timecell{1},P1(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('High Gamma RIPPLE')

%% Time Frequency plots

%First calculate Freq1 and Freq2
toy=[-1.2:.01:1.2];
freq1=justtesting(SUS2,SUS2timecell,[1:0.5:30],w,10,toy)
freq2=justtesting(p,timecell,[1:0.5:30],w,0.5,toy);

%Now calculate zlim
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
title('Wide Band NO RIPPLE')
xlim([-1 1])

%%
subplot(3,4,6)
% freq2=justtesting(p,timecell,[1:0.5:30],w,0.5)
ft_singleplotTFR(cfg, freq2); 

title('Wide Band RIPPLE')
xlim([-1 1])

%%
[stats]=stats_between_trials(freq1,freq2,label1,w);
%
subplot(3,4,10)

cfg = [];
cfg.channel = label1{2*w-1};
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
cfg.zlim = 'maxabs';
cfg.colorbar       = 'yes';
cfg.colormap=colormap(jet(256));
grid minor
ft_singleplotTFR(cfg, stats);
title('Ripple vs No Ripple')
%%
%Calculate Freq3 and Freq4 
toy=[-1.2:.01:1.2];
freq3=barplot2_ft(SUS,SUStimecell,[100:1:300],w,toy);
freq4=barplot2_ft(q,timecell,[100:1:300],w,toy);

%Calculate Zlimits
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
% freq3=barplot2_ft(SUS,SUStimecell,[100:1:300],w)
%freq=justtesting(q,timecell,[100:1:300],w,0.5)
ft_singleplotTFR(cfg, freq3); 
title('High Gamma NO RIPPLE')


subplot(3,4,8)
% freq4=barplot2_ft(q,timecell,[100:1:300],w)
%freq=justtesting(q,timecell,[100:1:300],w,0.5)
ft_singleplotTFR(cfg, freq4); 

title('High Gamma RIPPLE')

[stats1]=stats_between_trials(freq3,freq4,label1,w);

%%
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
title('Ripple vs No Ripple')


mtit(strcat('Events:',num2str(ripple(level))),'fontsize',14,'color',[1 0 0],'position',[.1 0.2 ])
labelthr=strcat('Thr:',num2str(round(thr(level+1))));
mtit(strcat(labelthr),'fontsize',14,'color',[1 0 0],'position',[.1 0.15 ])

mtit(strcat(label1{2*w-1},' (',label2{1},')'),'fontsize',14,'color',[1 0 0],'position',[.1 0.10 ])



