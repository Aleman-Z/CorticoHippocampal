function figure_pval(aver2,Xaver2,lab)
allscreen()
s1=subplot(1,2,1)
aver2(aver2>=0.05)=NaN;
im(aver2)
xlim([0 300])
%caxis([0 1])
s1.YTickLabel=[{' '} lab{1} {' '} lab{3} {' '} lab{5} {' '}];
xlabel('Frequency (Hz)')
        oldcmap = colormap;
colormap( flipud(oldcmap) );        

s2=subplot(1,2,2)
Xaver2(Xaver2>=0.05)=NaN;
im(Xaver2)
xlim([0 300])
%caxis([0 1])
s2.YTickLabel=[{' '} lab{2} {' '} lab{4} {' '} lab{6} {' '}];
xlabel('Frequency (Hz)')
t1=mtit('Plusmaze vs Baseline (p<0.05)');
        oldcmap = colormap;
colormap( flipud(oldcmap) );
end