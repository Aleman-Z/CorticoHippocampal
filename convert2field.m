function [newdata] = convert2field(dat)
% convert2field: Convert custom data into FieldTrip format
%
% INPUT:
%   dat - cell array where each cell is [channels x time] or [time x channels]
%
% OUTPUT:
%   newdata - FieldTrip-compatible structure with fields:
%             .trial    - cell array of trials (channels x time)
%             .time     - cell array of time vectors
%             .label    - channel labels
%             .fsample  - sampling frequency
%
% Example:
%   newdata = convert2field(myData);

%% ---------------- Convert trials ----------------
nTrials = length(dat);
cc = cell(1, nTrials);

for i = 1:nTrials
    trialData = dat{i};
    % Ensure orientation is channels x time
    if size(trialData,1) < size(trialData,2)
        trialData = trialData.'; 
    end
    cc{i} = trialData;
end

%% ---------------- Build output struct ----------------
newdata.trial    = cc;
newdata.fsample  = 1000;   % Hz (adjust if needed)

% Time vector (assuming fixed length = 2401 samples, -1.2 to 1.2 s)
nSamples = size(cc{1},2);
tee = linspace(-1.2,1.2,nSamples);

tim = repmat({tee}, 1, nTrials);
newdata.time = tim;

% Channel labels
nChannels = size(cc{1},1);
newdata.label = arrayfun(@num2str, 1:nChannels, 'UniformOutput', false);

end
