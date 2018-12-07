function plot_field(granger22)
    cfg           = [];
    cfg.parameter = 'grangerspctrm';
%     cfg.zlim      = [0 1];
    ft_connectivityplot(cfg, granger22);
end
