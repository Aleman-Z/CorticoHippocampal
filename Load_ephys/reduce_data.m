function[C6,tiempo]=reduce_data(data6m,transitions,fs,stage)
% Extract only NREM signals. (1 for awake, 3 for NREM)
%fs=20000; %Sampling frequency of acquisition.  
% c=find(transitions(:,1)==3); 
%Avoid using find to increase speed. 
nV=transitions(:,1);
% nV=(nV==stage); %LOOK FOR NREM Only. SHOULD BE 3!
% n1=[1:length(nV)].';
% c=n1(nV);
c=find(nV==stage);%Index of cells with NREM data.

newtrans=transitions(c,2:3); %Only use the NREM times. 
transamp=newtrans.*(fs); %Convert from seconds to samples 

%Defining void cell to save NREM signals. 
C6=cell(length(transamp),1);%NREM signals.

%T6=cell(length(transamp),1);% NREM Reference timestamps (Identical for all channels)
tiempo=nan(length(transamp),1); %Time duration per epoch

%Extract signals per channel and time  
for i=1:length(transamp)
probemos=transamp(i,:);
C6{i}=data6m(round(probemos(1)):floor(probemos(2))).*(0.195); % Open Ephys BitVolt CORRECTION FACTOR 

%T6{i}=timestamps6(round(probemos(1)):round(probemos(2)));
tiempo(i)=length(C6{i})*(1/fs); %Seconds

end

A=cellfun('length',C6);
on=(1:length(A)).';
%Ignore very short periods labelled as NREM sleep. 
%fA=find(A<2);
fA=on(A<2);

%if length(fA)~=0
if    ~isempty(fA)
    C6(fA)=[];
    tiempo(fA)=[];
end


end