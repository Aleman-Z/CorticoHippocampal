function [CHTM, rippleRate] = RIPPLES_thesis(level, nrem, notch, ~, lepoch)
%RIPPLES_THESIS Detect NREM ripples using monopolar and bipolar recordings.
%
%   [CHTM, rippleRate] = RIPPLES_thesis(level, nrem, notch, ~, lepoch)
%
%   Inputs:
%       level   - Threshold level index (0–4)
%       nrem    - NREM stage(s) for extraction
%       notch   - Apply notch filter? (1=yes, 0=no)
%       ~       - Placeholder (unused, for compatibility)
%       lepoch  - Epoch length (samples)
%
%   Outputs:
%       CHTM       - Array of thresholds [chtm, chtm/2, chtm/4, chtm/8, chtm/16]
%       rippleRate - Ripple rate (events/sec)
%
%   Notes:
%       - Loads transitions.mat and monopolar signals data{6,9,12,17}m.mat
%       - Band-pass: 100–300 Hz
%       - Low-pass: 320 Hz
%       - Optional notch filter: harmonics at 50 Hz
%

%% Parameters
fs = 1000; % Sampling frequency
[b_bp, a_bp] = butter(3, [100 300]/(fs/2), 'bandpass'); % ripple band
[b_lp, a_lp] = butter(3, 320/(fs/2));                   % low-pass

%% Load transitions
load('transitions.mat', 'transitions');

%% Load signals
V6  = load('data6m.mat');  V6  = filtfilt(b_lp, a_lp, V6.data6m);
V9  = load('data9m.mat');  V9  = filtfilt(b_lp, a_lp, V9.data9m);
V12 = load('data12m.mat'); V12 = filtfilt(b_lp, a_lp, V12.data12m);
V17 = load('data17m.mat'); V17 = filtfilt(b_lp, a_lp, V17.data17m);

%% Apply notch filter if requested
if notch
    Fline = [50 100 150 200 250 300];
    V6  = ft_notch(V6.',  fs, Fline, 1, 2).';
    V9  = ft_notch(V9.',  fs, Fline, 1, 2).';
    V12 = ft_notch(V12.', fs, Fline, 1, 2).';
    V17 = ft_notch(V17.', fs, Fline, 1, 2).';
end

%% Bipolar derivations
S17 = V17 - V6;
S12 = V12 - V6;
S9  = V9  - V6;

%% Band-pass filtering
Mono17 = filtfilt(b_bp, a_bp, V17); Bip17 = filtfilt(b_bp, a_bp, S17);
Mono12 = filtfilt(b_bp, a_bp, V12); Bip12 = filtfilt(b_bp, a_bp, S12);
Mono9  = filtfilt(b_bp, a_bp, V9);  Bip9  = filtfilt(b_bp, a_bp, S9);
Mono6  = filtfilt(b_bp, a_bp, V6);

disp('Loaded and filtered channels');

%% Restrict to NREM epochs
[V6,   ~] = reduce_data(V6,   transitions, fs, nrem);
[V9,   ~] = reduce_data(V9,   transitions, fs, nrem);
[V12,  ~] = reduce_data(V12,  transitions, fs, nrem);
[V17,  ~] = reduce_data(V17,  transitions, fs, nrem);

[Mono6,  ~] = reduce_data(Mono6,  transitions, fs, nrem);
[Mono9,  ~] = reduce_data(Mono9,  transitions, fs, nrem);
[Mono12, ~] = reduce_data(Mono12, transitions, fs, nrem);
[Mono17, ~] = reduce_data(Mono17, transitions, fs, nrem);

[Bip9,  ~] = reduce_data(Bip9,  transitions, fs, nrem);
[Bip12, ~] = reduce_data(Bip12, transitions, fs, nrem);
[Bip17, ~] = reduce_data(Bip17, transitions, fs, nrem);

%% Time asleep (minutes)
timeAsleep = sum(cellfun(@numel, V9)) / fs / 60;

%% Compute thresholds
chtm = median(cellfun(@max, Mono17)) / 0.195;
CHTM = floor([chtm, chtm/2, chtm/4, chtm/8, chtm/16]);

%% Prepare signals
signal   = cellfun(@(x) x/0.195, Bip17,  'UniformOutput', false);
signal2  = cellfun(@(x) x/0.195, Mono17, 'UniformOutput', false);
timeAxis = cellfun(@(x) (0:numel(x)-1)/fs, signal2, 'UniformOutput', false);

%% Ripple detection (single threshold level)
thr = CHTM(level+1);
[S2x, E2x, M2x] = cellfun(@(sig, t) ...
    findRipplesLisa(sig, t.', thr, thr/2, []), ...
    signal2, timeAxis, 'UniformOutput', false);

rippleCounts = cellfun(@numel, S2x);
rippleRate   = sum(rippleCounts) / (timeAsleep * 60); % ripples/sec

end
