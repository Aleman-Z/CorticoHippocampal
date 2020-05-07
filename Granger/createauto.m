function [granger2]=createauto(data1,ord,condition)
%Parametric model Order 20
cfg2         = [];
cfg2.order   = ord;
cfg2.toolbox = 'bsmart';
mdata2       = ft_mvaranalysis(cfg2, data1);

cfg2        = [];
cfg2.method = 'mvar';
mfreq2      = ft_freqanalysis(cfg2, mdata2);

cfg2           = [];
cfg2.method    = 'granger';

if strcmp(condition,'yes')
    cfg2.granger.feedback    = 'yes';
    cfg2.granger    = [];
    cfg2.granger.conditional    = 'yes';   
end

granger2       = ft_connectivityanalysis(cfg2, mfreq2);

end