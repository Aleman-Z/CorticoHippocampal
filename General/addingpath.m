
function addingpath(acer)
    if acer==0
    addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
    addpath(genpath('/home/raleman/Documents/GitHub/CorticoHippocampal'))
    addpath(genpath('/home/raleman/Documents/GitHub/ADRITOOLS'))
    addpath('/home/raleman/Documents/internship')
    else
    addpath('D:\internship\analysis-tools-master'); %Open Ephys data loader.
    addpath(genpath('C:\Users\addri\Documents\internship\CorticoHippocampal'))
    addpath(genpath('C:\Users\addri\Documents\GitHub\ADRITOOLS'))
    %addpath(('C:\Users\addri\Documents\internship\CorticoHippocampal'))
    addpath(genpath('C:\Users\addri\Documents\MATLAB\mvgc_v1.0'))   
    end
end