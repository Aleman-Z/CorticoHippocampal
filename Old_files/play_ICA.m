%% ICA on monopolar signals. (Takes a little while, better load precomputed Rs and Bs)

%New monopolar signals
R6=cell(length(V6),1);%NREM Reference signals
R9=cell(length(V6),1);%NREM Reference signals
R12=cell(length(V6),1);%NREM Reference signals
R17=cell(length(V6),1);%NREM Reference signals

%New Bipolar signals
B9=cell(length(V6),1);
B12=cell(length(V6),1);
B17=cell(length(V6),1);


for i=1:length(V6)
VK=[V6 V9 V12 V17];
checa=VK(i,:)
checale=[checa{1,1} checa{1,2} checa{1,3} checa{1,4}];
checale=checale';

%[A1 B]=fastica(checale);
[A1 B]=fastica(checale,'approach','symm');

sources=B*checale;
[nS,ny]=orderICA(checale,sources);
%[newvec]=sorter(checale, sources); %Sorts independent components (C6 C9 C12 C17)
R6{i}=newvec(1,:);
R9{i}=newvec(2,:);
R12{i}=newvec(3,:);
si=size(newvec);
if si(1)==4
R17{i}=newvec(4,:);
else
R17{i}=0;    
end
i
%Bipolar
B9{i}=R9{i}-R6{i};
B12{i}=R12{i}-R6{i};
B17{i}=R17{i}-R6{i};
end
% checale=checale';
% %%
