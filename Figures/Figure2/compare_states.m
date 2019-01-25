states2=load('states2.mat');
states2=states2.states;
%%
dst=abs(states-states2);
% dst((dst~=0))=1;
s1=sum(dst==0);
s2=sum(dst~=0);
ts=s1+s2;

% dst=categorical(dst);
c=categorical({'Match' 'Mismatch'});
y=[s1/ts*100 s2/ts*100];
h=bar(c,y)

% yticklabels(yticks*100)
ylabel('Percentage of epochs')

for i1=1:numel(y)
    text(c(i1),y(i1),num2str(y(i1),'%0.2f'),...
               'HorizontalAlignment','center',...
               'VerticalAlignment','bottom')
end
% h.Categories={'Matches' 'Mismatches'};
%%

    a=hgload('plusmaze_27.fig');
    b=hgload('base2_rat26.fig');
    c=hgload('plusmaze_26.fig');
    d=hgload('rat26_baseline1.fig');
    e=hgload('rat27_base1.fig');
    f=hgload('rat27_base2.fig');

    
    %
    % Prepare subplots
%       allscreen()
figure()
 h(1)=subplot(2,3,1);
 h(1).XTickLabel={'{ }' 'Match' '{ }' 'Mismatch'}
%     xlim([0 300])
%   grid on
%    set(gca, 'YScale', 'log')
title('Rat 26 Baseline 1', 'FontSize', 14)
ylabel('Percentage of epochs', 'FontSize', 12)
%     ylabel('Power', 'FontSize', 15)

    h(2)=subplot(2,3,2);
     h(2).XTickLabel={'{ }' 'Match' '{ }' 'Mismatch'}
%     xlabel('Frequency (Hz)', 'FontSize', 15)
ylabel('Percentage of epochs', 'FontSize', 12)
title('Rat 26 Baseline 2', 'FontSize', 14)

    h(3)=subplot(2,3,3);
     h(3).XTickLabel={'{ }' 'Match' '{ }' 'Mismatch'}
ylabel('Percentage of epochs', 'FontSize', 12)
title('Rat 26 PlusMaze', 'FontSize', 14)


    h(4)=subplot(2,3,4);
     h(4).XTickLabel={'{ }' 'Match' '{ }' 'Mismatch'}
ylabel('Percentage of epochs', 'FontSize', 12)
title('Rat 27 Baseline 1', 'FontSize', 14)


    h(5)=subplot(2,3,5);
     h(5).XTickLabel={'{ }' 'Match' '{ }' 'Mismatch'}
ylabel('Percentage of epochs', 'FontSize', 12)
title('Rat 27 Baseline 2', 'FontSize', 14)


    h(6)=subplot(2,3,6);
     h(6).XTickLabel={'{ }' 'Match' '{ }' 'Mismatch'}
ylabel('Percentage of epochs', 'FontSize', 12)
title('Rat 27 Plusmaze', 'FontSize', 14)


    
    % Paste figures on the subplots
    copyobj(allchild(get(d,'CurrentAxes')),h(1));
    copyobj(allchild(get(b,'CurrentAxes')),h(2));
    copyobj(allchild(get(c,'CurrentAxes')),h(3));
    copyobj(allchild(get(e,'CurrentAxes')),h(4));
    copyobj(allchild(get(f,'CurrentAxes')),h(5));
    copyobj(allchild(get(a,'CurrentAxes')),h(6));
    
    