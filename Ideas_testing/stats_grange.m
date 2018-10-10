 A=COMBO2{1};
 plot(A(:,1))
 hold on
 A=COMBO2{1};
 plot(A(:,1))
 
 %%
 gr=squeeze(mean(GRC1,4));
 %%
  av1=(COMBO2{3});
  av1=av1(:,1:size(GRC1,4));
  
  av2=(COMBO2{3});
  av2=av2(:,size(GRC1,4)+1:end);
  %%
  plot(je.g1_f,mean(av1,2))
  hold on
plot(je.g1_f,mean(av2,2))
%%
close all
CHAL=zeros(501,1);
KAL=zeros(501,1);

for t=1:size(GRC1,4)
    chal=av1(:,t);
    plot(av1(:,t))
    hold on
    pause(0.01)
    CHAL=CHAL+(chal>0);
    CHAL=CHAL+(chal>0)+(chal<0);

    KAL=KAL+chal;

end
figure()
plot(CHAL)
figure()
plot(KAL)
%%
figure()
KAL=KAL(1:301);
% plot(KAL)
zz=isoutlier(KAL);
plot(zz)
%%
