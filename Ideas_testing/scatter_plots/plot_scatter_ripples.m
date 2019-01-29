NU{k}=p_nl;
    QNU{k}=q_nl;
    TNU{k}=timecell_nl;
%%
subplot(4,1,1)
outlier_cluster(q,1)

subplot(4,1,2)
outlier_cluster(QNU{1},1)

subplot(4,1,3)
outlier_cluster(QNU{2},1)

subplot(4,1,4)
outlier_cluster(QNU{3},1)
%%
nu=2

outlier_cluster(q,nu)
xlabel('Mean of ripple epoch')
ylabel('Power Spectral Density')

hold on
grid minor
outlier_cluster(QNU{1},nu)

outlier_cluster(QNU{2},nu)

outlier_cluster(QNU{3},nu)


legend('Learning','Baseline1','Baseline2','Baseline3')


title('Bandpassed Hippocampal Ripples for Rat 26')
%% Plot combined ripples
nu=2

outlier_cluster(q,nu)
xlabel('Mean of ripple epoch')
ylabel('Power Spectral Density')

hold on
grid minor
% outlier_cluster(QNU{1},1)
% 
% outlier_cluster(QNU{2},1)
% 
outlier_cluster(q_nl,nu)


legend('Learning','Baselines (Combined)')


title('Bandpassed Hippocampal Ripples for Rat 26')




%%

outlier_cluster(p,3)
xlabel('Mean of ripple epoch')
ylabel('Power Spectral Density')

hold on
grid minor
outlier_cluster(NU{1},3)

outlier_cluster(NU{2},3)

outlier_cluster(NU{3},3)
legend('Learning','Baseline1','Baseline2','Baseline3')

title('Widepass Hippocampal Ripples for Rat 26')
%%
outlier_cluster(p,1);
xlabel('Mean of ripple epoch')
ylabel('Power Spectral Density')

hold on
grid minor
outlier_cluster(p_nl,1);
legend('Learning','No learning')

title('Widepass Hippocampal Ripples for Rat 26')
