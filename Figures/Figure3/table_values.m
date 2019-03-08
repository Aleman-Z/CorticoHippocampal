acer=1;
Rat=27;

if acer==1
cd('C:\Users\addri\Dropbox\Window')
else
cd('/home/raleman/Dropbox/Window')    
end

cd(num2str(Rat))

load('Mdam.mat')
n=201*101;
Mdam([2,4,6],:)=Mdam([2,4,6],:)./sqrt(n);

%%
Region= {'HPC';'PAR';'PFC'};
% NoLearning=Mdam([1 3 5],1);
% PlusMaze=Mdam([1 3 5],2);
% Novelty=Mdam([1 3 5],3);
% Foraging=Mdam([1 3 5],4);
% 
% T = table(Region,NoLearning,PlusMaze,Novelty,Foraging)
% %%
% char(177)
%%
% NoLearning=[num2str(Mdam([1 3 5],1)) [' '; ' '; ' '] [char(177); char(177); char(177)] [' '; ' '; ' '] num2str(Mdam([2 4 6],1))];
% PlusMaze=[num2str(Mdam([1 3 5],2)) [' '; ' '; ' '] [char(177); char(177); char(177)] [' '; ' '; ' '] num2str(Mdam([2 4 6],2))];
% Novelty=[num2str(Mdam([1 3 5],3)) [' '; ' '; ' '] [char(177); char(177); char(177)] [' '; ' '; ' '] num2str(Mdam([2 4 6],3))];
% Foraging=[num2str(Mdam([1 3 5],4)) [' '; ' '; ' '] [char(177); char(177); char(177)] [' '; ' '; ' '] num2str(Mdam([2 4 6],4))];
% 
% T = table(Region,NoLearning,PlusMaze,Novelty,Foraging)
%%
NoLearning={
    cell2mat(strcat(num2str(Mdam([1],1)),{' '},char(177),{' '},num2str(Mdam([2],1))));...
    cell2mat(strcat(num2str(Mdam([3],1)),{' '},char(177),{' '},num2str(Mdam([4],1))));...
    cell2mat(strcat(num2str(Mdam([5],1)),{' '},char(177),{' '},num2str(Mdam([6],1))));...
}

PlusMaze={
    cell2mat(strcat(num2str(Mdam([1],2)),{' '},char(177),{' '},num2str(Mdam([2],2))));...
    cell2mat(strcat(num2str(Mdam([3],2)),{' '},char(177),{' '},num2str(Mdam([4],2))));...
    cell2mat(strcat(num2str(Mdam([5],2)),{' '},char(177),{' '},num2str(Mdam([6],2))));...
}


Novelty={
    cell2mat(strcat(num2str(Mdam([1],3)),{' '},char(177),{' '},num2str(Mdam([2],3))));...
    cell2mat(strcat(num2str(Mdam([3],3)),{' '},char(177),{' '},num2str(Mdam([4],3))));...
    cell2mat(strcat(num2str(Mdam([5],3)),{' '},char(177),{' '},num2str(Mdam([6],3))));...
}


Foraging={
    cell2mat(strcat(num2str(Mdam([1],4)),{' '},char(177),{' '},num2str(Mdam([2],4))));...
    cell2mat(strcat(num2str(Mdam([3],4)),{' '},char(177),{' '},num2str(Mdam([4],4))));...
    cell2mat(strcat(num2str(Mdam([5],4)),{' '},char(177),{' '},num2str(Mdam([6],4))));...
}

TT=table(Region,NoLearning,PlusMaze,Novelty,Foraging)
% %%
% % NoLearning=cell2mat(NoLearning);
% % cell2mat(strcat(num2str(Mdam([1],1)),{' '},char(177),{' '},num2str(Mdam([2],1))))
% 
% [num2str(Mdam([1 3 5],1)) [' '; ' '; ' '] [char(177); char(177); char(177)] [' '; ' '; ' '] num2str(Mdam([2 4 6],1))];
%%
writetable(TT,'Values.xls','Sheet',1,'Range','B2:F6')
