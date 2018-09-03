function [nb1]=nbouts(s5,Score)
n = diff(find(s5));               % Number of repetitions
n(n==1)=0;
n(n~=0)=1;

if sum(n)+1==1 && Score==1
nb1=0;    
else
nb1=sum(n)+1;    
end

end