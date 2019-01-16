%%
[pxx,f]=pmtm(NC,4,[],1000);

PXX{k}=pxx;


subplot(1,2,1)
px=mean(pxx,2);
s=semilogy(f,(px),'Color',myColorMap(k,:),'LineWidth',2);
xlim([0 300])
%%

Fline=[31 32 33.2 34 66.4 99.6 166.5 232.9];
%Fline=[ 33 ];

% 
% %[NC] = ft_notch(NC, Fsample,Fline,20,0.5);
% [NC] = ft_notch(NC, Fsample,Fline,0.5,0.5);
% 
nu1=50;
nu2=10;
[NCC] = ft_notch(NC, Fsample,Fline,nu1,nu2);
%[NCC] = ft_preproc_dftfilter(NC, Fsample, Fline);
[pxx,f]=pmtm(NCC,4,[],1000);

PXX{k}=pxx;


subplot(1,2,2)
px=mean(pxx,2);
s=semilogy(f,(px),'Color',myColorMap(k,:),'LineWidth',2);
xlim([0 300])
