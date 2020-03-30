function [ripple2,RipFreq2,rip_duration,Mx,timeasleep,sig,Ex,Sx,ripple_douplets, RipFreq_douplets,rip_duration_douplets,sig_douplets_1,sig_triplets_1,ripple_triplets, RipFreq_triplets,rip_duration_triplets,ripple_quadruplets, RipFreq_quadruplets,rip_duration_quadruplets,ripple_pentuplets, RipFreq_pentuplets,rip_duration_pentuplets,ripple_sextuplets, RipFreq_sextuplets,rip_duration_sextuplets]=gui_findripples(CORTEX,states,xx,tr)
    %Band pass filter design:
    fn=1000; % New sampling frequency.
    Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=100-300 Hz
    [b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
    %LPF 300 Hz:
    fn=1000; % New sampling frequency.
    Wn1=[320/(fn/2)]; % Cutoff=320 Hz
    [b2,a2] = butter(3,Wn1); %Filter coefficients
%Convert signal to 1 sec epochs.
        e_t=1;
        e_samples=e_t*(1000); %fs=1kHz
        ch=length(CORTEX);
        nc=floor(ch/e_samples); %Number of epochsw
        NC=[];
        for kk=1:nc
          NC(:,kk)= CORTEX(1+e_samples*(kk-1):e_samples*kk);
        end
        vec_bin=states;
        vec_bin(vec_bin~=3)=0;
        vec_bin(vec_bin==3)=1;
        %Cluster one values:
        v2=ConsecutiveOnes(vec_bin);
        v_index=find(v2~=0);
        v_values=v2(v2~=0);
    for epoch_count=1:length(v_index)
    v{epoch_count,1}=reshape(NC(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
    end
    V=cellfun(@(equis) filtfilt(b2,a2,equis), v ,'UniformOutput',false);
    Mono=cellfun(@(equis) filtfilt(b1,a1,equis), V ,'UniformOutput',false);
    %Total amount of NREM time:
    timeasleep=sum(cellfun('length',V))*(1/1000)/60; % In minutes
    signal2=cellfun(@(equis) times((1/0.195), equis)  ,Mono,'UniformOutput',false);
    % ti=cellfun(@(equis) linspace(0, length(equis)-1,length(equis))*(1/fn) ,signal2,'UniformOutput',false);
    ti=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,signal2,'UniformOutput',false);
    %xo
    if strcmp(xx{1},'HPC')
    [Sx,Ex,Mx] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2, tr(1), (tr(1))*(1/2), [] ), signal2,ti,'UniformOutput',false);
    else
    [Sx,Ex,Mx] =cellfun(@(equis1,equis2) findRipplesLisa2020(equis1, equis2, tr(2), (tr(2))*(1/2), [] ), signal2,ti,'UniformOutput',false);
    end
    
    %Multiplets detection
    for l=1:length(Mx)
         hfo_sequence=ConsecutiveOnes(diff(Mx{l})<=0.300);
         %Douplets
         douplets=(hfo_sequence==1);
%          Mx_douplets_1{l}=Mx{l}(find(douplets));
%          Mx_douplets_2{l}=Mx{l}(find(douplets)+1);
         Sx_douplets_1{l}=Sx{l}(find(douplets));
%          Sx_douplets_2{l}=Sx{l}(find(douplets)+1);
         Ex_douplets_1{l}=Ex{l}(find(douplets));
%          Ex_douplets_2{l}=Ex{l}(find(douplets)+1);
         
         %Triplets
         triplets=(hfo_sequence==2);
%          Mx_triplets_1{l}=Mx{l}(find(triplets));
%          Mx_triplets_2{l}=Mx{l}(find(triplets)+1);
%          Mx_triplets_3{l}=Mx{l}(find(triplets)+2);
         Sx_triplets_1{l}=Sx{l}(find(triplets));
%          Sx_triplets_2{l}=Sx{l}(find(triplets)+1);
%          Sx_triplets_3{l}=Sx{l}(find(triplets)+2);
         Ex_triplets_1{l}=Ex{l}(find(triplets));
%          Ex_triplets_2{l}=Ex{l}(find(triplets)+1);
%          Ex_triplets_3{l}=Ex{l}(find(triplets)+2);
         
         %Quadruplets
         quadruplets=(hfo_sequence==3);
%          Mx_quadruplets_1{l}=Mx{l}(find(quadruplets));
%          Mx_quadruplets_2{l}=Mx{l}(find(quadruplets)+1);
%          Mx_quadruplets_3{l}=Mx{l}(find(quadruplets)+2);
%          Mx_quadruplets_4{l}=Mx{l}(find(quadruplets)+3);
         
         Sx_quadruplets_1{l}=Sx{l}(find(quadruplets));
%          Sx_quadruplets_2{l}=Sx{l}(find(quadruplets)+1);
%          Sx_quadruplets_3{l}=Sx{l}(find(quadruplets)+2);
%          Sx_quadruplets_4{l}=Sx{l}(find(quadruplets)+3);
         
         Ex_quadruplets_1{l}=Ex{l}(find(quadruplets));
%          Ex_quadruplets_2{l}=Ex{l}(find(quadruplets)+1);
%          Ex_quadruplets_3{l}=Ex{l}(find(quadruplets)+2);
%          Ex_quadruplets_4{l}=Ex{l}(find(quadruplets)+3);
         
         %Pentuplets
         pentuplets=(hfo_sequence==4);
