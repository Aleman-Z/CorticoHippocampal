states(states==1)=2;

c=area((1:length(states))/60,states)
xlabel('Time (Minutes)')
%xlabel('Minutes')

yticks([2 3 4 5])

yticklabels({'Wake','NREM','Transitional sleep','REM'})
ylim([1 5])
c.FaceColor=[1 0 0];
%alpha(0.8)