%Inputs:
%rat number
%frequency range
    % Load saved figures
    function merge_per_hist(Rat)    
    
cd(strcat('C:\Users\addri\Dropbox\Figures\Figure2\',num2str(Rat)))

    a=hgload('300Hz_complete_Hippocampus.fig');
    if Rat==24
            b=hgload('Ripples_per_condition_ALL.fig');

    else
            b=hgload('Ripples_per_condition_best.fig');

    end
    
    c=hgload('30Hz_complete_Hippocampus.fig');
    d=hgload('Sleep_amount.fig');

    
    %
    % Prepare subplots
      allscreen()
    h(1)=subplot(2,2,1);
    xlim([0 300])
    grid on
    set(gca, 'YScale', 'log')
    title('Periodogram', 'FontSize', 15)
    xlabel('Frequency (Hz)', 'FontSize', 15)
    ylabel('Power', 'FontSize', 15)

    h(2)=subplot(2,2,2);
% if fq_range==30
%     xlim([0 30])
% else
%     xlim([0 300])
% end
    grid on
%     set(gca, 'YScale', 'log')
    title('Ripples vs Threshold', 'FontSize', 15)
    xlabel('Threshold (uV)', 'FontSize', 15)
    set(gca, 'XDir','reverse')

    ylabel('Ripples per second','FontSize', 15)

    h(3)=subplot(2,2,3);
    xlim([0 30])
    grid on
    set(gca, 'YScale', 'log')
    title('Periodogram', 'FontSize', 15)
    xlabel('Frequency (Hz)', 'FontSize', 15)
    ylabel('Power', 'FontSize', 15)

    
    h(4)=subplot(2,2,4);
    grid on
    h(4).XTickLabel={'0';'Baseline';'Foraging';'Novelty';'Plusmaze'};
ylabel('Cumulative percentage of sleep','FontSize',14)
lg=legend('Wake','NREM','Transitional Sleep','REM')
lg.Location='eastoutside';
lg.FontSize=14

    
    % Paste figures on the subplots
    copyobj(allchild(get(a,'CurrentAxes')),h(1));
    copyobj(allchild(get(b,'CurrentAxes')),h(2));

    copyobj(allchild(get(c,'CurrentAxes')),h(3));
    copyobj(allchild(get(d,'CurrentAxes')),h(4));
    % 
%     close (a)
%     close (b)
%     close (c)

    % Add legends
     if Rat==24
    l(1)=legend(h(1),'Baseline1','Baseline2','Baseline3','Baseline4','Plusmaze1','Plusmaze2')
    l(2)=legend(h(2),'Baseline 1','Baseline 1 (fit)','Baseline 2','Baseline 2 (fit)','Baseline 3','Baseline 3 (fit)','Baseline 4','Baseline 4 (fit)','Plusmaze 1','Plusmaze 1 (fit)','Plusmaze 1','Plusmaze 1 (fit)')
     else
    l(1)=legend(h(1),'Baseline','Plusmaze','Novelty','Foraging')
    l(2)=legend(h(2),'Baseline','Baseline (fit)','Plusmaze','Plusmaze(fit)','Novelty','Novelty (fit)','Foraging','Foraging (fit)')
    l(3)=legend(h(3),'Baseline','Plusmaze','Novelty','Foraging')
         
     end
set(l(2),'Location','Northwest')
     
% string=strcat('merged_figure','.pdf');
% figure_function(gcf,[],string,[]);

    %     l(3)=legend(h(3),'Baseline1','Baseline2','Baseline3','Baseline4','Plusmaze1','Plusmaze2')
%     else
%     l(1)=legend(h(1),'Baseline','Plusmaze','Novelty','Foraging')
%     l(2)=legend(h(2),'Baseline','Plusmaze','Novelty','Foraging')
%     l(3)=legend(h(3),'Baseline','Plusmaze','Novelty','Foraging')
%     end
    end