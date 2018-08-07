h = gcf; %current figure handle

axesObjs = get(h, 'Children');  %axes handles
dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes

% zdata = get(dataObjs, 'ZData');
%%
subplot(1,2,1)
I=imagesc(flip(dataObjs{3}.CData,1))

%I=imagesc(dataObjs{3}.CData)
% colorbar()
colormap(jet(256))
I.CDataMapping = 'scaled';
  %camroll(180)  
   xlabel('Time (s)')
   title('Before Spectral Interpolation')
ylabel('Frequency (Hz)')
set(gca,'Ydir','reverse')
%%
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

