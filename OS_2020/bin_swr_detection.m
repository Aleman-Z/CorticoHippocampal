function [nr_swr_HPC, nr_swr_Cortex,nr_cohfos,nr_single_hpc,nr_single_cortex]=bin_swr_detection(HPC,Cortex,states,ss,D1,D2,xx,fn)
i=1;
    %Binning sleep scoring data
                        bin_size=5*60; %5minutes
                        nbins=size(states,2)/bin_size;

                        slpscr_binned = {};
                        for n=1:nbins
                           slpscr_binned= [slpscr_binned states(:,1+(n-1)*bin_size:bin_size*(n))];
                        end

    %Binning ephys data                    
                        bin_size2=5*60*fn; %5minutes
                        nbins=size(HPC,2)/bin_size2;
    %Band pass filter design:
    Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=100-300 Hz
    % Wn1=[50/(fn/2) 80/(fn/2)]; 
    [b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

    %LPF 300 Hz:
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
                           [HPC_binned{n}, Mx_hpc{n}] =  epoch_ephys_states(HPC(:,1+(n-1)*bin_size2:bin_size2*(n)).',slpscr_binned{n},ss,a1,a2,b1,b2,D1,D2,'HPC',fn);
                           [Cortex_binned{n},Mx_cortex{n}] = epoch_ephys_states(Cortex(:,1+(n-1)*bin_size2:bin_size2*(n)).',slpscr_binned{n},ss,a1,a2,b1,b2,D1,D2,xx{1},fn);
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
                             
                             %Coocurrent
                             [cohfos1{n},cohfos2{n}]=cellfun(@(equis1,equis2) co_hfo(equis1,equis2),Mx_hpc{n},Mx_cortex{n},'UniformOutput',false);
                             if ~isempty(cohfos1{n})
                                  nr_cohfos(i,n)=sum(cellfun('length',cohfos1{n}(:,1)));                          
                             else
                                 nr_cohfos(i,n)=0;                          
                             end

                              v2_single_hpc{n}=cellfun(@(equis1,equis2) single_hfo_get_sample(equis1,equis2),Mx_hpc{n},cohfos1{n},'UniformOutput',false);
                             if ~isempty(v2_single_hpc{n})
                                  nr_single_hpc(i,n)=sum(cellfun('length',v2_single_hpc{n}(:,1)));                          
                             else
                                 nr_single_hpc(i,n)=0;                          
                             end
                             
                              v2_single_cortex{n}=cellfun(@(equis1,equis2) single_hfo_get_sample(equis1,equis2),Mx_cortex{n},cohfos2{n},'UniformOutput',false);
                             if ~isempty(v2_single_cortex{n})
                                  nr_single_cortex(i,n)=sum(cellfun('length',v2_single_cortex{n}(:,1)));                          
                             else
                                 nr_single_cortex(i,n)=0;                          
                             end
                             

                        end
end