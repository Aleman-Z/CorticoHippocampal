%% Get files and move them to another location 
list = dir();
list([list.isdir]) = [];
list={list.name};
% 
% mkdir probando
for nmd=1:length(list)
movefile (list{nmd}, 'probando')
end
%%
