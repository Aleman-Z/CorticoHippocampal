t1=turnim(1,:)
t2=turnim2(1,:)
%%

%%
nr_bins=50;
elements=floor(length(t1)/nr_bins);

for j=1:nr_bins
 bin1(j,:)= t1((j-1)*10+1:elements*j);
 bin2(j,:)= t2((j-1)*10+1:elements*j);

 [p(j,:),h(j,:)] = signrank(bin1(j,:),bin2(j,:));
end

%%
%%
plot(t1)
hold on
plot(t2)
%%

