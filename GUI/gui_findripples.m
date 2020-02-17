function [ripple2,RipFreq2,rip_duration,Mx,timeasleep]=gui_findripples(CORTEX,states,xx,tr)
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
        nc=floor(ch/e_samples); %Number of epochs
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

    % [Sx,Ex,Mx] =cellfun(@(equis1,equis2) findRipplesLisa2020(equis1, equis2, tr(2), (tr(2))*(1/2), [] ), signal2,ti,'UniformOutput',false);           
    s=cellfun('length',Sx);        
    RipFreq2=sum(s)/(timeasleep*(60)); %RIpples per second.         
    ripple2=sum(s);

    C = cellfun(@minus,Ex,Sx,'UniformOutput',false);
    CC=([C{:}]);
    rip_duration=median(CC);
end