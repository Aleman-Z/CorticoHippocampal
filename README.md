# CorticoHippocampal
INTERNSHIP PROJECT by> Adrián Alemán
--------------------------------
DESCRIPTION of MAIN FUNCTIONS:

-PERIODOGRAMS
---------------
psd_epochs_intraconditions.m: Generates Power plots of NREM signals for all conditions in a specific brain area. 

psd_epochs_intraregions.m: Generates Power plots of NREM signals for all brain areas during a specific condition. 

-DATA DESCRIPTION
-----------------
time_of_sleep.m: Gives information per condition about amount of sleep, number of ripples found, threshold values, and rate of occurence.
 
plot_number_ripples.m: Plots information obtained from the above function. 

-SCATTER PLOTS
--------------
psd_ripples.m: Generates scatter plots to show difference between spectral power among conditions wrt the hippocampal power. 

psd_ripples2.m: Same but using bandpassed signals of PAR and PFC.

psd_ripples3.m: Same but using Wideband signals of PAR and PFC.


-SPECTROGRAMS AND GC
--------------------
main_optimized_ab.m: Main time-frequency analysis with permutation statistics. 

-HISTOGRAMS
----------------
ripple_amplitude.m: Generates normalized histogram of the amplitude of the 1000 strongest ripples in the Hippocampus. 

between_ripples.m: Histogram of time between ripples for different conditions. 

-Threshold vs Ripple Occurence plots
------------------
threshold_vs_ripple.m: Plots curves relating selected thresholds with the ripple rate they give. Useful for threshold selection. 

-Periodogram_no_ripples_with_original
------------------
Plots the frequency spectrum of the signal with and without ripples for 3 different thresholds. 

-Periodogram_with_coherence
------------------
Plots the frequency spectrum of the signal with and without ripples and shows the coherence between both signals. 

-Read data from Ophen Ephys
------------------
read_ratdata27.m: Adaptable to any other rat. 
