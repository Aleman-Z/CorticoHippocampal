%% Plot both: No Ripples and Ripples
allscreen()

% ------------------- Time-Domain Plots -------------------
subplot(3,4,1)
plot(timecell{1}, P2_SUS(w,:))
xlim([-1, 1])
grid minor
narrow_colorbar()
title('Wide Band - NO RIPPLE')

subplot(3,4,2)
plot(timecell{1}, P2(w,:))
xlim([-1, 1])
grid minor
narrow_colorbar()
title('Wide Band - RIPPLE')

subplot(3,4,3)
plot(timecell{1}, P1_SUS(w,:))
xlim([-1, 1])
grid minor
narrow_colorbar()
title('High Gamma - NO RIPPLE')

subplot(3,4,4)
plot(timecell{1}, P1(w,:))
xlim([-1, 1])
grid minor
narrow_colorbar()
title('High Gamma - RIPPLE')

%% ------------------- Time-Frequency Plots -------------------

% Calculate Freq1 (No Ripple) and Freq2 (Ripple)
toy    = -1.2:0.01:1.2;
freq1  = justtesting(SUS2, SUS2timecell, 1:0.5:30, w, 10, toy);
freq2  = justtesting(p,    timecell,     1:0.5:30, w, 0.5, toy);

% Z-limits for comparability
cfg         = [];
cfg.channel = freq1.label{w};
[zmin1, zmax1] = ft_getminmax(cfg, freq1);
[zmin2, zmax2] = ft_getminmax(cfg, freq2);
zlim        = [min([zmin1 zmin2]) max([zmax1 zmax2])];

% Shared cfg
cfg         = [];
cfg.zlim    = zlim;
cfg.channel = freq1.label{w};
cfg.colormap= colormap(jet(256));

subplot(3,4,5)
ft_singleplotTFR(cfg, freq1)
title('Wide Band - NO RIPPLE')
xlim([-1 1])

subplot(3,4,6)
ft_singleplotTFR(cfg, freq2)
title('Wide Band - RIPPLE')
xlim([-1 1])

% Stats between Wide Band conditions
stats = stats_between_trials(freq1, freq2, label1, w);

subplot(3,4,10)
cfg              = [];
cfg.channel      = label1{2*w-1};
cfg.parameter    = 'stat';
cfg.maskparameter= 'mask';
cfg.zlim         = 'maxabs';
cfg.colorbar     = 'yes';
cfg.colormap     = colormap(jet(256));
grid minor
ft_singleplotTFR(cfg, stats)
title('Wide Band: Ripple vs No Ripple')

%% ------------------- High Gamma TFR -------------------

% Calculate Freq3 (No Ripple) and Freq4 (Ripple)
toy    = -1.2:0.01:1.2;
freq3  = barplot2_ft(SUS, SUStimecell, 100:1:300, w, toy);
freq4  = barplot2_ft(q,   timecell,    100:1:300, w, toy);

% Z-limits
cfg         = [];
cfg.channel = freq3.label{w};
[zmin1, zmax1] = ft_getminmax(cfg, freq3);
[zmin2, zmax2] = ft_getminmax(cfg, freq4);
zlim        = [min([zmin1 zmin2]) max([zmax1 zmax2])];

% Shared cfg
cfg         = [];
cfg.zlim    = zlim;
cfg.channel = freq3.label{w};
cfg.colormap= colormap(jet(256));

subplot(3,4,7)
ft_singleplotTFR(cfg, freq3)
title('High Gamma - NO RIPPLE')

subplot(3,4,8)
ft_singleplotTFR(cfg, freq4)
title('High Gamma - RIPPLE')

% Stats between High Gamma conditions
stats1 = stats_between_trials(freq3, freq4, label1, w);

subplot(3,4,12)
cfg              = [];
cfg.channel      = label1{2*w-1};
cfg.parameter    = 'stat';
cfg.maskparameter= 'mask';
cfg.zlim         = 'maxabs';
cfg.colorbar     = 'yes';
cfg.colormap     = colormap(jet(256));
grid minor
ft_singleplotTFR(cfg, stats1)
title('High Gamma: Ripple vs No Ripple')

%% ------------------- Main Titles -------------------
mtit(['Events: ', num2str(ripple(level))], ...
     'fontsize',14,'color',[1 0 0],'position',[.1 0.2]);

labelthr = ['Thr: ', num2str(round(thr(level+1)))];
mtit(labelthr,'fontsize',14,'color',[1 0 0],'position',[.1 0.15]);

mtit([label1{2*w-1}, ' (', label2{1}, ')'], ...
     'fontsize',14,'color',[1 0 0],'position',[.1 0.10]);
