function Granger_bootstrap_ripple(GRC1,GRC2)
F= [1 2; 1 3; 2 3] ;
COMBO=cell(1,3);

for jj=1:3
ZMAP1=zeros(size(GRC1,3),size(GRC1,4));
ZMAP2=zeros(size(GRC1,3),size(GRC1,4));

    f=waitbar(0,'Please wait...');
    for ho=1:size(GRC1,4)
        progress_bar(ho,size(GRC1,4),f)
        
        ff=F(jj,:);
        turnim1=squeeze(GRC1(ff(1),ff(2),:,ho));
        turnim2=squeeze(GRC2(ff(1),ff(2),:,ho));
[zmap]=stats_high2((turnim1),(turnim2));
%ZMAP1=ZMAP1+zmap;
ZMAP1(:,ho)=zmap;


        turnim1=squeeze(GRC1(ff(2),ff(1),:,ho));
        turnim2=squeeze(GRC2(ff(2),ff(1),:,ho));
[zmap]=stats_high2((turnim1),(turnim2));
% ZMAP2=ZMAP2+zmap;
ZMAP2(:,ho)=zmap;
    end
    COMBO{jj}=[ZMAP1 ZMAP2];
    %xo
end
end