function [H]=max_outlier(p)
P=cell2mat(p);
P=P(1,:);
P=P.';
R=reshape(P,[length(p) size(p{1},2)]);
R=max(R.');

H=~isoutlier(R);

%Look for unique:
Vec=1:length(p);
vec=1:length(p);
vec=vec.*H;
vec=vec(vec~=0); %Index of no outliers. 

%Get index of unique
[~,a2]=unique(R,'first'); 
chidos=(intersect(vec,a2)); %Unique and non-outlier. 

H=ismember(Vec,chidos); %Index of elements in chidos. 

% H=~outlier(R,10);
% pp=p(H);
end