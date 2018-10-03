function barplot3_1000(p4,p3)
fn=1000;
data=p4;

[cfs,f] = cwt(data,fn,'TimeBandwidth',4);

%subplot(1,2,1)
subplot(3,2,3)

%t=linspace(-0.2,0.2, length(cfs));

t=linspace(-1,1, length(cfs));
helperCWTTimeFreqPlot(cfs,t,f,'surf','CWT of Quadratic Chirp','Seconds','Hz')
%plotter1(S,t,f)
title('Spectrogram Wideband (High time resolution)')
% xticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5])
% xticklabels({'-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5'})
% xticks([-1 -0.9 -0.8 -0.7 -0.6 -0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1])
% xticklabels({'-1', '-0.9', '-0.8', '-0.7', '-0.6', '-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1'})

xticks([-1 -0.8 -0.6 -0.4 -0.2  0  0.2  0.4  0.6  0.8  1])
xticklabels({'-1',  '-0.8',  '-0.6','-0.4', '-0.2', '0', '0.2', '0.4','0.6','0.8',  '1'})

%ylim([3.5 30])
%ylim([5 20])
%ylim([5.4 22])
ylim([5.4 30])


data=p3;


[cfs,f] = cwt(data,fn,'TimeBandwidth',40);

% [S,t,f] = mtspecgramc( data, movingwin, params );
subplot(3,2,4)
%t=linspace(-0.2,0.2, length(t));

t=linspace(-1,1, length(cfs));
%plotter1(S,t,f)
helperCWTTimeFreqPlot(cfs,t,f,'surf','CWT of Quadratic Chirp','Seconds','Hz')
%ylim([100 230])
ylim([100 300])

title('Spectrogram Bandpass (High time resolution)')

% xticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5])
% xticklabels({'-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5'})
% xticks([-1 -0.9 -0.8 -0.7 -0.6 -0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1])
% xticklabels({'-1', '-0.9', '-0.8', '-0.7', '-0.6', '-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1'})

xticks([-1 -0.8 -0.6 -0.4 -0.2  0  0.2  0.4  0.6  0.8  1])
xticklabels({'-1',  '-0.8',  '-0.6','-0.4', '-0.2', '0', '0.2', '0.4','0.6','0.8',  '1'})


end
