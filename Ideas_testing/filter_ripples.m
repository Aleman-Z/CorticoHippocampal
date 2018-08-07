function [GG]=filter_ripples(p,Fline,var1,var2)
%Notch filter
Fsample=1000;
%Fline=[200];
NC=cell2mat(p).';
[NC] = ft_notch(NC.', Fsample,Fline,var1,var2);
NC=NC.';
% %%
%% Rearranging from matrix to cell form
GG=[];
Cha=reshape(NC,[length(p{1}) length(p) 3]);
for cont=1:length(p)
gg=squeeze(Cha(:,cont,:)).';
GG=[GG {(gg)}];
end
end