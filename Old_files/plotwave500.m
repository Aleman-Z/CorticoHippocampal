function plotwave500(D1, D2, D3, D4,D5)
fn=1000;
D=cell(5,1);
D{1,1}=D1;
D{2,1}=D2;
D{3,1}=D3;
D{4,1}=D4;
D{5,1}=D5;
% 
valor=30;
% valor=linspace(3.1,30,5);
% valor=sort(valor,'descend');
valor=[3.1 3.1 3.1 3.1 19];

for j=1:5
[cfs,f] = cwt(D{j,1},fn,'TimeBandwidth',valor(j));

t=linspace(-0.5,0.5, length(cfs));
subplot(5,2,2*j)
length(cfs)
length(t)
length(f)

helperCWTTimeFreqPlot(cfs,t,f,'surf','CWT of Quadratic Chirp','Seconds','Hz')
title('Corresponding Spectrogram')
xticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5])
xticklabels({'-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5'})

end

end