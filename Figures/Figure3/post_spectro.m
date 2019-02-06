function post_spectro()
%Spectrogram Post-Processing. 

[Rat,selpath,ldura]=colorbar_among_conditions2();
axis_among_conditions2(Rat,selpath,ldura)
same_axis2(Rat,ldura,selpath)
close all
end