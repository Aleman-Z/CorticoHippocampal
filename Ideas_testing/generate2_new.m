%Hippocampus Bipolar
%Hippocampus Monopolar

%function [p3, p5,cellx,cellr,cfs,f]=generate2(carajo,veamos, Bip17,S17,label1,label2,Num)
function [cellx,cellr]=generate2_new(carajo,veamos, Bip17,S17,label1,label2,Num)

fn=1000;
%Generates windows
[cellx,cellr]=win_new(carajo,veamos,Bip17,S17,Num);
%Clears nans

% [cellx,cellr]=clean(cellx,cellr);
end


