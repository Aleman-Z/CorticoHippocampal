function [values_spec,n]=getval_spectra_All(P,Q,labelconditions2,label1,s,w,win_size)

n=([length(P.(labelconditions2{1}).(label1{w}){s}) length(P.(labelconditions2{2}).(label1{w}){s})...
        length(P.(labelconditions2{3}).(label1{w}){s}) length(P.(labelconditions2{4}).(label1{w}){s})]);

for condition=1:length(labelconditions2)

    %Order ripples
    p=P.(labelconditions2{condition}).(label1{w}){s}; 
    q=Q.(labelconditions2{condition}).(label1{w}){s}; 



    if w==3 %PAR-centered ripples.
         p=cellfun(@(equis1) flip(equis1),p,'UniformOutput',false);
         q=cellfun(@(equis1) flip(equis1),q,'UniformOutput',false);
    end
    
    ro=150;

    toy=[-.1:.001:.1];
%     freq3=barplot2_ft(q_nl,create_timecell(ro,length(q_nl)),[100:1:300],[],toy);
    freq4=barplot2_ft(q,create_timecell(ro,length(q)),[100:1:300],[],toy);

% allscreen()
    for j=1:3
    
%     [mdam,mdam2,mdam3,mdam4]=small_window(freq3,j);
    [ndam,ndam2,ndam3,ndam4]=small_window(freq4,j,win_size);
    
%     Mdam(j)=mdam;
%     Mdam2(j)=mdam2;
%     Mdam3(j)=mdam3;
%     Mdam4(j)=mdam4;
    
    Ndam(j)=ndam;
    Ndam2(j)=ndam2;
    Ndam3(j)=ndam3;
    Ndam4(j)=ndam4;

    end

%     values_spec.baseline=[Mdam;Mdam2;Mdam3;Mdam4];
    values_spec.(labelconditions2{condition})=[Ndam;Ndam2;Ndam3;Ndam4];
%     prueba.(labelconditions2{condition})=    rand_vec;
end

                 
end
