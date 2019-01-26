acer=1;
labelconditions=[
    {     
    'Baseline'}
     'PlusMaze'    
     'Novelty'
     'Foraging'
    ];

c = categorical(labelconditions); 

%%

for Rat=3:3
    
if Rat==1
    
    if acer==0
         cd('/home/raleman/Dropbox/Figures/Figure3/26/Baseline1_1000_Method4')
    else
          %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
          cd('C:/Users/addri/Dropbox/Figures/Figure3/26/Baseline1_1000_Method4')
    end

Base=[{'Baseline1'} {'Baseline2'} {'Baseline3'}];
contlim=length(Base);
end
if Rat==2
if acer==0
      cd('/home/raleman/Dropbox/Figures/Figure3/27/Baseline2_1000_Method4')
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd('C:/Users/addri/Dropbox/Figures/Figure3/27/Baseline2_1000_Method4')
end

% Base=[{'Baseline2'} {'Baseline1'}];
Base=[{'Baseline2'} {'Baseline1'} {'Baseline3'}];
contlim=length(Base);
end

if Rat==3
if acer==0
      cd('/home/raleman/Dropbox/Figures/Figure3/24')
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd('C:/Users/addri/Dropbox/Figures/Figure3/24')
end

Base=[ {'Baseline2'}];
contlim=length(Base);    
end

load('NumberRipples.mat')

for cont=1:contlim
vr=getfield(s,Base{cont});
bar(c,vr(:,1))
ylabel('Number of ripples')
ylim([0 4700])
% title(Base{cont})
% xo

string=strcat('Number_ripples_',Base{cont},'.fig');
saveas(gcf,string)
string=strcat('Number_ripples_',Base{cont},'.pdf');
figure_function(gcf,[],string,[]);
string=strcat('Number_ripples_',Base{cont},'.eps');
print(string,'-depsc')
close all
end

end