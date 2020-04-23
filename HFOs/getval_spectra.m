function values_spec=getval_spectra(P,Q,labelconditions2,label1,s,w)

    n=min([length(P.(labelconditions2{1}).(label1{w}){s}) length(P.(labelconditions2{2}).(label1{w}){s})...
        length(P.(labelconditions2{3}).(label1{w}){s}) length(P.(labelconditions2{4}).(label1{w}){s})]);

for condition=1:length(labelconditions2)

    %Order ripples
    p=P.(labelconditions2{condition}).(label1{w}){s}; 
    q=Q.(labelconditions2{condition}).(label1{w}){s}; 
    % R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,:)))),q));
    R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,121-50:121+50)))),q));
    [~,r]=sort(R,'descend');
    p=p(r);
    q=q(r);
    p=p(1:n);
    q=q(1:n);

%     %Order ripples
%     p_nl=P.nl.(label1{w}){s}; 
%     q_nl=Q.nl.(label1{w}){s}; 
%     % R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,:)))),q_nl));
%     R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,121-50:121+50)))),q_nl));
%     [~,r_nl]=sort(R,'descend');
%     p_nl=p_nl(r_nl);
%     q_nl=q_nl(r_nl);
%     p_nl=p_nl(1:n);
%     q_nl=q_nl(1:n);


    %Max 1000 ripples.
    if length(q)>1000
        q=q(1:1000);
        p=p(1:1000);
%         q_nl=q_nl(1:1000);
%         p_nl=p_nl(1:1000);
    end

    if w==3 %PAR-centered ripples.
         p=cellfun(@(equis1) flip(equis1),p,'UniformOutput',false);
         q=cellfun(@(equis1) flip(equis1),q,'UniformOutput',false);
%          p_nl=cellfun(@(equis1) flip(equis1),p_nl,'UniformOutput',false);
%          q_nl=cellfun(@(equis1) flip(equis1),q_nl,'UniformOutput',false);
    end
    
    ro=150;

    toy=[-.1:.001:.1];
%     freq3=barplot2_ft(q_nl,create_timecell(ro,length(q_nl)),[100:1:300],[],toy);
    freq4=barplot2_ft(q,create_timecell(ro,length(q)),[100:1:300],[],toy);

% allscreen()
    for j=1:3
    
%     [mdam,mdam2,mdam3,mdam4]=small_window(freq3,j);
    [ndam,ndam2,ndam3,ndam4]=small_window(freq4,j);
    
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
end

end
