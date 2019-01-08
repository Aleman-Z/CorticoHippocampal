function [CFC]=xfreq(LFsig,HFsig,met,kt)

        cfg              =[];
        %cfg.method       ='plv';   % or mvl/mi
        cfg.method       =met;   % or mvl/mi
        cfg.keeptrials   = kt;
        CFC              = ft_crossfrequencyanalysis(cfg,LFsig,HFsig);

end