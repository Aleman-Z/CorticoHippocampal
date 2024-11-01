function [vec_nrem, vec_trans ,vec_rem,vec_wake,labels]=stages_stripes(transitions2)
%Find maximum time value
m_time=max(max(transitions2(:,2:3)));
labels=(0:1:m_time);
vec_wake=zeros(length(labels),1);
vec_rem=vec_wake;
vec_nrem=vec_wake;
vec_trans=vec_wake;

u=unique(transitions2(:,1));
for j=1:size(u,1)
    tr2=(transitions2(find(transitions2(:,1)==u(j)),2:3)); %Use specific stage
    tr3=(diff(tr2.'));
        if u(j)~=1 % When not awake
            tr2=(tr2(find(tr3<10800),:)); %Discard scores longer than two hours.
        end
        
    for k=1:size(tr2,1)
        switch u(j)
            case 1
                vec_wake(ceil(tr2(k,1)):floor(tr2(k,2)))=1;
                
            case 3
                vec_nrem(ceil(tr2(k,1)):floor(tr2(k,2)))=1;

            case 4
                vec_trans(ceil(tr2(k,1)):floor(tr2(k,2)))=1;

            case 5
                vec_rem(ceil(tr2(k,1)):floor(tr2(k,2)))=1;
                  
        end
        
    end
        
%     [tr2]=merge_intervals(tr2);%Merges intervals that overlap.
%     ripples_per_stage(tr2,u(j),1)    
%     tr2=[u(j)*ones(size(tr2,1),1) tr2];%Sets output in same fashion as 'transitions'.
%     TR2=[TR2; tr2];
end
%% Logic part
vec_trans=and(vec_trans,not(vec_rem)); %The not is used on the vector with higher priority.
vec_nrem=and(vec_nrem,not(vec_trans));
vec_nrem=and(vec_nrem,not(vec_rem));


%% Plotting
% figure()
%  stripes(vec_trans,0.2,labels/60/60,'g')
% hold on
%  stripes(vec_rem,0.2,labels/60/60)
%  stripes(vec_nrem,0.2,labels/60/60,'b')

end