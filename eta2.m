function [rip,wide,avex]=eta2(cellx,cellr,nu,fn) 
%fn=1000;

avex=cell2mat(cellx');


s=size(avex);
if s(1)==1 || s(2)==1
   avex=cell2mat(cellx); 
end
% 
s=size(avex);

if s(1)~=length(cellx)
    avex=avex';
end
% avex= reshape(avex,[s(find(size(avex)~=77))],length(cellx));
% 
% avex=avex.';
% avex= reshape(avex,[77,401]);
wide=mean(avex);


aver=cell2mat(cellr');
s=size(aver);
if s(1)==1 || s(2)==1
   aver=cell2mat(cellr); 
end

s=size(aver);

if s(1)~=length(cellr)
    aver=aver';
end


% 
% aver=aver.';
rip=mean(aver);


% % % % % % subplot(3,2,1)
% % % % % % % vee=(1:length(wide))*(1/fn);
% % % % % % % nvee=(vee)-(201/1000);
% % % % % % plot(((1:length(wide))*(1/fn))-(nu+1)/1000,wide*(1/0.195))
% % % % % % % colorbar('on');
% % % % % % %colorbar('off');
% % % % % % narrow_colorbar
% % % % % % % caxis([0 1])
% % % % % % %plot(((1:length(wide))*(1/fn))-501/1000,wide*(1/0.195))
% % % % % % 
% % % % % % grid minor
% % % % % % %xlim([-nu/1000  nu/1000])
% % % % % % xlim([-500/1000  500/1000])
% % % % % % 
% % % % % % xlabel('time (sec)')
% % % % % % ylabel('uV')
% % % % % % title('Wide Band Event-triggered Average')

% % % % if nu==200
% % % % ticvec=linspace(-nu/1000,nu/1000,9);
% % % % xticks(ticvec)
% % % % ticvec=num2str(ticvec.');
% % % % xticklabels({ticvec(1,:), ticvec(2,:), ticvec(3,:), ticvec(4,:), ticvec(5,:), ticvec(6,:), ticvec(7,:), ticvec(8,:), ticvec(9,:)})
% % % % 
% % % % else 
% % % % ticvec=linspace(-nu/1000,nu/1000,11);
% % % % xticks(ticvec)
% % % % ticvec=num2str(ticvec.');
% % % % xticklabels({ticvec(1,:), ticvec(2,:), ticvec(3,:), ticvec(4,:), ticvec(5,:), ticvec(6,:), ticvec(7,:), ticvec(8,:), ticvec(9,:), ticvec(10,:), ticvec(11,:)})
% % % % 
% % % % end
% % % % 
% % % % %ticvec=linspace(-nu/1000,nu/1000,11);
% % % % %xticklabels({'-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5'})
% % % % 
% % % % % xticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5])
% % % % % xticklabels({'-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5'})
% % % % 
% % % % hold on
% % % % 
% % % % subplot(3,2,2)
% % % % plot(((1:length(rip))*(1/fn))-(nu+1)/1000,rip*(1/0.195))
% % % % %plot(((1:length(rip))*(1/fn))-501/1000,rip*(1/0.195))
% % % % % daspect([1 10 1])
% % % % narrow_colorbar
% % % % 
% % % % grid minor
% % % % %xlim([-nu/1000  nu/1000])
% % % % 
% % % % xlim([-500/1000  500/1000])
% % % % xlabel('time (sec)')
% % % % ylabel('uV')
% % % % title('High Gamma power Event-triggered Average')
% % % % % xticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5])
% % % % % xticklabels({'-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5'})
% % % % 
% % % % if nu==200
% % % % ticvec=linspace(-nu/1000,nu/1000,9);
% % % % xticks(ticvec)
% % % % ticvec=num2str(ticvec.');
% % % % xticklabels({ticvec(1,:), ticvec(2,:), ticvec(3,:), ticvec(4,:), ticvec(5,:), ticvec(6,:), ticvec(7,:), ticvec(8,:), ticvec(9,:)})
% % % % 
% % % % else 
% % % % ticvec=linspace(-nu/1000,nu/1000,11);
% % % % xticks(ticvec)
% % % % ticvec=num2str(ticvec.');
% % % % xticklabels({ticvec(1,:), ticvec(2,:), ticvec(3,:), ticvec(4,:), ticvec(5,:), ticvec(6,:), ticvec(7,:), ticvec(8,:), ticvec(9,:), ticvec(10,:), ticvec(11,:)})

%end


% if nu==200
% ticvec=linspace(-nu/1000,nu/1000,9);
% else 
% ticvec=linspace(-nu/1000,nu/1000,11);
% end
% 
% xticks(ticvec)
% ticvec=num2str(ticvec.');
% xticklabels({ticvec(1,:), ticvec(2,:), ticvec(3,:), ticvec(4,:), ticvec(5,:), ticvec(6,:), ticvec(7,:), ticvec(8,:), ticvec(9,:), ticvec(10,:), ticvec(11,:)})

end


%
% 
%plot(p3)
% grid minor
% % 
% % set(gca,'XLim',[0 1000])
% xticks([100 200 300 400 500 600 700 800 900 100])
% xticklabels({'-3\pi','-2\pi','-\pi','0','\pi','2\pi','3\pi','3\pi','3\pi','3\pi'})
% % %%
% x = linspace(-10,10,200);
% y = cos(x);
% plot(x,y)

% xticks([-3*pi -2*pi -pi 0 pi 2*pi 3*pi])
