function [Fval_par,Fval_hpc,Fval_par_mean,Fval_hpc_mean]=time_delay_slowfast(P,Q,label1,labelconditions2,w,s,F_values)
    n=min([length(P.(labelconditions2{1}).(label1{w}){s}) length(P.(labelconditions2{2}).(label1{w}){s})...
        length(P.(labelconditions2{3}).(label1{w}){s}) length(P.(labelconditions2{4}).(label1{w}){s})]);
 
 for condition=1:4
 %condition=1
     %Order ripples
    p=P.(labelconditions2{condition}).(label1{w}){s}; 
    q=Q.(labelconditions2{condition}).(label1{w}){s}; 
    % R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,:)))),q));
    %R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,121-50:121+50)))),q));

 %Max PAR
    R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,151-25:151+25)))),q));
    [~,r]=sort(R,'descend');
%     p=p(r);
%     q=q(r);
%     p=p(1:n);
%     q=q(1:n);

    fval_par=F_values.(labelconditions2{condition});
    fval_par=fval_par(r);
    fval_par=fval_par(1:n);
    Fval_par.(labelconditions2{condition})=fval_par;
    %Fval_par_mean.(labelconditions2{condition})=mean(fval_par);
    Fval_par_mean(condition)=mean(fval_par)*1000;

    
 %Max HPC
    R=(cellfun(@(equis1) max(abs(hilbert(equis1(3,151-25:151+25)))),q));
    [~,r]=sort(R,'descend');
    
    fval_hpc=F_values.(labelconditions2{condition});
    fval_hpc=fval_hpc(r);
    fval_hpc=fval_hpc(1:n);
    Fval_hpc.(labelconditions2{condition})=fval_hpc;
    Fval_hpc_mean(condition)=mean(fval_hpc)*1000;

 end
end