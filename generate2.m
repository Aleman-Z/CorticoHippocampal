%Hippocampus Bipolar
%Hippocampus Monopolar

function [p3, p5,cellx,cellr,cfs,f]=generate2(carajo,veamos, Bip17,S17,label1,label2,Num)
fn=1000;
% figure('units','normalized','outerposition',[0 0 1 1])
[TI,TN, cellx,cellr,to,tu]=win(carajo,veamos,Bip17,S17,Num);
[cellx,cellr]=clean(cellx,cellr);

% cellx{2}=cellx{1};
% 
% cellr{2}=cellr{1};
% for i=1:17
% %     if i~=2
%     plot(cellx{i})
%     hold on
% %     end
% end
% cellx{37}=cellx{36};
% cellr{37}=cellr{36};
[p3 ,p4]=eta2(cellx,cellr,Num,1000);
%%%%mtit(strcat(label1,' (',label2,')'),'fontsize',14,'color',[1 0 0],'position',[.5 1 ])

p5=p4;
% Wn2=[30/(fn/2)]; % Cutoff=500 Hz
% [b2,a2] = butter(3,Wn2); %Filter coefficients for LPF
% p4=filtfilt(b2,a2,p4);
% % % % % % % % % % % % % subplot(3,2,5)
% % % % % % % % % % % % % barplot2_ft(cellx,timecell,[100:1:300])
% % % % % % % % % % % % % 
% % % % % % % % % % % % % subplot(3,2,6)
% % % % % % % % % % % % % barplot2_ft(cellr,timecell,[100:1:300])

% barplot2(p4,p3,Num,1000);
% [cfs,f]=barplot3(p4,p3,Num);

%Replace with GIo's code

cfs=[];
f=[];
end


