%Periodogram of ripples

for cont=1:length(q)
    [f,G]=frequencylog(q{cont}(3,:));
    %gg(cont,:)=abs(G(1,end/2:end));
    gg(cont,:)=abs(G(1,1:length(f)));
end

%%
figure()
gt=mean(gg);
area(f*500,smooth(gt))
%%
[Q]=filter_ripples(q,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);
%%
for cont=1:length(Q)
    [f,G]=frequencylog(Q{cont}(3,:),'no');
    %gg(cont,:)=abs(G(1,end/2:end));
    gg(cont,:)=abs(G(1,1:length(f)));
end

%%
figure()
gt=mean(gg);
area(f*500,smooth(gt,29))
%% Testing lower frequencies

for cont=1:length(p)
    [f,G]=frequencylog(p{cont}(2,:));
    %gg(cont,:)=abs(G(1,end/2:end));
    gg(cont,:)=abs(G(1,1:length(f)));
end
%%
figure()
gt=mean(gg);
% area(f*500,smooth(gt,29))
area(f*500,gt)
xlim([0 50])
%%
[P]=filter_ripples(p,[5 15],.1,.5);
%%
for cont=1:length(P)
    [f,G]=frequencylog(P{cont}(3,:));
    %gg(cont,:)=abs(G(1,end/2:end));
    GG(cont,:)=abs(G(1,1:length(f)));
end
%%
hold on
gt=mean(GG);
% area(f*500,smooth(gt,29))
area(f*500,gt)
xlim([0 50])
%%
title('Spectral interpolation on Low frequencies')
%%
xlabel('Frequency','FontSize',12)
ylabel('Power (log)','FontSize',12)
legend('Original spectrum','Spectral interpolation at 5 and 15Hz')
