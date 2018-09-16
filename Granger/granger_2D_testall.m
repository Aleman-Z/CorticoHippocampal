function granger_2D_testall(g1,g1_f,labelconditions,freqrange)
allscreen()
F= [1 2; 1 3; 2 3] ;

lab=cell(6,1);

lab{1}='HPC -> Parietal';
lab{2}='Parietal -> HPC';
lab{3}='Parietal -> HPC vs HPC -> Parietal';

lab{4}='HPC -> PFC';
lab{5}='PFC -> HPC';
lab{6}='PFC -> HPC vs HPC -> PFC';

lab{7}='Parietal -> PFC';
lab{8}='PFC -> Parietal';
lab{9}='PFC -> Parietal vs Parietal -> PFC';

%% Get range
for jj=1:3
ff=F(jj,:);
%Max
mmax1=max([max(squeeze(g1{1}(ff(1),ff(2),:))) max(squeeze(g1{2}(ff(1),ff(2),:))) ...
     max(squeeze(g1{3}(ff(1),ff(2),:))) max(squeeze(g1{4}(ff(1),ff(2),:)))]);

mmax2=max([max(squeeze(g1{1}(ff(2),ff(1),:))) max(squeeze(g1{2}(ff(2),ff(1),:))) ...
     max(squeeze(g1{3}(ff(2),ff(1),:))) max(squeeze(g1{4}(ff(2),ff(1),:)))]);

mmax=max([mmax1 mmax2]);

%Min
mmin1=min([min(squeeze(g1{1}(ff(1),ff(2),:))) min(squeeze(g1{2}(ff(1),ff(2),:))) ...
     min(squeeze(g1{3}(ff(1),ff(2),:))) min(squeeze(g1{4}(ff(1),ff(2),:)))]);

mmin2=min([min(squeeze(g1{1}(ff(2),ff(1),:))) min(squeeze(g1{2}(ff(2),ff(1),:))) ...
     min(squeeze(g1{3}(ff(2),ff(1),:))) min(squeeze(g1{4}(ff(2),ff(1),:)))]);

mmin=min([mmin1 mmin2]);

mrange(jj,:)=log([mmin mmax]);
end
Mrange=[min(min(mrange)) max(max(mrange))];
%%

for j=1:3
f=F(j,:);
I=subplot(3,3,3*j-2)
turnim=[squeeze(g1{1}(f(1),f(2),:)).'; squeeze(g1{2}(f(1),f(2),:)).' ;squeeze(g1{3}(f(1),f(2),:)).' ;squeeze(g1{4}(f(1),f(2),:)).'];
imagesc(g1_f,[1:4],log(turnim));
colormap(jet(256))


cc=colorbar();
cc.Limits=Mrange;
caxis([Mrange])
%narrow_colorbar()
xlabel('Frequency (Hz)')
%I=gca;
% I.YTickLabel=[{} labelconditions{1} {} labelconditions{2} {} labelconditions{3} {} labelconditions{4} {}];
%I.YTickLabel=[{' '} labelconditions{1} {' '} labelconditions{2} {' '} labelconditions{3} {' '} labelconditions{4} {' '} ];
I.YTickLabel=labelconditions;
xlim(freqrange)
title(lab{3*j-2})

%Opposite direction
I=subplot(3,3,3*j-1)
turnim2=[squeeze(g1{1}(f(2),f(1),:)).'; squeeze(g1{2}(f(2),f(1),:)).' ;squeeze(g1{3}(f(2),f(1),:)).' ;squeeze(g1{4}(f(2),f(1),:)).'];
imagesc(g1_f,[1:4],log(turnim2));
colormap(jet(256))
% colorbar()
cc=colorbar();
cc.Limits=Mrange;
caxis([Mrange])
%narrow_colorbar()
xlabel('Frequency (Hz)')
%I=gca;
% I.YTickLabel=[{} labelconditions{1} {} labelconditions{2} {} labelconditions{3} {} labelconditions{4} {}];
% I.YTickLabel=[{' '} labelconditions{1} {' '} labelconditions{2} {' '} labelconditions{3} {' '} labelconditions{4} {' '} ];
I.YTickLabel=labelconditions;
xlim(freqrange)
title(lab{3*j-1})


[zmap]=stats_high2((turnim),(turnim2));

%Stats
I=subplot(3,3,3*j)
J=imagesc(g1_f,[1:4],zmap)
colormap(jet(256))
 colorbar()
xlabel('Frequency (Hz)')
% I=gca;
% I.YTickLabel=[{} labelconditions{1} {} labelconditions{2} {} labelconditions{3} {} labelconditions{4} {}];
% I.YTickLabel=[{' '} labelconditions{1} {' '} labelconditions{2} {' '} labelconditions{3} {' '} labelconditions{4} {' '} ];
I.YTickLabel=labelconditions;
%xlim auto

%
%set(gca,'xlim',xlim,'ydir','no')
zmap(zmap == 0) = NaN;
%aj=find(~isnan(zmap));
dale=0;
for ac=1:4
aj=sum(~isnan(zmap(ac,:)));
if aj~=0
       dale1=find(~isnan(zmap(ac,:)));
       dale1=abs(dale1);
       if dale1>dale
           dale=dale1;
       end
end
end
set(J,'AlphaData',~isnan(zmap))

% c=narrow_colorbar()
%  c.YLim=[-max(abs(c.YLim)) max(abs(c.YLim))];
% caxis([-max(abs(c.YLim)) max(abs(c.YLim))])
% c=narrow_colorbar()
if dale==0 || dale>95
xlim(freqrange)
else
xlim([0 dale*2+1])    
end
% xlim(freqrange)
title(lab{3*j})
end
end