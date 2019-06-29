function[C6,time_amount]=reduce_data(data6m,transitions,fs,stage)
%reduce_data(data6m,transitions,fs,stage)
% Extract only NREM signals. (stage: 1 for awake, 3 for NREM)

nV=transitions(:,1);
c=find(nV==stage);%Index of cells with NREM data.

newtrans=transitions(c,2:3); %Only use the NREM times. 
transamp=newtrans.*(fs); %Convert from seconds to samples 

%Defining void cell to save NREM signals. 
C6=cell(size(transamp,1),1);%NREM signals.

time_amount=nan(size(transamp,1),1); %Time duration per epoch

%Extract signals per channel and time  
for i=1:size(transamp,1)%length(transamp)
probemos=transamp(i,:);
C6{i}=data6m(round(probemos(1)):floor(probemos(2))).*(0.195); % Open Ephys BitVolt CORRECTION FACTOR 

time_amount(i)=length(C6{i})*(1/fs); %Seconds

end

A=cellfun('length',C6);
on=(1:length(A)).';
%Ignore very short periods labelled as NREM sleep. 
%fA=find(A<2);
fA=on(A<2);

%if length(fA)~=0
if    ~isempty(fA)
    C6(fA)=[];
    time_amount(fA)=[];
end


end