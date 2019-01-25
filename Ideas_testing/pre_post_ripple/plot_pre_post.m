%Pre, SWR and Post ripple. 
%No need of No Ripple. 

allscreen()

subplot(3,6,1)
plot(timecell{1},P2(w,:))
xlim([-1.5,-0.5])
ylim([min(P2(w,:)) round(max(P2(w,:)))])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('PRE Ripple')


subplot(3,6,2)
plot(timecell{1},P2(w,:))
xlim([-0.5,0.5])
ylim([min(P2(w,:)) round(max(P2(w,:)))])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('RIPPLE')

subplot(3,6,3)
plot(timecell{1},P2(w,:))
xlim([0.5,1.5])
ylim([min(P2(w,:)) round(max(P2(w,:)))])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('Post RIPPLE')
%%
%
subplot(3,6,4)
plot(timecell{1},P1(w,:))
xlim([-1.5,-0.5])
%xlim([-0.8,0.8])
ylim([min(P1(w,:)) round(max(P1(w,:)))])
grid minor
narrow_colorbar()
title('PRE RIPPLE')

subplot(3,6,5)
plot(timecell{1},P1(w,:))
xlim([-0.5,0.5])
ylim([min(P1(w,:)) round(max(P1(w,:)))])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('PRE RIPPLE')

subplot(3,6,6)
plot(timecell{1},P1(w,:))
xlim([0.5,1.5])
ylim([min(P1(w,:)) round(max(P1(w,:)))])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('PRE RIPPLE')

%% Time Frequency plots

%First calculate Freq1 and Freq2
toy=[-1.5:.01:1.5];
[freq2]=justtesting(p,timecell,[1:0.5:30],w,0.5,toy);
%% Pre, Ripple, Post
toy=[-1.5:.01:-0.5];
[freq21]=justtesting(p,timecell,[1:0.5:30],w,0.5,toy);
toy=[-0.5:.01:0.5];
[freq22]=justtesting(p,timecell,[1:0.5:30],w,0.5,toy);
toy=[0.5:.01:1.5];
[freq23]=justtesting(p,timecell,[1:0.5:30],w,0.5,toy);
%%
% setfield(freq22,'field',value)

%%
% [ft_data1]=format_data(p,timecell,[1:0.5:30],w,0.5,toy);


% 
% cfg = [];
% cfg.toilim = [-1.5 -0.5];
% prob1= ft_redefinetrial(cfg, ft_data1);
% cfg = [];
% cfg.toilim = [-0.5 0.5];
% prob2= ft_redefinetrial(cfg, ft_data1);
% cfg = [];
% cfg.toilim = [0.5 1.5];
% prob3= ft_redefinetrial(cfg, ft_data1);


%Now calculate zlim
% cfg              = [];
% cfg.channel      = freq2.label{w};
% [ zmin1, zmax1] = ft_getminmax(cfg, freq2);
% [zmin2 zmax2] = ft_getminmax(cfg, freq2);
% 
% zlim=[min([zmin1 zmin2]) max([zmax1 zmax2])];

%%
cfg              = [];
% cfg.zlim=zlim;
cfg.channel      = freq2.label{w};
cfg.colormap=colormap(jet(256));
%%

subplot(3,6,7)
ft_singleplotTFR(cfg, freq2); 
title('PRE RIPPLE')
xlim([-1.5 -0.5])

subplot(3,6,8)
ft_singleplotTFR(cfg, freq2); 
title('RIPPLE')
xlim([-0.5 0.5])

subplot(3,6,9)
ft_singleplotTFR(cfg, freq2); 
title('POST RIPPLE')
xlim([0.5 1.5])
%%
freq21.time=freq22.time;
freq23.time=freq22.time;
%%
[stats1]=stats_between_trials2(freq21,freq22,label1,w);
[stats2]=stats_between_trials2(freq23,freq22,label1,w);
[stats3]=stats_between_trials2(freq21,freq23,label1,w);

%%
subplot(3,6,13)

cfg = [];
cfg.channel = label1{2*w-1};
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
cfg.zlim = 'maxabs';
cfg.colorbar       = 'yes';
cfg.colormap=colormap(jet(256));
grid minor
ft_singleplotTFR(cfg, stats1);
title('Ripple vs PRE')
%%
%%
subplot(3,6,15)

