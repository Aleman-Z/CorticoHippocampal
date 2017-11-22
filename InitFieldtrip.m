function InitFieldtrip(varargin)
cd fieldtrip-master
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
cd ..
end