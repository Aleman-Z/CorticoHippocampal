function[freq1]=norm_spec(freq1)    
    cao=freq1.powspctrm;
    % KAO=cao;

    for j=1:size(cao,1)
        for y=1:size(cao,2)

            kao=squeeze(cao(j,y,:,:));
            mkao=max(kao.');
            nkao=kao./mkao.';
            KAO(j,y,:,:)=nkao;

        end
    end

    freq1.powspctrm=KAO;

end
%%
%             mkao=max(kao);
%             nkao=kao.'./mkao.';
%             nkao=nkao.';
%      
%             KAO(j,y,:,:)=nkao;

% subplot(1,2,1)
% imagesc(kao)
% colorbar()
% %%
% mkao=max(kao.');
% mmkao=max(mkao);
% %%
% nkao=kao./mkao.';
% %%
% 
% subplot(1,2,2)
% imagesc(nkao)
% colorbar()
% %%
% subplot(1,2,1)
% imagesc(kao)
% colorbar()
% %%
% subplot(1,2,2)
% imagesc(kao./mmkao)
% colorbar()
