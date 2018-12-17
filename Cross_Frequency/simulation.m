cfg = [];
cfg.method   = 'amplow_amphigh';
cfg.fsample  = 1000;
cfg.trllen   = 10;
cfg.numtrl   = 10;
cfg.output   = 'all';
% first frequency
cfg.s1.freq  = 6;
cfg.s1.phase = 0;
cfg.s1.ampl  = 1;
% second frequency
cfg.s2.freq  = 20;
cfg.s2.phase = 0;
cfg.s2.ampl  = 1;
% DC shift of s1 and s2
cfg.s3.freq  = 0;
cfg.s3.phase = 0;
cfg.s3.ampl  = 1; %determines amount of modulation, should be at least s4.ampl
% amplitude modulation (AM)
cfg.s4.freq  = 1; %frequency of this signal should be lower than s1 and s2
cfg.s4.phase = -1*pi;
cfg.s4.ampl  = 1;
% noise
cfg.noise    = 0.1;

data = ft_freqsimulation(cfg);

%%
%     cd(strcat('D:\internship\',num2str(Rat)))
    addpath D:\internship\fieldtrip-master
    InitFieldtrip()
