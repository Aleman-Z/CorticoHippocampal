
function [achis]=baseline_norm(freq1,w)

%%Average trials
TF=freq1.powspctrm;

TF=squeeze(mean(TF,1));
TF=squeeze(TF(w,:,:));
TFt=freq1.time;


tind=([-1 -0.5]);
% ind1=find(TFt==tind(1));
% ind2=find(TFt==tind(2));
ind1=find((ismembertol(TFt,tind(1))));
ind2=find((ismembertol(TFt,tind(2))));

FF=mean(squeeze(TF(:,ind1:ind2)),2); %baseline

achis=10*log10( bsxfun(@rdivide, TF, FF) );


end