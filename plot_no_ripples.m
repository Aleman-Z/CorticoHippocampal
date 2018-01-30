%p is SUS2
allscreen()

subplot(4,2,1)
plot(timecell{1},P2_SUS(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('Wide Band Event-triggered Average')


subplot(4,2,2)
plot(timecell{1},P1_SUS(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
narrow_colorbar()
title('High Gamma power Event-triggered Average')

subplot(4,2,3)
%freq=barplot2_ft(p,timecell,[0:.5:30],w)
freq=justtesting(SUS2,timecell,[1:0.5:30],w,0.5)
title('Spectrogram Widepass (High temporal resolution)')

subplot(4,2,5)
[stats]=stats_freq(freq,label1{2*w-1},baseline1);
title(strcat('Statistical Test with Baseline: [', num2str(baseline1(1)),': ',num2str(baseline1(2)),']',' sec'))

subplot(4,2,7)
[stats]=stats_freq(freq,label1{2*w-1},baseline2);
title(strcat('Statistical Test with Baseline: [', num2str(baseline2(1)),': ',num2str(baseline2(2)),']',' sec'))

subplot(4,2,4)
freq=barplot2_ft(SUS,timecell,[100:1:300],w)
%freq=justtesting(q,timecell,[100:1:300],w,0.5)
title('Spectrogram Bandpass (High temporal resolution)')

subplot(4,2,6)
[stats]=stats_freq(freq,label1{2*w-1},baseline1);
title(strcat('Statistical Test with Baseline: [', num2str(baseline1(1)),': ',num2str(baseline1(2)),']',' sec'))

subplot(4,2,8)
[stats]=stats_freq(freq,label1{2*w-1},baseline2);
title(strcat('Statistical Test with Baseline: [', num2str(baseline2(1)),': ',num2str(baseline2(2)),']',' sec'))


mtit('NO RIPPLES','fontsize',14,'color',[1 0 0],'position',[.5 0.8 ])
labelthr=strcat('Thr:',num2str(round(thr(level+1))));
mtit(strcat(labelthr),'fontsize',14,'color',[1 0 0],'position',[.5 0.9 ])

mtit(strcat(label1{2*w-1},' (',label2{1},')'),'fontsize',14,'color',[1 0 0],'position',[.5 1 ])

