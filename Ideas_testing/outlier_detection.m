%%First approach 
P=cell2mat(p);
P=P(1,:);
P=P.';
R=reshape(P,[length(p) size(p{1},2)]);
R=mean(R,2);
%R=median(R,2);

% H=~isoutlier(R);
H=~out(R,1.5);
% H=~outlier(R,10);
pp=p(H);
%%
for k=200:length(p)
    plot(p{k}(1,:))
    hold on
    pause(.1)
    title(num2str(k))
end
%%
%% MAX
P=cell2mat(p);
P=P(1,:);
P=P.';
R=reshape(P,[length(p) size(p{1},2)]);
R=max(R.')

H=~isoutlier(R);
% H=~outlier(R,10);
pp=p(H);

%% MAX abs
P=cell2mat(p);
P=P(1,:);
P=P.';
R=reshape(P,[length(p) size(p{1},2)]);
%mo=mean(R,2);
R=R-mo;

%R=abs(R);
R=max(R.');

H=~isoutlier(R);
% H=~outlier(R,10);
pp=p(H);

%%

for k=220:length(p)
    plot(p{k}(1,:))
    hold on
    pause(.1)
    title(num2str(k))
end
%%
%% Derivative
P=cell2mat(p);
P=P(1,:);
P=P.';
R=reshape(P,[length(p) size(p{1},2)]);
R=max(abs(diff(R.')))

H=~isoutlier(R);
% H=~outlier(R,10);
pp=p(H);
