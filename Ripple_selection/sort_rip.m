function [P,Q]=sort_rip(p,q)

    av=cat(1,p{1:end});
    %av=cat(1,q{1:end});

    av=av(1:3:end,:); %Only Hippocampus
    %AV=max(av.');
    %[B I]= maxk(AV,1000);
    %[B I]= maxk(max(av.'),1000); %Look for the 1000 ripples with highest amplitude. THIS SHOULD BE MEAN instead of Max since some peaks go downwards and no upwards. 

    [ach]=max(av.');
    [achinga,ran]=sort(ach,'descend');
    
    
    P=p(ran);
    Q=q(ran);
    P=P(11:end); %Ignore first 10 highest ripples cause they might be artifacts. 
    Q=Q(11:end);
end

