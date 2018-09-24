function [aver,aver2,Xaver,Xaver2]=perm_stats(GRC1,GRC2)
    %Select combinations. 
    F= [1 2; 1 3; 2 3] ;
    wb=waitbar(0,'wait')

     for j=1:3
        waitbar(j/3,wb,'wait')
          f=F(j,:);
        %Baseline  
        %First direction  
        gr1=abs(squeeze(GRC1(f(1),f(2),:,:)));
        ggr1=gr1-mean(gr1,1);

        %Plusmaze
        % GRC2(isnan(GRC2))=0;
        gr2=abs(squeeze(GRC2(f(1),f(2),:,:)));
        ggr2=gr2-mean(gr2,1);

            for ef=1:501
              [p(ef)]=permutationTest(gr2(ef,:),gr1(ef,:),1000);
                ef
            end

            P=p; %P value
            PP(P<0.05)=1;
            PP(P>=0.05)=0; %Binarized P value. 

       % Psaver{j}=P;
        %PPsaver{j}=PP;
        aver(j,:)=PP;
        aver2(j,:)=P;


        %Opposite direction
        Xgr1=abs(squeeze(GRC1(f(2),f(1),:,:)));
        Xggr1=Xgr1-mean(Xgr1,1);

        Xgr2=abs(squeeze(GRC2(f(2),f(1),:,:)));
        Xggr2=Xgr2-mean(Xgr2,1);



            for ef=1:501
              [p(ef)]=permutationTest(Xgr2(ef,:),Xgr1(ef,:),1000);
                ef
            end

            P=p; %P value
            PP(P<0.05)=1;
            PP(P>=0.05)=0; %Binarized P value. 

            %XPsaver{j}=P;
    %         XPPsaver{j}=PP;        
            Xaver(j,:)=PP;
            Xaver2(j,:)=P;

     end
    close(wb)
end