% parameters
F = 160;
A = 1;
n_trl = 100;
fs = 1000;
T = [-1, 1];
labels = {'chan0'
          'chan1'
          'chan2'
          'chan3'
          };
t = T(1):1/fs:T(2)-1/fs;      

n_labels = length(labels);      

% simulate random data
data = [];
data.label = labels;
data.time = repmat({t}, 1, n_trl);
n_pnt = size(data.time{1}, 2);
data.trial = mat2cell(randn(n_labels, n_pnt * n_trl), ...
    n_labels, n_pnt * ones(n_trl, 1));

% add some activation, which is flat before time-zero and an oscillation at
% F Hz and amplitude A afterwards
activation = [zeros(1, fs * (0 - T(1))) A * cos(t(fs+1:end) * 2 * pi * F)];
for i = 1:(size(data.trial, 2) / 2)
   data.trial{1, i} =  data.trial{1, i} + repmat(activation, n_labels, 1);
end    

% compute multitaper analysis
cfg = [];
cfg.method = 'mtmconvol';
cfg.keeptrials = 'yes';
cfg.taper = 'dpss';
cfg.tapsmofrq = 20;
cfg.toi = -.8:.1:.5;  % time of interest (including baseline period)
cfg.foi = 100:10:250;  % frequencies where to compute PSD
cfg.t_ftimwin = .2 * ones(size(cfg.foi));  % length of the window
% in theory, the inverse of the length of t_ftimwin is your freq resolution

freq = ft_freqanalysis(cfg, data);

cfg = [];
cfg.baseline = [-.7, -.5];  % baseline period (including extremes)
cfg.baselinetype = 'db';  % convert to dB, so you can interpret the results as dB changes from baseline
freq = ft_freqbaseline(cfg, freq);

% plot results
% you expect that the period of cfg.baseline is equal to zero
cfg = [];
freq_avg = ft_freqdescriptives(cfg, freq);

figure;
cfg = [];
cfg.channel = 'chan0';
cfg.zlim = 'maxabs';
ft_singleplotTFR(cfg, freq_avg);

freq_zero = freq;
freq_zero.powspctrm = zeros(size(freq.powspctrm));

cfg = [];
cfg.latency          = [-.5 .5];  % time of interest (exclude baseline: it doesn't make sense to compute statistics on a region we expect to be zero)

cfg.method           = 'montecarlo';
cfg.statistic        = 'ft_statfun_depsamplesT';
cfg.correctm         = 'cluster';
cfg.channel          = 'chan0';  % only one channel at the time, you should correct the p-value for the number of channels
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

% plot the t-statistics, by only showing the significant channels
figure;
cfg = [];
cfg.channel = 'chan0';
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
cfg.zlim = 'maxabs';
ft_singleplotTFR(cfg, stats);
% note that there is a significant activation after zero at frequency F