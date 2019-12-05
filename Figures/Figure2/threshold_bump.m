clear all
close all
h=openfig(strcat('Ripples_per_condition_PFC_Baseline2.fig'))

        axesObjs = get(h, 'Children');  %axes handles
        dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
        
%         %Plusmaze
%         ydata=dataObjs{2}(6).YData;
%         xdata=dataObjs{2}(6).XData;
%         
%         ydata2=dataObjs{2}(5).YData;
%         xdata2=dataObjs{2}(5).XData;

%         %Baseline
%         ydata=dataObjs{2}(8).YData;
%         xdata=dataObjs{2}(8).XData;
%         
%         ydata2=dataObjs{2}(7).YData;
%         xdata2=dataObjs{2}(7).XData;
        
 
%         %Novelty
%         ydata=dataObjs{2}(4).YData;
%         xdata=dataObjs{2}(4).XData;
%         
%         ydata2=dataObjs{2}(3).YData;
%         xdata2=dataObjs{2}(3).XData;
%         
        
        %Foraging
        ydata=dataObjs{2}(2).YData;
        xdata=dataObjs{2}(2).XData;
        
        ydata2=dataObjs{2}(1).YData;
        xdata2=dataObjs{2}(1).XData;
        
        
        
        figure()
        
        plot(xdata2,ydata2)
        hold on
        plot(xdata,ydata)
       
        vq = interp1(ydata,xdata,max(ydata),'pchip');
        vq2 = interp1(ydata2,xdata2,max(ydata2),'pchip');
        
        [vq vq2]
        
       