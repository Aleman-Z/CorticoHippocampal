function [cellx,cellr]=win(cara,veamos,Bip17,S17,Num)
%function [TI,TN, cellx,cellr,to,tu]=win(cara,veamos,Bip17,S17,Num)
count=0;
clear TI TN cellx cellr tu to
fn=1000;
%for index=1:length(cara)
for index=1:size(cara,1)
    
% index=3;
% index
% length(cara)
% whos cara
checa=cara(index,:);
maxch=checa{3};

%200 ms window before and after= 400+1
max1=maxch-(Num/1000);
max2=maxch+(Num/1000);

max1s=max1*(fn);
max2s=max2*(fn);

% %Start and end of SWR in samples
% mu1=checa{1}*(fn);
% mu2=checa{2}*(fn);
%
epoch=veamos(index);

% signal=M17{epoch};
signal=Bip17{epoch};
signalwave=S17{epoch};
% t=(0:length(signal)-1)*(1/fn); %IN SECONDS

lm=length(maxch);

%

for ii=1:lm
   checksize=max(round(max1s(1,ii)):round(max2s(1,ii)));


%Windows
if checksize>length(signal) || round(max1s(1,ii))== 0 || round(max1s(1,ii))< 0
    
  sn=nan;  
  sn1=nan;
   
 else
    sn=signal(round(max1s(1,ii)):round(max2s(1,ii)));
    sn1=signalwave(round(max1s(1,ii)):round(max2s(1,ii)));
end


count=count+1;
%Windows
cellx{count,1}=sn1;
cellr{count,1}=sn;
%Ripples


end

% tn=t(max1s:max2s);
% sn=signal(max1s:max2s);
% sn1=signalwave(max1s:max2s);    
end
end
