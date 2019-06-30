function kc = findKC(EEGdeep, EEGsup)

hf = designfilt('highpassiir', 'StopbandFrequency', 140, 'PassbandFrequency', 160,...
    'StopbandAttenuation', 60, 'PassbandRipple', 1, 'SampleRate', 2083);
low_env_filt = designfilt('lowpassiir', 'PassbandFrequency', 8, 'StopbandFrequency', 10,...
    'PassbandRipple', 1, 'StopbandAttenuation', 60, 'SampleRate', 2083);
hg = filtfilt(hf, EEGdeep);
hgal = filtfilt(low_env_filt, abs(hg));

thr_dw = 0.42;
thr = 0.0091;
dw = -EEGdeep+EEGsup > thr_dw;
ds = hgal < thr;

kc = dw .* ds;