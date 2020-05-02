function[th]=gaussmix(data,Rat,tr)

if size(data,1)< size(data,2)
 data=data.';   
end

% Fit a gaussian mixture model
% obj = fitgmdist(data,2);

obj = fitgmdist(data,2,'SharedCovariance',true);
% try
%     obj = fitgmdist(data,2);
% catch exception
%     disp('There was an error fitting the Gaussian mixture model')
% %     error = exception.message
%     obj = fitgmdist(data,2,'SharedCovariance',true);
% 
% end
idx = cluster(obj,data);
cluster1 = data(idx == 1,:);
cluster2 = data(idx == 2,:);

%Find threshold value
% th=min([max(cluster1) max(cluster2)]);
if Rat==26
    th=156.7; %Rat 26
end

if Rat==27
    th=158; %Rat 27
end

if Rat==24
    if tr(2)==40
        th=153.5; %Rat 24 (40)
    else
        th=153.6; %Rat 24 (35)
    end
end



%  th=156.7; %Rat 26
% th=158; %Rat 27
% th=153.5; %Rat 24 (40)
% th=153.6; %Rat 24 (35)
end