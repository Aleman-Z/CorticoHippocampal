%AIC test
function BS_order(dat)

winlen   = 12;
maxorder = 10;
points   = size(dat,1);
aic = aic_test(dat,winlen,maxorder);

%

wind = 5; %Select window size. 

if (wind > (points-winlen+1) || wind <= 0)
    errordlg('please input correct window number','parameter lost');
    return
end

dat = aic(wind,:);
data=dat(~isnan(dat));

% draw the figure
figure('Name','AIC Model Order Estimation','NumberTitle','off')
plot(data,'-s');
h = gca;
xlabel(h,'Model Order');
ylabel(h,'AIC measure');
end