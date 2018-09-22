function [granger]=createauto_np(data1,freqrange)
    cfg           = [];
    cfg.method    = 'mtmfft';
    cfg.taper     = 'dpss';
    cfg.output    = 'fourier';
    cfg.tapsmofrq = 2;
    cfg.pad = 10;
    cfg.foi=freqrange;
    %[0:1:500]
    freq          = ft_freqanalysis(cfg, data1);

    cfg           = [];
    cfg.method    = 'granger';
    granger = ft_connectivityanalysis(cfg, freq);
end
