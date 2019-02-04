function[V6]=downsampling(C6)
fs=20000;
Wn=[500/(fs/2) ]; % Cutoff=500 Hz
[b,a] = butter(3,Wn); %Filter coefficients for LPF
%Monopolar
V6=cell(length(C6),1);

for i=1:length(C6)
%Monipolar    
V6{i,1}=filtfilt(b,a,C6{i,1});
V6{i,1}=decimator(V6{i,1},20).';

end
end