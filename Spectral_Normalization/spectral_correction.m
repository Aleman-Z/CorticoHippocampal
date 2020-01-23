function [FREQ4]=spectral_correction(freq4)

FREQ4=freq4;
matf=squeeze(freq4.powspctrm);
MATF=matf;
for i=1:size(matf,1)
   for ii=1:size(matf,3)
       MATF(i,:,ii)=squeeze(MATF(i,:,ii)).*freq4.freq;
   end
end

FREQ4.powspctrm(1,:,:,:)=MATF;


end