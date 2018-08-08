h = gcf; %current figure handle

axesObjs = get(h, 'Children');  %axes handles
dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes

% zdata = get(dataObjs, 'ZData');
%%
allscreen()
subplot(3,4,5)
I=imagesc(flip(dataObjs{1}.CData,1))

colormap(jet(256))

%I=imagesc(dataObjs{3}.CData)
c1=narrow_colorbar()


% c1.Position=[c1.Position(1:2)  c1.Position(3)/2  c1.Position(4) ]
% c1.Location='eastoutside';

I.CDataMapping = 'scaled';
gg=gca;
gg.YTickLabel=flip(gg.YTickLabel);


subplot(3,4,6)
I=imagesc(flip(dataObjs{7}.CData,1))


%I=imagesc(dataObjs{3}.CData)
c2=narrow_colorbar()
colormap(jet(256))

I.CDataMapping = 'scaled';
gg=gca;
gg.YTickLabel=flip(gg.YTickLabel);
 
do=sort([c1.YLim c2.YLim]);
% mi1=min([c1.Limits c2.Limits]);
% mi2=max([c1.Limits c2.Limits]);
% c1.Limits=[mi1 mi2];
% c2.Limits=[mi1 mi2];
% 
% mi1=min([c1.YLim c2.YLim]);
% mi2=max([c1.YLim c2.YLim]);
c1.YLim=[do(2) do(3)];
c2.YLim=[do(2) do(3)];

%%
%camroll(180)  
   xlabel('Time (s)')
%    title('Before Spectral Interpolation')
ylabel('Frequency (Hz)')
% set(gca,'Ydir','reverse')

subplot(1,2,2)
I=imagesc(flip(dataObjs{7}.CData,1))

%I=imagesc(dataObjs{3}.CData)
colorbar()
colormap(jet(256))
I.CDataMapping = 'scaled';
  %camroll(180)  
   xlabel('Time (s)')
%    title('Before Spectral Interpolation')
ylabel('Frequency (Hz)')
%set(gca,'Ydir','reverse')


%%
figure()
subplot(1,2,1)
I=imagesc(data1)

%I=imagesc(dataObjs{3}.CData)
% colorbar()
colormap(jet(256))
I.CDataMapping = 'scaled';
  %camroll(180)  
   xlabel('Time (s)')
   title('Before Spectral Interpolation')
ylabel('Frequency (Hz)')
set(gca,'Ydir','reverse')


%% SECOND PART
subplot(1,2,2)
I=imagesc(data2)

%I=imagesc(dataObjs{3}.CData)
% colorbar()
colormap(jet(256))
I.CDataMapping = 'scaled';
  %camroll(180)  
   xlabel('Time (s)')
   title('After Spectral Interpolation')
ylabel('Frequency (Hz)')
set(gca,'Ydir','reverse')

