function gcbip(q,timecell,label,ro)
fn=1000;
data1.trial=q;
data1.time= timecell; %Might have to change this one 
data1.fsample=fn;
data1.label=cell(3,1);
data1.label{1}='Hippocampus';
data1.label{2}='Parietal';
data1.label{3}='PFC';
% data1.label{4}='Reference';

%Parametric model
cfg         = [];
cfg.order   = 10;
cfg.toolbox = 'bsmart';
mdata       = ft_mvaranalysis(cfg, data1);

cfg        = [];
cfg.method = 'mvar';
mfreq      = ft_freqanalysis(cfg, mdata);
% 

%Non-Parametric
cfg           = [];
cfg.method    = 'mtmfft';
cfg.taper     = 'dpss';
cfg.output    = 'fourier';
cfg.tapsmofrq = 2;
cfg.pad = 10;
cfg.foi=[0:2:300];
freq          = ft_freqanalysis(cfg, data1);

% Nonparametric freq analysis (MTMconvol)
cfg           = [];
%cfg.method    = 'mtmfft';
cfg.method    = 'mtmconvol';
%cfg.pad = 'nextpow2';
cfg.pad = 10;

cfg.taper     = 'dpss';
cfg.output    = 'fourier';
cfg.foi=[0:2:300];
 cfg.tapsmofrq = 10;
cfg.t_ftimwin=ones(length(cfg.foi),1).*(0.1);
%cfg.t_ftimwin=1000./cfg.foi;
%cfg.tapsmofrq = 0.4*cfg.foi;


%cfg.t_ftimwin=7./cfg.foi;

% cfg.toi='50%';
cfg.toi=linspace(-0.2,0.2,10);
freq1          = ft_freqanalysis(cfg, data1);

% % % 
% % % % Nonparametric freq analysis (Wavelet)
% % % cfg           = [];
% % % %cfg.method    = 'mtmfft';
% % % cfg.method    = 'wavelet';
% % % %cfg.pad = 'nextpow2';
% % % cfg.pad = 2;
% % % 
% % % cfg.width=1;
% % % 
% % % cfg.taper     = 'dpss';
% % % cfg.output    = 'powandcsd';
% % % cfg.foi=[0:5:300];
% % % % cfg.tapsmofrq = 2;
% % % %cfg.t_ftimwin=ones(length(cfg.foi),1).*(0.1);
% % % %cfg.t_ftimwin=7./cfg.foi;
% % % 
% % % % cfg.toi='50%';
% % % cfg.toi=linspace(-0.2,0.2,10);
% % % freq_mtmfft          = ft_freqanalysis(cfg, data1);



cfg           = [];
cfg.method    = 'granger';
granger       = ft_connectivityanalysis(cfg, freq);
granger1       = ft_connectivityanalysis(cfg, mfreq);
% granger2       = ft_connectivityanalysis(cfg, mfreq1);
granger2       = ft_connectivityanalysis(cfg, freq1);

%granger3       = ft_connectivityanalysis(cfg, freq_mtmfft);



lab=cell(16,1);
lab{1}='Hippo -> Hippo';
lab{2}='Hippo -> Parietal';
lab{3}='Hippo -> PFC';
% lab{4}='Hippo -> Reference';

lab{4}='Parietal -> Hippo';
lab{5}='Parietal -> Parietal';
lab{6}='Parietal -> PFC';
% lab{8}='Parietal -> Reference';

lab{7}='PFC -> Hippo';
lab{8}='PFC -> Parietal';
lab{9}='PFC -> PFC';
% lab{12}='PFC -> Reference';

% lab{13}='Reference -> Hippo';
% lab{14}='Reference -> Parietal';
% lab{15}='Reference -> PFC';
% lab{16}='Reference -> Reference';
conta=0;
compt=0;
figure('units','normalized','outerposition',[0 0 1 1])
for j=1:length(freq1.time)
    compt=compt+1; 
    conta=0;
for row=1:length(data1.label)
for col=1:length(data1.label)
  
    subplot(length(data1.label),length(data1.label),(row-1)*length(data1.label)+col);
% %   plot(granger1.freq, squeeze(granger1.grangerspctrm(row,col,:)))
% %   hold on
% % %   plot(granger2.freq, squeeze(granger2.grangerspctrm(row,col,:)))
% % 
% %   plot(granger.freq, squeeze(granger.grangerspctrm(row,col,:)))
% %   
  
  plot(granger2.freq, squeeze(granger2.grangerspctrm(row,col,:,j)),'LineWidth',.01,'Color',[0 0 0])
  hold on
  plot(granger1.freq, squeeze(granger1.grangerspctrm(row,col,:)),'Color',[1 0 0])
  %hold on
  plot(granger.freq, squeeze(granger.grangerspctrm(row,col,:)),'Color',[0 0 1])
 
  %%plot(granger3.freq, squeeze(granger3.grangerspctrm(row,col,:,j)),'LineWidth',.01,'Color',[0 1 0])
  
  
  ylim([0 1])
  xlim([0 300])
  xlabel('Frequency (Hz)')
  grid minor
  conta=conta+1;
  
 if conta==1 || conta==9  
     %legend('Parametric: AR(10)','NP:MTMFFT')
     legend('NP:Multitaper','Parametric: AR(10)','NP:MTMFFT')
     set(gca,'Color','k')
 end
 
 if conta==5
 set(gca,'Color','k')
 text(50,.6,strcat('Bipolar/',{' '},label,{' '}),'color','y','fontsize', 12)
 text(50,.5,strcat('+/-',num2str(ro),'msec'),'color','y','fontsize', 12)
 end
 
%   if conta==4
%       error('stop')
%   end
  title(lab{conta})
end
end
end
%mtit('Monopolar','fontsize',14,'color',[1 0 0],'position',[.5 .5 ])

%supertitle('Bipolar 200ms','color',[1 0 0])
% currentFigure = gcf;
% title(currentFigure.Children(end), 'blahfffffffffffffffffffffffffffffffffffffff');
% suptitle('I am a super title')
% mtit(label,'fontsize',14,'color',[1 0 0],'position',[.5 0.75 ])
% mtit('(+/-200ms)','fontsize',14,'color',[1 0 0],'position',[.5 0.5 ])
end