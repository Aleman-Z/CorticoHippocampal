function plot_cross(CFC,label1,n1,n2)

    im(squeeze(CFC.crsspctrm(1,:,:)),CFC.freqhigh,CFC.freqlow)
    y=ylabel({'Freq (Hz)',label1{2*n1}})
    x=xlabel({label1{2*n2},'Freq (Hz)'})
    title('Cross Frequency Coherence')
    x.FontSize=12;
    y.FontSize=12;


end