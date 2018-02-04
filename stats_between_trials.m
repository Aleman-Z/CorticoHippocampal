%%
function [stats]=stats_between_trials(freq1,freq2,label1,w)
cfg = [];
cfg.latency          = [-1 1];  % time of interest (exclude baseline: it doesn't make sense to compute statistics on a region we expect to be zero)

cfg.method           = 'montecarlo';
cfg.statistic        = 'ft_statfun_indepsamplesT';
cfg.correctm         = 'cluster';m
%cfg.channel          = 'chan0';  % only one channel at the time, you should correct the p-value for the number of channels
cfg.channel          = label1{2*w-1};  % only one channel at the time, you should correct the p-value for the number of channels


cfg.alpha            = 0.05 / length(freq1.label);
cfg.correcttail      = 'prob';
cfg.numrandomization = 500;  % this value won't change the statistics. Use a higher value to have a more accurate p-value

% design  = zeros(2, n_trl * 2);
% design(1, 1:n_trl) = 1;
% design(1, n_trl+1:end) = 2;
% design(2, :) = [1:n_trl 1:n_trl];

design = zeros(1,size(freq1.powspctrm,1) + size(freq2.powspctrm,1));
design(1,1:size(freq1.powspctrm,1)) = 1;
design(1,(size(freq1.powspctrm,1)+1):(size(freq1.powspctrm,1)+...
  size(freq1.powspctrm,1))) = 2;

cfg.design = design;
cfg.ivar = 1;
% cfg.uvar = 2;

stats = ft_freqstatistics(cfg, freq2, freq1);
end