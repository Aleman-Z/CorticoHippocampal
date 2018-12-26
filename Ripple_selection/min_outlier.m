function [H]=min_outlier(p,w)
P=cell2mat(p);
P=P(w,:);
P=P.';
R=reshape(P,[length(p) size(p{1},2)]);
R=R(:,1190:1210);
%R=max(abs(diff(R.')));
R=max((R.'));
%R=max(abs((R.')));

%H=~isoutlier(R,'mean'); %Not an outlier>1. Else 0. 
H=outlier_index(R,0.00001); %Not an outlier>1. Else 0. 
%0.01

%Look for unique:
Vec=1:length(p);
vec=1:length(p);
vec=vec.*H; %Index equal zero are outliers. 
vec=vec(vec~=0); %Index of no outliers. 

%Get index of unique
[~,a2]=unique(R,'first'); %Index of unique values.
chidos=(intersect(vec,a2)); %Unique and non-outlier. 

H=ismember(Vec,chidos); %Index of elements in chidos. 

% H=~outlier(R,10);
% pp=p(H);
end