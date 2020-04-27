function [swr_hpc,Mx_hpc]=epoch_ephys_states(HPC,states,ss,a1,a2,b1,b2,D1,D2,xx,fn)
    %Convert signal to 1 sec epochs.
        e_t=1;
        e_samples=e_t*(fn); %fs=1kHz
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
        if sum(vec_bin)>0
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
%%    
V_hpc=cellfun(@(equis) filtfilt(b2,a2,equis), v_hpc ,'UniformOutput',false);
Mono_hpc=cellfun(@(equis) filtfilt(b1,a1,equis), V_hpc ,'UniformOutput',false); %100-300 Hz
signal2_hpc=cellfun(@(equis) times((1/0.195), equis)  ,Mono_hpc,'UniformOutput',false); %Remove convertion factor for ripple detection

ti=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,signal2_hpc,'UniformOutput',false);    
%%
if strcmp(xx,'HPC')
[Sx_hpc,Ex_hpc,Mx_hpc] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2, D1, (D1)*(1/2), [] ), signal2_hpc,ti,'UniformOutput',false);    
else
%Cortical ripples
[Sx_hpc,Ex_hpc,Mx_hpc] =cellfun(@(equis1,equis2) findRipplesLisa2020(equis1, equis2, D1, (D1)*(1/2), [] ), signal2_hpc,ti,'UniformOutput',false);        
end

swr_hpc=[Sx_hpc Ex_hpc Mx_hpc];
%%    
    end 
        else
            %v_hpc=[];
            swr_hpc={};
            Mx_hpc={};
        end
    
end