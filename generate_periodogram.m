function[px,f,NC]=generate_periodogram(sig2,w,Rat,iii)
f_signal=sig2{2*w-1};

%Amplitude normalization
%f_signal=median(f_signal);

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

NCount(iii,1)=size(NC,2);

%Notch filter
Fsample=1000;
Fline=[50 100 150 200 250 300 66.5 133.5 266.5];

if w~=1 && w~=4  %Dont filter Hippocampus nor Reference 
[NC] = ft_notch(NC.', Fsample,Fline,0.5,0.5);
NC=NC.';
end

if Rat==26 %Noise peak was only observed in Rat 26
    if w==4  % Reference 
     Fline=[208 209];

    [NC] = ft_notch(NC.', Fsample,Fline,0.5,0.5);
    NC=NC.';
    end
end
%Equal number of epochs.

% if  Rat==26
%     NC=NC(:,end-1845+1:end);
% else
%     NC=NC(:,end-2500+1:end);
% end
% NC=zscore(NC);
% % % % % % NC=NC(:,end-1845+1:end);

 [pxx,f]= periodogram(NC,hann(size(NC,1)),size(NC,1),1000);
%[pxx,f]=pwelch(NC,[],[],[],1000);

%hann(length(NC))
px=mean(pxx,2);
% error('stop')
%plot(f,10*log10(px),'Color',myColorMap(iii,:),'LineWidth',1.5)


end