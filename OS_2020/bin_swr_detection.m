function [nr_swr_HPC, nr_swr_Cortex]=bin_swr_detection(HPC,Cortex,states,ss,D1,D2)
i=1;
    %Binning sleep scoring data
                        bin_size=5*60; %5minutes
                        nbins=size(states,2)/bin_size;

                        slpscr_binned = {};
                        for n=1:nbins
                           slpscr_binned= [slpscr_binned states(:,1+(n-1)*bin_size:bin_size*(n))];
                        end

    %Binning sleep scoring data                    
                        bin_size2=5*60*1000; %5minutes
                        nbins=size(HPC,2)/bin_size2;
    %Band pass filter design:
    fn=1000; % New sampling frequency. 
    Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=100-300 Hz
    % Wn1=[50/(fn/2) 80/(fn/2)]; 
    [b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

    %LPF 300 Hz:
    fn=1000; % New sampling frequency. 
    Wn1=[320/(fn/2)]; % Cutoff=320 Hz
    [b2,a2] = butter(3,Wn1); %Filter coefficients

%     D1=70;
%     D2=40;

                        HPC_binned = {};
                        Cortex_binned = {};

     %xo
                        for n=1:nbins
    %                        HPC_binned = [HPC_binned HPC(:,1+(n-1)*bin_size2:bin_size2*(n)).'];
    %                         epoch_ephys_states(HPC(:,1+(n-1)*bin_size2:bin_size2*(n)).',slpscr_binned{n},ss);
                           HPC_binned{n} =  epoch_ephys_states(HPC(:,1+(n-1)*bin_size2:bin_size2*(n)).',slpscr_binned{n},ss,a1,a2,b1,b2,D1,D2);
                           Cortex_binned{n} = epoch_ephys_states(Cortex(:,1+(n-1)*bin_size2:bin_size2*(n)).',slpscr_binned{n},ss,a1,a2,b1,b2,D1,D2);
    %                        Cortex_binned = [Cortex_binned Cortex(:,1+(n-1)*bin_size2:bin_size2*(n)).'];
                             if ~isempty(HPC_binned{n})
                                 nr_swr_HPC(i,n)=sum(cellfun('length',HPC_binned{n}(:,1)));
                             else
                                 nr_swr_HPC(i,n)=0;
                             end

                             if ~isempty(Cortex_binned{n})
                                 nr_swr_Cortex(i,n)=sum(cellfun('length',Cortex_binned{n}(:,1)));                          
                             else
                                 nr_swr_Cortex(i,n)=0;                          
                             end
                        end
end