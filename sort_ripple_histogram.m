function[Aver]=sort_ripple_histogram(consig,sig1,veamos)
avv=cellfun(@(equis) times((1000),equis), consig,'UniformOutput',false);

aja=sig1{1};
aja=aja(veamos{1});

for kk=1:length(aja)
    ave=aja{kk};
    bueno=round(avv{kk});
%     bueno=ave( round(avv{kk}));
    af{kk,1}=ave( round(avv{kk})).';
    af{kk,1}=af{kk,1}(1:end-1);
%     
% plot(ave)
% hold on
% plot(bueno,zeros(1,length(bueno)),'*r')
% grid minor
end

aver=cellfun(@(x) diff(x), consig,'UniformOutput',false);
aver=[aver{:}];
Aver=aver; %DELAYS
AF=[af{:}]; %MAGNITUDES

[B,I] = sort(AF,'descend');
Aver=Aver(I);
end