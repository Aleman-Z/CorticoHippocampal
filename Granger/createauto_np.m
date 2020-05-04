function [granger]=createauto_np(data1,freqrange,condition)
    cfg           = [];
    cfg.method    = 'mtmfft';
    cfg.taper     = 'dpss'; 
    cfg.output    = 'fourier'; 
%     cfg.tapsmofrq = 2; %1/1.2
    cfg.tapsmofrq = 4; %1/1.2
    
    cfg.pad = 10;
    cfg.foi=freqrange;
    %[0:1:500]
    freq          = ft_freqanalysis(cfg, data1);

    cfg           = [];
    cfg.method    = 'granger';
    
    if strcmp('yes',condition)
        cfg.granger.feedback    = 'yes';
        cfg.granger    = [];
        cfg.granger.conditional    = 'yes'; %Switch to no for pairwise. 
    end
    
    granger = ft_connectivityanalysis(cfg, freq);
end
