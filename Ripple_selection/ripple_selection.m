function [p,q,sos]=ripple_selection(p,q,sos,Rat,meth)
% % % % % % if quinientos==0
% % % % % % %xd
% % % % % % if outlie==1 
% % % % % % ache=max_outlier(p);
% % % % % % p=p(ache);
% % % % % % q=q(ache);
% % % % % % end
% % % % % % 
% % % % % % [ran]=select_rip(p,FiveHun);
% % % % % % p=p([ran]);
% % % % % % q=q([ran]);
% % % % % % 
% % % % % % else
% % % % % %      if iii~=2
% % % % % %         [ran]=select_quinientos(p,length(randrip)); 
% % % % % %         p=p([ran]);
% % % % % %         q=q([ran]);
% % % % % %      %    ran=1:length(randrip);
% % % % % %      end
% % % % % % end

    %No outliers
    ache=max_outlier(p,Rat,meth);
    p=p(ache);
    q=q(ache);

    if ~isempty(sos) 
        sos=sos(ache);
        [p,q,sos]=sort_rip(p,q,sos);
    else
        [p,q]=sort_rip(p,q);
    end
    %Find strongests ripples. 


%     if ~isempty(sos) && Rat==24
%         %xo
%         'Find outlier'
%         K=[];
%         for k=1:length(sos)
%             [vtr]=findsleep(sos{k}.',median(sos{k}.')); %1 for those above threshold.
%             if sum(vtr)>0
%                 K=[K k];
%             end
%         end
%      p=p(K);
%      q=q(K);
%      sos=sos(K);
%      
% 
%     end

%Select n strongest
% 
% switch Rat
%     case 24
% %         n=550;
%         n=552;
%     case 26
% %         n=180;
%         n=385;
%     case 27
% %         n=326;
%         n=339;
% end
% 
% p=p(1:n);
% q=q(1:n);

end