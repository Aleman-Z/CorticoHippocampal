function powerspectrum(f_signal)
[NC]=epocher(f_signal,2);
av=mean(NC,1);
av=artifacts(av,10);
%Limits artifacts to a maximum of 10
if sum(av)>=10
av=artifacts(av,20);    
end
av=not(av);
%Removing artifacts.
NC=NC(:,av);
 [pxx,f]= periodogram(NC,hann(size(NC,1)),size(NC,1),1000);
%[pxx,f]=pwelch(NC,[],[],[],1000);

%hann(length(NC))
px=mean(pxx,2);
% error('stop')
%plot(f,10*log10(px),'Color',myColorMap(iii,:),'LineWidth',1.5)
semilogy(f,(px)/sum(px))
xlim([0 300])
end