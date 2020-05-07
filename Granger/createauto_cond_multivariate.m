function [granger2]=createauto_cond_multivariate(data1,ord)
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

% if strcmp(condition,'yes')
%     cfg2.granger.feedback    = 'yes';
%     cfg2.granger    = [];
    cfg2.granger.conditional    = 'yes';   
% end
cfg2.channelcmb  = {data1.label{1}, data1.label{2}, data1.label{3}};
cfg2.granger.sfmethod = 'multivariate';

cfg2.granger.block(1).name   = mfreq2.label{1};
cfg2.granger.block(1).label  = mfreq2.label(1);
cfg2.granger.block(2).name   = mfreq2.label{2};
cfg2.granger.block(2).label  = mfreq2.label(2);
cfg2.granger.block(3).name   = mfreq2.label{3};
cfg2.granger.block(3).label  = mfreq2.label(3);


granger2       = ft_connectivityanalysis(cfg2, mfreq2);

end