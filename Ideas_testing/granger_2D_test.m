figure()
turnim=[squeeze(g1{1}(1,2,:)).'; squeeze(g1{2}(1,2,:)).' ;squeeze(g1{3}(1,2,:)).' ;squeeze(g1{4}(1,2,:)).'];
imagesc(g1_f,[1:4],log(turnim));
colormap(jet(256))
% colorbar()
narrow_colorbar()
xlabel('Frequency (Hz)')
I=gca;
% I.YTickLabel=[{} labelconditions{1} {} labelconditions{2} {} labelconditions{3} {} labelconditions{4} {}];
I.YTickLabel=[{' '} labelconditions{1} {' '} labelconditions{2} {' '} labelconditions{3} {' '} labelconditions{4} {' '} ];
xlim([0 300])