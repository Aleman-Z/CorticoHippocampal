 xq=0:0.5:500;

for k=1:length(q)
% plot(q{k})   
%  hold on
% [fi,am]=periodogram(q{6});
 [pxx,f]= periodogram(q{k},hann(length(q{k})),length(q{k}),1000);
%  semilogy(f,(pxx))
 vq1 = interp1(f,pxx,xq,'PCHIP');
 VQ(k,:)=vq1;
 U(op)=interp1(VQ(k,:),xq,max(VQ(k,:)));
 %%
%  semilogy(f,(pxx))
%  hold on
%  semilogy(xq,(vq1))
 k
end

%%
af=mean(VQ,1);
plot(xq,af)

AV=interp1(af,xq,max(af));
%%
% U=interp1(VQ,(repmat(xq,2000,1)),max(VQ.'));
for op=1:length(q)
  U(op)=interp1(VQ(op,:),xq,max(VQ(op,:)));
  op
end

