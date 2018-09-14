function [Fxy3, Fyx3]=BS(p,q)

np=nan(length(p{1}),3,length(p));
for i=1:length(p)
 aver=p{i};   
 aver=aver.';
 np(:,:,i)=aver;
end

nq=nan(length(q{1}),3,length(q));
for i=1:length(q)
 aver=q{i};   
 aver=aver.';
 nq(:,:,i)=aver;
end

%
dat=np;
frang=0:1:300; %Might require starting with 1. 
fs=1000;

order=4;
spts   = 1;
epts   = 400;
winlen = 10;
%
data1 = pre_sube(dat);

data2 = pre_sube_divs(dat);

data3 = pre_subt(dat);

data4 = pre_subt_divs(dat);
%
da1=BS_order(data1);
da2=BS_order(data2);
da3=BS_order(data3);
da4=BS_order(data4);
Da=[da1; da2; da3; da4];

mDa=min(Da);
if mDa==Da(1,:)
    dat=data1;
end

if mDa==Da(2,:)
    dat=data2;    
end
if mDa==Da(3,:)
     dat=data3;  
end
if mDa==Da(4,:)
   dat=data4;          
end

[Fxy3, Fyx3]=BS_main(dat,order, spts, epts, winlen,fs,frang);

end