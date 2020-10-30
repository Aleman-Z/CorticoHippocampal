function [X]=th_crossings(name)

P1=load_open_ephys_data_faster(name); %20 kHZ.
fn=20000;
Wn1=[300/(fn/2) 6000/(fn/2)]; % Cutoff=100-300 Hz
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

P1_hp=filtfilt(b1,a1,P1);
sigma_n=median(abs(P1_hp)/0.6745); % From Quian Quiroga 2004
th=4*sigma_n;
%%
% plot(P1_hp)
% yline(th)
%%
x=(P1_hp>=th);
bin_dur=25e-3;
bin_samp=bin_dur*fn;

clear X
for i=1:(floor(length(x)/bin_samp))
    X(i)=sum(x(bin_samp*(i-1)+1:bin_samp*(i-1)+1+bin_samp));
end
%X=X./bin_samp;
X=zscore(X);
end