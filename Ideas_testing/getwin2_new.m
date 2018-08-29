function [p,q,z1,z4]=getwin2_new(carajo,veamos,sig1,sig2,label1,label2,ro)
fn=1000;
i=1;

%allscreen()
[z1, z4]=generate2_new(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i},ro);
    
p=cell(length(z1),1);
q=cell(length(z1),1);
timecell=cell(length(z1),1);
%UNCOMMENT IF YOU WANT THE ENVELOPE:

for i=1:length(z1)

   %p{i,1}=[z1{i}.';z2{i}.';z3{i}.']; %Widepass
   p{i,1}=[z1{i}.']; %Widepass
   q{i,1}=[z4{i}.']; %Bandpassed
   
%   timecell{i,1}=[0:length(p1)-1]*(1/fn)-(ro/1000);
end

p=p.';
q=q.';

end