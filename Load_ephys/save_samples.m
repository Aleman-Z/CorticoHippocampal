function[V6,tiempo]=save_samples(x,transitions)

%Loads the .continuous file
h=messbox('Loading .continuous file','Current Progress')
[data6m, ~, ~] = load_open_ephys_data_faster(x);
close(h);
fs=20000; %Original sampling frequency.
[C6,tiempo]=reduce_data(data6m,transitions,fs,3);
clear data6m
A=cellfun('length',C6);
on=(1:length(A)).';
%Ignore very short periods labelled as NREM sleep. 
fA=on(A<2);

if length(fA)~=0
C6(fA)=[];
tiempo(fA)=[];
end
% 'Extracting NREM data'
h=messbox('Extracting NREM data','Current Progress')

[V6]=downsampling(C6);
clear C6
close(h);
%'Downsampling'
h=messbox('Downsampling','Current Progress')
close(h);
end