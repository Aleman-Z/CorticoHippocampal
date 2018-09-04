w=findobj(gcf,'Type','image');
ww=get(w,'cdata'); 

W=ww(1:2:end)
figure()
colormap(jet(256))
for i=1:length(W)
  subplot(2,3,i)
  imagesc(flip(W{i},1))
end

