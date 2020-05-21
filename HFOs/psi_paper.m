
function [freq,freq2]=psi_paper(q,timecell,freqrange,fn)
%fn=1000;
data1.trial=q;
data1.time= timecell; %Might have to change this one 
data1.fsample=fn;
data1.label=cell(3,1);
% data1.label{1}='Hippocampus';
% data1.label{2}='Parietal';
% data1.label{3}='PFC';

data1.label{1}='PAR';
data1.label{2}='PFC';
data1.label{3}='HPC';


% %Non parametric
% [granger]=createauto_np(data1,freqrange,[]);

    cfg           = [];
    cfg.method    = 'mtmfft';
    cfg.taper     = 'dpss'; 
    cfg.output    = 'fourier'; 
    cfg.tapsmofrq = 2; %1/1.2
%     cfg.tapsmofrq = 4; %1/1.2
    
    cfg.pad = 10;
    cfg.foi=freqrange;
    %[0:1:500]
    freq          = ft_freqanalysis(cfg, data1);

%Parametric    
cfg2         = [];
cfg2.order   = 10;
cfg2.toolbox = 'bsmart';
mdata2       = ft_mvaranalysis(cfg2, data1);

cfg2        = [];
cfg2.method = 'mvar';
freq2      = ft_freqanalysis(cfg2, mdata2);


end