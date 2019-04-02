folder_st='C:\Users\addri\Dropbox\Window';
Rat=[26 27 24];
val=25;

for rat=3:3
RAT=Rat(rat);

for num_rip=2:2
cd(strcat(folder_st,'\',num2str(RAT)))
    
if num_rip==1
    cd('all_rip')
end
open('100ms_mejorado.fig')
aver=ex;
%%
aver=aver(1:2:end);
% %%
% Av=[];
% for i=1:length(aver)
% %  subplot(3,4,i)
%  av=max(max(aver{i,1}));
%  Av=[Av av];
% end
% av=max(Av);
%%
AV=[];
allscreen()
for i=1:length(aver)
%  subplot(3,4,i)
%  im(aver{i,1})
 jp=aver{i,1};
 if val==25
    jp=jp(:,51+25:end-50-25);
 else
    jp=jp(:,51:end-50); 
 end
AV(i)=mean(jp(:));
end

close all
%%
AV=flip(AV);
%%
NoLearning=[AV(1); AV(3); AV(5)];
PlusMaze=[AV(2); AV(4); AV(6)];
Novelty=[AV(7); AV(8); AV(9)];
Foraging=[AV(10); AV(11); AV(12)];

%%
Region= {'HPC';'PAR';'PFC'};
TT=table(Region,NoLearning,PlusMaze,Novelty,Foraging)
xo
if val==25
writetable(TT,'Val_25.xls','Sheet',1,'Range','B2:F6')    
else
writetable(TT,'Val_50.xls','Sheet',1,'Range','B2:F6')    
end
clear AV
end
end
% size(jp(:,1:50))
% size(jp(:,end-49:end))
%Foraging PFC 
%Foraging PAR
%Foraging HPC
