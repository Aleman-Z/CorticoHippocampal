function [gra,gra2]=fieldtrip_adapted(q,ord,ro)
    timecell=create_timecell(ro,length(q));
    fn=1000;
    data1.trial=q;
    data1.time= timecell; %Might have to change this one 
    data1.fsample=fn;
    data1.label=cell(3,1);
    data1.label{1}='Hippocampus';
    data1.label{2}='Parietal';
    data1.label{3}='PFC';
    %data1.label{4}='Reference';

    %Parametric model
    [granger1]=createauto(data1,ord)

    %Non-parametric model
    [granger2]=createauto_np(data1)
    
    %cfg         = [];
    %cfg.order   = ord;
    %cfg.toolbox = 'bsmart';
    %mdata       = ft_mvaranalysis(cfg, data1);
    
    %cfg        = [];
    %cfg.method = 'mvar';
    %mfreq      = ft_freqanalysis(cfg, mdata);
    %cfg           = [];
    %cfg.method    = 'granger';
    %granger1       = ft_connectivityanalysis(cfg, mfreq);

    gra=granger1.grangerspctrm;
    
    gra2=granger2.grangerspctrm;
    %gra=granger1;

end
