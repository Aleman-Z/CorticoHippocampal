% Go to folder with data
cd('/home/adrian/Documents/OS_Parrivesh/Rat9/SD10_OR/PT5')
addpath('/home/adrian/Documents/fieldtrip-master/external/fastica')
% Channel 49 is HPC.
%%
[CH1]=th_crossings('100_CH1.continuous');
[CH25]=th_crossings('100_CH25.continuous');
[CH27]=th_crossings('100_CH27.continuous');
[CH28]=th_crossings('100_CH28.continuous');
%%
X=[CH1;CH25;CH27;CH28].';
[b,n]=size(X);
Cor = corrcoef(X);
% m=size(X,1);
% Sigma = (1/m) * (X' * X);   
[~, S] = eig(Cor);

[dimred,score,latent,tsquared,explained,mu]=pca(X);
l_max=(1+sqrt(n/b)).^2;

N_a=latent(latent>=l_max);
P_sign=dimred(:,1:length(N_a));
Zproj=P_sign'*X.';
% e = eig(dimred);
[icasig, A, W] = fastica(Zproj);
%A: Mixing matrix
% W: Separating matrix.
V=P_sign*W;

V = V/norm(V);

vin=find(V==max(abs(V))| V==-max(abs(V)));
if V(vin)<0
V=V*-1;
end

%%
%Load signal
P1=load_open_ephys_data_faster('100_CH1.continuous'); %20 kHZ.
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
bin_dur=100e-3;
bin_samp=bin_dur*fn;

clear X
for i=1:(floor(length(x)/bin_samp))
    X(i)=sum(x(bin_samp*(i-1)+1:bin_samp*(i-1)+1+bin_samp));
end
X=X./bin_samp;


% length(x)/bin_samp
% [Y,E] = discretize(x);