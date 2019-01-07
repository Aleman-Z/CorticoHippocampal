function cfc_print(hpc_LF,hpc_HF,label1,labelconditions,iii,n1,n2)

    [hpc_hpc]=xfreq(hpc_LF,hpc_HF,'coh');
    plot_cross(hpc_hpc,label1,n1,n2) 
    printing(strcat('CFC_',labelconditions{iii},'_',label1{n1*2},'_vs_',label1{n2*2}))
    close all

end