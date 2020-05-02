function [ripple2,RipFreq2,rip_duration,Mx,timeasleep,sig,Ex,Sx,p,q,cont,sig_pq]=gui_findripples_spec(CORTEX,states,xx,tr,PFC,HPC,fn)

[Mono,V]=swr_preprocessing(CORTEX,states,fn); %Main signal
[Mono2,V2]=swr_preprocessing(PFC,states,fn); %PFC signal
[Mono3,V3]=swr_preprocessing(HPC,states,fn); %Third signal


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
   
    
    for l=1:length(Sx)
         [sig{l},p{l},q{l},cont{l},sig_pq{l}]=getsignal_spec(Sx,Ex,ti,Mono,l,Mx,V,Mono2,V2,Mono3,V3);
%        sig{l}=getsignal(Sx,Ex,ti,V,l);
        
    end


%     end
    sig=sig.';

    [ripple2, RipFreq2,rip_duration]=hfo_count_freq_duration(Sx,Ex,timeasleep);
    
%  p=p(~cellfun('isempty',p));
%  p=[p{:}];
%  q=q(~cellfun('isempty',q));
%  q=[q{:}];
%  
p=p.';
q=q.';
sig_pq=sig_pq.';
cont=cell2mat(cont);
end