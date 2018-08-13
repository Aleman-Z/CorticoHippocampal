function [timeasleep]=find_thr_base
V9=load('V9.mat');
V9=V9.V9;

%Total amount of time spent sleeping (NREM):
timeasleep=sum(cellfun('length',V9))*(1/1000); % In minutes
end