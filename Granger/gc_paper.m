
function [granger,granger1]=gc_paper(q,timecell,label,ro,ord,freqrange)
fn=1000;
data1.trial=q;
data1.time= timecell; %Might have to change this one 
data1.fsample=fn;
data1.label=cell(3,1);
data1.label{1}='Hippocampus';
data1.label{2}='Parietal';
data1.label{3}='PFC';
%data1.label{4}='Reference';

%Parametric model
 [granger1]=createauto(data1,ord);
%  
% cfg         = [];
% cfg.order   = ord;
% cfg.toolbox = 'bsmart';
% mdata       = ft_mvaranalysis(cfg, data1);
% 
% cfg        = [];
% cfg.method = 'mvar';
% mfreq      = ft_freqanalysis(cfg, mdata);
% granger1       = ft_connectivityanalysis(cfg, mfreq);


%Non parametric
[granger]=createauto_np(data1,freqrange);
% cfg           = [];
% cfg.method    = 'mtmfft';
% cfg.taper     = 'dpss';
% %cfg.taper     = 'hanning';
% 
% cfg.output    = 'fourier';
% cfg.tapsmofrq = 2;
% cfg.pad = 10;
% cfg.foi=freqrange;
% freq          = ft_freqanalysis(cfg, data1);
 
% %Non parametric- Multitaper
% cfg           = [];
% cfg.method    = 'mtmconvol';
% cfg.foi          = 1:1:100;
% cfg.taper     = 'dpss';
% cfg.output    = 'fourier';
% cfg.tapsmofrq = 10;
% cfg.toi='50%'; 
% cfg.t_ftimwin    = ones(length(cfg.foi),1).*.1;   % length of time window = 0.5 sec
% 
% 
% freq1          = ft_freqanalysis(cfg, data1);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Nonparametric freq analysis (OTHER WAVELET)
% cfg           = [];
% cfg.method    = 'wavelet';
% % cfg.width=10;
% cfg.gwidth=5;
% 
% cfg.foi          = 0:5:300;
% %cfg.foilim=[10 100]
% % cfg.taper     = 'dpss';
% cfg.output    = 'powandcsd';
% %andcsd
% %cfg.toi=-0.2:0.001:0.2;
% cfg.toi=-0.199:0.1:0.2;
% 
% %cfg.t_ftimwin    = ones(length(cfg.foi),1).*0.1;   % length of time window = 0.5 sec

% % % % 
% % % % % Nonparametric freq analysis (MTMconvol)
% % % % cfg           = [];
% % % % %cfg.method    = 'mtmfft';
% % % % cfg.method    = 'mtmconvol';
% % % % %cfg.pad = 'nextpow2';
% % % % cfg.pad = 10;
% % % % 
% % % % cfg.taper     = 'dpss';
% % % % cfg.output    = 'fourier';
% % % % cfg.foi=[0:2:300];
% % % %  cfg.tapsmofrq = 10;
% % % % cfg.t_ftimwin=ones(length(cfg.foi),1).*(0.1);
% % % % %cfg.t_ftimwin=1000./cfg.foi;
% % % % %cfg.tapsmofrq = 0.4*cfg.foi;


%cfg.t_ftimwin=7./cfg.foi;

% % % % % % % % cfg.toi='50%';
% % % % % % % cfg.toi=linspace(-0.2,0.2,10);
% % % % % % % freq1          = ft_freqanalysis(cfg, data1);

% % % % % % % % 
% % % % % % % % % Nonparametric freq analysis (Wavelet)
% % % % % % % % cfg           = [];
% % % % % % % % %cfg.method    = 'mtmfft';
% % % % % % % % cfg.method    = 'wavelet';
% % % % % % % % %cfg.pad = 'nextpow2';
% % % % % % % % cfg.pad = 2;
% % % % % % % % 
% % % % % % % % cfg.width=1;
% % % % % % % % 
% % % % % % % % cfg.taper     = 'dpss';
% % % % % % % % cfg.output    = 'powandcsd';
% % % % % % % % cfg.foi=[0:5:300];
% % % % % % % % % cfg.tapsmofrq = 2;
% % % % % % % % %cfg.t_ftimwin=ones(length(cfg.foi),1).*(0.1);
% % % % % % % % %cfg.t_ftimwin=7./cfg.foi;
% % % % % % % % 
% % % % % % % % % cfg.toi='50%';
% % % % % % % % cfg.toi=linspace(-0.2,0.2,10);
% % % % % % % % freq_mtmfft          = ft_freqanalysis(cfg, data1);

