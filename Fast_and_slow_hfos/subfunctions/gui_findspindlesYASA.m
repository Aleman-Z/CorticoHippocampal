function [ripple,RipFreq,rip_duration,Mx,timeasleep,sig,Ex,Sx,ripple_multiplets,RipFreq_multiplets,rip_duration_multiplets,sig_multiplets,M_multiplets,V,Mono]=gui_findspindlesYASA(CORTEX,states,xx,multiplets,fn)
    %Band pass filter design:
    Wn1=[0.3/(fn/2) 300/(fn/2)]; 
    [b2,a2] = butter(3,Wn1); %0.3 to 300Hz
%Convert signal to 1 sec epochs.
        e_t=1;
        e_samples=e_t*(fn); %fs=1kHz
        ch=length(CORTEX);
        nc=floor(ch/e_samples); %Number of epochsw
        NC=[];
        for kk=1:nc
          NC(:,kk)= CORTEX(1+e_samples*(kk-1):e_samples*kk);
        end
        vec_bin=states;
        %Convert to 1 if NREM.
        vec_bin(vec_bin~=3)=0;
        vec_bin(vec_bin==3)=1;
        %Cluster one values:
        v2=ConsecutiveOnes(vec_bin);
        v_index=find(v2~=0);
        v_values=v2(v2~=0);
    for epoch_count=1:length(v_index)
    v{epoch_count,1}=reshape(NC(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
    end
    V=cellfun(@(equis) filtfilt(b2,a2,equis), v ,'UniformOutput',false); %0.3 to 300Hz
    

    Wn1=[9/(fn/2) 20/(fn/2)]; % Cutoff=9-20 Hz
    [b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients
    Mono=cellfun(@(equis) filtfilt(b1,a1,equis), V ,'UniformOutput',false); %Regular 9-20Hz bandpassed for sig variable.
       
    %Total amount of NREM time:
    timeasleep=sum(cellfun('length',V))*(1/fn)/60; % In minutes
    ti=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,Mono,'UniformOutput',false);

    % %% Find largest epoch.
    max_length=cellfun(@length,v);
    nrem_epoch=find(max_length==max(max_length)==1);
    nrem_epoch=nrem_epoch(1);

    
    
    if strcmp(xx{1},'PAR')
            spindout=load('YASA_PAR_spindles.mat');
            spindout=spindout.averout;

            for jj=1:length(spindout)
                if ~isempty(spindout{jj})
                    aver=spindout{jj}(:,1:3);
                    aver=[aver{:}];
                    aver=sort(aver);
                    aver=reshape(aver,[3,length(aver)/3]);
                    Sx_spind{jj}=aver(1,:);
                    Mx_spind{jj}=aver(2,:);
                    Ex_spind{jj}=aver(3,:);
                else
                    Sx_spind{jj}=[];
                    Mx_spind{jj}=[];
                    Ex_spind{jj}=[];

                end

            end

              Sx=Sx_spind.';
              Ex=Ex_spind.';
              Mx=Mx_spind.';
    

    else
        
        spindout=load('YASA_PFC_spindles.mat');
        spindout=spindout.averout;

        for jj=1:length(spindout)
            if ~isempty(spindout{jj})
                aver=spindout{jj}(:,1:3);
                aver=[aver{:}];
                aver=sort(aver);
                aver=reshape(aver,[3,length(aver)/3]);
                Sx_spind{jj}=aver(1,:);
                Mx_spind{jj}=aver(2,:);
                Ex_spind{jj}=aver(3,:);
            else
                Sx_spind{jj}=[];
                Mx_spind{jj}=[];
                Ex_spind{jj}=[];

            end

        end
   
          Sx=Sx_spind.';
          Ex=Ex_spind.';
          Mx=Mx_spind.'; 
    end
    
    %Multiplets detection
    for l=1:length(Mx)
         hfo_sequence=ConsecutiveOnes(diff(Mx{l})<=0.300);

         for ll=1:length(multiplets)
             eval([multiplets{ll} '=(hfo_sequence=='  num2str(ll-1) ');'])
             cont=1;
             M_multiplets.(multiplets{ll}){l}=[];
             while cont<=ll
                 eval(['Mx_' multiplets{ll} '_' num2str(cont) '{l}=Mx{l}(find(' multiplets{ll} ')+(cont-1));'])
                 Mx_multiplets.(multiplets{ll}).(strcat('m_',num2str(cont))){l}=eval(['Mx_' multiplets{ll} '_' num2str(cont) '{l}']);
                 M_multiplets.(multiplets{ll}){l}=eval(['sort([M_multiplets.(multiplets{ll}){l} ' ' Mx_' multiplets{ll} '_' num2str(cont) '{l}])']); % Combined consecutive multiplets    
                 cont=cont+1;
             end
         end
    end
    
        %Multiplets detection
    for l=1:length(Mx)
         hfo_sequence=ConsecutiveOnes(diff(Mx{l})<=0.300);

         for ll=1:length(multiplets)
             eval([multiplets{ll} '=(hfo_sequence=='  num2str(ll-1) ');'])
             eval(['Sx_' multiplets{ll} '_1{l}=Sx{l}(find(' multiplets{ll} '));'])
             eval(['Ex_' multiplets{ll} '_1{l}=Ex{l}(find(' multiplets{ll} '));'])

         end
    end
    
    for l=1:length(Sx)
         sig{l}=getsignal(Sx,Ex,ti,Mono,l);
        for ll=1:length(multiplets)
            eval(['sig_' multiplets{ll} '_1{l}=getsignal(Sx_' multiplets{ll} '_1,Ex_' multiplets{ll} '_1,ti,Mono,l);'])
                        eval(strcat('sig_',multiplets{ll},'_1=sig_',multiplets{ll},'_1.'';'))
              eval(['sig_multiplets.(' 'multiplets{ll}' ')=sig_' multiplets{ll},'_1.'';'])  
              eval(['clear' ' ' 'sig_' multiplets{ll} '_1'])
        end
    end

    sig=sig.';

    [ripple, RipFreq,rip_duration]=hfo_count_freq_duration(Sx,Ex,timeasleep);
    
    for ll=1:length(multiplets)
        eval(['[ripple_multiplets.(' 'multiplets{ll}' '), RipFreq_multiplets.(' 'multiplets{ll}' '),rip_duration_multiplets.(' 'multiplets{ll}' ')]=hfo_count_freq_duration(Sx_' multiplets{ll} '_1,Ex_' multiplets{ll} '_1,timeasleep);']);
    end
    RipFreq=RipFreq*60; %Spindles per minute.
end