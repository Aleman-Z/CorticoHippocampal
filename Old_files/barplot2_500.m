function barplot2_500(p4,p3)
fn=1000;
data=p4;

[cfs,f] = cwt(data,fn,'TimeBandwidth',100);

%subplot(1,2,1)
subplot(3,2,5)

%t=linspace(-0.2,0.2, length(cfs));

t=linspace(-0.5,0.5, length(cfs));
helperCWTTimeFreqPlot(cfs,t,f,'surf','CWT of Quadratic Chirp','Seconds','Hz')
%plotter1(S,t,f)
title('Spectrogram Wideband (High frequency resolution)')
xticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5])
xticklabels({'-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5'})
%ylim([3.5 30])
%ylim([5 20])
%ylim([5.4 22])
ylim([5.4 100])


data=p3;


[cfs,f] = cwt(data,fn,'TimeBandwidth',100);

% [S,t,f] = mtspecgramc( data, movingwin, params );
subplot(3,2,6)
%t=linspace(-0.2,0.2, length(t));

t=linspace(-0.5,0.5, length(cfs));
%plotter1(S,t,f)
helperCWTTimeFreqPlot(cfs,t,f,'surf','CWT of Quadratic Chirp','Seconds','Hz')
%ylim([100 230])
ylim([100 300])

title('Spectrogram Bandpass (High frequency resolution)')

xticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5])
xticklabels({'-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5'})


end