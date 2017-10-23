function [ese]=orderICA(S,y)
[corr,indx,indy,corrs] = matcorr(S,y,0,2);
% 
nS=S(indx,:);
ny=y(indy,:);

corrsign=(corr<0);

for i=1:length(corr)
  if corrsign(i,1)==1
      ny(i,:)=ny(i,:)*(-1);
  end    
end

% for i=1:length(corr)
%   subplot(length(corr),2,2*i)
%   plot(ny(i,:))
%   subplot(length(corr),2,(2*i)-1)
%   plot(nS(i,:))
%   
% end

for i=1:length(corr)
    ese(indx(i,1),:)=ny(i,:);
end

end