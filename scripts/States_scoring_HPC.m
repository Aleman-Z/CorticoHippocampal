clc
clear

SampleRate = 20000;  % EEG sampling rate
DS_fac = 100;        % downsampling factor, adjust accordingly

% importing eeg signals
EEG = abfload('C:\Users\mmlab\Mojtaba\Data\20180926\LFP\2018_09_26_0003.abf','start',1,'stop','e');
LFP_HPC = EEG(:,1);

% filtering HPC 
[z,p,k] = cheby1(4,0.3,2*[.2 100]/SampleRate,'bandpass');
[sos,g] = zp2sos(z,p,k);
HPC_filt = filtfilt(sos,g,double(LFP_HPC));
HPC_filt_ds = downsample(HPC_filt, DS_fac);
SampleRate_ds = SampleRate/DS_fac;

% Calculating P_theta/P_T
% [Pratio, start_t, finish_t] = Power_ratio_MT_MovingWin(signal, flo, fhi, win_size, ol_size, nw, SampleRate)
[ratio_theta, ~, start_t, end_t] = Power_ratio_MT_MovingWin(HPC_filt_ds, 3.5, 4.5, 6, 3, 4, SampleRate_ds);
% calcualting P_SW/P_T
[ratio_sw, ~, start_t, end_t] = Power_ratio_MT_MovingWin(HPC_filt_ds, .3, 1.5, 6, 3, 3, SampleRate_ds);


% scoring rem, nrem and transitory epochs
index_rem = ratio_theta > 0.4;   % adjust thresholds if necessary
index_nrem = ratio_sw > 0.4;

index_trans = 1 - index_rem - index_rem;
index_trans(index_trans==-1) = 1;

index_rem(index_trans==1) = 0;
index_nrem(index_trans==1) = 0;


