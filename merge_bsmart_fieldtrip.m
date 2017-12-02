%Dat: 15 channels, 137 trials, 18 points and 200 Hz as sampling rate. 

dat=load('test71_pre.mat');
dat=dat.dat;
%%
%Need 137 cells
cc=cell(1,length(dat));

for i=1:length(dat)
    cc{i}=dat(:,:,i);
    cc{i}=cc{i}.';
end

newdata.trial=cc;
newdata.fsample=200;
tee=0:length(cc{1})-1;
tee=tee*(1/200);
%newdata.time=tee;

for i=1:length(dat)
   tim{i}=tee;
end
newdata.time=tim;
%%
for i=1:15
label{i,1}=num2str(i);
end
newdata.label=label;


%%

%% Nonparametric freq analysis (MTMconvol)
cfg           = [];
%cfg.method    = 'mtmfft';
cfg.method    = 'mtmconvol';
%cfg.pad = 'nextpow2';
cfg.pad = 10;

cfg.taper     = 'hanning';
cfg.output    = 'fourier';
%cfg.output    = 'powandcsd';


cfg.foi=[0:1:100-1];
 cfg.tapsmofrq = 2;

cfg.t_ftimwin=ones(length(cfg.foi),1).*(0.5);


%cfg.t_ftimwin=1000./cfg.foi;
%cfg.tapsmofrq = 0.4*cfg.foi;


%cfg.t_ftimwin=7./cfg.foi;

% cfg.toi='50%';
cfg.toi=linspace(min(newdata.time{1}),max(newdata.time{1}),18);
freq_mtmfft          = ft_freqanalysis(cfg, newdata);

%%
cfg           = [];
cfg.method    = 'granger';
granger       = ft_connectivityanalysis(cfg, freq_mtmfft);

%%


container1=nan(18,99)
    for ex=1:18
%                   subplot(3,3,(row-1)*3+col);
       container1(ex,:)=( squeeze(granger.grangerspctrm(10,5,:,ex)))
    end
    
    %%
    
imagesc(granger.freq,granger.time,container1)
colorbar()

%%
%Dat: 15 channels, 137 trials, 18 points and 200 Hz as sampling rate. 

dat=load('test71_pre.mat');
dat=dat.dat;
%%
da1=dat(1:6,:,:);
da2=dat(7:12,:,:);
da3=dat(13:18,:,:);
%%
da1=dat(1:9,:,:);
da2=dat(10:18,:,:);
%da3=dat(13:18,:,:);

%%

[newdata1]=convert2field(da1)
[newdata2]=convert2field(da2)
%[newdata3]=convert2field(da3)

%%
%Need 137 cells
cc=cell(1,length(dat));

for i=1:length(dat)
    cc{i}=dat(:,:,i);
    cc{i}=cc{i}.';
end

newdata.trial=cc;
newdata.fsample=200;
tee=0:length(cc{1})-1;
tee=tee*(1/200);
%newdata.time=tee;

for i=1:length(dat)
   tim{i}=tee;
end
newdata.time=tim;



%% Nonparametric freq analysis (MTMFFT)
cfg           = [];
cfg.method    = 'mtmfft';
%cfg.method    = 'mtmconvol';
%cfg.pad = 'nextpow2';
cfg.pad = 10;

cfg.taper     = 'dpss';
cfg.output    = 'fourier';
%cfg.output    = 'powandcsd';

cfg.foi=[0:1:100];
cfg.tapsmofrq = 2;
freq_mtmfft1          = ft_freqanalysis(cfg, newdata1);
%%
freq_mtmfft2          = ft_freqanalysis(cfg, newdata2);
freq_mtmfft3          = ft_freqanalysis(cfg, newdata3);
%%
cfg           = [];
cfg.method    = 'granger';
granger       = ft_connectivityanalysis(cfg, freq_mtmfft);





