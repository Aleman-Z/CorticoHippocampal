function [TGA_results]=getval_transfer_entropy(P,Q,labelconditions3,label1,s,w,fn,min_amount_trials);

 n=min([length(P.(labelconditions3{1}).(label1{w}){s}) length(P.(labelconditions3{2}).(label1{w}){s})...
        length(P.(labelconditions3{3}).(label1{w}){s}) length(P.(labelconditions3{4}).(label1{w}){s})]);
    
for  condition=1:4

    
%Order ripples
p=P.(labelconditions3{condition}).(label1{w}){s}; 
q=Q.(labelconditions3{condition}).(label1{w}){s}; 
% R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,:)))),q));
%R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,121-50:121+50)))),q));
R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,151-25:151+25)))),q));
[~,r]=sort(R,'descend');
p=p(r);
q=q(r);
p=p(1:n);
q=q(1:n);


%Max 1000 ripples.
if length(q)>50
    q=q(1:50);
    p=p(1:50);
%         q_nl=q_nl(1:1000);
%         p_nl=p_nl(1:1000);
end


if w==1 %HPC-centered ripples.
     p=cellfun(@(equis1) flip(equis1),p,'UniformOutput',false);
     q=cellfun(@(equis1) flip(equis1),q,'UniformOutput',false);
end

myOutputpath = '/home/adrian/Documents/TRENTOOL_results/';
outputpath=myOutputpath;
% aver=load('lorenz_1-2-3_delay_20_20_ms.mat');
data.fsample=1000;
data.label={'PAR' 'PFC' 'HPC'};
data.trial=p;
ro=1200;
data.time=create_timecell(ro,length(p));

%% prepare configuration structure for TEprepare.m

cfgTEP = [];

% data
cfgTEP.toi     = [data.time{1}(1) data.time{1}(end)]; % time of interest
cfgTEP.channel = data.label;                          % channels to be analyzed

% ensemble methode
cfgTEP.ensemblemethod = 'no';

% scanning of interaction delays u
cfgTEP.predicttimemin_u    = 0;      % minimum u to be scanned
cfgTEP.predicttimemax_u    = 1800;	  % maximum u to be scanned
cfgTEP.predicttimestepsize = 200; 	  % time steps between u's to be scanned

% estimator
cfgTEP.TEcalctype  = 'VW_ds';         % use the new TE estimator (Wibral, 2013)

% ACT estimation and constraints on allowed ACT(autocorelation time)
cfgTEP.maxlag      = 1200;  % max. lag for the calculation of the ACT
cfgTEP.actthrvalue = 2000;   % threshold for ACT
if min_amount_trials<12  
cfgTEP.minnrtrials = min_amount_trials;    % minimum acceptable number of trials
else
cfgTEP.minnrtrials = 12;    % minimum acceptable number of trials
end

% optimizing embedding
cfgTEP.optimizemethod ='ragwitz';  % criterion used
cfgTEP.ragdim         = 2:5;       % dimensions d to be used
cfgTEP.ragtaurange    = [0.1 0.6]; % tau range to be used
cfgTEP.ragtausteps    = 5;         % steps for ragwitz tau
cfgTEP.repPred        = 129;       % no. local prediction/points used for the Ragwitz criterion

% kernel-based TE estimation
cfgTEP.flagNei = 'Mass' ;           % type of neigbour search (knn)
cfgTEP.sizeNei = 4;                 % number of neighbours in the mass/knn search

% set the level of verbosity of console outputs
cfgTEP.verbosity = 'info_minor';

%% define cfg for TEsurrogatestats.m

cfgTESS = [];

% use individual dimensions for embedding
cfgTESS.optdimusage = 'indivdim';
cfgTESS.embedsource = 'no';

% statistical testing
cfgTESS.tail           = 1;
cfgTESS.numpermutation = 5e4;
cfgTESS.surrogatetype  = 'trialshuffling';

cfgTESS.permstatstype='mean';

% shift test
cfgTESS.shifttest      = 'no';      % don't test for volume conduction

% prefix for output data
cfgTESS.fileidout  = fullfile(outputpath, 'plusmaze_test');

%% TE analysis 
try
    TGA_results.(labelconditions3{condition}) = InteractionDelayReconstruction_calculate(cfgTEP,cfgTESS,data);

catch exception
    disp('There was an error with the number of points')
cfgTEP.predicttimemax_u=1600;
    TGA_results.(labelconditions3{condition}) = InteractionDelayReconstruction_calculate(cfgTEP,cfgTESS,data);

end


end
end