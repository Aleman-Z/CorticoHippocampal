function [S, E, M] = findSpindlesWithPeaks(Filt_EEG,SignalPeaks,timestamps, DetectThreshold, LimitThreshold, fn,minpeak, varargin)
% [S, E, M] = findRipples(Filt_EEG, DetectThreshold, LimitThreshold, varargin)
% 
% INPUTS: 
% fn: Sampling frequency.
% Filt_EEG: EEG tsd filtered in the ripples (e.g. 100-300 Hz) range
% DetectThreshold: Threshold for detection of ripples 
% LimitThreshold: Threshold for finding the ripple boundaries
%
% PARAMETERS:
% Q1: number of cycles to check to find boundaries
% CloseThreshold: Closeness threhshold,if two ripple events are closer than
%   this,  lump them together
% MinRippleDuration: discard theta evants shorter than this
% OUTPUTS:
% S: ripple events start times
% E: ripple events end times
% M: ts object with ripple events peak times

% copyright (c) 1999 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%

% adapted for LG data FPB 2016


% parameters
Q1 = 3;
% CloseThreshold = 500 / 1000;
% MinRippleDuration = 500 / 1000;
CloseThreshold = 1000 / fn;
MinRippleDuration = 300 / fn;
MaxRippleDuration = 2000 / fn;



EEGStart = timestamps(1);
EEGEnd = timestamps(end);

% do it in chunks
% chunk length in seconds

LChunk = 300;

ChStart = EEGStart;
ChEnd = min(ChStart + LChunk, EEGEnd);
nChunks = (EEGEnd - EEGStart)/LChunk;
TRStart = [];
TREnd = [];
TRMax = [];
TRMaxValue = [];

i = 0;
% h = waitbar(0, 'Find Ripples...');

while ChStart < EEGEnd
%   waitbar(i/nChunks, h);

  t1 = find(timestamps >= ChStart, 1);
  t2 = find(timestamps >= ChEnd, 1);
  t = timestamps(t1:t2);
  eeg = Filt_EEG(t1:t2);
  
  sz = size(eeg);
  if sz(1) ~= 1
    eeg = eeg';    % we want to work with row vectors
    t = t';
  end
  
  

  
  de = diff(eeg);
  de1 = [de 0];
  de2 = [0 de];
  
  
  %finding peaks
  upPeaksIdx = find(de1 < 0 & de2 > 0);
  downPeaksIdx = find(de1 > 0 & de2 < 0);
  
  PeaksIdx = [upPeaksIdx downPeaksIdx];
  PeaksIdx = sort(PeaksIdx);
  
  Peaks = eeg(PeaksIdx);
  Peaks = abs(Peaks);
  
  %when a peaks is above threshold, we detect a ripple
  
  RippleDetectIdx = find(Peaks > DetectThreshold);
  DetectDiff = [0 diff(RippleDetectIdx)];
  RippleDetectIdx = RippleDetectIdx(DetectDiff > 2);
  RippleDetectIdx = RippleDetectIdx(RippleDetectIdx < length(Peaks)-Q1+1);
  RippleStart = zeros(1, length(RippleDetectIdx));
  RippleEnd = zeros(1, length(RippleDetectIdx));
  RippleMax = zeros(1, length(RippleDetectIdx));
  RippleMaxValue = zeros(1, length(RippleDetectIdx));
  for ii = 1:length(RippleDetectIdx) 
    CP = RippleDetectIdx(ii); % Current Peak
    % detect start of the ripple
    for j = CP-1:-1:Q1
      if all(Peaks(j-Q1+1:j) < LimitThreshold)
	
	break;
      end
    end
    RippleStart(ii) = j;
    %detect end of ripple
    for j = CP+1:length(Peaks)-Q1+1
      if all(Peaks(j:j+Q1-1)< LimitThreshold)
	
	break;
      end
    end
    RippleEnd(ii) = j;
    [RippleMaxValue(ii), RippleMax(ii)] = max(Peaks(RippleStart(ii):RippleEnd(ii)));
    RippleMax(ii) = RippleStart(ii) + RippleMax(ii) - 1;
  end
  
  TRStart = [TRStart t(PeaksIdx(RippleStart))]; %#ok<*AGROW>
  TREnd = [TREnd t(PeaksIdx(RippleEnd))];
  TRMax = [TRMax t(PeaksIdx(RippleMax))];
  TRMaxValue = [TRMaxValue RippleMaxValue];
  i = i+1;
  ChStart = ChStart + LChunk;

  ChEnd = min(ChStart + LChunk, EEGEnd);
end
% close(h);
i = 2;


while i <= length(TRStart)
  
  if (TRStart(i) - TREnd(i-1)) < CloseThreshold
    TRStart = [TRStart(1:i-1) TRStart(i+1:end)];
    TREnd = [TREnd(1:i-2) TREnd(i:end)];
    [~, ix] = max([TRMaxValue(i-1) TRMaxValue(i)]);
    TRMax = [TRMax(1:i-2) TRMax(i - 2 + ix) TRMax(i+1:end)]; 
  else
    i = i +1 ;
    
  end
  
end
length(TRStart);
length(TREnd);
i = 1;
while i <= length(TRStart)
  if(TREnd(i)+0.000001 - TRStart(i)) < MinRippleDuration
    TRStart = [TRStart(1:i-1) TRStart(i+1:end)];
    TREnd = [TREnd(1:i-1) TREnd(i+1:end)];
    TRMax = [TRMax(1:i-1), TRMax(i+1:end)];
  else
    i = i+ 1;
    
  end
  
end

%%Max duration criteria
i = 1;
while i <= length(TRStart)
  if(TREnd(i)-0.000001 - TRStart(i)) >= MaxRippleDuration
    TRStart = [TRStart(1:i-1) TRStart(i+1:end)];
    TREnd = [TREnd(1:i-1) TREnd(i+1:end)];
    TRMax = [TRMax(1:i-1), TRMax(i+1:end)];
  else
    i = i+ 1;
    
  end
  
end

%Minimum amount of peaks criteria
i=1;
while i <= length(TRStart)
x=SignalPeaks(findclosest(timestamps,TRStart(i)):findclosest(timestamps,TREnd(i)));
[~,locs,~,pr] =findpeaks(-x);
clus=kmeans(pr,2);
c1=pr(find(clus==1));
c1=max(c1);
c2=pr(find(clus==2));
c2=max(c2);
if c1>c2
    locs=(find(clus==1));
else
    locs=(find(clus==2));
end

%    if length(locs)< minpeak &&  length(locs)> minpeak-2
    if length(locs)>= minpeak
        
%     TRStart = [TRStart(1:i-1) TRStart(i+1:end)];
%     TREnd = [TREnd(1:i-1) TREnd(i+1:end)];
%     TRMax = [TRMax(1:i-1), TRMax(i+1:end)];
i=i+1;    
    else
%         i=i+1;
    TRStart = [TRStart(1:i-1) TRStart(i+1:end)];
    TREnd = [TREnd(1:i-1) TREnd(i+1:end)];
    TRMax = [TRMax(1:i-1), TRMax(i+1:end)];

    end
end
  
S = (TRStart);
E = (TREnd);
M = (TRMax);
end