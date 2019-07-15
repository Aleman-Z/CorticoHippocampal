% [tr2]=sort_scoring(transitions,3);
% tr2=tr2(:,2:3);
%%
% x=tr2;
function ripples_per_stage(x,stage,plotting)
%ripples_per_stage(x)
%For plotting, plotting=1. Else use plotting=0.
nrow = size(x,1);

nline  = repmat((stage.*ones(1,length(x)))',1,2);
% plot(x',nline','o-')
    if plotting==1
        plot(x'/60/60,nline','-','Color',[0 0 0],'LineWidth',10)
        ylim([-.5*nrow 1.5*nrow])
        xlabel('Time (Hours)')
        hold on
        ylim([0 6])
    end
end