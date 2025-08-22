function [ripple2,timeAsleep,DEMAIS,y1] = NREM_accurate(level,nrem,notch,w,lepoch,chtm)
%NREM_ACCURATE Detect ripples during NREM sleep with threshold sweep.
%
%   [ripple2,timeAsleep,DEMAIS,y1] = NREM_accurate(level,nrem,notch,w,lepoch,chtm)
%
%   Inputs:
%       level   - Threshold level index
%       nrem    - NREM sleep label
%       notch   - Apply notch filter? (1=yes, 0=no)
%       w       - (unused?) parameter
%       lepoch  - Epoch length
%       chtm    - Threshold reference value
%
%   Outputs:
%       ripple2    - Ripple counts across thresholds
%       timeAsleep - Total NREM time (minutes)
%       DEMAIS     - Threshold sweep values
%       y1         - Polynomial fit of ripple counts
%
%   Notes:
%       - Monopolar recordings are taken from data17m.mat
%       - NREM segments extracted using transitions.mat
%       - Filters: 100–300 Hz bandpass, 320 Hz lowpass
%

%% Parameters
fn = 1000;   % Sampling frequency
g  = 0.5;    % Step for threshold sweep

%% Filters
[b1,a1] = butter(3,[100 300]/(fn/2),'bandpass');  % Ripple band
[b2,a2] = butter(3,320/(fn/2));                   % Low-pass 320 Hz

%% Load data
load('transitions.mat');   % Sleep stage transitions
V17 = load('data17m.mat'); % Monopolar signal
V17 = V17.data17m;

% Apply low-pass
V17 = filtfilt(b2,a2,V17);

% Optional notch filtering
if notch==1
    Fline = [50 100 150 200 250.5 300];
    V17   = ft_notch(V17.', fn, Fline, 1, 2).'; 
end

% Band-pass filtered version
Mono17 = filtfilt(b1,a1,V17);

% Reduce to NREM segments
[V17,~]    = reduce_data(V17,transitions,fn,nrem);
[Mono17,~] = reduce_data(Mono17,transitions,fn,nrem);

disp('Loaded channels & performed bandpass');

%% Time asleep (minutes)
timeAsleep = sum(cellfun(@length,V17)) / fn / 60;

%% Threshold sweep values
DEMAIS = chtm + (-5:3)*g;  
rep    = numel(DEMAIS);

%% Scale and time vectors
signal2 = cellfun(@(x) x/0.195, Mono17,'UniformOutput',false);
ti      = cellfun(@(x) (0:numel(x)-1)/fn, signal2,'UniformOutput',false);

%% Ripple detection across thresholds
s172 = zeros(numel(signal2),rep);
for k = 1:rep
    [S2x,E2x,M2x] = cellfun(@(sig,t) ...
        findRipplesLisa(sig,t.',DEMAIS(k),DEMAIS(k)/2,[]), ...
        signal2, ti, 'UniformOutput',false);

    s172(:,k) = cellfun(@numel,S2x);
end

%% Ripple count
ripple2 = sum(s172);               % Total ripples per threshold
% rippleRate = sum(s172)/(timeAsleep*60); % Ripples/sec (optional)

%% Polynomial fit
[p,S,mu] = polyfit(DEMAIS,ripple2,rep-1);
y1 = polyval(p,DEMAIS,[],mu);

end
