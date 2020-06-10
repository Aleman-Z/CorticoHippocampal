
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% THE BELOW CODE SHOULD IDEALLY GO INTO A FAQ OR EXAMPLE SCRIPT ON THE WEBSITE

% simulate some data
dat = ft_preproc_bandpassfilter(randn(1,100050),1000,[15 25],[],'firws');

dat1 = reshape(dat(1:100000),[],100)';
dat2 = reshape(dat(51:end),[],100)'; % 2 is leading 1

tlck.trial = zeros(100,2,1000);
tlck.trial(:,1,:) = dat1+randn(100,1000)./4;
tlck.trial(:,2,:) = dat2+randn(100,1000)./4;
tlck.label  = {'chan01';'chan02'};
tlck.dimord = 'rpt_chan_time';
tlck.time   = (0:999)./1000;

data = ft_checkdata(tlck,'datatype', 'raw');

% spectral decomposition
cfg        = [];
cfg.method = 'mtmfft';
%cfg.foilim = [0 100];
cfg.tapsmofrq = 2;
cfg.output = 'fourier';
cfg.pad    = 4;
freq       = ft_freqanalysis(cfg, data);


cfg.output = 'powandcsd';
cfg.channelcmb = {'all' 'all'};
freq_csd   = ft_freqanalysis(cfg, data);


% connectivity estimation
cfg           = [];
cfg.method    = 'psi';
cfg.bandwidth = 5;
psi           = ft_connectivityanalysis(cfg, freq);
% psi2          = ft_connectivityanalysis(cfg, freq_csd);

% bonus: estimate delay from the phase difference spectrum
cfg           = [];
cfg.method    = 'coh';
cfg.complex   = 'complex';
coh           = ft_connectivityanalysis(cfg, freq);

findx = nearest(freq.freq,18):nearest(freq.freq,22);
X     = [ones(1,numel(findx));freq.freq(findx)-mean(freq.freq(findx))];
b     = unwrap(squeeze(angle(coh.cohspctrm(2,1,findx))))'/X;
delay = 1000.*b(2)./(2.*pi);

% another bonus: estimate granger causality
cfg        = [];
cfg.method = 'granger';
granger    = ft_connectivityanalysis(cfg, freq);
granger2   = ft_connectivityanalysis(cfg, freq_csd);
%%
cfg           = [];
cfg.method    = 'psi';
cfg.bandwidth = 5;
%cfg.jackknife= 'yes';
psi           = ft_connectivityanalysis(cfg, freq);
cfg = [];
% cfg.xlim = [0 50];
%%
figure()
cfg.parameter = 'psispctrm';
ft_connectivityplot(cfg, psi);
%%
figure()
cfg.parameter = 'grangerspctrm';
ft_connectivityplot(cfg, granger);

%%
aver=psi.psispctrm./sqrt(psi.psispctrmsem);
psi.aver=aver;
%%
cfg           = [];
cfg.method    = 'psi';
cfg.bandwidth = 5;
%cfg.jackknife= 'yes';
cfg.normalize='yes';
psi2           = ft_connectivityanalysis(cfg, freq);
cfg = [];
% cfg.xlim = [0 50];
cfg.parameter = 'psispctrm';
% ft_connectivityplot(cfg, psi);
%%
%%
cfg = [];
% cfg.xlim = [0 50];
cfg.parameter = 'psispctrm';
ft_connectivityplot(cfg, psi2);
figure()

cfg = [];
% cfg.xlim = [0 50];
cfg.parameter = 'psispctrm';
ft_connectivityplot(cfg, psi);

%%
figure()
cfg = [];
cfg.parameter = 'grangerspctrm';
ft_connectivityplot(cfg, granger2);
%%
cfg = [];
cfg.xlim = [0 50];
cfg.parameter = 'grangerspctrm';
ft_connectivityplot(cfg, granger2);

