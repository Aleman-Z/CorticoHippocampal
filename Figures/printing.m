function printing(name)
string=strcat(name,'.eps');
% saveas(gcf,string)
print(string,'-depsc')

string=strcat(name,'.fig');
saveas(gcf,string)

string=strcat(name,'.pdf');
figure_function(gcf,[],string,[]);
end