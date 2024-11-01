function granger_2D_stats_conditions(g1,g1_f,labelconditions,freqrange,f)
%allscreen()

W=[1 2; 1 3; 1 4;  2 1; 2 3; 2 4; 3 1; 3 2; 3 4 ; 4 1; 4 2; 4 3];

lab=cell(12,1);

% lab{1}={'Baseline vs Foraging' 'Baseline vs Novelty' 'Baseline vs Plusmaze'}.';
lab{1}={'{ }' 'Baseline vs Foraging' '{ }' 'Baseline vs Novelty' '{ }' 'Baseline vs Plusmaze' '{ }'}.';
% lab{2}='Baseline vs Novelty';
% lab{3}='Baseline vs Plusmaze';
lab{2}={'{ }' 'Foraging vs Baseline' '{ }' 'Foraging vs Novelty' '{ }' 'Foraging vs Plusmaze' '{ }'}.';
lab{3}={'{ }' 'Novelty vs Baseline' '{ }' 'Novelty vs Foraging' '{ }' 'Novelty vs Plusmaze' '{ }'}.';
lab{4}={'{ }' 'Plusmaze vs Baseline' '{ }' 'Plusmaze vs Foraging' '{ }' 'Plusmaze vs Novelty' '{ }'}.';


% lab{4}='Foraging vs Baseline';
% lab{5}='Foraging vs Novelty';
% lab{6}='Foraging vs Plusmaze';
 
% lab{7}='Novelty vs Baseline';
% lab{8}='Novelty vs Foraging';
% lab{9}='Novelty vs Plusmaze';
 
% lab{10}='Plusmaze vs Baseline';
% lab{11}='Plusmaze vs Foraging';
% lab{12}='Plusmaze vs Novelty';

%%
allscreen()
for j=1:4 % Block of 3. They will be 4 blocks. 

I=subplot(2,2,j)
turnim=[squeeze(g1{1}(f(1),f(2),:)).'; squeeze(g1{2}(f(1),f(2),:)).' ;squeeze(g1{3}(f(1),f(2),:)).' ;squeeze(g1{4}(f(1),f(2),:)).'];
% turnim2=[squeeze(g1{1}(f(2),f(1),:)).'; squeeze(g1{2}(f(2),f(1),:)).' ;squeeze(g1{3}(f(2),f(1),:)).' ;squeeze(g1{4}(f(2),f(1),:)).'];
% zmap(1,:)=stats_high2((turnim(1,:)),(turnim(2,:)));
% zmap(2,:)=stats_high2((turnim(1,:)),(turnim(3,:)));
% zmap(3,:)=stats_high2((turnim(1,:)),(turnim(4,:)));

zmap(1,:)=stats_high2((turnim(W(3*(j-1)+1,1),:)),(turnim(W(3*(j-1)+1,2),:)));
zmap(2,:)=stats_high2((turnim(W(3*(j-1)+2,1),:)),(turnim(W(3*(j-1)+2,2),:)));
zmap(3,:)=stats_high2((turnim(W(3*(j-1)+3,1),:)),(turnim(W(3*(j-1)+3,2),:)));

zmap(zmap == 0) = NaN;

J=imagesc(zmap); 
colormap(jet(256))
c=colorbar(); 
c.Limits=[-max(abs(c.Limits)) max(abs(c.Limits))];
caxis([c.Limits])
set(J,'AlphaData',~isnan(zmap))
xlabel('Frequency (Hz)')
%xlim([0 300])
I.YTickLabel=lab{j};
dale=0;
for ac=1:3
aj=sum(~isnan(zmap(ac,:)));
if aj~=0
       dale1=max(find(~isnan(zmap(ac,:))));
       dale1=abs(dale1);
       if dale1>dale
           dale=dale1;
       end
end
end

if dale==0 
xlim(freqrange)
else
%xlim([0 dale*2+1])
%xlim([0 g1_f(dale)+5])
if freqrange(1)~=100
    if length(g1_f)==501
    xlim([0 g1_f(dale)+5])
    else
    xlim([0 (dale)+5])    
    end
else
xlim(freqrange)    
end

end
% xlim(freqrange)
clear dale dale1
end
%%
% % % % zmap(1,:)=stats_high2((turnim(2,:)),(turnim(1,:)));
% % % % zmap(2,:)=stats_high2((turnim(3,:)),(turnim(1,:)));
% % % % zmap(3,:)=stats_high2((turnim(4,:)),(turnim(1,:)));
% % % % 
% % % % zmap(zmap == 0) = NaN;
% % % % J=imagesc(g1_f,[1:4],zmap); colorbar(); colormap(jet(256))
% % % % set(J,'AlphaData',~isnan(zmap))
% % % % xlabel('Frequency (Hz)')
% % % % I=gca;
% % % % I.YTickLabel=lab{1};
% % % % 
% % % % 
% % % % %Stats
% % % % I=subplot(3,3,3*j)
% % % % J=imagesc(g1_f,[1:4],zmap)
% % % % colormap(jet(256))
% % % %  colorbar()
% % % % xlabel('Frequency (Hz)')
% % % % % I=gca;
% % % % % I.YTickLabel=[{} labelconditions{1} {} labelconditions{2} {} labelconditions{3} {} labelconditions{4} {}];
% % % % % I.YTickLabel=[{' '} labelconditions{1} {' '} labelconditions{2} {' '} labelconditions{3} {' '} labelconditions{4} {' '} ];
% % % % I.YTickLabel=labelconditions;
% % % % %xlim auto
% % % % 
% % % % %
% % % % %set(gca,'xlim',xlim,'ydir','no')
% % % % zmap(zmap == 0) = NaN;
% % % % %aj=find(~isnan(zmap));
% % % % dale=0;
% % % % for ac=1:4
% % % % aj=sum(~isnan(zmap(ac,:)));
% % % % if aj~=0
% % % %        dale1=max(find(~isnan(zmap(ac,:))));
% % % %        dale1=abs(dale1);
% % % %        if dale1>dale
% % % %            dale=dale1;
% % % %        end
% % % % end
% % % % end
% % % % set(J,'AlphaData',~isnan(zmap))
% % % % 
% % % % % c=narrow_colorbar()
% % % % %  c.YLim=[-max(abs(c.YLim)) max(abs(c.YLim))];
% % % % % caxis([-max(abs(c.YLim)) max(abs(c.YLim))])
% % % % % c=narrow_colorbar()
% % % % if dale==0 
% % % % xlim(freqrange)
% % % % else
% % % % %xlim([0 dale*2+1])
% % % % xlim([0 g1_f(dale)+2])
% % % % end
% % % % % xlim(freqrange)
% % % % title(lab{3*j})
end
%end