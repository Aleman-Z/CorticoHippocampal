function[thr]=findsleep(ax1,threshold,t)
da=diff([ax1; ax1(end)]);
da=abs(da);
da=da./max(da);

%0.004
% mda=da*0;
% mda=mda+2*std(da);

% thr=(da>1*std(da));
% th=da.*ax1;
% 
% plot(t,ax1(1:end))
% hold on
%figure()
%close all
allscreen
%plot(t,da)
thr=(da>threshold);
%thr=(da>0.005);

% thr=thr*(-1);
% thr=thr+1;


% 
% for i=3:length(thr)-2
%     %tt=thr(i,1);
%     
%     %if i~=1 || i~=length(thr) || i~=2 || i~=length(thr)-1
%    if  thr(i,1)==0   
%         %if (thr(i-1,1)==1 || thr(i+2,1)==1)    
%         if sum([thr(i-1,1),thr(i-1,1),thr(i-1,1),thr(i-1,1)])>=1 
%         thr(i,1)==1;
%         end
%    end
% end

%th=da.*thr;


ax=ax1-mean(ax1);
ax=abs(ax);
% ax=ax1;
ax=ax./max(ax);

plot(t,thr,'Color','k')
hold on

plot(t,ax,'Color',[1 0.7 0])

title('Threshold on Accelerometer data')
xlabel('Time(sec)')
ylabel('Normalized Magnitude')
grid minor
legend('Awake state','Accelerometer data ')

end