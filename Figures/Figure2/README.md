# List of functions used to generate Figures
------------------

## :zap: Figure 2: 

* **periodogram_without_normalization.m:**  
*Self-explainatory.* 
<img src="periodogram.png" width="400">

* **periodogram_without_normalization_mt.m:**  
*Updated version of the above. It uses Multitaper spectral analysis for the higher frequencies.* 

* **merge_blocks.m:**   
*Merges time blocks of periodograms.* 
<img src="time_blocks.png" width="600">

* **thr_vs_rip.m:**   
*Plots the relationship between amplitude threshold for SWR and the rate of ripple occurrence per condition.* 
<img src="Ripples_per_condition.png" width="400">

* **thr_vs_rip_vs.m:**   
*Does the same thing as the function above but using vx.mat files and different baselines.*

* **test_fix_thr.m:**
*Plots and saves the threshold vs ripple plot per rat and baseline, indicating the fixed threshold used on Method 4.*
<img src="thr_vs_rip_line.png.png" width="400">

* **bars_ripples.m:**
Bar plots of the number of ripples found among conditions for a fixed baseline threshold.
<img src="example_bars.png" width="400">

* **sleep_amount.m:**   
*Generates barplots with amount of sleep per condition.* 
<img src="Sleep_amount.png" width="600">

* **compare_states.m:**   
*Quantifies and displays the percentual differences between the oldest and the newests sleep scoring methods.* 
<img src="scoring_comparison.png" width="600">

* **get_histograms.m:**
*Generates percentual histogram of interriple time between baseline and plusmaze.*
<img src="Histo.png" width="400">

* **get_histograms_allconditions.m:** \
When ripdur=0 and tailed~=1:\
*Generates percentual histogram of interriple time between all conditions.*
<img src="HistAmp.png" width="600">

When ripdur=0 and tailed=1:\
*Generates full-tail non-normalized histogram of interriple time between all conditions.*
<img src="fulltail.png" width="600">

When ripdur=1: \
*Plots notched boxplots of the ripples´s duration per condition.* \
<img src="RipDur.png" width="400">

* **get_histograms_allconditions_outliers.m:** 
When ripdur=1: \
*Plots notched boxplots of the ripples´s duration per condition. Outliers are displayed.* 
<img src="boxplot_outliers.png" width="400">
*Violin plot of skewed distributions per condition.* 
<img src="violin.png" width="400">


* **frequency_boxplots.m:**
*Plots notched boxplots of the ripples´s peak or mean frequency.* 
<img src="peak_freq.png" width="400">

* **sleep_bouts.m:**
*Characterizes bouts for Wake, NREM, REM and transitional sleep stages*
<img src="Bouts.png" width="400">

* **equal_axis.m:**
*Equalizes axes among boxplots for different rats.*
