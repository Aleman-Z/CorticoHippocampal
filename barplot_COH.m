function [coh]=barplot_COH(q,timecell,freqrange)
%[100:1:300]

ft_data1 = [];
ft_data1.fsample = 1000;
%tt=linspace(-5,5,1000);
%ft_data1.trial = q(1:1); % q should be larger than +/-500 ms. Better to use 1 sec. 
%ft_data1.trial = q(1,end-199:end); % q should be larger than +/-500 ms. Better to use 1 sec. 
ft_data1.trial = q(1,1:end); % q should be larger than +/-500 ms. Better to use 1 sec. 


%ft_data1.time = (timecell(1,end-199:end));
ft_data1.time = (timecell(1,1:end));

%ft_data1.time = {[tt;tt;tt;tt]};

%ft_data1

ft_data1.label = {'Hippo'; 'Parietal'; 'PFC';'REF'};


% Compute Multitaper

cfg = [];
cfg.method = 'mtmconvol';
%cfg.taper = 'dpss';
cfg.taper = 'hanning';
%cfg.pad='nextpow2';
%cfg.foi = [100:50:300];
cfg.foi = freqrange;


cfg.t_ftimwin = .2 * ones(size(cfg.foi));
cfg.tapsmofrq = 10;
cfg.toi = [-.5:.025:.5];
%cfg.toi = [-0.8:.01:0.8];


%cfg.toi = [-.4:.001:.4];
cfg.keeptrials = 'yes';
cfg.output         = 'powandcsd';
%cfg.output         = 'fourier';


freq = ft_freqanalysis(cfg, ft_data1);


% cfg = [];
% cfg.method = 'wavelet';
% cfg.pad='nextpow2';
% 
% % cfg.taper = 'dpss';
% %cfg.foi = [100:50:300];
% cfg.foi = freqrange;
% 
% cfg.width=20;
% cfg.gwidth=3;
% 
% 
% %cfg.t_ftimwin = .2 * ones(size(cfg.foi));
% cfg.tapsmofrq = 10;
% %cfg.toi = [-.4:.1:.4];
% %cfg.toi = [-.4:.001:.4];
% cfg.toi = [-.5:.001:.5];
% 
% cfg.keeptrials = 'yes';
% cfg.output         = 'powandcsd';
% freq = ft_freqanalysis(cfg, ft_data1);


%
% Plot 
%allscreen()
% 
% chanindx = find(strcmp(freq.label, 'Hippo'));
% % imagesc(squeeze(freq.powspctrm(chanindx,:,:)));
% imagesc(freq.time, freq. freq, squeeze(freq.powspctrm(chanindx,:,:)));
% axis xy % flip vertically
% colorbar

% 
% chanindx = find(strcmp(freq.label,ft_data1.label{label} ));
% imagesc(freq.time, freq. freq, squeeze(freq.powspctrm(1,chanindx,:,:)));
% axis xy % flip vertically
% colormap(jet(256))
%  narrow_colorbar()
% cfg=[];
% %cfg.channel = label; % top figure
% cfg.channel =ft_data1.label{label};
% ft_singleplotTFR(cfg,  freq);
% %colorbar()
% colormap(jet(256))

%COHERENCE
cfg           = [];
cfg.method    = 'coh';
coh           = ft_connectivityanalysis(cfg, freq);

cfg           = [];
cfg.parameter = 'cohspctrm';
cfg.channel= {'Hippo'; 'Parietal'; 'PFC'};

cfg.zlim      = [0 1];
ft_connectivityplot(cfg, coh);
title('Time-Frequency Coherence')

colormap(jet(256))
narrow_colorbar()

end