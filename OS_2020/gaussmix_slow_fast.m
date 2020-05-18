function[th]=gaussmix_slow_fast(data)

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
th=min([max(cluster1) max(cluster2)]);


end