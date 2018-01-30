function[P2]=avg_samples(p,timecell)
ft_data1 = [];
ft_data1.fsample = 1000;
tt=linspace(-5,5,1000);
ft_data1.trial = p; % q should be larger than +/-500 ms. Better to use 1 sec. 

ft_data1.time = (timecell);

%ft_data1.time = {[tt;tt;tt;tt]};

ft_data1;

%ft_data1.label = {'Hippo'; 'Parietal'; 'PFC';'REF'};
ft_data1.label = {'Hippo'; 'Parietal'; 'PFC'};

cfg = [];

    cfg.channel            = 'all';
    cfg.trials             = 'all';
    cfg.covariance         = 'no';
    cfg.covariancewindow   = 'all';
    cfg.keeptrials         = 'yes';
    cfg.removemean         = 'no';
    cfg.vartrllength       = 0;
    
   avg= ft_timelockanalysis(cfg,ft_data1);
   P2=avg.avg;
end