je_base=g1{1};
je_plus=g1{4};
% Select direction
je_base=squeeze(je_base(3,1,:));
je_plus=squeeze(je_plus(3,1,:));

diffo=je_plus-je_base;

 [oud]=isoutlier(diffo);
 ind=find(oud);
 
Ind=zeros(size(diffo));
Ind(ind)=1;
%%
plot(je_base)
hold on
plot(je_plus)
stripes(Ind,0.2)
ylim([0 max(max([je_base je_plus]))])
xlim([200 400])
title('Example of stripes.m')