cfg = [];
cfg.channel = label1{2*w-1};
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
cfg.zlim = 'maxabs';
cfg.colorbar       = 'yes';
cfg.colormap=colormap(jet(256));
grid minor
ft_singleplotTFR(cfg, stats2);
title('Ripple vs Post')
%%

subplot(3,6,14)

cfg = [];
cfg.channel = label1{2*w-1};
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
cfg.zlim = 'maxabs';
cfg.colorbar       = 'yes';
cfg.colormap=colormap(jet(256));
grid minor
ft_singleplotTFR(cfg, stats3);
title('Post vs Pre')


%%
% subplot(3,4,6)
% % freq2=justtesting(p,timecell,[1:0.5:30],w,0.5)
% ft_singleplotTFR(cfg, freq2); 
% 
% title('Wide Band RIPPLE')
% xlim([-1 1])

%%
%%
%Calculate Freq3 and Freq4 
%freq3=barplot2_ft(SUS,SUStimecell,[100:1:300],w);
toy=[-1.5:.01:1.5];
freq3=barplot2_ft(q,timecell,[100:1:300],w,toy);


% %Calculate Zlimits
% cfg              = [];
% cfg.channel      = freq3.label{w};
% [ zmin1, zmax1] = ft_getminmax(cfg, freq3);
% [zmin2 zmax2] = ft_getminmax(cfg, freq4);
% 
% zlim=[min([zmin1 zmin2]) max([zmax1 zmax2])];

%%
cfg              = [];
%  cfg.zlim=zlim;
cfg.channel      = freq3.label{w};
cfg.colormap=colormap(jet(256));
%%
subplot(3,6,10)
ft_singleplotTFR(cfg, freq3); 
title('PRE RIPPLE')
xlim([-1.5 -0.5])

subplot(3,6,11)
ft_singleplotTFR(cfg, freq3); 
title('RIPPLE')
xlim([-0.5 0.5])

subplot(3,6,12)
ft_singleplotTFR(cfg, freq3); 
title('POST RIPPLE')
xlim([0.5 1.5])
%%
%% Pre, Ripple, Post
toy=[-1.5:.01:-0.5];
[freq21]=barplot2_ft(q,timecell,[100:1:300],w,toy);
toy=[-0.5:.01:0.5];
[freq22]=barplot2_ft(q,timecell,[100:1:300],w,toy);
toy=[0.5:.01:1.5];
[freq23]=barplot2_ft(q,timecell,[100:1:300],w,toy);
%%
freq21.time=freq22.time;
freq23.time=freq22.time;
%%
[stats1]=stats_between_trials2(freq21,freq22,label1,w);
[stats2]=stats_between_trials2(freq23,freq22,label1,w);
[stats3]=stats_between_trials2(freq21,freq23,label1,w);

%%
subplot(3,6,16)

cfg = [];
cfg.channel = label1{2*w-1};
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
cfg.zlim = 'maxabs';
cfg.colorbar       = 'yes';
cfg.colormap=colormap(jet(256));
grid minor
ft_singleplotTFR(cfg, stats1);
title('Ripple vs PRE')
%%
subplot(3,6,18)

cfg = [];
cfg.channel = label1{2*w-1};
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
cfg.zlim = 'maxabs';
cfg.colorbar       = 'yes';
cfg.colormap=colormap(jet(256));
grid minor
ft_singleplotTFR(cfg, stats2);
title('Ripple vs Post')
%%
subplot(3,6,17)

cfg = [];
cfg.channel = label1{2*w-1};
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
cfg.zlim = 'maxabs';
cfg.colorbar       = 'yes';
cfg.colormap=colormap(jet(256));
grid minor
ft_singleplotTFR(cfg, stats3);
title('Post vs Pre')


%%
% 
% 
% mtit(strcat('Events:',num2str(ripple(level))),'fontsize',14,'color',[1 0 0],'position',[0 0.2 ])
% labelthr=strcat('Thr:',num2str(round(thr(level+1))));
% mtit(strcat(labelthr),'fontsize',14,'color',[1 0 0],'position',[0 0.15 ])
% 
% mtit(strcat(label1{2*w-1},' (',label2{1},')'),'fontsize',14,'color',[1 0 0],'position',[0 0.10 ])



