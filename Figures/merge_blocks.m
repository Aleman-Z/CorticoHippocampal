
function merge_blocks(rat,fq_range)
%Inputs:
%rat number
%frequency range
if fq_range==30
    % Load saved figures
    a=hgload('30Hz_block1_Hippocampus.fig');
    b=hgload('30Hz_block2_Hippocampus.fig');
    c=hgload('30Hz_block3_Hippocampus.fig');    
end  

if fq_range==300
    % Load saved figures
    a=hgload('300Hz_block1_Hippocampus.fig');
    b=hgload('300Hz_block2_Hippocampus.fig');
    c=hgload('300Hz_block3_Hippocampus.fig');    
end  
    %
    % Prepare subplots
    allscreen()
    h(1)=subplot(1,3,1);
if fq_range==30
    xlim([0 30])
else
    xlim([0 300])
end
    grid on
    set(gca, 'YScale', 'log')
    title('Block 1', 'FontSize', 15)
    xlabel('Frequency (Hz)', 'FontSize', 15)
    ylabel('Power', 'FontSize', 15)

    h(2)=subplot(1,3,2);
if fq_range==30
    xlim([0 30])
else
    xlim([0 300])
end
    grid on
    set(gca, 'YScale', 'log')
    title('Block 2', 'FontSize', 15)
    xlabel('Frequency (Hz)', 'FontSize', 15)
    % ylabel('Power')

    h(3)=subplot(1,3,3);
if fq_range==30
    xlim([0 30])
else
    xlim([0 300])
end
    grid on
    set(gca, 'YScale', 'log')
    title('Block 3', 'FontSize', 15)
    xlabel('Frequency (Hz)', 'FontSize', 15)
    % ylabel('Power')

    % Paste figures on the subplots
    copyobj(allchild(get(a,'CurrentAxes')),h(1));
    copyobj(allchild(get(b,'CurrentAxes')),h(2));
    copyobj(allchild(get(c,'CurrentAxes')),h(3));

    close (a)
    close (b)
    close (c)

    % Add legends
    if rat==24
    l(1)=legend(h(1),'Baseline1','Baseline2','Baseline3','Baseline4','Plusmaze1','Plusmaze2')
    l(2)=legend(h(2),'Baseline1','Baseline2','Baseline3','Baseline4','Plusmaze1','Plusmaze2')
    l(3)=legend(h(3),'Baseline1','Baseline2','Baseline3','Baseline4','Plusmaze1','Plusmaze2')
    else
    l(1)=legend(h(1),'Baseline','Plusmaze','Novelty','Foraging')
    l(2)=legend(h(2),'Baseline','Plusmaze','Novelty','Foraging')
    l(3)=legend(h(3),'Baseline','Plusmaze','Novelty','Foraging')
    end
    
    if fq_range==300
        string=strcat('300Hz_','time_blocks','_','Hippocampus','.eps');
        saveas(gcf,string)
        string=strcat('300Hz_','time_blocks','_','Hippocampus','.fig');
        saveas(gcf,string)
    end
    
    if fq_range==30
        string=strcat('30Hz_','time_blocks','_','Hippocampus','.eps');
        saveas(gcf,string)
        string=strcat('30Hz_','time_blocks','_','Hippocampus','.fig');
        saveas(gcf,string)
    end
   close all 
end