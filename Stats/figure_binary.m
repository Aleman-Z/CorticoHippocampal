function figure_binary(aver,Xaver,lab)
    allscreen()
    s1=subplot(1,2,1);
    im(aver)
    colorbar('off')
    xlim([0 300])
    caxis([0 1])
    s1.YTickLabel=[{' '} lab{1} {' '} lab{3} {' '} lab{5} {' '}];
    xlabel('Frequency (Hz)')

    s2=subplot(1,2,2);
    im(Xaver)
    colorbar('off')
    xlim([0 300])
    caxis([0 1])
    s2.YTickLabel=[{' '} lab{2} {' '} lab{4} {' '} lab{6} {' '}];
    xlabel('Frequency (Hz)')
    t1=mtit('Plusmaze vs Baseline (p<0.05)');
end