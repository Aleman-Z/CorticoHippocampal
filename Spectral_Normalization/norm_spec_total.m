function[freq1]=norm_spec_total(freq1)    
    cao=freq1.powspctrm;
    % KAO=cao;

    for j=1:size(cao,1)
        for y=1:size(cao,2)

            kao=squeeze(cao(j,y,:,:));
            mkao=max(max(kao.'));
            nkao=kao./mkao.';
            KAO(j,y,:,:)=nkao;

        end
    end

    freq1.powspctrm=KAO;

end