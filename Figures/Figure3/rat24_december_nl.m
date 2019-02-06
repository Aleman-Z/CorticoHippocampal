if Rat==24 && rat24base==2
clear em
%Find max and min peaks    
     for j=1:length(p_nl)
          %em(j)=max(abs(p{j}(2,1150:1250))); % Best result works when detection is done on Parietal. 1150:1250 ensures detection around time zero. 
          em(j)=max(abs(p_nl{j}(2,:))); % Best result works when detection is done on Parietal. 1150:1250 ensures detection around time zero.
%           EM(j)=max(abs(p{j}(3,:))); % Best result works when detection is done on Parietal. 1150:1250 ensures detection around time zero.
          %hold on
     end
 [em,nu]=unique(em);
%  [EM,NU]=unique(EM);    
%Sort and remove largest peaks
[c1,c2]=sort(em,'descend');
% [C1,C2]=sort(EM,'descend');

c2=nu(c2); 
% C2=NU(C2); 
%
% c3=intersect(c2,C2);%USE THIS 
% 
% C3=[];
% for k=1:length(c2)
%     if ismember(c2(k),c3)
%         C3=[C3 c2(k)];
%     end
% end
% c2=C3;

% p=p(:,c2(350:end));
% q=q(:,c2(350:end));
p_nl=p_nl(:,c2(floor(0.66*length(c2)):end));
q_nl=q_nl(:,c2(floor(0.66*length(c2)):end));
%170    
end
