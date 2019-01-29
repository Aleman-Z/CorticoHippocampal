%Hippocampus Bipolar
%Hippocampus Monopolar

%function [p3, p5,cellx,cellr]=generate2(cara,veamos, Bip17,S17,ro)
function [cellx,cellr]=generate2(cara,veamos, Bip17,S17,ro)

%Generates windows
[cellx,cellr]=win(cara,veamos,Bip17,S17,ro);
%Clears nans
[cellx,cellr]=clean(cellx,cellr);

% [p3 ,p5]=eta2(cellx,cellr,ro,1000);
end


