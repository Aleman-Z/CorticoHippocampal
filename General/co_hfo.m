%
% a=Mx_hpc{3};
% N=Mx_pfc{3};
% Do per cell
%%
function [co_vec1,co_vec2]=co_hfo(a,N)
    co_vec1=[];
    co_vec2=[];
    for index_hfo=1:length(N);
     n=N(index_hfo);   

    [val,idx]=min(abs(a-n));
    minVal=a(idx);

    %Diference
    df=abs(minVal-n);

    if df<=0.050
        co_vec1=[co_vec1 n];
        co_vec2=[co_vec2 minVal];
    end

    end
end
% [val,idx]=min(abs(a-n));
% minVal=a(idx);