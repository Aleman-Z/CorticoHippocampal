%gui_downsample
%Downsamples ephys data.

close all
clear variables
clc
fs=20000; %Sampling frequency of acquisition.  

rats=[1 3 4 6 9 11]; %First and second drive

%HPC, PFC, EEG FRONTAL, EEG PARIETAL.
channels.Rat1 = [ 46 11 6 5];
channels.Rat3 = [ 31 49 NaN 54];
channels.Rat4 = [ 37 34 NaN NaN];
channels.Rat6 = [ 2 33 34 36];
channels.Rat9 = [ 49 30 3 9];
channels.Rat11 = [ 11 45 55 56];


