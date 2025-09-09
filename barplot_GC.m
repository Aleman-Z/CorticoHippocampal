function [granger] = barplot_GC(q, timecell, freqrange)
% barplot_GC: Compute time-frequency Granger causality using FieldTrip
%
% INPUTS:
%   q          - data matrix (channels x time)
%   timecell   - time vector (same length as q)
%   freqrange  - frequency range, e.g. 100:1:300
%
% OUTPUT:
%   granger    - granger causality structure from ft_connectivityanalysis
%
% Example:
%   granger = barplot_GC(q, timecell, 100:1:300);
%
% Requires FieldTrip on path.

%% ---------------- Prepare data ----------------
ft_data           = [];
ft_data.fsample   = 1000;                            % Sampling rate
ft_data.trial     = {q};                             % Wrap in cell for FT
ft_data.time      = {timecell};                      % Time vector
ft_data.label     = {'Hippo'; 'Parietal'; 'PFC'; 'REF'}; % Channel labels

%% ---------------- Frequency analysis ----------------
cfg               = [];
cfg.method        = 'mtmconvol';                     % multitaper convolution
cfg.taper         = 'hanning';
cfg.foi           = freqrange;                       % Frequencies of interest
cfg.t_ftimwin     = 0.2 * ones(size(cfg.foi));       % Fixed 200 ms window
cfg.tapsmofrq     = 10;                              % Frequency smoothing
cfg.toi           = -0.5:0.025:0.5;                  % Time of interest
cfg.keeptrials    = 'yes';
cfg.output        = 'fourier';                       % Needed for Granger

freq              = ft_freqanalysis(cfg, ft_data);

%% ---------------- Granger causality ----------------
cfg               = [];
cfg.method        = 'granger';
granger           = ft_connectivityanalysis(cfg, freq);

%% ---------------- Plot Granger ----------------
cfg               = [];
cfg.parameter     = 'grangerspctrm';
cfg.channel       = ft_data.label(1:3);              % Select subset of channels
cfg.zlim          = [0 1];

ft_connectivityplot(cfg, granger);
xticks(-0.5:0.2:0.5)
title('Time-Frequency Granger Causality')
colormap(jet(256))
narrow_colorbar()

end
