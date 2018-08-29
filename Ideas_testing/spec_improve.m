function spec_improve(lab,sanity,dura)
h = gcf; %current figure handle
axesObjs = get(h, 'Children');  %axes handles
dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
%%
% axesObjs(15).XLabel.String='Time (s)'
% axesObjs(16).XLabel.String='Time (s)'
%%
hold on
%allscreen()
% if sanity==1
% datmat=(flip(dataObjs{3}.CData,1));
% else
% % datmat=(flip(dataObjs{1}.CData,1));
% datmat=(flip(dataObjs{1}.CData,1));
% end
% 
% if size(datmat,2)~=201
% datmat=datmat(:,20:end-20);
% end

subplot(3,4,5)
%I=imagesc(datmat);
I=imagesc(flip(dataObjs{1}.CData,1));

colormap(jet(256))
c1=narrow_colorbar()
cax1=caxis;%  -1.6465    8.3123
I.CDataMapping = 'scaled';
gg=gca;
gg.YTickLabel=flip(gg.YTickLabel);
%%
gg.XTick=[1 50 100 150 200];
if dura==1
gg.XTickLabel=[{-1} {-0.5} {0} {0.5} {1}];
else
gg.XTickLabel=[{-10} {-5} {0} {5} {10}];    
end
%
i=I.CData;
set(gca, 'YTick',[1 size(i,1)/2/3 size(i,1)/2/3*2 size(i,1)/2 size(i,1)/2/3*4 size(i,1)/2/3*5] , 'YTickLabel', [30 25 20 15 10 5]) % 20 ticks
%%
subplot(3,4,6)
I=imagesc(flip(dataObjs{7}.CData,1))
colormap(jet(256))

c2=narrow_colorbar()
cax2=caxis; %   -5.1735    4.4000
I.CDataMapping = 'scaled';
gg=gca;
gg.YTickLabel=flip(gg.YTickLabel);
%% 
kax=[cax1 cax2];
kax=[min(kax) max(kax)];
% kax=sort(kax);
% kax=[kax(2) kax(3)];
caxis(kax)
do=sort([c1.YLim c2.YLim])
c1.YLim=[do(2) do(3)];
c2.YLim=[do(2) do(3)];
% c1.YLim=[do(1) do(4)];
% c2.YLim=[do(1) do(4)];

%%
gg.XTick=[1 50 100 150 200];
if dura==1
gg.XTickLabel=[{-1} {-0.5} {0} {0.5} {1}];
else
gg.XTickLabel=[{-10} {-5} {0} {5} {10}];    
end
%gg.XTickLabel=[{-1} {-0.5} {0} {0.5} {1}];

i=I.CData;
set(gca, 'YTick',[1 size(i,1)/2/3 size(i,1)/2/3*2 size(i,1)/2 size(i,1)/2/3*4 size(i,1)/2/3*5] , 'YTickLabel', [30 25 20 15 10 5]) % 20 ticks
c2=narrow_colorbar()

xlabel('Time (s)')
ylabel('Frequency (Hz)')
title(strcat('Wide Band','{ }',lab))

%% Redo left size
subplot(3,4,5)
I=imagesc(flip(dataObjs{1}.CData,1))
caxis(kax)
%colormap(jet(256))
c1=narrow_colorbar()
% cax1=caxis;%  -1.6465    8.3123
% c1.YLim=[do(1) do(4)];
I.CDataMapping = 'scaled';
gg=gca;
gg.YTickLabel=flip(gg.YTickLabel);
%%
gg.XTick=[1 50 100 150 200];
%gg.XTickLabel=[{-1} {-0.5} {0} {0.5} {1}];
if dura==1
gg.XTickLabel=[{-1} {-0.5} {0} {0.5} {1}];
else
gg.XTickLabel=[{-10} {-5} {0} {5} {10}];    
end

%
i=I.CData;
set(gca, 'YTick',[1 size(i,1)/2/3 size(i,1)/2/3*2 size(i,1)/2 size(i,1)/2/3*4 size(i,1)/2/3*5] , 'YTickLabel', [30 25 20 15 10 5]) % 20 ticks
xlabel('Time (s)')
title('Wide Band No Learning')
ylabel('Frequency (Hz)')



end