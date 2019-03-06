%freq3
function [zmin100,zmax100]=smaller_window(freq3)

    FG3=freq3;
    FG3.time=[-.05:.001:.05];
    FG3.powspctrm=freq3.powspctrm(:,:,:,1+50:end-50);

    [ zmin100, zmax100] = ft_getminmax(cfg, FG3);
end

