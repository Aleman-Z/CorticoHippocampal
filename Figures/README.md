# List of functions used to generate Figures
------------------

## :file_folder: Figure 2 

## :file_folder: Figure 3

* **Poster_main_optimized:**
*Generates non-normalized spectrograms and statistical tests using the complete recordings.*


* **spectrogram_without_normalization.m:**
*Generates non-normalized spectrograms on the wideband and bandpassed signals for different conditions, durations and window sizes.*
<img src="example_figure_spectrogram.png" width="600">

* **spec_loop_improve.m:**
*Calls .fig files with non-normalized spectrograms and changes color scaling settings to improve visualization of spindles. UPDATE: Avoid using. This approach gives wrong results for Non-learning baseline.*
<img src="example_improve.png" width="600">

* **test_fix_thr.m:**
*Plots and saves the threshold vs ripple plot per rat and baseline, indicating the fixed threshold used on Method 4.*
<img src="thr_vs_rip_line.png.png" width="400">

* **fix_threshold.m:**
*Initial test ran to try the fixed_threshold approach. Later merged with spectrogram_withouth_normalization.m*

* **testing_loop.m:**
*Loop ran to observe that the folder names generated followed the correct order.*

* **bars_ripples.m:**
Bar plots of the number of ripples found among conditions for a fixed baseline threshold.
<img src="example_bars.png" width="400">

* **spec_skipto_high.m:**
*Calls .fig files and replaces wrong stats for High Gamma power spectrograms.*
* **plot_inter_conditions_33_high.m:**
*Corrected version of plot_inter_conditions_33, using an improved method to generate the stats.* (Update 25/08: Not suitable for further figure improvement. Best to run: *plot_inter_conditions_33* followed by *plot_inter_high_improve*).
* **plot_inter_high_improve.m:**
*Adaptation of plot_inter_conditions_33_high, only computing the High Gamma spectrograms*
* **stats_high.m:**
*Computes statistics on the high frequency spectrograms.*
<img src="example_high_freq_stats.png" width="400">

* **colorbar_among_conditions.m:**
*Equalizes the colorbar ranges among conditions for a specific brain area*

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

####  :link: Post-Processing steps for spectrograms: 

1. **spec_loop_improve.m:**
*Visualizes spindles.*

2. **spec_skipto_high.m:**
*High frequency statistics.*

3. **colorbar_among_conditions.m:**
*Equal colorbar range among conditions.*

4. **axis_among_conditions.m:**
*Equal Y-axis for traces among conditions.*

5. **same_axis.m:**
*Equal Y-axis and colorbar among brain areas.*


####  :link: NEW Post-Processing steps for spectrograms (19-9-18): 
Leaves spindles visualization RAW.

1. **colorbar_among_conditions2.m:**
*Equal colorbar range among conditions.*

2. **axis_among_conditions2.m:**
*Equal Y-axis for traces among conditions.*

3. **same_axis2.m:**
*Equal Y-axis and colorbar among brain areas.*

## :zap: Controls for spectrograms.

1. **sanity=1:**
*This control test consists on selecting the same n random number of ripples among conditions. Since Plusmaze generates less ripples, this condition defines the value of n.*

2. **quinientos=1:**
*Similar to control above but this one makes sure to take the top 500 ripples instead of their random version. Could be more vulnerable to outliers.*

3. **outlie=1:**
*The use of this control activates a more agressive detection of outliers.*

## :zap: Figure 4:

* **granger_fig4.m:**
*Main file to generate granger causality figures.*

* **granger_fig4_mvgc.m:**
*Performs spectral GC calculations per ripple for all conditions. Then saves on .mat files. This takes a very long time.* :warning: 

* **granger_fig4_mvgc_stats.m:**
*Continuation of above which loads previously saved computations and performs permutation tests among conditions per frequency.*
