function [H]=max_outlier(p)
P=cell2mat(p);
P=P(1,:);
P=P.';
R=reshape(P,[length(p) size(p{1},2)]);
R=max(R.');

H=~isoutlier(R,'quartiles'); %Not an outlier>1. Else 0. 

%Look for unique:
Vec=1:length(p);
vec=1:length(p);
vec=vec.*H; %Index equal zero are outliers. 
vec=vec(vec~=0); %Index of non-outliers. 

%Get index of unique
[~,a2]=unique(R,'first'); %Index of unique values.
chidos=(intersect(vec,a2)); %Unique and non-outlier. 

H=ismember(Vec,chidos); %Index of elements in chidos. 

% H=~outlier(R,10);
% pp=p(H);
end