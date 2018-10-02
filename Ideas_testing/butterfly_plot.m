function butterfly_plot(p,w)
 allscreen()
ax1=subplot(1,2,1)
    for j=1:length(p)
      plot(p{j}(w,:))
      hold on
    end
title('Butterfly plot of ripples')

ax2=subplot(1,2,2)
PP1=avg_samples(p,create_timecell(1200,length(p)));
plot(PP1(w,:))
title('Grand average of ripples')
linkaxes([ax1,ax2],'x')
    
end