function [ripple2, RipFreq2,rip_duration]=hfo_count_freq_duration(Sx,Ex,timeasleep)
    s=cellfun('length',Sx);
    RipFreq2=sum(s)/(timeasleep*(60)); %RIpples per second.
    ripple2=sum(s);
    C = cellfun(@minus,Ex,Sx,'UniformOutput',false);
    CC=([C{:}]);
        if isempty(CC)
            rip_duration=0;
        else
            rip_duration=median(CC);
        end
     
end