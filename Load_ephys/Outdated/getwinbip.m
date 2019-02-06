function [p,q,timecell]=getwinbip(carajo,veamos,sig1,sig2,label1,label2,ro)
fn=1000;
if ro==200;

%CAMBIA
i=2;
[p1, p4, z1, z4]=generate(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i});

i=5;
[p2, p5, z2, z5]=generate(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i});

i=9;
[p3, p6, z3, z6]=generate(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i});

end
 


if ro==500;
i=2;
[p1, p4, z1, z4]=generate500(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i});

i=5;
[p2, p5, z2, z5]=generate500(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i});

i=9;
[p3, p6, z3, z6]=generate500(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i});

end

if ro==1000;
i=2;
[p1, p4, z1, z4]=generate1000(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i});

i=5;
[p2, p5, z2, z5]=generate1000(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i});

i=9;
[p3, p6, z3, z6]=generate1000(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i});
end

p=cell(length(z1),1);
q=cell(length(z1),1);
timecell=cell(length(z1),1);


for i=1:length(z1)
   p{i,1}=[z1{i}.';z2{i}.';z3{i}.'];
   q{i,1}=[z4{i}.';z5{i}.';z6{i}.'];
%    p{i,1}=[z1{i}.';z2{i}.';z3{i}.';z7{i}.']; %Widepass
%    q{i,1}=[z4{i}.';z5{i}.';z6{i}.';z8{i}.']; %Bandpassed
   timecell{i,1}=[0:length(p3)-1]*(1/fn)-(ro/1000);

end

p=p.';
q=q.';
timecell=timecell.';



end

