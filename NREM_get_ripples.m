function [sig1, sig2, rippleCount, rippleEvents, rippleEpochs, CHTM, rippleRate, timeAsleep] = ...
    NREM_get_ripples(level, nrem, notch, ~, lepoch, Score)
%NREM_GET_RIPPLES Detect ripples in NREM sleep across multiple channels.
%
%   [sig1, sig2, rippleCount, rippleEvents, rippleEpochs, CHTM, rippleRate, timeAsleep] =
%       NREM_get_ripples(level, nrem, notch, w, lepoch, Score)
%
%   Inputs:
%       level   - Threshold level index (0–4)
%       nrem    - NREM sleep label(s) for extraction
%       notch   - Apply notch filter? (1=yes, 0=no)
%       w       - (unused, placeholder for compatibility)
%       lepoch  - Epoch length (samples)
%       Score   - 1=use transitions.mat, 2=use transitions2.mat
%
%   Outputs:
%       sig1        - Cell array of bandpassed signals per channel
%       sig2        - Cell array of raw signals per channel
%       rippleCount - Total ripples detected at given threshold
%       rippleEvents- Cell array with detected ripple events
%       rippleEpochs- Indices of epochs containing ripples
%       CHTM        - Threshold values [base, /2, /4, /8, /16]
%       rippleRate  - Ripple rate (events/second)
%       timeAsleep  - Total NREM duration (minutes)
%
%   Notes:
%       - Monopolar signals loaded from data{6,9,12,17}m.mat
%       - Sleep stage classification loaded from transitions.mat or transitions2.mat
%       - Band-pass filter: 100–300 Hz
%       - Optional notch filter: 50 Hz harmonics
%

%% Parameters
fs = 1000;   % Sampling frequency
[b_bp, a_bp] = butter(3, [100 300]/(fs/2), 'bandpass'); % ripple band

%% Load sleep stage transitions
if Score==1
    load('transitions.mat', 'transitions');
else
    load('transitions2.mat', 'transitions');
end

%% Load monopolar signals
channels = {'data17m','data12m','data9m','data6m'};
rawSignals = cellfun(@(fname) load([fname '.mat']), channels, 'UniformOutput', false);
rawSignals = cellfun(@(s,f) s.(f), rawSignals, channels, 'UniformOutput', false);

% Ensure column vectors
rawSignals = cellfun(@(x) x(:), rawSignals, 'UniformOutput', false);

% Apply notch filter if requested
if notch
    Fline = [50 100 150 200 250.5 300];
    rawSignals = cellfun(@(sig) ft_notch(sig.', fs, Fline, 1, 2).', rawSignals, 'UniformOutput', false);
end

%% Band-pass filtering and NREM restriction
bandpassed = cellfun(@(sig) filtfilt(b_bp, a_bp, sig), rawSignals, 'UniformOutput', false);
rawSignals = cellfun(@(sig) reduce_data(sig, transitions, fs, nrem), rawSignals, 'UniformOutput', false);
bandpassed = cellfun(@(sig) reduce_data(sig, transitions, fs, nrem), bandpassed, 'UniformOutput', false);

% unwrap reduce_data outputs
rawSignals = cellfun(@(c) c{1}, rawSignals, 'UniformOutput', false);
bandpassed = cellfun(@(c) c{1}, bandpassed, 'UniformOutput', false);

disp('Loaded channels and applied bandpass');

%% Compute time asleep (minutes)
timeAsleep = sum(cellfun(@numel, rawSignals{1})) / fs / 60;

%% Threshold computation
NC = epocher(bandpassed{1}, lepoch);
ncmax = max(NC) * (1/0.195);
chtm  = median(ncmax);
CHTM  = floor([chtm chtm/2 chtm/4 chtm/8 chtm/16]);

%% Scale signals and time vectors
signalScaled = cellfun(@(x) x/0.195, bandpassed{1}, 'UniformOutput', false);
timeVectors  = cellfun(@(x) (0:numel(x)-1)/fs, signalScaled, 'UniformOutput', false);

%% Ripple detection (single threshold level)
thr = CHTM(level+1);
[S2x,E2x,M2x] = cellfun(@(sig,t) ...
    findRipplesLisa(sig, t.', thr, thr/2, []), ...
    signalScaled, timeVectors, 'UniformOutput', false);

% Count ripples
counts = cellfun(@numel, S2x);
rippleCount = sum(counts);
rippleRate  = rippleCount / (timeAsleep*60);

%% Collect epochs and ripple events
rippleEpochs = arrayfun(@(i) find(counts~=0), 1:size(counts,2), 'UniformOutput', false);
rippleEvents = arrayfun(@(i) [S2x(rippleEpochs{i}) E2x(rippleEpochs{i}) M2x(rippleEpochs{i})], ...
                        1:numel(rippleEpochs), 'UniformOutput', false);

%% Organize outputs
sig1 = {bandpassed{1},[],bandpassed{2},[],bandpassed{3},[],bandpassed{4}};
sig2 = {rawSignals{1},[],rawSignals{2},[],rawSignals{3},[],rawSignals{4}};

end
