function [output]=convert_pvalue(input,p)
%p is p value

% chec=FP_aver.Xaver2;
chec=input;
CHEC=chec;
CHEC(chec>=p)=0;
CHEC(chec<p)=1;
output=CHEC;
end