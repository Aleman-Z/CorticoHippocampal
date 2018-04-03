function [ran]=rip_select(p)
        av=cat(1,p{1:end});
        %av=cat(1,q{1:end});

        av=av(1:3:end,:); %Only Hippocampus
        %AV=max(av.');
        %[B I]= maxk(AV,1000);
        %[B I]= maxk(max(av.'),1000); %Look for the 1000 ripples with highest amplitude. THIS SHOULD BE MEAN instead of Max since some peaks go downwards and no upwards. 

        [ach]=max(av.');
        achinga=sort(ach,'descend');
        if length(achinga)>1000
        achinga=achinga(1:1000);
        end
        B=achinga;
        I=nan(1,length(B));
            for hh=1:length(achinga)
               % I(hh)= min(find(ach==achinga(hh)));
            I(hh)= find(ach==achinga(hh),1,'first');
            end



        [ajal ind]=unique(B); %Repeated ripples, which are very close to each other. 
%         if length(ajal)>500
%         ajal=ajal(end-499:end);
%         ind=ind(end-499:end);
%         end

if length(ajal)>1000
        ajal=ajal(end-999:end);
        ind=ind(end-999:end);
end
        
dex=I(ind);

        ran=dex.';
    end