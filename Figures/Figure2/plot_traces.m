% sig2 %63x1 Raw signal 
% ti % 63x1 times 
% 
% veamos %Epochs where ripples were detected wrt sig2. 58x1
% cara %58x3; sample where they occur
% cara_times  %58x3; times where they occur
%%
function plot_traces(sig2,veamos,cara,ti,amp_vec,iii,labelconditions,chtm,include_hpc,cara_hpc,veamos_hpc,chtm_hpc)

% amp_vec=[5 5];
    %HPC
     hpc_bout=sig2{1};
    %PAR 
     par_bout=sig2{3};
     
     if include_hpc==1
         [C,ia,ib]=intersect(veamos{1},veamos_hpc{1});
         %ia wrt veamos{1}
         %ib wrt veamos_hpc{1}

         hpc_bout=hpc_bout(C);
         par_bout=par_bout(C); 
         hpc_ti=ti(C);
         
         cara={cara{1}(ia,:)};
         cara_hpc={cara_hpc{1}(ib,:)};
         
     else %Only use epochs where ripples were detected.
         hpc_bout=hpc_bout(veamos{1});
         par_bout=par_bout(veamos{1}); 
         hpc_ti=ti(veamos{1});
         % 
%          cara{1}(n,:)
     end
     

    nrem_length=cellfun(@length,hpc_bout);
    n=find((nrem_length==max(nrem_length))==1)%Index wrt veamos.
    %% Plot traces
    %HPC
    %plot(hpc_ti{n}/60,amp_vec(1).*(zscore(hpc_bout{n}))+100)
    plot(hpc_ti{n},amp_vec(1).*(zscore(hpc_bout{n}))+100)
    hold on

    %PAR
%    plot(hpc_ti{n}/60,amp_vec(2).*(zscore(par_bout{n}))+200)
    plot(hpc_ti{n},amp_vec(2).*(zscore(par_bout{n}))+200)

    %xlabel('Time (Minutes)')
    xlabel('Time (Seconds)')
    title(['Largest NREM bout: ' labelconditions{iii} '.  Thr:' num2str(chtm) ' uV'])
    %%
    times_rip=cara{1}(n,:);%Works.
    times_rip=times_rip(1,3);%Ripple center.
    times_rip=times_rip{1};
    %%
    if include_hpc==1
    times_rip_hpc=cara_hpc{1}(n,:); 
    times_rip_hpc=times_rip_hpc(1,3);%Ripple center.
    times_rip_hpc=times_rip_hpc{1};  
    end
%     times_rip=times_rip/60;
    %%
    % y = ylim; % current y-axis limits
    % plot([times_rip times_rip],[y(1) y(2)])
    stem(times_rip,240.*ones(1,length(times_rip)))
    hold on
    stem(times_rip_hpc,240.*ones(1,length(times_rip_hpc)),'Color','blue')
yticks([100 200])
yticklabels({'HPC','PAR'})
    end






