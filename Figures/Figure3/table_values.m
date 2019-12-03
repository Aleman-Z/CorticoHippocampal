acer=1;
Rat=24;
st=0; %Include Standard deviation.

if acer==1
cd('C:\Users\addri\Dropbox\Window')
else
cd('/home/raleman/Dropbox/Window')    
end

cd(num2str(Rat))
cd('all_rip')
%%
load('Mdam.mat')
n=201*101;
Mdam([2,4,6],:)=Mdam([2,4,6],:)./sqrt(n);

%%
Region= {'HPC';'PAR';'PFC'};

if st==1
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
else
    
    NoLearning={
        (strcat(num2str(Mdam([1],1))));...
        (strcat(num2str(Mdam([3],1))));...
        (strcat(num2str(Mdam([5],1))));...
    }

    PlusMaze={
    (strcat(num2str(Mdam([1],2))));...
    (strcat(num2str(Mdam([3],2))));...
    (strcat(num2str(Mdam([5],2))));...
    }


    Novelty={
    (strcat(num2str(Mdam([1],3))));...
    (strcat(num2str(Mdam([3],3))));...
    (strcat(num2str(Mdam([5],3))));...
    }


    Foraging={
    (strcat(num2str(Mdam([1],4))));...
    (strcat(num2str(Mdam([3],4))));...
    (strcat(num2str(Mdam([5],4))));...
    }
    
    
end
TT=table(Region,NoLearning,PlusMaze,Novelty,Foraging)

xo

% %%
% % NoLearning=cell2mat(NoLearning);
% % cell2mat(strcat(num2str(Mdam([1],1)),{' '},char(177),{' '},num2str(Mdam([2],1))))
% 
% [num2str(Mdam([1 3 5],1)) [' '; ' '; ' '] [char(177); char(177); char(177)] [' '; ' '; ' '] num2str(Mdam([2 4 6],1))];
%%
writetable(TT,'Values.xls','Sheet',1,'Range','B2:F6')
