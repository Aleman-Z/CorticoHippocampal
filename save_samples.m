function[V6,tiempo]=save_samples(x,transitions)

[data6m, ~, ~] = load_open_ephys_data_faster(x);

[C6,tiempo]=reduce_data(data6m,transitions);
clear data6m
A=cellfun('length',C6);

%Ignore very short periods labelled as NREM sleep. 
%fA=find(A<2);
fA=A(A<2);

if length(fA)~=0
C6(fA)=[];
tiempo(fA)=[];
end
'Extracting NREM data'

[V6]=downsampling(C6);
clear C6
'Downsampling'
end