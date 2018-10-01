 fs = 1000; 
 tstep = 2;%samples

 spec_win = fs/2/2/2; 
 spec_win=100;
%  spec_win = fs/2; 

 nfft = fs*30; 
%nfft = 100; 

 
  x=p{1}(1,:);
  y=p{1}(2,:);
 
  jo=tfcohf2(x,y,nfft,spec_win,tstep,fs);
  %%
  av1=linspace(0,500,size(jo,1));
  av2=linspace(-1.2,1.2,size(jo,2));
  imagesc(av2,av1,abs(jo))
  colormap(jet(256))
  ylim([0 300])
  xlim([-1 1])
  colorbar()
  %h=gcf;
 set(gca,'YDir','normal')
title('Coherence between Hippocampus and Parietal')
xlabel('Time (s)')
ylabel('Frequency (Hz)')
