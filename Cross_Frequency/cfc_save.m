function cfc_save(n1,n2,co_1_LF,co_2_LF,co_3_LF,co_1_HF,co_2_HF,co_3_HF,labelconditions,iii)

[dumvar]=xfreq(eval(strcat('co_',num2str(n1),'_LF')),eval(strcat('co_',num2str(n2),'_HF')),'coh','yes');
save(strcat(num2str(n1),'_',num2str(n2),'_',labelconditions{iii},'.mat'),'dumvar')

end