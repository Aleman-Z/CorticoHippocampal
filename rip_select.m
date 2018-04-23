function [ran]=rip_select(p)
        av=cat(1,p{1:end});
        %av=cat(1,q{1:end});

        av=av(1:3:end,:); %Only Hippocampus
        %AV=max(av.');
        %[B I]= maxk(AV,1000);
        %[B I]= maxk(max(av.'),1000); %Look for the 1000 ripples with highest amplitude. THIS SHOULD BE MEAN instead of Max since some peaks go downwards and no upwards. 

        [ach, ind]=max(av.');
        [B, I]=sort(ach,'descend');
%         if length(achinga)>1000
%         achinga=achinga(1:1000);
%         end
%          B=achinga;
%         %Determine indexes 
%         I=nan(1,length(B));
%         uachinga=unique(achinga);
%         cont=0;
%             for hh=1:length(uachinga)
%                % I(hh)= min(find(ach==achinga(hh)));
%             rep=find(ach==uachinga(hh));
%             if length(rep)==1
%                 cont=cont+1;
% %                I(hh)= find(ach==achinga(hh),1,'first');   
%                 I(cont)=rep(1);
%             else
%                 cont=cont+1;
% 
%                 I(cont)=rep(1);
%                 for hhh=2:length(rep)
%                     %hh=hh+1;
%                     cont=cont+1;
%                     I(cont)=rep(hhh);
%                     
%                 end
%             end
%             %I(hh)= find(ach==achinga(hh),1,'first');
%             end



 %       [ajal ind]=unique(B); %Repeated ripples, which are very close to each other. 
%         if length(ajal)>500
%         ajal=ajal(end-499:end);
%         ind=ind(end-499:end);
%         end
% ajal=B;
% ind=I;
% if length(ajal)>1000
% %         ajal=ajal(end-999:end);
% %         ind=ind(end-999:end);
%         ajal=ajal(1:1000);
%         ind=ind(1:1000);
% end
I=I(2:end);
if length(I)>1000
%         ajal=ajal(end-999:end);
%         ind=ind(end-999:end);
        I=I(1:1000);
end


%dex=I(ind);
dex=I;
        ran=dex.';
    end