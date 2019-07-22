function [TR2]=sort_scoring(transitions)
%Sorts chronologically the scoring labels for sleep stages and merges those
%overlapping.
%[transitions]=sort_chronologic(transitions,stage)
%For NREM: stage=3.

[~,I] = sort( transitions(:,2));
transitions=transitions(I,:);
TR2=[];
u=unique(transitions(:,1));
for j=1:size(u,1)
    tr2=(transitions(find(transitions(:,1)==u(j)),2:3)); %Use specific stage
    tr3=(diff(tr2.'));
        if u(j)~=1 % When not awake
            tr2=(tr2(find(tr3<10800),:)); %Discard scores longer than 3 hours.
        end
      [tr2]=merge_intervals(tr2);%Merges intervals that overlap.
    ripples_per_stage(tr2,u(j),0)    
    tr2=[u(j)*ones(size(tr2,1),1) tr2];%Sets output in same fashion as 'transitions'.
    TR2=[TR2; tr2];
end
% xlim([0 4.5])
% ylim([0 6])
[~,I] = sort( TR2(:,2));
TR2=TR2(I,:);


% tr2=(transitions(find(transitions(:,1)==stage),2:3));
% [tr2]=merge_intervals(tr2);
 %tr2=[stage*ones(size(tr2,1),1) tr2];

end