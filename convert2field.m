function [newdata]=convert2field(dat)

cc=cell(1,length(dat));

for i=1:length(dat)
    cc{i}=dat(:,:,i);
    cc{i}=cc{i}.';
end

chc=size(dat);

newdata.trial=cc;
newdata.fsample=200;
tee=0:(chc(1))-1;
tee=tee*(1/200);
%newdata.time=tee;

for i=1:length(dat)
   tim{i}=tee;
end
newdata.time=tim;


for i=1:chc(2)
label{i,1}=num2str(i);
end
newdata.label=label;

end