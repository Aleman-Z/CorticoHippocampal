function [sd_swr,signal2_hpc,signal2_pfc]=find_std(HPC,PFC,states,ss,fn)
 
%Ignore NaNs
if sum(isnan(HPC))~=0 || sum(isnan(PFC))~=0
    HPC=HPC(isfinite(HPC));
    PFC=PFC(isfinite(PFC));
    states=states(isfinite(states));
end

%Band pass filter design:
%fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=100-300 Hz
% Wn1=[50/(fn/2) 80/(fn/2)]; 
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

%LPF 300 Hz:
% fn=1000; % New sampling frequency. 
Wn1=[320/(fn/2)]; % Cutoff=320 Hz
[b2,a2] = butter(3,Wn1); %Filter coefficients


%Convert signal to 1 sec epochs.
    e_t=1;
    e_samples=e_t*(fn); %fs=1kHz
    ch=length(HPC);
    nc=floor(ch/e_samples); %Number of epochs
    NC=[];
    NC2=[];
    
    for kk=1:nc    
      NC(:,kk)= HPC(1+e_samples*(kk-1):e_samples*kk);
      NC2(:,kk)= PFC(1+e_samples*(kk-1):e_samples*kk);
    end
    
    vec_bin=states;
    vec_bin(vec_bin~=ss)=0;
    vec_bin(vec_bin==ss)=1;
    
    if sum(vec_bin)==0  %%All states
        vec_bin=vec_bin+1;
    end
    %Cluster one values:
    v2=ConsecutiveOnes(vec_bin);
    
    v_index=find(v2~=0);
    v_values=v2(v2~=0);

%     
%     ver=NC(:, v_index(1):v_index(1)+(v_values(1,1)-1));
%     v{1}=reshape(A, numel(A), 1);
for epoch_count=1:length(v_index)
v_hpc{epoch_count,1}=reshape(NC(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
v_pfc{epoch_count,1}=reshape(NC2(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
end 

%v_hpc and v_pfc: NREM epochs.

%Ripple detection

V_hpc=cellfun(@(equis) filtfilt(b2,a2,equis), v_hpc ,'UniformOutput',false);
Mono_hpc=cellfun(@(equis) filtfilt(b1,a1,equis), V_hpc ,'UniformOutput',false); %100-300 Hz
signal2_hpc=cellfun(@(equis) times((1/0.195), equis)  ,Mono_hpc,'UniformOutput',false); %Remove convertion factor for ripple detection

V_pfc=cellfun(@(equis) filtfilt(b2,a2,equis), v_pfc ,'UniformOutput',false);
Mono_pfc=cellfun(@(equis) filtfilt(b1,a1,equis), V_pfc ,'UniformOutput',false); %100-300 Hz
signal2_pfc=cellfun(@(equis) times((1/0.195), equis)  ,Mono_pfc,'UniformOutput',false); %Remove convertion factor for ripple detection
% fn=1000;

%% SD analysis
%Two approaches
%1) Concatenated epochs:
sd_hpc_co=std(cell2mat(signal2_hpc));
mean_hpc_co=mean(cell2mat(signal2_hpc));
sd2_hpc_co=2*sd_hpc_co+mean_hpc_co;
sd5_hpc_co=5*sd_hpc_co+mean_hpc_co;

sd_pfc_co=std(cell2mat(signal2_pfc));
mean_pfc_co=mean(cell2mat(signal2_pfc));
sd2_pfc_co=2*sd_pfc_co+mean_pfc_co;
sd5_pfc_co=4*sd_pfc_co+mean_pfc_co;


%2) Longest NREM epoch
max_length=cellfun(@length,signal2_hpc);
N=max_length==max(max_length);

%In case of more than one
if sum(N)>1
    N_rep=(find(N==1));
    N_rep=N_rep(1);
    N=N_rep;
end

sd_hpc_long=std(signal2_hpc{N});
mean_hpc_long=mean(signal2_hpc{N});
sd2_hpc_long=2*sd_hpc_long+mean_hpc_long;
sd5_hpc_long=5*sd_hpc_long+mean_hpc_long;

sd_pfc_long=std(signal2_pfc{N});
mean_pfc_long=mean(signal2_pfc{N});
sd2_pfc_long=2*sd_pfc_long+mean_pfc_long;
sd5_pfc_long=5*sd_pfc_long+mean_pfc_long;


%Save values in a struct array.
sd_swr.sd2_hpc_co=sd2_hpc_co;
sd_swr.sd5_hpc_co=sd5_hpc_co;
sd_swr.sd2_pfc_co=sd2_pfc_co;
sd_swr.sd5_pfc_co=sd5_pfc_co;
sd_swr.sd2_hpc_long=sd2_hpc_long;
sd_swr.sd5_hpc_long=sd5_hpc_long;
sd_swr.sd2_pfc_long=sd2_pfc_long;
sd_swr.sd5_pfc_long=sd5_pfc_long;


end