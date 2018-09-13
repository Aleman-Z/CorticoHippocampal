function granger_2D_test(g1,g1_f,labelconditions)
allscreen()
subplot(1,3,1)
turnim=[squeeze(g1{1}(1,2,:)).'; squeeze(g1{2}(1,2,:)).' ;squeeze(g1{3}(1,2,:)).' ;squeeze(g1{4}(1,2,:)).'];
imagesc(g1_f,[1:4],log(turnim));
colormap(jet(256))
 colorbar()
%narrow_colorbar()
xlabel('Frequency (Hz)')
I=gca;
% I.YTickLabel=[{} labelconditions{1} {} labelconditions{2} {} labelconditions{3} {} labelconditions{4} {}];
I.YTickLabel=[{' '} labelconditions{1} {' '} labelconditions{2} {' '} labelconditions{3} {' '} labelconditions{4} {' '} ];
xlim([0 300])

%Opposite direction
subplot(1,3,2)
turnim2=[squeeze(g1{1}(2,1,:)).'; squeeze(g1{2}(2,1,:)).' ;squeeze(g1{3}(2,1,:)).' ;squeeze(g1{4}(2,1,:)).'];
imagesc(g1_f,[1:4],log(turnim2));
colormap(jet(256))
 colorbar()
%narrow_colorbar()
xlabel('Frequency (Hz)')
I=gca;
% I.YTickLabel=[{} labelconditions{1} {} labelconditions{2} {} labelconditions{3} {} labelconditions{4} {}];
I.YTickLabel=[{' '} labelconditions{1} {' '} labelconditions{2} {' '} labelconditions{3} {' '} labelconditions{4} {' '} ];
xlim([0 300])

[zmap]=stats_high2((turnim),(turnim2));

%Stats
subplot(1,3,3)
J=imagesc(g1_f,[1:4],zmap)
colormap(jet(256))
 colorbar()
xlabel('Frequency (Hz)')
I=gca;
% I.YTickLabel=[{} labelconditions{1} {} labelconditions{2} {} labelconditions{3} {} labelconditions{4} {}];
I.YTickLabel=[{' '} labelconditions{1} {' '} labelconditions{2} {' '} labelconditions{3} {' '} labelconditions{4} {' '} ];
xlim([0 300])
%
%set(gca,'xlim',xlim,'ydir','no')
zmap(zmap == 0) = NaN;
set(J,'AlphaData',~isnan(zmap))
% c=narrow_colorbar()
%  c.YLim=[-max(abs(c.YLim)) max(abs(c.YLim))];
% caxis([-max(abs(c.YLim)) max(abs(c.YLim))])
% c=narrow_colorbar()
end