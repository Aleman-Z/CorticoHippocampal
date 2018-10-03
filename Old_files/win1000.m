function [TI,TN, cellx,cellr,to,tu]=win1000(carajo,veamos,Bip17,S17)
count=0;
clear TI TN cellx cellr tu to
fn=1000;
for index=1:length(carajo)
% index=3;

checa=carajo(index,:);
maxch=checa{3};

%500 ms window before and after
max1=maxch-(1000/1000);
max2=maxch+(1000/1000);

max1s=max1*(fn);
max2s=max2*(fn);

%Start and end of SWR 
mu1=checa{1}*(fn);
mu2=checa{2}*(fn);
%
epoch=veamos(index);

% signal=M17{epoch};
signal=Bip17{epoch};
signalwave=S17{epoch};
t=(0:length(signal)-1)*(1/fn); %IN SECONDS

lm=length(maxch);

%

for ii=1:lm
   
    checksize=max(round(max1s(1,ii)):round(max2s(1,ii)));
    if checksize>length(t)
    tn=t(round(max1s(1,ii)):end); %Window length
    else
 
       if max1s(1,ii)<0
           max1s(1,ii)=1;
       end
tn=t(round(max1s(1,ii)):round(max2s(1,ii))); %Window length
    end
ti=t(round(mu1(1,ii)):round(mu2(1,ii))); %Ripple length

%Windows
if checksize>length(signal)
sn=signal(round(max1s(1,ii)):end);
sn1=signalwave(round(max1s(1,ii)):end);

else
sn=signal(round(max1s(1,ii)):round(max2s(1,ii)));
sn1=signalwave(round(max1s(1,ii)):round(max2s(1,ii)));
end
%Ripples
sno1=signal(round(mu1(1,ii)):round(mu2(1,ii)));
sno2=signalwave(round(mu1(1,ii)):round(mu2(1,ii)));

count=count+1;
%Windows
cellx{count,1}=sn1;
cellr{count,1}=sn;
%Ripples
tu{count,:}=sno1;
to{count,:}=sno2;
%Times
TN{count,:}=tn;
TI{count,:}=ti;

end

% tn=t(max1s:max2s);
% sn=signal(max1s:max2s);
% sn1=signalwave(max1s:max2s);    
end
end