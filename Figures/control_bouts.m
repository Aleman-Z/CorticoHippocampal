function [LLL]=control_bouts(LL)
for i=1:length(LL)
    len=min(cellfun('length',LL(:,i)));
    
    for j=1:length(LL)
        ee=cell2mat(LL(j,i));
        if length(ee)~=len
           EE=datasample(ee,len,'Replace',false); 
           LLL(j,i)={EE};
        else
           LLL(j,i)=LL(j,i);
 
        end
        
    end
    
end
end