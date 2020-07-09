% function [sig]=getsignal(Sx,Ex,ti,V)
%     for j=1:length(Sx)
%     ts=find(ti==Sx(j));
%     tend=find(ti==Ex(j));
%     sigl{j}=V(ts:tend);
%     end
% end
%
function [sig]=getsignal(Sx,Ex,ti,V,k)
if ~isempty(Sx{k})
    for j=1:length(Sx{k})
    %ts=find(ti{k}==Sx{k}(j));
    [~,ts]=min(abs(ti{k}-Sx{k}(j)));
    %tend=find(ti{k}==Ex{k}(j));
    [~,tend]=min(abs(ti{k}-Ex{k}(j)));
    sig{j}=V{k}(ts:tend);
       % else
   % sig{j}=0;
    %    end
    end
else
    sig=[];
end
end







