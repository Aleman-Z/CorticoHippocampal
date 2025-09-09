acer = 0;

%% ---------------- PATHS ----------------
if acer == 0
    addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); % Open Ephys data loader
    addpath('/home/raleman/Documents/GitHub/CorticoHippocampal')
    addpath('/home/raleman/Documents/internship')
else
    addpath('D:\internship\analysis-tools-master'); % Open Ephys data loader
    addpath('C:\Users\Welt Meister\Documents\Donders\CorticoHippocampal\CorticoHippocampal')
end

%% ---------------- RAT & CONDITIONS ----------------
Rat = 21;

if Rat == 21
    nFF = { ...
        '2015-11-27_13-50-07 5h baseline', ...
        'rat21 baselin2015-12-11_12-52-58', ...
        'rat21_learningbaseline2_2015-12-10_15-24-17', ...
        'rat21with45minlearning_2015-12-02_14-25-12', ...
        'rat21 post t-maze 2015-12-14_13-30-52' ...
    };

    labelconditions = { ...
        'Learning Baseline', ...
        '45minLearning', ...
        'Novelty_2', ...
        't-maze', ...
        'Post t-maze' ...
    };
end

%% ---------------- SETUP ----------------
if acer == 0
    cd(fullfile('/home/raleman/Documents/internship/', num2str(Rat)))
    addpath /home/raleman/Documents/internship/fieldtrip-master/
    InitFieldtrip()
else
    cd(fullfile('D:\internship\', num2str(Rat)))
    addpath D:\internship\fieldtrip-master
    InitFieldtrip()
end
clc

%% ---------------- OPTIONS ----------------
inter         = 1;
granger       = 0;
ro            = [1200]; % window length
coher         = 0;
selectripples = 0;
mergebaseline = 0;
notch         = 1;
nrem          = 3;

% Channel labels
label1 = {'Hippo'; 'Hippo'; 'Parietal'; 'Parietal'; 'PFC'; 'PFC'; 'Reference'};
label2 = {'Monopolar'; 'Bipolar'; 'Monopolar'; 'Bipolar'; 'Monopolar'; 'Bipolar'; 'Monopolar'};

%% ---------------- MAIN LOOP ----------------
for iii = 3:length(nFF)
    clearvars -except nFF iii labelconditions inter granger Rat ro label1 label2 ...
        coher selectripples acer mergebaseline nrem notch

    for level = 1:1
        for w = 1:1
            %% --- Learning condition ---
            cd(fullfile('/home/raleman/Documents/internship/', num2str(Rat), nFF{iii}))
            lepoch = 2;

            [sig1,sig2,ripple,rippleEvents,veamos,CHTM,RIPFREQ2,timeasleep] = ...
                nrem_newest_only_ripple_level(level,nrem,notch,w,lepoch);

            [p,q,timecell,~,~,~] = getwin2(rippleEvents{:,:,1},veamos{1},sig1,sig2, ...
                label1,label2,ro,ripple(1),CHTM(level+1));

            eventMatrix = rippleEvents{1};
            eventMatrix = eventMatrix(:,2);
            aver        = cellfun(@(x) diff(x), eventMatrix,'UniformOutput',false);
            Aver        = [aver{:}];

            histogram(Aver,'Normalization','probability','BinWidth',0.1)
            xlim([0 4]); grid minor; hold on

            %% --- Baseline 1 ---
            plotBaselineHistogram(nFF{1}, 'Baseline 1', labelconditions{iii-2}, ...
                Aver, label1{2*w-1}, Rat, RIPFREQ2, nrem, notch, w, lepoch)

            %% --- Baseline 2 ---
            plotBaselineHistogram(nFF{2}, 'Baseline 2', labelconditions{iii-2}, ...
                Aver, label1{2*w-1}, Rat, RIPFREQ2, nrem, notch, w, lepoch)
        end
    end
end

%% ---------------- HELPER FUNCTION ----------------
function plotBaselineHistogram(folderName, baselineName, conditionName, Aver, label, Rat, RIPFREQ2, nrem, notch, w, lepoch)
    % Go to baseline folder
    cd(fullfile('/home/raleman/Documents/internship/', num2str(Rat), folderName))

    [sig1,sig2,ripple,rippleEvents,~,CHTM,RipFreq2] = ...
        nrem_newest_only_ripple_level(1,nrem,notch,w,lepoch);

    eventMatrix = rippleEvents{1};
    eventMatrix = eventMatrix(:,2);
    aver        = cellfun(@(x) diff(x), eventMatrix,'UniformOutput',false);
    aver        = [aver{:}];

    histogram(Aver,'Normalization','probability','BinWidth',0.1)
    hold on
    histogram(aver,'Normalization','probability','BinWidth',0.1)
    alpha(0.4); xlim([0 4])

    xlabel('Time (sec)')
    ylabel('Probability of occurrence')
    legend(conditionName, baselineName)
    title('Histogram of interripple occurrence')

    % Annotate frequencies
    annotation('textbox',[.6 .5 .3 .1], ...
        'String', sprintf('Rate of occurrence for %s: %.2f', conditionName, RIPFREQ2))
    annotation('textbox',[.6 .6 .3 .1], ...
        'String', sprintf('Rate of occurrence for %s: %.2f', baselineName, RipFreq2))

    % Save figures
    saveDir = fullfile('/home/raleman/Dropbox/Histograms/', num2str(Rat), conditionName);
    if ~exist(saveDir, 'dir'); mkdir(saveDir); end
    cd(saveDir)

    saveas(gcf, sprintf('Histograms_%s_%s.png', label, baselineName))
    saveas(gcf, sprintf('Histograms_%s_%s.fig', label, baselineName))
    close all
end
