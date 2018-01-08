function [stats]=stats_freq(freq,label,baseline)
%Statistics
n_trl=size(freq.powspctrm,1);

cfg = [];
cfg.baseline = baseline;  % baseline period (including extremes)
cfg.baselinetype = 'db';  % convert to dB, so you can interpret the results as dB changes from baseline
freq = ft_freqbaseline(cfg, freq);

cfg = [];
freq_avg = ft_freqdescriptives(cfg, freq);

freq_zero = freq;
freq_zero.powspctrm = zeros(size(freq.powspctrm));

cfg = [];
cfg.latency          = [-.5 .5];  % time of interest (exclude baseline: it doesn't make sense to compute statistics on a region we expect to be zero)

cfg.method           = 'montecarlo';
cfg.statistic        = 'ft_statfun_depsamplesT';
cfg.correctm         = 'cluster';
%cfg.channel          = 'chan0';  % only one channel at the time, you should correct the p-value for the number of channels
cfg.channel          = label;  % only one channel at the time, you should correct the p-value for the number of channels


cfg.alpha            = 0.05 / length(freq.label);
cfg.correcttail      = 'prob';
cfg.numrandomization = 500;  % this value won't change the statistics. Use a higher value to have a more accurate p-value

design  = zeros(2, n_trl * 2);
design(1, 1:n_trl) = 1;
design(1, n_trl+1:end) = 2;
design(2, :) = [1:n_trl 1:n_trl];
cfg.design = design;
cfg.ivar = 1;
cfg.uvar = 2;

stats = ft_freqstatistics(cfg, freq, freq_zero);

cfg = [];
cfg.channel = label;
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
cfg.zlim = 'maxabs';
cfg.colorbar       = 'no';
% figure()
ft_singleplotTFR(cfg, stats);
colormap(jet(256))
narrow_colorbar()

end