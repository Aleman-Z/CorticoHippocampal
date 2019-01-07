function [pp]=pchannel(p,w)
    for j=1:length(p)
        pp{j}=p{j}(w,:);
    end
end