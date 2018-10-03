
for j=1:20
for row=1:3
for col=1:3
  subplot(3,3,(row-1)*3+col);
  %plot(granger.freq, squeeze(granger.grangerspctrm(row,col,:)))
  plot(granger.freq, squeeze(granger.grangerspctrm(row,col,:,j)),'LineWidth',1,'Color',[0 0 0])
   hold on
%   %plot(granger.freq, squeeze(chocho(row,col,:)))
%  %hold on
    plot(granger1.freq, squeeze(granger1.grangerspctrm(row,col,:)))
     ylim([0 1])
end
end
end

%%
pe=p{1};
pe=pe(1,:);

pe=pe(2:end);
pe=[pe];
pa=padarray(pe,[0,500]);
%%
% [cfs,f] = cwt(p4,fn,'TimeBandwidth',4);
[cfs,f] = cwt(pe,1000) ;
%[cfs1,f1] = cwt(pe,1000) ;
[cfs1,f1] = cwt(pa,1000) ;

