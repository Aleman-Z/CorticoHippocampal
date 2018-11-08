%
% This function performs spectrally resolved Granger causality using the
% non-parametric spectral matrix factorization of Wilson, as implemented
% by Dhahama & Rangarajan in sfactorization_wilson. Both standard and
% conditional Granger causality are attempted.
%
% FieldTrip code being used is a recent download zip file dated
% 6/3/2014. Running on Windows 7, Student Edition Matlab R2012a.
%
%function [] = pal_test_ft_granger_cond()

    close all;

    NTrials  = 100;
    NSamples = 300;
    FS       = 200;
    
    %NSamples2 = floor(NSamples/2)+1; % number of samples 0-PI
    
    %Freqs = [0:NSamples-1]*(FS/NSamples);
    %Freqs2 = Freqs(1:NSamples2); % frequencies 0-PI
    
    %Times = [0:(NSamples-1)]/FS; % times corresponding to samples
   
    %
    % Build a sample MVAR system
    %
    % X.trial is a 1xNTrials cell array, with each cell containing a
    % PxNSamples array of doubles.
    %
    fprintf('Generating sample MVAR trials...');
    
    mvar_cfg             = [];
    mvar_cfg.ntrials     = NTrials;
    mvar_cfg.triallength = NSamples/FS;
    mvar_cfg.fsample     = FS;
    mvar_cfg.nsignal     = 3;
    mvar_cfg.method      = 'ar';

    if (0)
        %
        % From Dhamala, Rangarajan, & Ding, 2008, Physical Review Letters
        % (with addition of third noise series if desired).
        % Direction of causality does not change mid-trial as in the paper.
        %
        % x1(t) = 0.5*x1(t-1) - 0.8*x1(t-2)
        % x2(t) = 0.5*x2(t-1) - 0.8*x2(t-2) + 0.25*x1(t-1)
        % x3(t) = noise, no AR structure, not linked to x1, x2
        %
        % The spectrum of these series have a characteristic peak around 40 Hz.
        %
        if (mvar_cfg.nsignal == 2)
            mvar_cfg.params(:,:,1) = [ 0.5  0.0  ;
                                       0.25 0.5 ];
                      
            mvar_cfg.params(:,:,2) = [-0.8  0.0 ; 
                                       0.0 -0.8]; 
                        
            mvar_cfg.noisecov      = [ 1.0  0.0 ;
                                       0.0  1.0];
        else
            mvar_cfg.params(:,:,1) = [ 0.5  0.0  0.0 ;
                                       0.25 0.5  0.0 ;
                                       0.0  0.0  0.0];
                      
            mvar_cfg.params(:,:,2) = [-0.8  0.0  0.0 ; 
                                       0.0 -0.8  0.0 ; 
                                       0.0  0.0  0.0];
                        
            mvar_cfg.noisecov      = [ 1.0  0.0  0.0 ;
                                       0.0  1.0  0.0 ;
                                       0.0  0.0  1.0];
        end
    else
        %
        % From Dhamala, Rangarajan, & Ding, 2008, NeuroImage. 3-variable
        % system used to test condition Granger causality. Here y->z->x.
        % Conditional Granger will show this, but non-conditional will show
        % y->x as well.
        %
        % x(t) = 0.80*x(t-1) - 0.50*x(t-2) + 0.40*z(t-1)
        % y(t) = 0.53*y(t-1) - 0.80*y(t-2)
        % z(t) = 0.50*z(t-1) - 0.20*z(t-2) + 0.50*y(t-1)
        %
        mvar_cfg.params(:,:,1) = [ 0.8  0.0  0.4 ;
                                   0.0  0.53 0.0 ;
                                   0.0  0.5  0.5];
                      
        mvar_cfg.params(:,:,2) = [-0.5  0.0  0.0 ; 
                                   0.0 -0.8  0.0 ; 
                                   0.0  0.0 -0.2];
                        
        mvar_cfg.noisecov      = [ 1.0  0.0  0.0 ;
                                   0.0  1.0  0.0 ;
                                   0.0  0.0  1.0];
    end
                           
    X = ft_connectivitysimulation(mvar_cfg);
    
    size(X)
    X

    %
    % Estimate the parameters of the system we just built - sanity check.
    % This works fine with the possible exception that the individual
    % series noise variances are estimated as 0.0033 instead of 1. The
    % estimated model order is 5 but coefficients are small where expected
    % to be.
    %
    if (0)
        fprintf('Estimating parameters of MVAR system...\n');
        mvar_est_cfg         = [];
        mvar_est_cfg.order   = 5;
        mvar_est_cfg.toolbox = 'bsmart';
        mvar_est_X           = ft_mvaranalysis(mvar_est_cfg, X);

        mvar_est_X
        mvar_est_X.coeffs
        mvar_est_X.noisecov
    end

    %
    % Transform the system into the Fourier frequency domain. It appears
    % that the output is an average of the individual trial spectra.
    %
    fprintf('Transforming MVAR trials into average Fourier spectra...\n');
    
    fourier_cfg           = [];
    fourier_cfg.output    = 'powandcsd';
    fourier_cfg.method    = 'mtmfft';
    fourier_cfg.taper     = 'dpss';
    fourier_cfg.tapsmofrq = 2;
    
    fourier_freq = ft_freqanalysis(fourier_cfg, X);
    fourier_freq
    
    %
    % Plot the Fourier frequency power and cross-power spectra. Abs is
    % applied to the complex cross-power, but is unnecessary for the real-
    % valued auto-power spectra. Everything looks good here.
    %
    fprintf('Plotting average Fourier spectra and cross-spectra...\n');
    
    figure;
    csidx=1;
    n = mvar_cfg.nsignal;
    for (r=1:n)     % rows in subplot
        for (c=r:n) % cols in subplot
            pos  = ((r-1)*n)+c; % position index to use in subplot
            pos2 = ((c-1)*n)+r; % reflection of pos across diagonal
            if (r==c)
                subplot(n,n, pos); plot(fourier_freq.freq,     fourier_freq.powspctrm(r,    :) ); xlim([0 100]); ylim([0 0.2]);
            else
                subplot(n,n, pos); plot(fourier_freq.freq,abs(fourier_freq.crsspctrm(csidx,:))); xlim([0 100]); ylim([0 0.2]);
                subplot(n,n,pos2); plot(fourier_freq.freq,abs(fourier_freq.crsspctrm(csidx,:))); xlim([0 100]); ylim([0 0.2]);
                csidx = csidx+1;
            end
        end
    end
      
    %
    % Do spectral decomposition and non-conditional granger causality in
    % Fourier domain. This calls the non-parametric spectral
    % factorization code sfactorization_wilson via
    % ft_connectivity_csd2transfer.
    %
    % The Granger calculations appear to take place around line 100 of
    % ft_connectivity_granger, and the equation is recognizatble from
    % several sources including Dhamala, Rangarajan, & Ding, 2008, PRL,
    % Eq 8.
    %
    fprintf('Non-conditional Granger causality in Fourier domain...\n');
    
    fourier_granger_cfg                     = [];
    fourier_granger_cfg.method              = 'granger';
    fourier_granger_cfg.granger.feedback    = 'yes';
    fourier_granger_cfg.granger             = [];
    fourier_granger_cfg.granger.conditional = 'no';
    
    fourier_granger = ft_connectivityanalysis(fourier_granger_cfg, fourier_freq);
    fourier_granger
    fourier_granger.cfg
    
    %
    % Plot Granger results in Fourier frequency domain.
    %
    % Results are as expected for both MVAR systems described above. For
    % the first system, the only non-zero output is for x1->x2 (subplot(3,3,2))
    % in the 40 Hz range. Peak Granger output is ~0.75. Matches Fig 1. of
    % Dhamala, Rangarajan, & Ding, 2008, PRL. Addition of the third noise
    % variable makes no difference.
    %
    % For the second system, prima facie causality is seen y->x, y->z, and
    % z->x, as expected from Dhamala, Rangarajan, & Ding, NeuroImage 2008,
    % Fig. 1.
    %
    % My plotting convention is "row-causing-column".
    %
    figure;
    for (r=1:n)
        for (c=1:n)
            pos = ((r-1)*n)+c;
            subplot(n,n, pos); plot(fourier_granger.freq,squeeze(abs(fourier_granger.grangerspctrm(r,c,:)))); xlim([0 100]); ylim([0 1]);
        end
    end
    
    %
    % Same as block above but this time calculate conditional Granger.
    % It appears that the Granger calculation is being performed in
    % blockwise_conditionalgranger.m, but I do not recognize the
    % normaliation matrix being applied.
    %
    % Three variables are required in order to avoid a crash in
    % blockwise_conditionalgranger.m at line 21 (i.e. no test for a
    % misguided attempt to perform conditional analysis on a bivariate
    % system).
    %
    fprintf('Conditional Granger causality in Fourier domain...\n');
    
    fourier_granger_cfg.granger.conditional = 'yes';
    
    fourier_granger = ft_connectivityanalysis(fourier_granger_cfg, fourier_freq);
    fourier_granger
    fourier_granger.cfg
    
    %
    % Plot conditional Granger output.
    %
    % For the first MVAR system above there should be no difference in
    % the non-conditional and conditional output (no opportunity for prima
    % facie causality in this system). However, the conditional output
    % shows constant non-zero values for x->x, y->x, and z->x, while
    % all other plots are uniformly zero.
    %
    % For the second MVAR system output appears to be near zero in all
    % plots for all frequencies.
    %
    %%
    figure;
    for (r=1:n)
        for (c=1:n)
            pos = ((r-1)*n)+c;
            subplot(n,n, pos); plot(fourier_granger.freq,squeeze(abs(fourier_granger.grangerspctrm(r,c,:)))); %xlim([0 100]); %ylim([0 .1]);
        end
    end

    return;
%end
%%
plot(fourier_granger.freq, fourier_granger.grangerspctrm)
%%
plot_spw2(granger.grangerspctrm)
%figure()
% plot(granger_cond.freq,(granger_cond.grangerspctrm))
% legend('1','2','3','1','1','1')
%%
figure()
cont=1;
for yu=1:9
    subplot(3,3,yu)
    if yu~=1 & yu~=5 & yu~=9 
        
        switch yu
        case 2
            plot(granger_cond.freq,(granger_cond.grangerspctrm(2,:)))
        case 3
            plot(granger_cond.freq,(granger_cond.grangerspctrm(4,:)))
        case 4
            plot(granger_cond.freq,(granger_cond.grangerspctrm(1,:)))
        case 6
            plot(granger_cond.freq,(granger_cond.grangerspctrm(6,:)))
            case 7
            plot(granger_cond.freq,(granger_cond.grangerspctrm(3,:)))
        otherwise
            plot(granger_cond.freq,(granger_cond.grangerspctrm(5,:)))
        end
             ylim([0 0.2])

%         plot(granger_cond.freq,(granger_cond.grangerspctrm(cont,:)))
%         ylim([0 0.2])
%         cont=cont+1;
    end
end
