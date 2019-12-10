% sig2 %63x1 Raw signal 
% ti % 63x1 times 
% 
% veamos %Epochs where ripples were detected. 58x1
% cara %58x3; sample where they occur
% cara_times  %58x3; times where they occur
%%
function plot_traces(sig2,veamos,cara,ti,amp_vec,iii,labelconditions)

% amp_vec=[5 5];
    %HPC
     hpc_bout=sig2{1};
     par_bout=sig2{3};
     hpc_bout=hpc_bout(veamos{1});
     par_bout=par_bout(veamos{1}); 
     hpc_ti=ti(veamos{1});


    nrem_length=cellfun(@length,hpc_bout);
    n=find((nrem_length==max(nrem_length))==1);
    %%
    %HPC
    %plot(hpc_ti{n}/60,amp_vec(1).*(zscore(hpc_bout{n}))+100)
    plot(hpc_ti{n},amp_vec(1).*(zscore(hpc_bout{n}))+100)
    hold on

    %PAR
%    plot(hpc_ti{n}/60,amp_vec(2).*(zscore(par_bout{n}))+200)
    plot(hpc_ti{n},amp_vec(2).*(zscore(par_bout{n}))+200)

    %xlabel('Time (Minutes)')
    xlabel('Time (Seconds)')
    title(['Largest NREM bout: ' labelconditions{iii} ])
    %%
    times_rip=cara{1}(n,:);
    times_rip=times_rip(1,3);
    times_rip=times_rip{1};
%     times_rip=times_rip/60;
    %%
    % y = ylim; % current y-axis limits
    % plot([times_rip times_rip],[y(1) y(2)])
    stem(times_rip,240.*ones(1,length(times_rip)))
yticks([100 200])
yticklabels({'HPC','PAR'})
    end






