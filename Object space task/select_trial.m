
function [A,str2]=select_trial(str,Rat)

A = dir(cd);
A={A.name};    
aver=cellfun(@(x) strfind(x,str),A,'UniformOutput',false);
aver=cellfun(@(x) length(x),aver,'UniformOutput',false);
aver=cell2mat(aver);
A=A(find(aver));

A=A.';

str2=cell(size(A,1),1);

for n=1:size(A,1)
%     str2{n,1}=strcat('F:\Lisa_files\',num2str(Rat),'\PT',num2str(n));
    str2{n,1}=strcat('PT',num2str(n));
end

end