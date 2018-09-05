F=figure()  
Bver=[Aver{1,:} Aver{2,:} Aver{3,:} Aver{4,:}];
grp = [zeros(1,cellfun('length',Aver(1,1))),ones(1,cellfun('length',Aver(2,1))),2*ones(1,cellfun('length',Aver(3,1))),3*ones(1,cellfun('length',Aver(4,1)))];

bb=boxplot(Bver,grp);
set(bb(7,:),'Visible','off');
ylim auto
%set(gca, 'YScale', 'log')

%%
Daver=Aver.';
Daver{1}=Daver{1}.';
Daver{2}=Daver{2}.';
Daver{3}=Daver{3}.';
Daver{4}=Daver{4}.';
%%
f=figure()
% c=categorical(labelconditions);
% violin([Aver{1,:} Aver{2,:} Aver{3,:} Aver{4,:}])
V=violin(Daver ,'facecolor',[[1 0 0];[0 0 0];[0 0 1];[0 1 0]],'medc','k','mc','')
%set(gca, 'YScale', 'log')
ylim([-10 50])
legend off
%box off
%axis off
% ,'facecolor',[[1 0 0];[0 0 1]],'medc','','mc','k')
  
