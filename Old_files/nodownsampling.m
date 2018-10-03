%% NoDownsampling

%% Band pass design 
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=500 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients for LPF
%% Bandpass filter 
fn=1000;

nMono17=cell(63,1);
nBip17=cell(63,1);
nMono12=cell(63,1);
nMono9=cell(63,1);
%%
SS17=cell(63,1);
for i=1:63
SS17{i}=C17{i}-C6{i};
end
%%

for i=1:63
nBip17{i}=filtfilt(b1,a1,SS17{i});
nMono17{i}=filtfilt(b1,a1,C17{i});
nMono6{i}=filtfilt(b1,a1,C6{i});
nMono9{i}=filtfilt(b1,a1,C9{i});
nMono12{i}=filtfilt(b1,a1,C12{i});

end
