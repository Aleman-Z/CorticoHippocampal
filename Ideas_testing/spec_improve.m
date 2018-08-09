function spec_improve
h = gcf; %current figure handle
axesObjs = get(h, 'Children');  %axes handles
dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
%%
subplot(3,4,5)
I=imagesc(flip(dataObjs{1}.CData,1))

colormap(jet(256))
c1=narrow_colorbar()

I.CDataMapping = 'scaled';
gg=gca;
gg.YTickLabel=flip(gg.YTickLabel);
%%
gg.XTick=[1 50 100 150 200];
gg.XTickLabel=[{-1} {-0.5} {0} {0.5} {1}];
%
i=I.CData;
set(gca, 'YTick',[1 size(i,1)/2/3 size(i,1)/2/3*2 size(i,1)/2 size(i,1)/2/3*4 size(i,1)/2/3*5] , 'YTickLabel', [30 25 20 15 10 5]) % 20 ticks
%%
subplot(3,4,6)
I=imagesc(flip(dataObjs{7}.CData,1))

c2=narrow_colorbar()
colormap(jet(256))

I.CDataMapping = 'scaled';
gg=gca;
gg.YTickLabel=flip(gg.YTickLabel);
 
do=sort([c1.YLim c2.YLim]);
c1.YLim=[do(2) do(3)];
c2.YLim=[do(2) do(3)];
%%
gg.XTick=[1 50 100 150 200];
gg.XTickLabel=[{-1} {-0.5} {0} {0.5} {1}];

i=I.CData;
set(gca, 'YTick',[1 size(i,1)/2/3 size(i,1)/2/3*2 size(i,1)/2 size(i,1)/2/3*4 size(i,1)/2/3*5] , 'YTickLabel', [30 25 20 15 10 5]) % 20 ticks
end