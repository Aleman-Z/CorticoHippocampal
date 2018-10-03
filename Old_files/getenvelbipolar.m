%% Envelope of q.

function [ww]=getenvelbipolar(q)
ww=cell(1,length(q));

for i=1:length(q)
   w=q{i}; 
   for j=1:3
   envel=w(j,:);
   ev(j,:)=envelope1(envel);
   end
   ww{i}=ev;
end
end
