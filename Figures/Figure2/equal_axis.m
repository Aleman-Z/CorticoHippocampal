%% Equal axis among rats
% fil='Average_Frequency_Allconditions_complete_';
%fil='Average_Frequency_Violin_Allconditions_complete_';
%fil='Peak_Frequency_Violin_Allconditions_complete_';
%fil='Peak_Frequency_Allconditions_complete_';
%fil='RippleDuration_Outliers_Allconditions_complete_';
%fil='RippleDuration_Violin_Allconditions_complete_';
%fil='RippleDuration_Violin_Allconditions_complete_';
% fil='InterrippleTime_Violin_Allconditions_complete_';
fil='InterrippleTime_Allconditions_complete_';

cd('C:\Users\addri\Dropbox\Figures\Figure3\26')
%cd('C:\Users\addri\Dropbox\Figures\Figure3\26\Bouts_showing_outliers')

openfig(fil)
H=gca;
a1=[H.YLim];
close all

cd('C:\Users\addri\Dropbox\Figures\Figure3\27')
%cd('C:\Users\addri\Dropbox\Figures\Figure3\27\Bouts_showing_outliers')
openfig(fil)
H=gca;
a1=[a1 H.YLim];
close all

a2=[min(a1) max(a1)];
%% Change value
cd('C:\Users\addri\Dropbox\Figures\Figure3\26')
%cd('C:\Users\addri\Dropbox\Figures\Figure3\26\Bouts_showing_outliers')

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
%cd('C:\Users\addri\Dropbox\Figures\Figure3\27\Bouts_showing_outliers')

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




