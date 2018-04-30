function [win]=artifacts(vectormean,k)

%% Outlier detection with IQR method
y = quantile(vectormean,[.25 .75]);
IQR=y(2)-y(1);
Y=[y(1)-k*(IQR) y(2)+k*(IQR)]; %Whiskers

%% 1.5 IQR method Thresholding 
vectorm=vectormean;

win2=vectorm>(Y(2)) ; %Above Upper whiskers
win1=vectorm<(Y(1)) ; %Below Lower whiskers
win=win1+win2; %Outliers
end