function [tr2]=sort_scoring(transitions,stage)
%Sorts chronologically the scoring labels for sleep stages and merges those
%overlapping.
%[transitions]=sort_chronologic(transitions,stage)
%For NREM stage=3.

[B,I] = sort( transitions(:,2));
transitions=transitions(I,:);

tr2=(transitions(find(transitions(:,1)==stage),2:3));

[tr2]=merge_intervals(tr2);
 tr2=[stage*ones(size(tr2,1),1) tr2];

end