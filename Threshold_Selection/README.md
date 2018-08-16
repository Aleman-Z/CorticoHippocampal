# Threshold Selection methods tested on the SWR detection. 

* **newest_only_ripple_level_ERASETHIS.m** : Median of maxima per epoch of Bip17. 

* **median_std.m** : Median+3 times STD of concatenated epochs without outliers. 

* **nrem_fixed_thr.m**: Selects threshold which gives a rate of occurence of 1 ripple per sec. 

* **nrem_fixed_thr_Vfiles.m**: Same as above but uses the original Vx.mat files instead of the ones generated in python. 

* **NREM_newest_only_ripple_level.m**: Loop with different threshold values to generate thr_vs_ripple plot.   

* **NREM_newest_only_ripple_level_vx.m**: Same as above but using vx.mat files. 

* **NREM_newest_only_ripple_level_vx_CUSTOM.m**: Same as above but uses customized chtm values and polynomial order to improve plot visualization. 

