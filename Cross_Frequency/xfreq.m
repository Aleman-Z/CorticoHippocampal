function [CFC]=xfreq(LFsig,HFsig,met)

        cfg              =[];
        %cfg.method       ='plv';   % or mvl/mi
        cfg.method       =met;   % or mvl/mi
        cfg.keeptrials   = 'no';
        CFC              = ft_crossfrequencyanalysis(cfg,LFsig,HFsig);

end