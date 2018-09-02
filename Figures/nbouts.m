function [nb1]=nbouts(s5)
n = diff(find(s5));               % Number of repetitions
n(n==1)=0;
n(n~=0)=1;
nb1=sum(n)+1;
end