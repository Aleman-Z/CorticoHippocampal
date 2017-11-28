function[C6,tiempo]=reduce_data(data6m,transitions)
% Extract only NREM signals. (1 for awake, 3 for NREM)
fs=20000; %Sampling frequency of acquisition.  
c=find(transitions(:,1)==3); 
newtrans=transitions(c,2:3); %Only use the NREM times. 
transamp=newtrans.*(fs); %Convert from seconds to samples 

%Defining void vectors to save NREM signals. 
C6=cell(length(transamp),1);%NREM Reference signals
% C9=cell(length(transamp),1);%NREM Reference signals
% C12=cell(length(transamp),1);%NREM Reference signals
% C17=cell(length(transamp),1);%NREM Reference signals

%T6=cell(length(transamp),1);% NREM Reference timestamps (Identical for all channels)
tiempo=nan(length(transamp),1); %Time duration per epoch

%Extract signals per channel and time  
for i=1:length(transamp)
probemos=transamp(i,:);
C6{i}=data6m(round(probemos(1)):round(probemos(2))).*(0.195); % Open Ephys BitVolt CORRECTION FACTOR 
% C9{i}=data9m(round(probemos(1)):round(probemos(2))).*(0.195); %Open Ephys BitVolt CORRECTION FACTOR
% C12{i}=data12m(round(probemos(1)):round(probemos(2))).*(0.195); %Open Ephys BitVolt CORRECTION FACTOR
% C17{i}=data17m(round(probemos(1)):round(probemos(2))).*(0.195); %Open Ephys BitVolt CORRECTION FACTOR

%T6{i}=timestamps6(round(probemos(1)):round(probemos(2)));
tiempo(i)=length(C6{i})*(1/fs); %Seconds

end


end