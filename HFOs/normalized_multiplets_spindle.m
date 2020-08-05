for n=1:4
total_am(n)=sum(times(Out_PAR{n}(2:end,1),Out_PAR{n}(2:end,2)));
end

for n=1:4
aver=squeeze(Out_rand_PAR(n,:,:));

for multi=1:1000
    vec(multi)=sum(aver(multi,2:end).*[2:6]);
end

histogram(vec)
xline(total_am(n),'-r','LineWidth',2)

    Y1 = prctile(vec,5)
    Y2 = prctile(vec,95)
    xline(Y1, '-.k','LineWidth',2)
    xline(Y2, '-.k','LineWidth',2)
    close all
aj(n)=(1+sum(vec >=total_am(n)))/(length(vec)+1)


Multi_norm_24(n,:)=(vec-total_am(n))/std(vec);
end

%%
%%
set(0,'defaultAxesFontName', 'Arial')
set(0,'defaultTextFontName', 'Arial')

labelconditions=[
    {'plusmaze'}
    {'baseline'      }
    {'foraging'     }
    {'novelty' }];

    
%n=1;% condition
for n=1:4
%w=1;
a_26=Multi_norm_categories_26(n,:);
a_27=Multi_norm_categories_27(n,:);
a_24=Multi_norm_categories_24(n,:);

vec=[a_26 a_27 a_24];

% vec=a(:,mult);

histogram(vec,[-8.5:1:8.5],'FaceColor',[0 0 0])
    Y1 = prctile(vec,5)
    Y2 = prctile(vec,95)
    xline(Y1, '-.k','LineWidth',2)
     xline(Y2, '-.k','LineWidth',2)

xline(0, '-r','LineWidth',2)
xlim([-8 8])
xticks([-8:2:8])

aj(n)=(1+sum(vec >=0))/(length(vec)+1)

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

printing(['PAR_Multiplets_' labelconditions{n}])
close all

end
%% Counting multiplets, not individual ripples.

for n=1:4
total_am(n)=sum(Out_PAR{n}(2:end,2));
end

for n=1:4
aver=squeeze(Out_rand_PAR(n,:,:));

for multi=1:1000
    vec(multi)=sum(aver(multi,2:end));
end

histogram(vec)
xline(total_am(n),'-r','LineWidth',2)

    Y1 = prctile(vec,5)
    Y2 = prctile(vec,95)
    xline(Y1, '-.k','LineWidth',2)
    xline(Y2, '-.k','LineWidth',2)
    close all
aj(n)=(1+sum(vec >=total_am(n)))/(length(vec)+1)


Multi_norm_categories_24(n,:)=(vec-total_am(n))/std(vec);
end
