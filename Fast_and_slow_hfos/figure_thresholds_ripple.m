fig = gcf;

axObjs = fig.Children
% dataObjs = axObjs.Children


a = get(gca,'Children');
xdata = get(a, 'XData');
ydata = get(a, 'YData');

%%
Xdata=xdata(2:2:end);;;;
Ydata=ydata(2:2:end);

xpoint=xdata(1:2:end);
ypoint=ydata(1:2:end);


 S=StandardColors();
% myColorMap(1,:)=[0.65, 0.65, 0.65]; %GREY CONTROL
% myColorMap(2,:)=[0, 0, 0]; %Black plusmaze
% myColorMap(3,:)=[0.9290, 0.6940, 0.1250]; %Yellow Novelty
% myColorMap(4,:)=[0.49, 0.18, 0.56]; %Foraging Violet. 

 
 
for i=1:4
    
if i==1 %foraging
   Xdata{i}=Xdata{i}(7:end)
   Ydata{i}=Ydata{i}(7:end)
   
end

if i==3 %plusmaze
   Xdata{i}=Xdata{i}(8:end)
   Ydata{i}=Ydata{i}(8:end)
   
end

if i==2 %novelty
   Xdata{i}=Xdata{i}(2:end)
   Ydata{i}=Ydata{i}(2:end)
   
end
    
plot(Xdata{i},Ydata{i},'*','Color',S(i,:))
hold on

% plot(xpoint{i},ypoint{i})
% plot(xpoint{i},ypoint{i})
plot(Xdata{i},Ydata{i},'Color',S(i,:),'LineWidth',3)

end

xlabel('Threshold value (uV)')
ylabel('Ripples per second')
title('Rate of ripples per Threshold value')
set(gca, 'XDir','reverse')

ylim([-0.5 3])
xlim([0 350])