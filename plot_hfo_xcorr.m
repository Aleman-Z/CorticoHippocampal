function plot_hfo_xcorr(si,Mx_hpc,Sx_hpc,label)

em=[Mx_hpc{:}]*1000;% Centers of ripples;
%one_sec=1.*1000;
tm=2*1000+1; %2 seconds
M=nan(size(si,2),tm);
M_envel=M;
%%
aver=(cellfun(@(equis1,equis2) (equis1-equis2)*1000,Mx_hpc,Sx_hpc,'UniformOutput',false));
 ajalas=[aver{:}];
 ajalas=ajalas+1;
 %
 ajalas=single(ajalas);
for i=1:size(M,1)
    %M(i,tm/2-ajalas(i):tm/2-ajalas(i)+length(si{i})-1)=si{i}.';
    M(i,round(tm/2)-ajalas(i):round(tm/2)-ajalas(i)+length(si{i})-1)=si{i}.';
    M_envel(i,round(tm/2)-ajalas(i):round(tm/2)-ajalas(i)+length(si{i})-1)=abs(hilbert(si{i}.'));

end
% i=1
% M(i,:)
%%
m=nanmean(M_envel,1);
m(isnan(m))=0;
%plot((1:length(m))/1000,m)
t=-1:1/1000:1;
% subplot(1,2,1)
    plot(t,m)
    %xlim([tm/2-.200*(1000) tm/2+.200*(1000)])
    hold on
    %plot((1:length(m))/1000,abs(hilbert(m)))
%     plot(t,abs(hilbert(m)))
    if strcmp(label,'HPC')
    xlim([-.200 .200] )
    else
    xlim([-.100 .100] )    
    end
    xlabel('Seconds')
    ylabel('uV')
% subplot(1,2,2)
% m=nanmean(M_envel,1);
% m(isnan(m))=0;
%     plot(t,m)
%     %xlim([tm/2-.200*(1000) tm/2+.200*(1000)])
%     hold on
%     %plot((1:length(m))/1000,abs(hilbert(m)))
%     % plot(t,abs(hilbert(m)))
%     if strcmp(label,'HPC')
%     xlim([-.200 .200] )
%     else
%     xlim([-.100 .100] )    
%     end


end