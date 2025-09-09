function [coh] = barplot_COH(q, timecell, freqrange)
% barplot_COH: Compute time-frequency coherence using FieldTrip
%
% INPUTS:
%   q          - data matrix (channels x time)
%   timecell   - time vector (same length as q)
%   freqrange  - frequency range, e.g. 100:1:300
%
% OUTPUT:
%   coh        - coherence structure from ft_connectivityanalysis
%
% Example:
%   coh = barplot_COH(q, timecell, 100:1:300);
%
% Requires FieldTrip on path.

%% ---------------- Prepare data ----------------
ft_data           = [];
ft_data.fsample   = 1000;                     % Sampling rate
ft_data.trial     = {q};                      % Wrap in cell for FieldTrip
ft_data.time      = {timecell};               % Time vector
ft_data.label     = {'Hippo'; 'Parietal'; 'PFC'}; % Channel labels

%% ---------------- Frequency analysis ----------------
cfg               = [];
cfg.method        = 'mtmconvol';              % multitaper convolution
cfg.taper         = 'hanning';
cfg.pad           = 'nextpow2';
cfg.foi           = freqrange;                % Frequencies of interest
cfg.t_ftimwin     = 0.2 * ones(size(cfg.foi));% Fixed 200 ms window
cfg.tapsmofrq     = 10;                       % Frequency smoothing
cfg.toi           = -1:0.025:1;               % Time of interest
cfg.keeptrials    = 'yes';
cfg.output        = 'powandcsd';              % Needed for coherence

freq              = ft_freqanalysis(cfg, ft_data);

%% ---------------- Coherence analysis ----------------
cfg               = [];
cfg.method        = 'coh';
coh               = ft_connectivityanalysis(cfg, freq);

%% ---------------- Plot coherence ----------------
cfg               = [];
cfg.parameter     = 'cohspctrm';
cfg.channel       = {'Hippo'; 'Parietal'; 'PFC'};
cfg.zlim          = [0 1];

ft_connectivityplot(cfg, coh);
title('Time-Frequency Coherence')
colormap(jet(256))
narrow_colorbar()

end
