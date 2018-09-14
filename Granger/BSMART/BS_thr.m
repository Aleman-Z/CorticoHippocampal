function BS_thr(Fxy3,Fyx3,th)

  comb(:,1)=[ones(3,1);2*ones(3,1);3*ones(3,1) ];
comb(:,2)=[[1:3]';[1:3]';[1:3]' ];

frang=1:1:300;
%
% Fxynew=Fxy3.*(Fxy3>0.10);
% Fyxnew=Fyx3.*(Fyx3>0.10);
%th=0.1
 
% Fxynew=(Fxy3>th);
% Fyxnew=(Fyx3>th);
Fxynew=(Fxy3);
Fyxnew=(Fyx3);


allscreen()
for ii=1:9
subplot(3,3,ii)
if comb(ii,1)~=comb(ii,2)
BS_plot2(Fxynew,Fyxnew,comb(ii,1),comb(ii,2),frang)
ylim([100 200])
xlim([150 250])
else
set(gca,'Color','k')   
end

end

end