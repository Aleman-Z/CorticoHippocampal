
function [vecpow]=ps_rip(p,w)

[ran]=rip_select(p);
p=p(ran);

    for j=1:length(p)
        F = fft(p{j}(w,:)); 
        pow = F.*conj(F);
      vecpow(1,j)=sum(pow);
    end
end