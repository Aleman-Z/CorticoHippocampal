function [swr_hpc,swr_pfc,s_hpc,s_pfc,V_hpc,V_pfc,signal2_hpc,signal2_pfc,sd_swr,sig]=swr_check_thr(HPC,PFC,states,ss,D1,D2,fn)
 
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
        if ss==6  %Only continue if All states option was selected
        vec_bin=vec_bin+1;
        else  %When the sleep state was not found.
swr_hpc=0;
swr_pfc=0;
s_hpc=0;
s_pfc=0;
V_hpc=0;
V_pfc=0;
signal2_hpc=0;
signal2_pfc=0;
sd_swr=0;
sig={};
            return
        end
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

ti=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,signal2_hpc,'UniformOutput',false);
% ti_pfc=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,signal2_pfc,'UniformOutput',false);
%% SWR in HPC
% D1=70;%THRESHOLD
k=1;
    [Sx_hpc,Ex_hpc,Mx_hpc] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2, D1, (D1)*(1/2),fn), signal2_hpc,ti,'UniformOutput',false);    
    swr_hpc(:,:,k)=[Sx_hpc Ex_hpc Mx_hpc];
    s_hpc(:,k)=cellfun('length',Sx_hpc);
%% Cortical ripples
%D2=35;%THRESHOLD
    [Sx_pfc,Ex_pfc,Mx_pfc] =cellfun(@(equis1,equis2) findRipplesLisa2020(equis1, equis2, D2, (D2)*(1/2), fn ), signal2_pfc,ti,'UniformOutput',false);    
    swr_pfc(:,:,k)=[Sx_pfc Ex_pfc Mx_pfc];
    s_pfc(:,k)=cellfun('length',Sx_pfc);%% Cortical ripples
%% Extract waveforms.

%Get traces of events detected

    for l=1:length(Sx_pfc)
         sig{l}=getsignal(Sx_pfc,Ex_pfc,ti,Mono_pfc,l);
%         sig{l}=getsignal(Sx_pfc,Ex_pfc,ti,V_pfc,l);
    end
    sig=sig.';
    
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