function [pp]=max_outlier(p)
P=cell2mat(p);
P=P(1,:);
P=P.';
R=reshape(P,[length(p) size(p{1},2)]);
R=max(R.');

H=~isoutlier(R);
% H=~outlier(R,10);
pp=p(H);
end