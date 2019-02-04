%% Get files and move them to another location 
list = dir();
list([list.isdir]) = [];
list={list.name};
%% 
Folder=[{'all_ripples'} {'500'} {'1000'}];

% if exist(Folder)~=7
% (mkdir(Folder))
% end

mkdir(Folder{FiveHun+1})
 
for nmd=1:length(list)
movefile (list{nmd}, 'probando')
end
