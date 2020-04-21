
function [sig,p,q,cont]=getsignal_spec(Sx,Ex,ti,Mono,k,Mx,V,Mono2,V2,Mono3,V3)
cont=0;
if ~isempty(Sx{k})
    for j=1:length(Sx{k})
    ts=find(ti{k}==Sx{k}(j));
    tend=find(ti{k}==Ex{k}(j));
    sig{j}=Mono{k}(ts:tend);
    
   if nargin>5
    %Ripple-centered window.
    tm=find(ti{k}==Mx{k}(j));
        if  tm+150<=length(ti{k}) && tm-150>=1
            p{j}=[V{k}(tm-150:tm+150).';V2{k}(tm-150:tm+150).';V3{k}(tm-150:tm+150).'];
            q{j}=[Mono{k}(tm-150:tm+150).';Mono2{k}(tm-150:tm+150).';Mono3{k}(tm-150:tm+150).'];
            
        else
            p{j}=[];
            q{j}=[];
            cont=cont+1;
        end
   else
    p{j}=[];
    q{j}=[];
   end
       % else
   % sig{j}=0;
    %    end
    end
else
    sig=[];
    p=[];
    q=[];
end
end







