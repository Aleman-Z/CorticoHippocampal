# Threshold Selection methods tested on the SWR detection. 

* **newest_only_ripple_level_ERASETHIS.m** : Median of maxima per epoch of Bip17. 

* **median_std.m** : Median+3 times STD of concatenated epochs without outliers. 

* **nrem_fixed_thr.m**: Selects threshold which gives a rate of occurence of 1 ripple per sec. 

* **nrem_fixed_thr_Vfiles.m**: Same as above but uses the original Vx.mat files instead of the ones generated in python. 
