F=figure()  
Bver=[Aver{1,:} Aver{2,:} Aver{3,:} Aver{4,:}];
grp = [zeros(1,cellfun('length',Aver(1,1))),ones(1,cellfun('length',Aver(2,1))),2*ones(1,cellfun('length',Aver(3,1))),3*ones(1,cellfun('length',Aver(4,1)))];

bb=boxplot(Bver,grp);
set(bb(7,:),'Visible','off');
ylim auto
set(gca, 'YScale', 'log')


  
