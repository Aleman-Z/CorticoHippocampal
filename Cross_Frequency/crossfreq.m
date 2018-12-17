function [CFC]=crossfreq(q,f1,f2,ro,met)
%  Pre-processed data
fn=1000;
data.trial=q;
data.time=  create_timecell(ro,length(q)); %Might have to change this one
avf=create_timecell(ro,1);
data.fsample=fn;
data.label=cell(3,1);
data.label{1}='Hippocampus';
data.label{2}='Parietal';
data.label{3}='PFC';


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         f1 =4:1:20;       % interest low frequency range of CFC
%         f2 =30:10:150;    % interest high frequency range of CFC
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % extract low frequency signal
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        cfg              = [];
        cfg.output       = 'fourier';
        cfg.channel      = 'all';
        cfg.method       = 'mtmconvol';
        cfg.taper        = 'hanning';
        cfg.foi          =  f1;                         
        cfg.t_ftimwin    = ones(length(cfg.foi),1).*0.5;    
       % cfg.toi          = 0.5:1/data.fsample:3.5;
        cfg.toi=cell2mat(avf);
        cfg.pad=4;
        LFsig           = ft_freqanalysis(cfg, data);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % extract high frequency envelope signal 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        cfg              = [];
        cfg.output       = 'fourier';
        cfg.channel      = 'all';
        cfg.method       = 'mtmconvol';
%        cfg.taper        = 'hanning';
        cfg.taper        = 'dpss';
        cfg.foi          =  f2;
        cfg.tapsmofrq=0.3.*cfg.foi; % Multitaper smoothing. 
        cfg.pad=4; % Integer frequencies. 

        cfg.t_ftimwin    = 5./cfg.foi;    
        %cfg.toi          = 0.5:1/data.fsample:3.5;
        cfg.toi=cell2mat(avf);
        HFsig           = ft_freqanalysis(cfg, data);

        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % ft_crossfreqanalysis
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        tic;
        cfg              =[];
        %cfg.method       ='plv';   % or mvl/mi
        cfg.method       =met;   % or mvl/mi
        cfg.keeptrials   = 'no';
        CFC              = ft_crossfrequencyanalysis(cfg,LFsig,HFsig);
end