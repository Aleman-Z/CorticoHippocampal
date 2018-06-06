function [ran]=rip_outlier(p)
        av=cat(1,p{1:end});
        %av=cat(1,q{1:end});

        av=av(1:3:end,:); %Only Hippocampus
        %AV=max(av.');
        %[B I]= maxk(AV,1000);
        %[B I]= maxk(max(av.'),1000); %Look for the 1000 ripples with highest amplitude. THIS SHOULD BE MEAN instead of Max since some peaks go downwards and no upwards. 

        
        [ac]=mean(av.');
        ind=[1:length(ac)];
        
        AC=ind(not(isoutlier((ac)))); %Gives non outliers. 
         
%         [ach, ind]=max(av.');
%         AC=ind(not(isoutlier((ach))));
        


        ran=AC;
    end