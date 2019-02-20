function center_stats(h)
pos = get(h,'Position');
new = mean(cellfun(@(v)v(1),pos(1:2)));
set(h(9),'Position',[new,pos{9}(2:end)])

pos = get(h,'Position');
new = mean(cellfun(@(v)v(1),pos(3:4)));
set(h(10),'Position',[new,pos{10}(2:end)])
%%
set(h(1),'Position',[pos{1}(1:2),pos{1+4}(3:end)])
set(h(2),'Position',[pos{2}(1:2),pos{2+4}(3:end)])
set(h(3),'Position',[pos{3}(1:2),pos{3+4}(3:end)])
set(h(4),'Position',[pos{4}(1:2),pos{4+4}(3:end)])

%%
H=gcf;
ca = get(H, 'Children');  %axes handles
Pos = get(ca,'Position');

set(ca(2),'Position', [Pos{1}(1)+0.1496,Pos{2}(2:end)])
set(ca(8),'Position', [Pos{7}(1)+Pos{7}(3)+0.0078 ,Pos{8}(2:end)])

end