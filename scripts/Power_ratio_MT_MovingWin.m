function [Pratio, PmeanBand, start_t, end_t] = Power_ratio_MT_MovingWin(signal, flo, fhi, win_size, ol_size, nw, SampleRate)

window = floor(win_size*SampleRate); 
overlap = floor(ol_size*SampleRate); 
ii = 1;
nSamples = length(signal);
start_t(1) = 1;               % frame number for start of each window
end_t(1) = start_t(1) + window;   % frame number for end of each window
while end_t(ii) < nSamples
    start_t(ii+1) = start_t(ii) + (window-overlap);
    end_t(ii+1) = start_t(ii+1) + window;
    ii = ii + 1;
end
start_t = start_t(1:end-1);
end_t = end_t(1:end-1);

nep = length(start_t); %number of epoches
nfft = 1024;

for ii = 1:nep
    
    [Pxx(ii,:),f] = pmtm(signal(start_t(ii):end_t(ii)), nw, nfft, SampleRate, 0.99);    
    % find the index of the closest value to flo in f
    [~, ind_lo] = min(abs(f-flo));
    % find the index of the closest value to flo in f
    [~, ind_hi] = min(abs(f-fhi));
 
    % caculate the area in the band
    PmeanBand(ii) = sum(Pxx(ii,1:ind_hi))-sum(Pxx(ii,1:ind_lo-1));
    % divide by total power to get power ration in the band
    PmeanTotal(ii) = sum(Pxx(ii,1:end));        
    Pratio(ii) = PmeanBand(ii)/PmeanTotal(ii);
end

start_t = start_t/SampleRate;
end_t = end_t/SampleRate;

end

