function[Fxy, Fyx]=BS_main(data2,order, spts, epts, winlen,fs, frang)

dat=data2;

order  = 4;
morder = order;
% spts   = 1;
% epts   = 18;
% winlen = 10;
% fs = 200;
% %frang = 1:0.5:fs/2;
% frang = 1:0.25:40;


%BS_order(dat,winlen,10)
mov_bi_model(dat,order,spts,epts,winlen);
[Fxy1,Fyx1] = mov_bi_ga(dat,spts,epts,winlen,morder,fs,frang);
Fxy=Fxy1;
Fyx=Fyx1;

end