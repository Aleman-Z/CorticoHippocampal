 Norm_Cohfos2_PAR_g1_24=Cohfos1_PAR_all_g1-cellfun('length',Cohfos1_PAR_g1).';  %1x4
Norm_Cohfos2_PAR_g1_24=Norm_Cohfos2_PAR_g1_24./std(Cohfos1_PAR_all_g1.').';

Norm_Cohfos2_PAR_g2_24=Cohfos1_PAR_all_g2-cellfun('length',Cohfos1_PAR_g2).';  %1x4
Norm_Cohfos2_PAR_g2_24=Norm_Cohfos2_PAR_g2_24./std(Cohfos1_PAR_all_g2.').';

 Norm_Cohfos2_PFC_g1_24=Cohfos1_PFC_all_g1-cellfun('length',Cohfos1_PFC_g1).';  %1x4
Norm_Cohfos2_PFC_g1_24=Norm_Cohfos2_PFC_g1_24./std(Cohfos1_PFC_all_g1.').';

 Norm_Cohfos2_PFC_g2_24=Cohfos1_PFC_all_g2-cellfun('length',Cohfos1_PFC_g2).';  %1x4
Norm_Cohfos2_PFC_g2_24=Norm_Cohfos2_PFC_g2_24./std(Cohfos1_PFC_all_g2.').';
%%
save('New_Norm_spindles_hfos_24','Norm_Cohfos2_PAR_g1_24','Norm_Cohfos2_PAR_g2_24',...
    'Norm_Cohfos2_PFC_g1_24','Norm_Cohfos2_PFC_g2_24');
%%
n=4;
close all
vec=[Norm_Cohfos2_PAR_g1_26([n],:);Norm_Cohfos2_PAR_g1_27([n],:);Norm_Cohfos2_PAR_g1_24([n],:)];
vec=vec(:);
% vec=vec(~isnan(vec));
% vec=vec(~isinf(vec));

[k1]=histogram(vec,[-5.5:5.5],'FaceColor',[0 0 0]);
 hold on
    ylabel('Frequency')
    xlabel('Count')
    Y1 = prctile(vec,5)
    Y2 = prctile(vec,95)
plot([Y2 Y2],[0 max(k1.Values)],'-.k');
ylim([0 max(k1.Values)]);
plot([0 0],[0 max(k1.Values)],'-r','LineWidth',2);
plot([Y1 Y1],[0 max(k1.Values)],'-.k');
xlim([-6 6])
%%
printing(['new_PAR_g1' '_' labelconditions{n}])