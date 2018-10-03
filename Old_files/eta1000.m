function [rip,wide]=eta1000(cellx,cellr) 
fn=1000;

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


subplot(3,2,1)
%plot(((1:length(wide))*(1/fn))-202/1000,wide*(1/0.195))
plot(((1:length(wide))*(1/fn))-1002/1000,wide*(1/0.195))

grid minor
%xlim([-200/1000  200/1000])
xlim([-1000/1000  1000/1000])

xlabel('time (sec)')
ylabel('uV')
title('Wide Band Event-triggered Average')
xticks([-1 -0.8 -0.6 -0.4 -0.2  0  0.2  0.4  0.6  0.8  1])
xticklabels({'-1',  '-0.8',  '-0.6','-0.4', '-0.2', '0', '0.2', '0.4','0.6','0.8',  '1'})

hold on

subplot(3,2,2)
%plot(((1:length(rip))*(1/fn))-202/1000,rip*(1/0.195))
plot(((1:length(rip))*(1/fn))-1002/1000,rip*(1/0.195))
% daspect([1 10 1])
grid minor
%xlim([-200/1000  200/1000])

xlim([-1000/1000  1000/1000])
xlabel('time (sec)')
ylabel('uV')
title('High Gamma power Event-triggered Average')
% xticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5])
% xticklabels({'-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5'})
% xticks([-1 -0.9 -0.8 -0.7 -0.6 -0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1])
% xticklabels({'-1', '-0.9', '-0.8', '-0.7', '-0.6', '-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5', '0.6', '0.7', '0.8', '0.9', '1'})

xticks([-1 -0.8 -0.6 -0.4 -0.2  0  0.2  0.4  0.6  0.8  1])
xticklabels({'-1',  '-0.8',  '-0.6','-0.4', '-0.2', '0', '0.2', '0.4','0.6','0.8',  '1'})

end


