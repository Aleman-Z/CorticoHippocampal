%%
function [zmap]=plot_inter_conditions_33_high(freq3,freq4)
%Requires turning NaN into zeros.
no1=freq3.powspctrm;
no2=freq4.powspctrm;

no1(isnan(no1))=0;
no2(isnan(no2))=0;
%%
freq3.powspctrm=no1;
freq4.powspctrm=no2;
%% statistics via permutation testing

% p-value
pval = 0.05;

% convert p-value to Z value
zval = abs(norminv(pval));

% number of permutations
n_permutes = 500;

% initialize null hypothesis maps
permmaps = zeros(n_permutes,length(freq3.freq),length(freq3.time));

% for convenience, tf power maps are concatenated
%   in this matrix, trials 1:ntrials are from channel "1" 
%   and trials ntrials+1:end are from channel "2"
%tf3d = cat(3,squeeze(tf(1,:,:,:)),squeeze(tf(2,:,:,:)));
%tf3d = cat(3,squeeze(freq3.powspctrm(:,w,:,:)),squeeze(freq3.powspctrm(:,w,:,:)));
tf3d = cat(3,reshape(squeeze(freq3.powspctrm(:,w,:,:)),[length(freq3.freq) length(freq3.time)... 
    length(p) ]),reshape(squeeze(freq4.powspctrm(:,w,:,:)),[length(freq3.freq) length(freq3.time)... 
    length(p) ]));

%concatenated in time.
% freq, time, trials
%59 241 2000

% generate maps under the null hypothesis
for permi = 1:n_permutes
    permi
    % randomize trials, which also randomly assigns trials to channels
    randorder = randperm(size(tf3d,3));
    temp_tf3d = tf3d(:,:,randorder);
    
    % compute the "difference" map
    % what is the difference under the null hypothesis?
    permmaps(permi,:,:) = squeeze( mean(temp_tf3d(:,:,1:ntrials),3) - mean(temp_tf3d(:,:,ntrials+1:end),3) );
end
%% show non-corrected thresholded maps

diffmap = squeeze(mean(freq4.powspctrm(:,w,:,:),1 )) - squeeze(mean(freq3.powspctrm(:,w,:,:),1 ));

% compute mean and standard deviation maps
mean_h0 = squeeze(mean(permmaps));
std_h0  = squeeze(std(permmaps));

% now threshold real data...
% first Z-score
zmap = (diffmap-mean_h0) ./ std_h0;

% threshold image at p-value, by setting subthreshold values to 0
zmap(abs(zmap)<zval) = 0;
end