% % % 
% % % % Nonparametric freq analysis (Wavelet OTHER)
% % % cfg           = [];
% % % %cfg.method    = 'mtmfft';
% % % cfg.method    = 'tfr';
% % % %cfg.pad = 'nextpow2';
% % % cfg.pad = 2;
% % % 
% % % cfg.width=2;
% % % % 
% % % % cfg.taper     = 'dpss';
% % % cfg.output    = 'powandcsd';
% % % cfg.foi=[0:5:300];
% % % %%cfg.tapsmofrq = 2;
% % % cfg.t_ftimwin=ones(length(cfg.foi),1).*(0.1);
% % % %cfg.t_ftimwin=7./cfg.foi;
% % % 
% % % % cfg.toi='50%';
% % % cfg.toi=linspace(-0.2,0.2,5);
% % % freq_wavt          = ft_freqanalysis(cfg, data1);




% cfg           = [];
% cfg.method    = 'granger';
% granger       = ft_connectivityanalysis(cfg, freq);

% granger1       = ft_connectivityanalysis(cfg, mfreq);

% % % % % % % % % % % % % % % % % % % % % % % %granger2       = ft_connectivityanalysis(cfg, freq1);
% % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % %%granger3       = ft_connectivityanalysis(cfg, freq_mtmfft); %Wavelet
% % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % granger4       = ft_connectivityanalysis(cfg, freq_wavt);
% % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % %lab=cell(16,1);
% % % % % % % % % % % % % % % % % % % % % % % % lab{1}='Hippo -> Hippo';
% % % % % % % % % % % % % % % % % % % % % % % % lab{2}='Hippo -> Parietal';
% % % % % % % % % % % % % % % % % % % % % % % % lab{3}='Hippo -> PFC';
% % % % % % % % % % % % % % % % % % % % % % % % lab{4}='Hippo -> Reference';
% % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % lab{5}='Parietal -> Hippo';
% % % % % % % % % % % % % % % % % % % % % % % % lab{6}='Parietal -> Parietal';
% % % % % % % % % % % % % % % % % % % % % % % % lab{7}='Parietal -> PFC';
% % % % % % % % % % % % % % % % % % % % % % % % lab{8}='Parietal -> Reference';
% % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % lab{9}='PFC -> Hippo';
% % % % % % % % % % % % % % % % % % % % % % % % lab{10}='PFC -> Parietal';
% % % % % % % % % % % % % % % % % % % % % % % % lab{11}='PFC -> PFC';
% % % % % % % % % % % % % % % % % % % % % % % % lab{12}='PFC -> Reference';
% % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % lab{13}='Reference -> Hippo';
% % % % % % % % % % % % % % % % % % % % % % % % lab{14}='Reference -> Parietal';
% % % % % % % % % % % % % % % % % % % % % % % % lab{15}='Reference -> PFC';
% % % % % % % % % % % % % % % % % % % % % % % % lab{16}='Reference -> Reference';
% % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % lab=cell(9,1);
% % % % % % % % % % % % % % % % % % % % % % % lab{1}='Hippo -> Hippo';
% % % % % % % % % % % % % % % % % % % % % % % lab{2}='Hippo -> Parietal';
% % % % % % % % % % % % % % % % % % % % % % % lab{3}='Hippo -> PFC';
% % % % % % % % % % % % % % % % % % % % % % % %lab{4}='Hippo -> Reference';
% % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % lab{4}='Parietal -> Hippo';
% % % % % % % % % % % % % % % % % % % % % % % lab{5}='Parietal -> Parietal';
% % % % % % % % % % % % % % % % % % % % % % % lab{6}='Parietal -> PFC';
% % % % % % % % % % % % % % % % % % % % % % % %lab{8}='Parietal -> Reference';
% % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % lab{7}='PFC -> Hippo';
% % % % % % % % % % % % % % % % % % % % % % % lab{8}='PFC -> Parietal';
% % % % % % % % % % % % % % % % % % % % % % % lab{9}='PFC -> PFC';
% % % % % % % % % % % % % % % % % % % % % % % %lab{12}='PFC -> Reference';
% % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % lab{13}='Reference -> Hippo';
% % % % % % % % % % % % % % % % % % % % % % % % lab{14}='Reference -> Parietal';
% % % % % % % % % % % % % % % % % % % % % % % % lab{15}='Reference -> PFC';
% % % % % % % % % % % % % % % % % % % % % % % % lab{16}='Reference -> Reference';
% % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % figure
% % % % % % % % % % % % % % % % % % % % % % % conta=0;
% % % % % % % % % % % % % % % % % % % % % % % compt=0;
% % % % % % % % % % % % % % % % % % % % % % % figure('units','normalized','outerposition',[0 0 1 1])
% % % % % % % % % % % % % % % % % % % % % % % %for j=1:length(freq1.time)
% % % % % % % % % % % % % % % % % % % % % % %     compt=compt+1; 
% % % % % % % % % % % % % % % % % % % % % % %     conta=0;
% % % % % % % % % % % % % % % % % % % % % % % for row=1:length(data1.label)
% % % % % % % % % % % % % % % % % % % % % % % for col=1:length(data1.label)
% % % % % % % % % % % % % % % % % % % % % % %     
% % % % % % % % % % % % % % % % % % % % % % % % % % % %   subplot(length(data1.label),length(data1.label),(row-1)*length(data1.label)+col);
% % % % % % % % % % % % % % % % % % % % % % % % % % % %   
% % % % % % % % % % % % % % % % % % % % % % % % % % % %  % plot(granger2.freq, squeeze(granger2.grangerspctrm(row,col,:,j)),'LineWidth',.01,'Color',[0 0 0])
% % % % % % % % % % % % % % % % % % % % % % % % % % % %   %hold on
% % % % % % % % % % % % % % % % % % % % % % % % % % % %   plot(granger1.freq, squeeze(granger1.grangerspctrm(row,col,:)),'Color',[1 0 0])
% % % % % % % % % % % % % % % % % % % % % % % % % % % %   hold on
% % % % % % % % % % % % % % % % % % % % % % % % % % % %   plot(granger.freq, squeeze(granger.grangerspctrm(row,col,:)),'Color',[0 0 1])
% % % % % % % % % % % % % % % % % % % % % % % % % % % %  
% % % % % % % % % % % % % % % % % % % % % % %   %%plot(granger3.freq, squeeze(granger3.grangerspctrm(row,col,:,j)),'LineWidth',.01,'Color',[0 1 0])
% % % % % % % % % % % % % % % % % % % % % % %   
% % % % % % % % % % % % % % % % % % % % % % %   %plot(granger2.freq, squeeze(granger2.grangerspctrm(row,col,:)))
% % % % % % % % % % % % % % % % % % % % % % % %   plot(granger4.freq, squeeze(granger4.grangerspctrm(row,col,:,j)),'LineWidth',.01,'Color',[1 1 0])
% % % % % % % % % % % % % % % % % % % % % % %   
% % % % % % % % % % % % % % % % % % % % % % %   ylim([0 1])
% % % % % % % % % % % % % % % % % % % % % % %   xlim([0 300])
% % % % % % % % % % % % % % % % % % % % % % %   xlabel('Frequency (Hz)')
% % % % % % % % % % % % % % % % % % % % % % %   grid minor
% % % % % % % % % % % % % % % % % % % % % % %   conta=conta+1;
% % % % % % % % % % % % % % % % % % % % % % %   
% % % % % % % % % % % % % % % % % % % % % % % % if conta==1 || conta==6 || conta==11 || conta==16
% % % % % % % % % % % % % % % % % % % % % % %  if conta==1 || conta==5 || conta==9
% % % % % % % % % % % % % % % % % % % % % % %      
% % % % % % % % % % % % % % % % % % % % % % %   % legend('NP:Multitaper','Parametric: AR(10)','NP:MTMFFT')  
% % % % % % % % % % % % % % % % % % % % % % % %  legend('Parametric: AR(10)','Non-P:Multitaper')    
% % % % % % % % % % % % % % % % % % % % % % % %  set(gca,'Color','k')
% % % % % % % % % % % % % % % % % % % % % % % % text(100,0.5,'A Simple Plot','Color','red','FontSize',14)
% % % % % % % % % % % % % % % % % % % % % % %  end
% % % % % % % % % % % % % % % % % % % % % % %   if conta==5
% % % % % % % % % % % % % % % % % % % % % % % %      text(100,0.5,'Monopolar','Color','red','FontSize',14)
% % % % % % % % % % % % % % % % % % % % % % % %      text(100,0.35,label,'Color','red','FontSize',14)
% % % % % % % % % % % % % % % % % % % % % % % %      text(100,0.20,strcat('(+/-',num2str(ro),'ms)'),'Color','red','FontSize',14)
% % % % % % % % % % % % % % % % % % % % % % %      
% % % % % % % % % % % % % % % % % % % % % % %   end
% % % % % % % % % % % % % % % % % % % % % % %   title(lab{conta})
% % % % % % % % % % % % % % % % % % % % % % % end
% % % % % % % % % % % % % % % % % % % % % % % end
% % % % % % % % % % % % % % % % % % % % % % % %end
% % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % mtit('Monopolar','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
% % % % % % % % % % % % % % % % % % % % % % % %mtit(label,'fontsize',14,'color',[1 0 0],'position',[.5 0.75 ])
% % % % % % % % % % % % % % % % % % % % % % % %mtit(strcat('(+/-',num2str(ro),'ms)'),'fontsize',14,'color',[1 0 0],'position',[.5 0.5 ])
% % % % % % % % % % % % % % % % % % % % % % % compt
end