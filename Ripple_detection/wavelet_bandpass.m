function [output]=wavelet_bandpass(signal)

timeband=80;
fb = cwtfilterbank('SamplingFreq',1000,'SignalLength',length(signal),'Wavelet','morse','FrequencyLimits',[9 20],'WaveletParameters',[3,timeband]);
[psidft,f] = freqz(fb);
bpcf = centerFrequencies(fb);
[~,idx] = min(abs(bpcf-14)); %Closest frequency to 14Hz
 [psi,t] = wavelets(fb);
% sca = scales(fb);
% [~,idx] = min(abs(sca-1));

% m = psi(idx,:);
% plot(t,real(m))
% % hold on 
% % plot(t,imag(m))
% xlim([-0.5 0.5])
% xticks([-0.5:0.25:0.5])

C=cwt(signal,'FilterBank',fb);
output=C(idx,:);
output=abs(output);
output=output.^2;
output=output.';

end