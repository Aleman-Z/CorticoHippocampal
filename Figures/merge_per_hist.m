%Inputs:
%rat number
%frequency range
    % Load saved figures
    a=hgload('300Hz_complete_Hippocampus.fig');
    b=hgload('Ripples_per_condition_ALL.fig');

    %
    % Prepare subplots
    allscreen()
    h(1)=subplot(1,2,1);
    xlim([0 300])
    grid on
    set(gca, 'YScale', 'log')
    title('Periodogram', 'FontSize', 15)
    xlabel('Frequency (Hz)', 'FontSize', 15)
    ylabel('Power', 'FontSize', 15)

    h(2)=subplot(1,2,2);
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

    % Paste figures on the subplots
    copyobj(allchild(get(a,'CurrentAxes')),h(1));
    copyobj(allchild(get(b,'CurrentAxes')),h(2));
% 
%     close (a)
%     close (b)
%     close (c)

    % Add legends
%     if rat==24
    l(1)=legend(h(1),'Baseline1','Baseline2','Baseline3','Baseline4','Plusmaze1','Plusmaze2')
    l(2)=legend(h(2),'Baseline 1','Baseline 1 (fit)','Baseline 2','Baseline 2 (fit)','Baseline 3','Baseline 3 (fit)','Baseline 4','Baseline 4 (fit)','Plusmaze 1','Plusmaze 1 (fit)','Plusmaze 1','Plusmaze 1 (fit)')
    
set(l(2),'Location','Northwest')
    
string=strcat('merged_figure','.pdf');
figure_function(gcf,[],string,[]);

    %     l(3)=legend(h(3),'Baseline1','Baseline2','Baseline3','Baseline4','Plusmaze1','Plusmaze2')
%     else
%     l(1)=legend(h(1),'Baseline','Plusmaze','Novelty','Foraging')
%     l(2)=legend(h(2),'Baseline','Plusmaze','Novelty','Foraging')
%     l(3)=legend(h(3),'Baseline','Plusmaze','Novelty','Foraging')
%     end
