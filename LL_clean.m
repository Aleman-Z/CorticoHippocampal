function Avero=LL_clean(LL)
    for v=1:size(LL,1)
        for j=1:size(LL,2)
            avero=cell2mat(LL(v,j));
            Avero(v,j)={avero(~isoutlier(avero))};
        end
    end
end
