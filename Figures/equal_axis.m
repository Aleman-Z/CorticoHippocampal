%% Equal axis among rats
fil='Average_Frequency_Allconditions_complete_';

cd('C:\Users\addri\Dropbox\Figures\Figure3\26')
openfig(fil)
H=gca;
a1=[H.YLim];
close all

cd('C:\Users\addri\Dropbox\Figures\Figure3\27')
openfig(fil)
H=gca;
a1=[a1 H.YLim];
close all

a2=[min(a1) max(a1)];
%% Change value
cd('C:\Users\addri\Dropbox\Figures\Figure3\26')
openfig(fil)
H=gca;
H.YLim=a2;

string=strcat(fil,'.pdf');
figure_function(gcf,[],string,[]);
string=strcat(fil,'.eps');
print(string,'-depsc')
string=strcat(fil,'.fig');
saveas(gcf,string)

close all
%%
cd('C:\Users\addri\Dropbox\Figures\Figure3\27')
openfig(fil)
H=gca;
H.YLim=a2;

string=strcat(fil,'.pdf');
figure_function(gcf,[],string,[]);
string=strcat(fil,'.eps');
print(string,'-depsc')
string=strcat(fil,'.fig');
saveas(gcf,string)

close all
%%




