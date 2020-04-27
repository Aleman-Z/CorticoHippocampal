%freq3
function [mdam,mdam2,mdam3,mdam4]=small_window(freq3,w,win_size)

dam=((squeeze(mean(squeeze(freq3.powspctrm(:,w,:,1+win_size:end-win_size)),1)))); %Average all ripples.
mdam=mean(dam(:)); %Mean value 

freqs=freq3.freq;

%100 to 150 Hz
n1=sum(freqs<=150);
dam=((squeeze(mean(squeeze(freq3.powspctrm(:,w,1:n1,1+win_size:end-win_size)),1)))); %Average all ripples.
mdam2=mean(dam(:)); %Mean value 

%151 to 200 Hz
n2=sum(freqs<=200);
dam=((squeeze(mean(squeeze(freq3.powspctrm(:,w,n1+1:n2,1+win_size:end-win_size)),1)))); %Average all ripples.
mdam3=mean(dam(:)); %Mean value 

%201 to 250 Hz
n3=sum(freqs<=250);
dam=((squeeze(mean(squeeze(freq3.powspctrm(:,w,n2+1:n3,1+win_size:end-win_size)),1)))); %Average all ripples.
mdam4=mean(dam(:)); %Mean value 

%     FG3=freq3;
%     FG3.time=[-.05:.001:.05];
%     FG3.powspctrm=freq3.powspctrm(:,:,:,1+50:end-50);
% 
%     [ zmin100, zmax100] = ft_getminmax(cfg, FG3);
end

