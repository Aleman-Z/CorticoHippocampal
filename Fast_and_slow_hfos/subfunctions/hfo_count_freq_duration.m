function [ripple, RipFreq,rip_duration]=hfo_count_freq_duration(Sx,Ex,timeasleep)
    s=cellfun('length',Sx);
    RipFreq=sum(s)/(timeasleep*(60)); %RIpples per second.
    ripple=sum(s);
    C = cellfun(@minus,Ex,Sx,'UniformOutput',false);
    CC=([C{:}]);
        if isempty(CC)
            rip_duration=0;
        else
            rip_duration=median(CC);
        end
     
end