%          Mx_pentuplets_1{l}=Mx{l}(find(pentuplets));
%          Mx_pentuplets_2{l}=Mx{l}(find(pentuplets)+1);
%          Mx_pentuplets_3{l}=Mx{l}(find(pentuplets)+2);
%          Mx_pentuplets_4{l}=Mx{l}(find(pentuplets)+3);
%          Mx_pentuplets_5{l}=Mx{l}(find(pentuplets)+4);
         
         
         Sx_pentuplets_1{l}=Sx{l}(find(pentuplets));
%          Sx_pentuplets_2{l}=Sx{l}(find(pentuplets)+1);
%          Sx_pentuplets_3{l}=Sx{l}(find(pentuplets)+2);
%          Sx_pentuplets_4{l}=Sx{l}(find(pentuplets)+3);
%          Sx_pentuplets_5{l}=Sx{l}(find(pentuplets)+4);

         
         Ex_pentuplets_1{l}=Ex{l}(find(pentuplets));
%          Ex_pentuplets_2{l}=Ex{l}(find(pentuplets)+1);
%          Ex_pentuplets_3{l}=Ex{l}(find(pentuplets)+2);
%          Ex_pentuplets_4{l}=Ex{l}(find(pentuplets)+3);         
%          Ex_pentuplets_5{l}=Ex{l}(find(pentuplets)+4);
         
         
         %Sextuplets
         sextuplets=(hfo_sequence==5);
%          Mx_sextuplets_1{l}=Mx{l}(find(sextuplets));
%          Mx_sextuplets_2{l}=Mx{l}(find(sextuplets)+1);
%          Mx_sextuplets_3{l}=Mx{l}(find(sextuplets)+2);
%          Mx_sextuplets_4{l}=Mx{l}(find(sextuplets)+3);
%          Mx_sextuplets_5{l}=Mx{l}(find(sextuplets)+4);
%          Mx_sextuplets_6{l}=Mx{l}(find(sextuplets)+5);
                  
         Sx_sextuplets_1{l}=Sx{l}(find(sextuplets));
%          Sx_sextuplets_2{l}=Sx{l}(find(sextuplets)+1);
%          Sx_sextuplets_3{l}=Sx{l}(find(sextuplets)+2);
%          Sx_sextuplets_4{l}=Sx{l}(find(sextuplets)+3);
%          Sx_sextuplets_5{l}=Sx{l}(find(sextuplets)+4);
%          Sx_sextuplets_6{l}=Sx{l}(find(sextuplets)+5);
         
         Ex_sextuplets_1{l}=Ex{l}(find(sextuplets));
%          Ex_sextuplets_2{l}=Ex{l}(find(sextuplets)+1);
%          Ex_sextuplets_3{l}=Ex{l}(find(sextuplets)+2);
%          Ex_sextuplets_4{l}=Ex{l}(find(sextuplets)+3);         
%          Ex_sextuplets_5{l}=Ex{l}(find(sextuplets)+4);
%          Ex_sextuplets_6{l}=Ex{l}(find(sextuplets)+5);  
         
    end    
    
    for l=1:length(Sx)
         sig{l}=getsignal(Sx,Ex,ti,Mono,l);
%        sig{l}=getsignal(Sx,Ex,ti,V,l);
         sig_douplets_1{l}=getsignal(Sx_douplets_1,Ex_douplets_1,ti,Mono,l);
         sig_triplets_1{l}=getsignal(Sx_triplets_1,Ex_triplets_1,ti,Mono,l);
         sig_quadruplets_1{l}=getsignal(Sx_quadruplets_1,Ex_quadruplets_1,ti,Mono,l);
         sig_pentuplets_1{l}=getsignal(Sx_pentuplets_1,Ex_pentuplets_1,ti,Mono,l);
         sig_sextuplets_1{l}=getsignal(Sx_sextuplets_1,Ex_sextuplets_1,ti,Mono,l);         
         
    end
    sig=sig.';
    sig_douplets_1=sig_douplets_1.';
    sig_triplets_1=sig_triplets_1.';
    sig_quadruplets_1=sig_quadruplets_1.';    
    sig_pentuplets_1=sig_pentuplets_1.';    
    sig_sextuplets_1=sig_sextuplets_1.';    
    
    % [Sx,Ex,Mx] =cellfun(@(equis1,equis2) findRipplesLisa2020(equis1, equis2, tr(2), (tr(2))*(1/2), [] ), signal2,ti,'UniformOutput',false);
%All HFOs
%     s=cellfun('length',Sx);
%     RipFreq2=sum(s)/(timeasleep*(60)); %RIpples per second.
%     ripple2=sum(s);
%     C = cellfun(@minus,Ex,Sx,'UniformOutput',false);
%     CC=([C{:}]);
%     rip_duration=median(CC);
    [ripple2, RipFreq2,rip_duration]=hfo_count_freq_duration(Sx,Ex,timeasleep);
%Douplets
    [ripple_douplets, RipFreq_douplets,rip_duration_douplets]=hfo_count_freq_duration(Sx_douplets_1,Ex_douplets_1,timeasleep);
%Triplets
    [ripple_triplets, RipFreq_triplets,rip_duration_triplets]=hfo_count_freq_duration(Sx_triplets_1,Ex_triplets_1,timeasleep);
%Quadruplets
    [ripple_quadruplets, RipFreq_quadruplets,rip_duration_quadruplets]=hfo_count_freq_duration(Sx_quadruplets_1,Ex_quadruplets_1,timeasleep);
%Pentuplets
    [ripple_pentuplets, RipFreq_pentuplets,rip_duration_pentuplets]=hfo_count_freq_duration(Sx_pentuplets_1,Ex_pentuplets_1,timeasleep);
%Sextuplets
    [ripple_sextuplets, RipFreq_sextuplets,rip_duration_sextuplets]=hfo_count_freq_duration(Sx_sextuplets_1,Ex_sextuplets_1,timeasleep);

end