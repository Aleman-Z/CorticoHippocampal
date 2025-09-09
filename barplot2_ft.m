function [freq] = barplot2_ft(q, timecell, freqrange, label, toy, pad_option)
% barplot2_ft: Compute time-frequency representation using FieldTrip
%
% INPUTS:
%   q          - data matrix (channels x time)
%   timecell   - time vector (same length as q)
%   freqrange  - frequency range, e.g. 100:1:300
%   label      - integer specifying which channel to analyze
%   toy        - vector of time points of interest, e.g. -1.2:0.01:1.2
%   pad_option - padding option for FFT ('nextpow2', numeric, or [])
%
% OUTPUT:
%   freq       - frequency structure from ft_freqanalysis
%
% Example:
%   freq = barplot2_ft(q, timecell, 100:1:300, 2, -1:0.01:1, 'nextpow2');
%
% Requires FieldTrip on path.

%% ---------------- Prepare data ----------------
ft_data = [];
ft_data.fsample = 1000;                    % Sampling rate
ft_data.trial   = {q};                     % Trial data (wrap in cell for FT)
ft_data.time    = {timecell};              % Time vector
ft_data.label   = {'HPC'; 'PAR'; 'PFC'};   % Channel labels

%% ---------------- Frequency analysis cfg ----------------
cfg = [];
cfg.method     = 'mtmconvol';              % multitaper time-frequency
cfg.taper      = 'dpss';                   % Slepian taper
cfg.foi        = freqrange;                % Frequencies of interest
cfg.t_ftimwin  = 0.1 * ones(size(cfg.foi));% Window length (100 ms per freq)
cfg.tapsmofrq  = 10;                       % Spectral smoothing (Hz)
cfg.toi        = toy;                      % Time points of interest
cfg.keeptrials = 'yes';
cfg.output     = 'pow';

% Optional padding
if exist('pad_option','var') && ~isempty(pad_option)
    cfg.pad = pad_option;
end

%% ---------------- Run analysis ----------------
freq = ft_freqanalysis(cfg, ft_data);

end
