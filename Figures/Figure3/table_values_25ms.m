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
 subplot(3,4,i)
 im(aver{i,1})
 jp=aver{i,1};
jp=jp(:,51:end-50);
AV(i)=mean(jp(:));
end
%%
AV=flip(AV);
%%
NL=[AV(1); AV(3); AV(5)];
PM=[AV(2); AV(4); AV(6)];
NV=[AV(7); AV(8); AV(9)];
FORA=[AV(10); AV(11); AV(12)];

%%
Region= {'HPC';'PAR';'PFC'};
TT=table(Region,NL,PM,NV,FORA)
writetable(TT,'Val_25.xls','Sheet',1,'Range','B2:F6')



% size(jp(:,1:50))
% size(jp(:,end-49:end))
%Foraging PFC 
%Foraging PAR
%Foraging HPC
