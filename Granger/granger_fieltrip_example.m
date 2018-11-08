addpath(genpath('C:\Users\addri\Documents\MATLAB\mvgc_v1.0'))

cfg             = [];
cfg.ntrials     = 500;
cfg.triallength = 1;
cfg.fsample     = 200;
cfg.nsignal     = 3;
cfg.method      = 'ar';

cfg.params(:,:,1) = [ 0.8    0    0 ; 
                        0  0.9  0.5 ;
                      0.4    0  0.5];
                      
cfg.params(:,:,2) = [-0.5    0    0 ; 
                        0 -0.8    0 ; 
                        0    0 -0.2];
                        
cfg.noisecov      = [ 0.3    0    0 ;
                        0    1    0 ;
                        0    0  0.2];

data              = ft_connectivitysimulation(cfg);

%%
cfg         = [];
cfg.order   = 5;
cfg.toolbox = 'bsmart';
mdata       = ft_mvaranalysis(cfg, data);
%%
cfg        = [];
cfg.method = 'mvar';
mfreq      = ft_freqanalysis(cfg, mdata);
%%
cfg           = [];
cfg.method    = 'mtmfft';
cfg.taper     = 'dpss';
cfg.output    = 'fourier';
cfg.tapsmofrq = 2;
freq          = ft_freqanalysis(cfg, data);
%%
cfg           = [];
cfg.method    = 'granger';
granger       = ft_connectivityanalysis(cfg, freq);

cfg           = [];
cfg.parameter = 'grangerspctrm';
cfg.zlim      = [0 1];
ft_connectivityplot(cfg, granger);
%%
cfg           = [];
cfg.method    = 'granger';
cfg.granger.feedback    = 'yes';
cfg.granger    = [];
cfg.granger.conditional    = 'yes';

granger22       = ft_connectivityanalysis(cfg, freq);

cfg           = [];
cfg.parameter = 'grangerspctrm';
cfg.zlim      = [0 1];
ft_connectivityplot(cfg, granger22);


%%
 figure()
 plot_spw2(granger.grangerspctrm,200)
%%
figure()
MA=convcond(granger22);
plot_spw2(MA)