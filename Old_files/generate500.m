
function [p3,p5,cellx,cellr,cfs,f]=generate500(carajo,veamos, Bip17,S17,label1,label2)
fn=1000;
figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win500(carajo,veamos,Bip17,S17);
[cellx,cellr]=clean(cellx,cellr);
% cellx{37}=cellx{36};
% cellr{37}=cellr{36};
[p3 p4]=eta500(cellx,cellr);
mtit(strcat(label1,' (',label2,')'),'fontsize',14,'color',[1 0 0],'position',[.5 1 ])

p5=p4;
% Wn2=[30/(fn/2)]; % Cutoff=500 Hz
% [b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
% p4=filtfilt(b2,a2,p4);

barplot2_500(p4,p3)
[cfs,f]=barplot3_500(p4,p3)
end

