%% spectrogram.
% n=102;
% aver=NC(:,n);
aver=hpc;
% aver=aver(450:650);
% aver2=PFC_spindles(:,n);
% spectrogram(aver)
%% Spectrogram HPC
t_aver=1:length(aver);
t_aver=t_aver-1;
t_aver=t_aver/1000;
t_aver={t_aver};

w=1;
%toy=[1:60:length(t_aver{1})/1000]; %secs
toy=[1:0.5:length(t_aver{1})/1000]; %secs %480

%toy=[-1:.01:1];
% q={[aver  ].'};
q={[aver aver aver ].'};

freq4=barplot2_ft(q,t_aver,[60:5:250],w,toy);
[freq4]=spectral_correction(freq4);

cfg              = [];
%cfg.zlim=zlim; %U might want to uncomment this if you use a smaller step: (Memory purposes)
cfg.channel      = freq4.label{w};
cfg.colormap=colormap(jet(256));

a1=subplot(2,1,1)
ft_singleplotTFR(cfg, freq4);
xlim([0 max(t_aver{1})])
g=title('High Frequencies');
g.FontSize=12;
xlabel('Time (s)')
%ylabel('uV')
ylabel('Frequency (Hz)')
% xlim([0.3 0.8])

a2=subplot(2,1,2)
plot(t_aver{1},aver)
xlim([0 max(t_aver{1})])
colorbar()

linkaxes([a1 a2],'x')


