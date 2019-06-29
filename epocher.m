function [NC]=epocher(input,e_t)
%%
% Creates epochs with length of e_t seconds. 
%[NC]=epocher(input,e_t)

%e_t=2; %Seconds 
e_samples=e_t*(1000);

%for k=1:size(input,1)
%Input should be checked to make sure epochs are long enough. 
ch=cellfun('length',input);

cont=1;
for k=1:size(input,1)
    
va=input{k,1};
nc=floor(length(va)/e_samples);

        for kk=1:nc    
          NC(:,cont)= va(1+e_samples*(kk-1):e_samples*kk);
          cont=cont+1;
        end
end

end