
labelconditions=[
    {     
    'Baseline'}
     'PlusMaze'    
     'Novelty'
     'Foraging'
    ];

c = categorical(labelconditions); 

%%

for Rat=2:2
    
if Rat==1
cd('/home/raleman/Dropbox/Figures/Figure3/26/Baseline1_1000_Method4')
Base=[{'Baseline1'} {'Baseline2'} {'Baseline3'}];
contlim=3;
else
cd('/home/raleman/Dropbox/Figures/Figure3/27/Baseline2_1000_Method4')
Base=[{'Baseline2'} {'Baseline1'}];
contlim=2;
end
load('NumberRipples.mat')

for cont=1:contlim
vr=getfield(s,Base{cont});
bar(c,vr(:,1))
ylabel('Number of ripples')
title(Base{cont})
%  xo

% string=strcat('Number_ripples_',Base{cont},'.fig');
% saveas(gcf,string)
string=strcat('Number_ripples_',Base{cont},'.pdf');
figure_function(gcf,[],string,[]);
% string=strcat('Number_ripples_',Base{cont},'.eps');
% print(string,'-depsc')
close all
end

end