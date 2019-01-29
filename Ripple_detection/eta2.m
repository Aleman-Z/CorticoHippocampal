function [rip,wide]=eta2(cellx,cellr,nu,fn) 
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



end


