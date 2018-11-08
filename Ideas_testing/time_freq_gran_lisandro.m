fn=1000;
data1.trial=p;
data1.time= create_timecell(ro,length(q)); %Might have to change this one 
data1.fsample=fn;
data1.label=cell(3,1);
data1.label{1}='Hippocampus';
data1.label{2}='Parietal';
data1.label{3}='PFC';

%%
toy = [-1.2:.01:1.2];
freq2=justtesting(p,create_timecell(ro,length(p)),[1:0.5:30],w,0.5,toy);
%% justtesting modified
w=2;
equis=0.5;
freqrange=[0:1:30];
%freqrange=[100:2:150];

ft_data1 = [];
ft_data1.fsample = 1000;
ft_data1.trial = p(1,1:end); % q should be larger than +/-500 ms. Better to use 1 sec. 

timecell=create_timecell(ro,length(p))
ft_data1.time = (timecell(1,1:end));

ft_data1.label = {'Hippo'; 'Parietal'; 'PFC'};

% Compute Multitaper
       
cfg = [];
cfg.method = 'mtmconvol';

cfg.taper = 'hanning';
% cfg.pad='nextpow2';
cfg.pad=3;
%cfg.padtype='edge';
cfg.foi = freqrange;
%  cfg.t_ftimwin = 0.4 * ones(size(cfg.foi));
cfg.t_ftimwin = 0.5.*ones(size(4./cfg.foi')); 
cfg.tapsmofrq = equis*cfg.foi;

%cfg.toi=toy;
cfg.toi       = -1:0.01:1;
%cfg.output         = 'pow';
cfg.output         = 'fourier';

cfg.keeptrials = 'yes';


freq = ft_freqanalysis(cfg, ft_data1);




%%
cfg = [];
%      cfg.channelcmb = {'PFC' 'Parietal'};
     cfg.method    = 'granger';
     granger    = ft_connectivityanalysis(cfg, freq);

     %%
    ngra=squeeze(granger.grangerspctrm(3,2,:,:));
     %%
      dfreq = diff(freq.freq)./mean(diff(freq.freq));
%assert(all(dfreq>0.999) && all(dfreq<1.001)
%%
       cfg           = [];
       cfg.method    = 'mtmconvol';
       cfg.output    = 'fourier';
       cfg.taper     = 'hanning';
       cfg.foi       = 0:0.5:30;
       cfg.t_ftimwin = 0.4.*ones();
       cfg.toi       = -1:0.05:1;
       freq          = ft_freqanalysis(cfg, data1);
       