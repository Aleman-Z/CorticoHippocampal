
function [A,str2]=select_trial(str,Rat)

% A = dir(cd);
% A={A.name};    
A=getfolder;
aver=cellfun(@(x) strfind(x,str),A,'UniformOutput',false);
aver=cellfun(@(x) length(x),aver,'UniformOutput',false);
aver=cell2mat(aver);
A=A(find(aver));

A=A.';
% %% Removes the PNG files. 
% str='PNG';
% % B = dir(cd);
% % B={B.name};    
% B=getfolder;
% aver=cellfun(@(x) strfind(x,str),B,'UniformOutput',false);
% aver=cellfun(@(x) length(x),aver,'UniformOutput',false);
% aver=cell2mat(aver);
% B=B(find(aver));
% 
% B=B.';
% %%
% [C,ia,ib] = intersect(A,B, 'stable');
% l=1:length(A);
% ll= l(l~=ia);
% A=A(ll,1);

%%
str2=cell(size(A,1),1);

for n=1:size(A,1)
%     str2{n,1}=strcat('F:\Lisa_files\',num2str(Rat),'\PT',num2str(n));
    str2{n,1}=strcat('PT',num2str(n));
end

end