function [newdata]=convert2field(dat)

cc=cell(1,length(dat));

for i=1:length(dat)
%     cc{i}=dat(:,:,i);
    cc{i}=dat{i}.';

    cc{i}=cc{i}.';
end

chc=size(dat);

newdata.trial=cc;
newdata.fsample=1000;
tee=0:(chc(2))-1;
tee=tee*(1/200);
tee=tee-1.2;
tee=linspace(-1.2,1.2,2401)
%newdata.time=tee;

for i=1:length(dat)
   tim{i}=tee;
end
newdata.time=tim;


%for i=1:chc(2)
for i=1:3
    
label{1,i}=num2str(i);
end
newdata.label=label;

end