%allscreen()
numer=3
subplot(1,2,1)
plot(cell2mat(create_timecell(ro,1)),p{numer}(1,:), 'LineWidth', 0.8);
xlim([-0.2 0.2])
%xlim([-1 1])

h=xlabel('Time')
set(h, 'FontSize', 12) 
h=ylabel('Magnitude (uV)')
set(h, 'FontSize', 12) 


subplot(1,2,2)
plot(cell2mat(create_timecell(ro,1)),q{numer}(1,:), 'LineWidth', 0.8);
 xlim([-0.2 0.2])
%xlim([-1 1])

h=xlabel('Time')
set(h, 'FontSize', 12) 
h=ylabel('Magnitude (uV)')
set(h, 'FontSize', 12) 
%%
string=strcat('trace','.pdf');
figure_function(gcf,[],string,[]);