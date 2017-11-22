function[p,q,timecell]=newgetwin(z1,z4,p7,ro)
fn=1000;

p=cell(length(z1),1);
q=cell(length(z1),1);
timecell=cell(length(z1),1);


for i=1:length(z1)
%    p{i,1}=[z1{i}.';z2{i}.';z3{i}.'];
%    q{i,1}=[z4{i}.';z5{i}.';z6{i}.'];
   p{i,1}=[z1{i}.']; %Widepass
   q{i,1}=[z4{i}.']; %Bandpassed
   timecell{i,1}=[0:length(p7)-1]*(1/fn)-(ro/1000);

end

p=p.';
q=q.';
timecell=timecell.';
end