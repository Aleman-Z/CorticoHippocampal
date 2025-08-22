function [rippleCount, timeAsleep, chtm, yFit] = NREM_accurate(nrem, notch, chtm)
%NREM_ACCURATE Detect ripples during NREM sleep using given threshold.
%
%   [rippleCount, timeAsleep, chtm, yFit] = NREM_accurate(nrem, notch, chtm)
%
%   Inputs:
%       nrem  - NREM sleep label(s) for extraction
%       notch - Apply notch filter? (1=yes, 0=no)
%       chtm  - Threshold reference value
%
%   Outputs:
%       rippleCount - Number of ripples detected
%       timeAsleep  - Total NREM duration (minutes)
%       chtm        - Threshold used
%       yFit        - Polynomial fit (if applied)
%
%   Notes:
%       - Monopolar recording loaded from data17m.mat
%       - Sleep stage transitions loaded from transitions.mat
%       - Band-pass filter: 100–300 Hz
%       - Low-pass filter: 320 Hz
%       - Optional notch filter: 50 Hz harmonics
%

%% Parameters
fs = 1000;   % Sampling frequency (Hz)

%% Filter design
% Ripple band (100–300 Hz)
[b_bp, a_bp] = butter(3, [100 300]/(fs/2), 'bandpass');

% Low-pass (320 Hz)
[b_lp, a_lp] = butter(3, 320/(fs/2));

%% Load data
load('transitions.mat', 'transitions');
rawData = load('data17m.mat');
V17 = rawData.data17m;

% Apply low-pass filter
V17 = filtfilt(b_lp, a_lp, V17);

% Optional notch filter
if notch
    Fline = [50 100 150 200 250.5 300];
    V17   = ft_notch(V17.', fs, Fline, 1, 2).'; 
end

% Band-pass filtered version
Mono17 = filtfilt(b_bp, a_bp, V17);

% Restrict to NREM periods
[V17, ~]    = reduce_data(V17,    transitions, fs, nrem);
[Mono17, ~] = reduce_data(Mono17, transitions, fs, nrem);

disp('Loaded channels and applied filters.');

%% Compute time asleep (in minutes)
timeAsleep = sum(cellfun(@numel, V17)) / fs / 60;

%% Scale signal & time vectors
signalScaled = cellfun(@(x) x/0.195, Mono17, 'UniformOutput', false);
timeVectors  = cellfun(@(x) (0:numel(x)-1)/fs, signalScaled, 'UniformOutput', false);

%% Ripple detection
[S2x, E2x, M2x] = cellfun(@(sig, t) ...
    findRipplesLisa(sig, t.', chtm, chtm/2, []), ...
    signalScaled, timeVectors, 'UniformOutput', false);

% Count ripples per epoch
sCount = cellfun(@numel, S2x);

% Total ripples
rippleCount = sum(sCount);

%% Optional: polynomial fit of detection count vs threshold
% (here trivial, since only one threshold)
yFit = rippleCount;

end
