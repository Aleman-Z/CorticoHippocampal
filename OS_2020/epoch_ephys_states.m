function [v_hpc]=epoch_ephys_states(HPC,states,ss)
    %Convert signal to 1 sec epochs.
        e_t=1;
        e_samples=e_t*(1000); %fs=1kHz
        ch=length(HPC);
        nc=floor(ch/e_samples); %Number of epochs
        NC=[];
        %NC2=[];

        for kk=1:nc    
          NC(:,kk)= HPC(1+e_samples*(kk-1):e_samples*kk);
         % NC2(:,kk)= PFC(1+e_samples*(kk-1):e_samples*kk);
        end

        vec_bin=states;
        vec_bin(vec_bin~=ss)=0;
        vec_bin(vec_bin==ss)=1;
        %Cluster one values:
        v2=ConsecutiveOnes(vec_bin);

        v_index=find(v2~=0);
        v_values=v2(v2~=0);

    %     
    %     ver=NC(:, v_index(1):v_index(1)+(v_values(1,1)-1));
    %     v{1}=reshape(A, numel(A), 1);
    for epoch_count=1:length(v_index)
    v_hpc{epoch_count,1}=reshape(NC(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
    %v_pfc{epoch_count,1}=reshape(NC2(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
    end 
end