
function [A,str2]=select_trial(str)

A = dir(cd);
A={A.name};    
aver=cellfun(@(x) strfind(x,str),A,'UniformOutput',false);
aver=cellfun(@(x) length(x),aver,'UniformOutput',false);
aver=cell2mat(aver);
A=A(find(aver));

A=A.';

str2=cell(size(A,1),1);

end