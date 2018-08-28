X = [ -120 -110 -100 -90 -80 -70 -60 -50 -40 -30 -20 -10]';
Y = [0.9996 1.0000 0.9772 0.8978 0.6916 0.3253 0.0680 0.0091 0.0089 0.0088 0.0098 0.0119]';
%%
data = Y + 0.1*randn(12, 8);                        % Create (12x8) Data Array

data_mean = mean(data,2);                           % Mean Across Columns
data_SEM = std(data,[],2)/sqrt(size(data,2));       % SEM Across Columns

figure(1)
errorbar(X, data_mean, data_SEM)
grid
axis([-130  0    ylim])
%%
mean_velocity = [0.2574, 0.1225, 0.1787]; % mean velocity
std_velocity = [0.3314, 0.2278, 0.2836];  % standard deviation of velocity

figure
hold on
bar(1:3,mean_velocity)
errorbar(1:3,mean_velocity,std_velocity,'.')
%%
 young= [458.05,509.63]; %values are for young and old respectively
young2= [458.05,509.63,200,340];
old= [200,340];
group = [young;old];
SEM=[12,12,56,45]; % values for error bars

 figure
hold on
bar(1:2,group)
errorbar([0.86,1.14,1.86,2.14],young2,SEM,'.') %errorbar(x,y,err)
%%
k=categorical(labelconditions)
 boxplot([ CC{1}; CC{2}; CC{3}; CC{4}])
 %
%%

C = [CC{1} CC{2}  CC{3}  CC{4}];
grp = [zeros(1,length(CC{1})),ones(1,length(CC{2})),2*ones(1,length(CC{3})),3*ones(1,length(CC{4}))];
%%
bb=boxplot(C,grp,'Notch','on');
ylim([0 0.16])
set(bb(7,:),'Visible','off');

%% Without outlier
tvar=CC{1};
CCC{1}=tvar(~isoutlier(tvar));
tvar=CC{2};
CCC{2}=tvar(~isoutlier(tvar));
tvar=CC{3};
CCC{3}=tvar(~isoutlier(tvar));
tvar=CC{4};
CCC{4}=tvar(~isoutlier(tvar));
%%

C = [CCC{1} CCC{2}  CCC{3}  CCC{4}];
grp = [zeros(1,length(CCC{1})),ones(1,length(CCC{2})),2*ones(1,length(CCC{3})),3*ones(1,length(CCC{4}))];
%%
figure()
bb=boxplot(C*1000,grp,'Notch','on' );
ylim([0 0.10*1000])

set(bb(7,:),'Visible','off');
ave=gca;
ave.XTickLabel=labelconditions;
ylabel('Time (ms)')
%%
string=strcat('RippleDuration_','Allconditions','_',Block{block_time+1},'_','.pdf');
figure_function(gcf,[],string,[]);
string=strcat('RippleDuration_','Allconditions','_',Block{block_time+1},'_','.eps');
print(string,'-depsc')
string=strcat('RippleDuration_','Allconditions','_',Block{block_time+1},'_','.fig');
saveas(gcf,string)

