function [Cha]=filter_ripples_new(p,Fline,var1,var2)
%Notch filter
Fsample=1000;
%Fline=[200];
NC=cell2mat(p).';
[NC] = ft_notch(NC.', Fsample,Fline,var1,var2);
NC=NC.';
% %%
%% Rearranging from matrix to cell form
GG=[];
Cha=mat2cell(NC.',[1],[cellfun('length',p)]);
% for cont=1:length(p)
% gg=squeeze(Cha(:,cont,:)).';
% GG=[GG {(gg)}];
% end
end
