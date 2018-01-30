allscreen()

subplot(4,2,1)
plot(timecell{1},P2(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('Wide Band Event-triggered Average')

subplot(4,2,2)
plot(timecell{1},P1(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('High Gamma power Event-triggered Average')

subplot(4,2,3)
%freq=barplot2_ft(p,timecell,[0:.5:30],w)
freq=justtesting(p,timecell,[1:0.75:30],w,0.75)
title('Spectrogram Widepass (High temporal resolution)')

subplot(4,2,5)
[stats]=stats_freq(freq,label1{2*w-1},baseline1);
title(strcat('Statistical Test with Baseline: [', num2str(baseline1(1)),': ',num2str(baseline1(2)),']',' sec'))

subplot(4,2,7)
[stats]=stats_freq(freq,label1{2*w-1},baseline2);
title(strcat('Statistical Test with Baseline: [', num2str(baseline2(1)),': ',num2str(baseline2(2)),']',' sec'))

% freq=barplot3_ft(p,timecell,[0:.5:30],w)

% cfg              = [];
% % cfg.baseline     = [-0.5 -0.1]; 
% % cfg.baselinetype = 'absolute'; 
% % cfg.maskstyle    = 'saturation';	
% % cfg.zlim         = [-3e-27 3e-27];	
% cfg.channel      = freq.label{w};
% cfg.colormap=colormap(jet(256));
% ft_singleplotTFR(cfg, freq); 

% [stats]=stats_freq(freq,label1{2*w-1},baseline);
% grid minor

% subplot(1,3,2)
% [stats]=stats_freq(freq,label1{2*w-1},[-0.8, -0.6]);
% subplot(1,3,3)
% [stats]=stats_freq(freq,label1{2*w-1},[-1, -0.8]);
% 
% subplot(3,2,5)
% %freq=barplot3_ft(p,timecell,[0:.1:30],w)
% [stats]=stats_freq(freq,label1{2*w-1},[-0.8, -0.6]);
% grid minor

subplot(4,2,4)
freq=barplot2_ft(q,timecell,[100:1:300],w)
%freq=justtesting(q,timecell,[100:1:300],w,0.5)
title('Spectrogram Bandpass (High temporal resolution)')


subplot(4,2,6)
[stats]=stats_freq(freq,label1{2*w-1},baseline1);
title(strcat('Statistical Test with Baseline: [', num2str(baseline1(1)),': ',num2str(baseline1(2)),']',' sec'))

subplot(4,2,8)
[stats]=stats_freq(freq,label1{2*w-1},baseline2);
title(strcat('Statistical Test with Baseline: [', num2str(baseline2(1)),': ',num2str(baseline2(2)),']',' sec'))


% subplot(3,2,6)
% %freq=barplot3_ft(q,timecell,[100:1:300],w)
% [stats]=stats_freq(freq,label1{2*w-1},[-0.8, -0.6]);
% grid minor
% title('Spectrogram Bandpass (High frequency resolution)')



% subplot(4,2,7)
% freq=barplot3_ft(p,timecell,[1:.1:30],w)

% 
% cfg              = [];
% % cfg.baseline     = [-0.5 -0.1]; 
% % cfg.baselinetype = 'absolute'; 
% % cfg.maskstyle    = 'saturation';	
% % cfg.zlim         = [-3e-27 3e-27];	
% cfg.channel      = freq.label{w};
% cfg.colormap=colormap(jet(256));
% ft_singleplotTFR(cfg, freq); 

% 
% [stats]=stats_freq(freq,label1{2*w-1},baseline);
% % grid minor
% %title('Spectrogram Widepass (High frequency resolution)')
% title(strcat('Statistical Test with Baseline: [', num2str(baseline(1)),': ',num2str(baseline(2)),']',' sec'))

% subplot(4,2,8)
% freq=barplot3_ft(q,timecell,[100:1:300],w)
% [stats]=stats_freq(freq,label1{2*w-1},baseline);
% %xticks([-0.5:0.2:0.5 ])
% grid minor
%title('Spectrogram Bandpass (High frequency resolution)')
%title(strcat('Statistical Test with Baseline: [', num2str(baseline(1)),': ',num2str(baseline(2)),']',' sec'))

% 
% figure()
% baseline=[0.6, 0.8];
% 
% subplot(3,2,5)
% freq=barplot3_ft(p,timecell,[0:.1:30],w)
% [stats]=stats_freq(freq,label1{2*w-1},baseline);
% grid minor
% %title('Spectrogram Widepass (High frequency resolution)')
% title(strcat('Statistical Test with Baseline:', num2str(baseline(1)),' to ',num2str(baseline(2))))
% 
% subplot(3,2,6)
% freq=barplot3_ft(q,timecell,[100:1:300],w)
% [stats]=stats_freq(freq,label1{2*w-1},baseline);
% grid minor
% %title('Spectrogram Bandpass (High frequency resolution)')
% title(strcat('Statistical Test with Baseline: [', num2str(baseline(1)),': ',num2str(baseline(2)),']'))


mtit(strcat('Events:',num2str(ripple(level))),'fontsize',14,'color',[1 0 0],'position',[.5 0.8 ])
labelthr=strcat('Thr:',num2str(round(thr(level+1))));
mtit(strcat(labelthr),'fontsize',14,'color',[1 0 0],'position',[.5 0.9 ])

mtit(strcat(label1{2*w-1},' (',label2{1},')'),'fontsize',14,'color',[1 0 0],'position',[.5 1 ])
