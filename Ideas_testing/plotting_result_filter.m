addpath('C:\Users\addri\Documents\GitHub\ADRITOOLS')
%%
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


%% NOTCH 
figure()
subplot(1,2,1)
%I=imagesc(data1)

I=imagesc(flip(dataObjs{3}.CData,1))
% colorbar()
colormap(jet(256))
I.CDataMapping = 'scaled';
  %camroll(180)  
   xlabel('Time (s)')
   title('Before Spectral Interpolation')
ylabel('Frequency (Hz)')
set(gca,'Ydir','reverse')
% gg=gca;
% gg.YTickLabel=flip(gg.YTickLabel);

%%
i=I.CData;
set(gca, 'XTick',[0.5 size(i,2)/4 size(i,2)/2 size(i,2)/4*3  size(i,2)+0.5], 'XTickLabel', [-1:0.5:1]) % 10 ticks 
%%
set(gca, 'YTick', [1 size(i,1)/4 size(i,1)/2 size(i,1)/4*3 size(i,1)], 'YTickLabel', [300 250 200 150 100]) % 20 ticks
%%
%% not necessary
gg=gca;
gg.YTickLabel=flip(gg.YTickLabel);

%% SECOND PART
subplot(1,2,2)
I=imagesc(flip(data2))

% I=imagesc(dataObjs{3}.CData)
% colorbar()
colormap(jet(256))
I.CDataMapping = 'scaled';
  %camroll(180)  
   xlabel('Time (s)')
   title('After Spectral Interpolation')
ylabel('Frequency (Hz)')
%set(gca,'Ydir','reverse')
%%
i=I.CData;
set(gca, 'XTick',[0.5 size(i,2)/4 size(i,2)/2 size(i,2)/4*3  size(i,2)+0.5], 'XTickLabel', [-1:0.5:1]) % 10 ticks 
%%
set(gca, 'YTick', [1 size(i,1)/4 size(i,1)/2 size(i,1)/4*3 size(i,1)], 'YTickLabel', [300 250 200 150 100]) % 20 ticks
