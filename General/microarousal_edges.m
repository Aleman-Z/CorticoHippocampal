function [Micro]=microarousal_edges(microarousal)

    for j=1:length(microarousal)
        if j==1
            Micro=microarousal;  
            Micro(:,1)=1;
        end

        if j==length(microarousal)
            Micro(:,length(microarousal))=1;
        end

    if j~=1 && j~=length(microarousal) 

        if microarousal(j)==1 && microarousal(j-1)==0 
            Micro(j-1)=1;
        end

        if microarousal(j)==1 && microarousal(j+1)==0 
            Micro(j+1)=1;
        end


    end


    end

end