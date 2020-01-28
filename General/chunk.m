function [NC]=chunk(HPC,e_t)
  %Convert signal to e_t sec epochs.
  %HPC: signal.
  %e_t: lenght of epoch in seconds
  
    e_samples=e_t*(1000); %fs=1kHz
    ch=length(HPC);
    nc=floor(ch/e_samples); %Number of epochs
    NC=[];
    NC2=[];
    
    for kk=1:nc    
      NC(:,kk)= HPC(1+e_samples*(kk-1):e_samples*kk);
   %   NC2(:,kk)= PFC(1+e_samples*(kk-1):e_samples*kk);
    end

end