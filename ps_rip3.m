function [vecpow,vecpow2]=ps_rip3(p,q,w)

[ran]=rip_select(p);
p=p(ran);
q=q(ran);

    for j=1:length(p)
        %Hippocampus
        F = fft(p{j}(1,:)); 
        pow = F.*conj(F);
      vecpow(1,j)=sum(pow);
      
      %Other brain area
        F2 = fft(q{j}(w,:)); % w is either 2 or 3
        pow2 = F2.*conj(F2);
      vecpow2(1,j)=sum(pow2);
      
    end
end
