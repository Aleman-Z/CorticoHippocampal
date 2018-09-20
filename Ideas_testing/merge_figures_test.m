
cd('/home/raleman/Dropbox/Figures/Figure4/26')
fh1 = open('Stat_HPC_Parietal_NP_Widepass_1sec.fig');
cd('/home/raleman/Dropbox/Figures/Figure4/27')
fh2 = open('Stat_HPC_Parietal_NP_Widepass_1sec.fig');

%%
 ax1 = get(fh1, 'Children');
 ax2 = get(fh2, 'Children');
 ax2p = get(ax2,'Children');
 copyobj(ax2p, ax1);
 %%
cd('/home/raleman/Dropbox/Figures/Figure4/26')
fh1 = hgload('Stat_HPC_Parietal_NP_Widepass_1sec.fig');
cd('/home/raleman/Dropbox/Figures/Figure4/27')
fh2 = hgload('Stat_HPC_Parietal_NP_Widepass_1sec.fig');
%%
% Prepare subplots
figure
h(1)=subplot(1,2,1);
h(2)=subplot(1,2,2);

% Paste figures on the subplots
% copyobj(allchild(get(fh1,'CurrentAxes')),h(1));
% copyobj(allchild(get(fh2,'CurrentAxes')),h(2));
copyobj(allchild(fh1), h(1))
copyobj(allchild(fh2), h(2))

% % Add legends
% l(1)=legend(h(1),'LegendForFirstFigure')
% l(2)=legend(h(2),'LegendForSecondFigure')
%%
fileFolder = fullfile(matlabroot,'toolbox','images','imdata');
dirOutput = dir(fullfile(fileFolder,'AT3_1m4_*.tif'));
fileNames = string({dirOutput.name});

montage(fileNames, 'Size', [2 5]);
