function [granger]=createauto_np_cond(data1,freqrange)
    cfg           = [];
    cfg.method    = 'mtmfft';
    cfg.taper     = 'dpss';
    cfg.output    = 'fourier';
    cfg.tapsmofrq = 2;
    cfg.pad = 10;
    cfg.foi=freqrange;
    %[0:1:500]
    freq          = ft_freqanalysis(cfg, data1);

%     cfg           = [];
%     cfg.method    = 'granger';
    
    
cfg           = [];
cfg.method    = 'granger';
cfg.granger.feedback    = 'yes';
cfg.granger    = [];
cfg.granger.conditional    = 'yes';

    
    
    granger = ft_connectivityanalysis(cfg, freq);
end
