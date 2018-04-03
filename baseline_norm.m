
function [achis]=baseline_norm(freq3,w)

%%Average trials
TF=freq3.powspctrm;
TF=squeeze(mean(TF,1));
TF=squeeze(TF(w,:,:));
TFt=freq3.time;


tind=([-1 -0.5]);
ind1=find(TFt==tind(1));
ind2=find(TFt==tind(2));


FF=mean(squeeze(TF(:,ind1:ind2)),2); %baseline

achis=10*log10( bsxfun(@rdivide, TF, FF) );


end