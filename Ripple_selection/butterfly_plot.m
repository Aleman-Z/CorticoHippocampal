function butterfly_plot(p,w)
 allscreen()
ax1=subplot(1,2,1)
    for j=1:length(p)
      plot(-1:1/1000:1,p{j}(w,201:end-200))
      hold on
    end
title('Butterfly plot of ripples')
xlabel('Time (s)')
ylabel('Voltage (uV)')

ax2=subplot(1,2,2)
PP1=avg_samples(p,create_timecell(1200,length(p)));
plot(-1:1/1000:1,PP1(w,201:end-200)) %Ignore the extra samples took.
title('Grand average of ripples')
linkaxes([ax1,ax2],'x')
xlabel('Time (s)')
ylabel('Voltage (uV)')

end