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
set(0,'defaultAxesFontName', 'Arial')
set(0,'defaultTextFontName', 'Arial')

n=4;
close all
vec=[Norm_Cohfos2_PAR_g1_26([n],:);Norm_Cohfos2_PAR_g1_27([n],:);Norm_Cohfos2_PAR_g1_24([n],:)];
%vec=[Norm_Cohfos2_PAR_g1_26([1:4],:);Norm_Cohfos2_PAR_g1_27([1:4],:);Norm_Cohfos2_PAR_g1_24([1:4],:)];
vec=vec(:);
% vec=vec(~isnan(vec));
% vec=vec(~isinf(vec));

[k1]=histogram(vec,[-5.5:5.5],'FaceColor',[0 0 0]);
set(gca,'FontName','Arial')
set(gca,'FontSize',10)
 hold on
    ylabel('Frequency','FontSize',10,'FontName','Arial')
    xlabel('Count','FontSize',10,'FontName','Arial')
set(gca,'FontName','Arial')
set(gca,'FontSize',10)
ax = gca;
ax.YAxis.FontSize = 18 %for y-axis 
ax.XAxis.FontSize = 18 %for y-axis 
ax.XAxis.FontName='Arial';
ax.XAxis.FontName='Arial';

    Y1 = prctile(vec,5)
    Y2 = prctile(vec,95)
plot([Y2 Y2],[0 max(k1.Values)],'-.k');
ylim([0 max(k1.Values)]);
plot([0 0],[0 max(k1.Values)],'-r','LineWidth',2);
plot([Y1 Y1],[0 max(k1.Values)],'-.k');
xlim([-6 6])
%%
printing(['new_PAR_g1' '_' labelconditions{n}])
%% NORM for hpc ripples
Norm_Cohfos2_PAR_24_all=Cohfos2_PAR_hpc_all-cellfun('length',Cohfos2_PAR_hpc).';  %1x4
Norm_Cohfos2_PAR_24_all=Norm_Cohfos2_PAR_24_all./std(Cohfos2_PAR_hpc_all.').';

Norm_Cohfos2_PAR_24_unique=Cohfos2_PAR_hpc_unique-(cell2mat(cellfun(@(equis) length(unique(equis)),Cohfos2_PAR_hpc,'UniformOutput',false))).';  %1x4
Norm_Cohfos2_PAR_24_unique=Norm_Cohfos2_PAR_24_unique./std(Cohfos2_PAR_hpc_unique.').';

Norm_Cohfos2_PFC_24_all=Cohfos2_PFC_hpc_all-cellfun('length',Cohfos2_PFC_hpc).';  %1x4
Norm_Cohfos2_PFC_24_all=Norm_Cohfos2_PFC_24_all./std(Cohfos2_PFC_hpc_all.').';

Norm_Cohfos2_PFC_24_unique=Cohfos2_PFC_hpc_unique-(cell2mat(cellfun(@(equis) length(unique(equis)),Cohfos2_PFC_hpc,'UniformOutput',false))).';  %1x4
Norm_Cohfos2_PFC_24_unique=Norm_Cohfos2_PFC_24_unique./std(Cohfos2_PFC_hpc_unique.').';
%%
save('New_Norm_spindles_SWR_24','Norm_Cohfos2_PAR_24_all','Norm_Cohfos2_PAR_24_unique',...
    'Norm_Cohfos2_PFC_24_all','Norm_Cohfos2_PFC_24_unique');
%%
set(0,'defaultAxesFontName', 'Arial')
set(0,'defaultTextFontName', 'Arial')

n=1;
close all
vec=[Norm_Cohfos2_PFC_26_all([n],:);Norm_Cohfos2_PFC_27_all([n],:);Norm_Cohfos2_PFC_24_all([n],:)];
%vec=[Norm_Cohfos2_PFC_g1_26([1:4],:);Norm_Cohfos2_PFC_g1_27([1:4],:);Norm_Cohfos2_PFC_g1_24([1:4],:)];
vec=vec(:);
% vec=vec(~isnan(vec));
% vec=vec(~isinf(vec));

[k1]=histogram(vec,[-5.5:5.5],'FaceColor',[0 0 0]);
set(gca,'FontName','Arial')
set(gca,'FontSize',10)
 hold on
    ylabel('Frequency','FontSize',10,'FontName','Arial')
    xlabel('Count','FontSize',10,'FontName','Arial')
set(gca,'FontName','Arial')
set(gca,'FontSize',10)
ax = gca;
ax.YAxis.FontSize = 18 %for y-axis 
ax.XAxis.FontSize = 18 %for y-axis 
ax.XAxis.FontName='Arial';
ax.XAxis.FontName='Arial';

    Y1 = prctile(vec,5)
    Y2 = prctile(vec,95)
plot([Y2 Y2],[0 max(k1.Values)],'-.k','LineWidth',2);
ylim([0 max(k1.Values)]);
plot([0 0],[0 max(k1.Values)],'-r','LineWidth',2);
plot([Y1 Y1],[0 max(k1.Values)],'-.k','LineWidth',2);
xlim([-6 6])
%%
printing(['Anew_PFC_all' '_' labelconditions{n}])
%printing(['new_PFC_g1' '_' 'across_all'])
close all