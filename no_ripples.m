

%Vector with times

% for k=1:length(ti)-1
%    caco=ti(1,k);
%    
%   if max(caco>S{1})&& (caco<E{1});
%   end
% end
function [chec,chec2,checQ]=no_ripples(ti,S,E,ro,signal_array,signal_array2,signal_arrayQ)
% Find times with no ripples
caco=ti;
cao=signal_array;
cao2=signal_array2;
caoQ=signal_arrayQ;

for L=1:length(S)
%  caco=caco (find( not(caco>=S{1}(L) & caco<= E{1}(L) )));
 
% caco=caco (find( not(caco>=S(L) & caco<= E(L) )));
%  cao=cao(find( not(caco>=S(L) & caco<= E(L) )),:);
%  cao2=cao2(find( not(caco>=S(L) & caco<= E(L) )),:);
% caoQ=caoQ(find( not(caco>=S(L) & caco<= E(L) )),:);

caco=caco (( not(caco>=S(L) & caco<= E(L) )));
 cao=cao(( not(caco>=S(L) & caco<= E(L) )),:);
 cao2=cao2(( not(caco>=S(L) & caco<= E(L) )),:);
caoQ=caoQ(( not(caco>=S(L) & caco<= E(L) )),:);

disp(strcat('Waiting:',num2str(round(L*100/length(S))),'%'))

end
%caco contains the concatenation all times when there are no ripples.
%

% caco=caco*(1000); %Multiply by sampling freq. 

k=sum(diff(caco)>0.0011); %Number of discontinuities. 
% no_rip=cell(k+1,1);
%Find samples where discontinuities occur. 
pks=find(diff(caco)>0.0011);

if sum(pks)==0
    %chec=0;
    chec=cell.empty;
    chec2=cell.empty;
    checQ=cell.empty;
    return;
else
    

for i=1:k+1
    if i==1
   %no_rip{1}= caco(1:pks(1))*1000; %MUltiply by 1000 to convert seconds to samples. 
   NR{1,1}=cao(1:pks(1),:);
   NR2{1,1}=cao2(1:pks(1),:);
   NRQ{1,1}=caoQ(1:pks(1),:);
   
    elseif i==k+1
%     no_rip{i}= caco((pks(i-1)+1):(end))*1000;
    NR{i,1}=cao((pks(i-1)+1):(end),:);
    NR2{i,1}=cao2((pks(i-1)+1):(end),:);
    NRQ{i,1}=caoQ((pks(i-1)+1):(end),:);
    
    else
%    no_rip{i}= caco((pks(i-1)+1):(pks(i)))*1000;    
    NR{i,1}=cao((pks(i-1)+1):(pks(i)),:);
    NR2{i,1}=cao2((pks(i-1)+1):(pks(i)),:);
    NRQ{i,1}=caoQ((pks(i-1)+1):(pks(i)),:);
    
    end
end


%aff=cellfun('length',no_rip);
aff=cellfun('length',NR);


chec= NR(find(aff>=ro*2+1));
chec2= NR2(find(aff>=ro*2+1));
checQ= NRQ(find(aff>=ro*2+1));

% A=cellfun('length',chec)./(2*ro+1);
% A=floor(A);

% 
% %Standardize all windows to have same lenght

for index=1:length(chec)
dumm=chec{index};
chec{index}=dumm(1:ro*2+1,:).'; %time

dumm2=chec2{index};
chec2{index}=dumm2(1:ro*2+1,:).'; %time

dummQ=checQ{index};
checQ{index}=dummQ(1:ro*2+1,:).'; %time

end



end
end
%



