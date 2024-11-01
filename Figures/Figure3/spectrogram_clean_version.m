%Generates spectrograms and table values. 

close all
clear variables

%Rat numbers
rats=[26 27 24 21]; 

%Calls GUI to select analysis and parameters. Description of GUI on github.
gui_parameters
% xo
 
if view_traces==0
    %Method of Ripple selection. Method 4 gives best results.
    prompt = {'Select SWR detection Method'};
    dlgtitle = 'Detection';
    definput = {'4'};
    opts.Interpreter = 'tex';
    answer = inputdlg(prompt,dlgtitle,[1 40],definput,opts);
    meth=str2num(answer{1});
else
    meth=5;   %Visualize traces with parietal ripples. 
end

% meth=4;
s=struct;

%Area corresponding to method.
switch meth
    case 5
            w='PAR';
    case 4
            w='HPC';
    otherwise
            w='NaN'
            error('Not available')
end

%Data location
datapath='C:\Users\addri\Documents\internship\downsampled_NREM_data';
cluster_stats=0;
RAT24_test=1;

clear sanity
%%
Rat=rats(RAT);  %Rat number to use. 

%Baseline number to use
switch Rat   
    case 26
         base=2;
    case 27
         base=1; %Base 1 actually calls baseline 2. 
    case 24
        base=2; %Should be 2
    otherwise
        disp('Rat 21 not available')
        xo
end


riptable=zeros(4,3);% Variable used to save number of ripples.         

    if Rat==24%Must be 2 for Rat 24.
        rat24base=2;
    else
        rat24base=1;
    end

  if Rat~=24 && rat24base==2
      xo
  end

  %Was the +/-10 ms spectrogram windows option selected?
  %If yes, make use of a loop to run twice and equalize axes on the second
  %run.
  if win_ten==1
      spec_lim=2;
  else
      spec_lim=1;
  end
   
    %Spectrogram axis-equalization loop
for spectra_winval=1:spec_lim
    % Folder names with data per rat.  
    
    [nFF,NFF,labelconditions,label1,label2]=rat_foldernames(Rat,rat26session3,rat27session3,rat24base);
     
%     label1=label1(1:2:end);
%     label2=label2(1:2:end);
  
    % Use other baseline, caution when using mergebaseline
    if Rat~=24
        if base==2
            nFF{1}=NFF{1};
        end
    end

    if base==3
        break
    end

%xo
    %% Go to main directory, add to path, initiate Fieldtrip.
    if acer==0
        cd(strcat('/home/adrian/Documents/downsampled_NREM_data/',num2str(Rat)))
%         addpath /home/raleman/Documents/internship/fieldtrip-master/
        InitFieldtrip()

        cd(strcat('/home/adrian/Documents/downsampled_NREM_data/',num2str(Rat)))
        clc
    else
        cd(strcat(datapath,'/',num2str(Rat)))
%         addpath D:\internship\fieldtrip-master
%         InitFieldtrip()

        cd(strcat(datapath,'/',num2str(Rat)))
        clc
    end

    %Select length of window in miliseconds:
    ro=1200; 
    
    notch=0;
    nrem=3;
    zlim=cell(1,3);     
    %%
% block_time=0; %Ideally erase

    %CONDITION LOOP. (Main loop).    
    for iii=2:length(nFF) %Should start with 2 for spectrogram. 1 for power window.
       %xo
    
    if iii>length(nFF)
        break
    end

    
    if acer==0
        cd(strcat('/home/adrian/Documents/downsampled_NREM_data/',num2str(Rat)))
    else
        cd(strcat(datapath,'/',num2str(Rat)))
    end

%Change current folder according to Condition.    
    cd(nFF{iii})
    
    lepoch=2;
    level=1;

%Ripple detection methods. Currently method 4 is being used. Descriptions
%on Dropbox .ppt.
%xo

[sig1,sig2,ripple,cara,veamos,RipFreq2,timeasleep,ti,vec_nrem, vec_trans ,vec_rem,vec_wake,labels,transitions,transitions2,ripples_times,riptable,chtm,CHTM]=meth_selection(meth,level,notch,Rat,datapath,nFF,acer,iii,w,rat26session3,base);

% switch meth
%     case 1
%       [sig1,sig2,ripple,cara,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level_ERASETHIS(level);
%     case 2
%         [sig1,sig2,ripple,cara,veamos,CHTM,RipFreq2,timeasleep]=median_std;        
%     case 3
%         chtm=load('vq_loop2.mat');
%         chtm=chtm.vq;
%         [sig1,sig2,ripple,cara,veamos,RipFreq2,timeasleep,~]=nrem_fixed_thr_Vfiles(chtm,notch);
%         CHTM=[chtm chtm];
%         
%     case 4
%         %Find threshold on Baseline which gives 2000 ripples during the whole NREM.
%         if acer==0
%             cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
%         else
%             cd(strcat(datapath,'/',num2str(Rat)))
%         end
% 
%         cd(nFF{1}) %Baseline
% 
%         [timeasleep]=find_thr_base;
%         ror=2000/timeasleep; %2000 Ripples during whole NREM sleep.
% 
%         %Find thresholds vs ripple freq plot.
%         if acer==0
%             cd(strcat('/home/raleman/Dropbox/Figures/Figure2/',num2str(Rat)))
%         else
%               %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
%               cd(strcat('C:\Users\addri\Dropbox\Figures\Figure2\',num2str(Rat)))   
%         end
% 
% 
%         if Rat==26 || Rat==24 
%         Base=[{'Baseline1'} {'Baseline2'}];
%         end
%         if Rat==26 && rat26session3==1
%         Base=[{'Baseline3'} {'Baseline2'}];
%         end
% 
%         if Rat==27 
%         Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
%         end
% 
%         if Rat==27 && rat27session3==1
%         Base=[{'Baseline2'} {'Baseline3'}];% We run Baseline 2 first, cause it is the one we prefer.    
%         end
%         %openfig('Ripples_per_condition_best.fig')
%     
%         h=openfig(strcat('Ripples_per_condition_',Base{base},'.fig'))
% 
%         %h = gcf; %current figure handle
%         axesObjs = get(h, 'Children');  %axes handles
%         dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
% 
%         ydata=dataObjs{2}(8).YData;
%         xdata=dataObjs{2}(8).XData;
% 
%         chtm = interp1(ydata,xdata,ror); %Interpolate for value ror.
%         close(h)
% 
%         %xo
%         if acer==0
%             cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
%         else
%             cd(strcat(datapath,'/',num2str(Rat)))
%         end
% 
%         cd(nFF{iii})
%         w='HPC';
%         [sig1,sig2,ripple,cara,veamos,RipFreq2,timeasleep,ti,vec_nrem, vec_trans ,vec_rem,vec_wake,labels,transitions,transitions2,ripples_times]=nrem_fixed_thr_Vfiles(chtm,notch,w);      
%         CHTM=[chtm chtm]; %Threshold
%         
%         %Fill table with ripple information.
%         riptable(iii,1)=ripple; %Number of ripples.
%         riptable(iii,2)=timeasleep;
%         riptable(iii,3)=RipFreq2;
%         
%    case 5
% %              xo
%              
% %             if acer==0
% %                 cd(strcat('/home/raleman/Dropbox/Figures/Figure2/',num2str(Rat)))
% %             else
% %                   %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
% %                   cd(strcat('C:\Users\addri\Dropbox\Figures\Figure2\',num2str(Rat)))   
% %             end
% % 
% % 
% %             if Rat==26 || Rat==24 
% %             Base=[{'Baseline1'} {'Baseline2'}];
% %             end
% %             if Rat==26 && rat26session3==1
% %             Base=[{'Baseline3'} {'Baseline2'}];
% %             end
% % 
% %             if Rat==27 
% %             Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
% %             end
% % 
% %             if Rat==27 && rat27session3==1
% %             Base=[{'Baseline2'} {'Baseline3'}];% We run Baseline 2 first, cause it is the one we prefer.    
% %             end
% %             %openfig('Ripples_per_condition_best.fig')
% % 
% %             h=openfig(strcat('Ripples_per_condition_',w,'_',Base{base},'.fig'))
% % 
% %             %h = gcf; %current figure handle
% %             axesObjs = get(h, 'Children');  %axes handles
% %             dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
% % 
% %             ydata=dataObjs{2}(8).YData;
% %             xdata=dataObjs{2}(8).XData;
% %             % figure()
% %             % plot(xdata,ydata)
% %             chtm = interp1(ydata,xdata,ror);
% %             close(h) 
% % if Rat~=24
% chtm=20;
% % chtm=25;
% % else
% % chtm=35;    
% % end
% % chtm=10;
% 
%         if acer==0
%             cd(strcat('/home/adrian/Documents/downsampled_NREM_data/',num2str(Rat)))
%         else
%             cd(strcat(datapath,'/',num2str(Rat)))
%         end
% 
%         cd(nFF{iii})
%         
%         [sig1,sig2,ripple,cara,veamos,RipFreq2,timeasleep,ti,vec_nrem, vec_trans ,vec_rem,vec_wake,labels,transitions,transitions2,ripples_times]=nrem_fixed_thr_Vfiles(chtm,notch,w);      
%         CHTM=[chtm chtm]; %Threshold
%         
%         %Fill table with ripple information.
%         riptable(iii,1)=ripple; %Number of ripples.
%         riptable(iii,2)=timeasleep;
%         riptable(iii,3)=RipFreq2;
% %          continue
% end
% xo
if view_traces==1
    include_hpc=1;
%    include_hpc=0;
    
    if include_hpc==1   
        [~,~,~,cara_hpc,veamos_hpc,~,~,~,~, ~ ,~,~,~,~,~,~,~,chtm_hpc,~]=meth_selection(4,level,notch,Rat,datapath,nFF,acer,iii,'HPC',rat26session3,base,rat27session3);
    else
        cara_hpc=[];
        veamos_hpc=[];
        chtm_hpc=[];
    end
    
    amp_vec=[5 5];
xo
    plot_traces(sig2,veamos,cara,ti,amp_vec,iii,labelconditions,chtm,include_hpc,cara_hpc,veamos_hpc,chtm_hpc);
    cd('C:\Users\addri\Documents\Donders\Projects\SWR_d\Cortical_ripples')
    xo
end
xo
if rip_hist    
        %% Create ripple occurrence histogram.
        allscreen()
        rip_times=ripples_times{1}(:,3);
        rip_times=[rip_times{:}];
        aver=histcounts(rip_times,[0:10: max(labels)+1]);
        maver=max(aver);
        maver=30;
        % stem(linspace(0,max(labels)/60/60,length(aver)),aver,'filled','Color',[0.3010 0.7450 0.9330])
        %plot(linspace(0,max(labels)/60/60,length(aver)),aver,'Color','b')

        %%
        hold on
        vec_wake=not(vec_trans) & not(vec_rem) & not(vec_nrem);

        %Plot wake
        % stripes((vec_wake),0.2,labels/60/60,'w',maver)
        xlabel('Time (Hours)','FontSize',12)
        ylabel('Amount of ripples','FontSize',12)
        title('Histogram of ripples','FontSize',12)
        %%
        %figure()
        hold on
        stripes(vec_trans,0.2,labels/60/60,[0.5 0.5 0.5],maver)
        stripes(vec_rem,0.2,labels/60/60,'r',maver)
        stripes(vec_nrem,0.9,labels/60/60,'k',maver)

        stem(linspace(0,max(labels)/60/60,length(aver)),aver,'filled','Color',[0.3010 0.7450 0.9330])

        xlim([0 4])
        ylim([0 30])
        yticks([0:2:30])
        %%
        cd('C:\Users\addri\Dropbox\preparando')
        % printing(strcat('Histogram','_Rat_',num2str(Rat),'_',labelconditions{iii}))

        close all
        %stripes(vec_nrem,0.2,labels/60/60,'b',maver)
        %break
        continue
        %%
end
%    xo  
%% Calculate median duration of ripples    
    consig=cara{1};
    bon=consig(:,1:2);
    %Difference between starting time and end time of ripple.
    C = cellfun(@minus,bon(:,2),bon(:,1),'UniformOutput',false);
    C=cell2mat(C.');
    c=median(C)*1000; %Miliseconds
    cc(iii)=c; %Store for all conditions.
    
    %% Generate +/- time window for each ripple found.
    [p,q,~,sos]=getwin2(cara{1},veamos{1},sig1,sig2,ro); 
    %p: Wideband signal windows.
    %q: Bandpassed signal (100-300Hz) windows.
%     xo
    clear sig1 sig2
 
    %Ripple selection: Removes outliers and sorts ripples from strongest to weakest. 
    if Rat~=24 || RAT24_test==1
    [p,q,sos]=ripple_selection(p,q,sos,Rat,meth);
    end
     

    %Equalize number of ripples. 
    %(Same number of ripples found on Plusmaze after ripple selection). 
    if equal_num==1 %&& Rat~=24
      if meth==4 
           switch Rat
            case 24
                %n=550;
                %n=308; %New value
                n=133;

            case 26
                n=180;
            case 27
                n=326;
            otherwise
                error('Error found')
           end
      end
      
      if meth==5 
           switch Rat
            case 24
                %n=550;
                %n=308; %New value
                n=426;

            case 26
                n=476;
            case 27
                n=850;
            otherwise
                error('Error found')
           end
      end

        p=p(1:n);
        q=q(1:n);

    end

    %Freeing Memory. Use maximum of 1000 strongests ripples. 
    if length(p)>1000 && (Rat~=24|| RAT24_test==1) %Novelty or Foraging
     p=p(1,1:1000);
     q=q(1,1:1000);
    end
    
    %Notch filter
    [q]=filter_ripples(q,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);
    
    %Non learning condition.
    if acer==0
        cd(strcat('/home/adrian/Documents/downsampled_NREM_data/',num2str(Rat)))
    else
        %cd(strcat('D:\internship\',num2str(Rat)))
        cd(strcat(datapath,'/',num2str(Rat)))
    end
    cd(nFF{1}) %Baseline
    
%Ripple detection on Baseline condition.
    
    if win_ten==0 || win_ten==1 && iii==2 || win_ten==1 && win_stats==1
            switch meth
                case 1
                    [sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,RipFreq3,timeasleep2]=newest_only_ripple_level_ERASETHIS(level);
                case 2
                    [sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,RipFreq3,timeasleep2]=median_std;        
                case 3
                    chtm=load('vq_loop2.mat');
                    chtm=chtm.vq;
                    [sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,RipFreq3,timeasleep2,~]=nrem_fixed_thr_Vfiles(chtm,notch,w);
                    CHTM2=[chtm chtm];              
                case 4
                    [sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,RipFreq3,timeasleep2,~]=nrem_fixed_thr_Vfiles(chtm,notch,w);
                    CHTM2=[chtm chtm];
                    riptable(1,1)=ripple_nl;
                    riptable(1,2)=timeasleep2;
                    riptable(1,3)=RipFreq3;
                case 5
                    [sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,RipFreq3,timeasleep2,~]=nrem_fixed_thr_Vfiles(chtm,notch,w);
                    CHTM2=[chtm chtm];
                    riptable(1,1)=ripple_nl;
                    riptable(1,2)=timeasleep2;
                    riptable(1,3)=RipFreq3;

            end
    else
       error('Check which parameters lead to this') 
    end
% xo
%% Calculate median duration of ripples (No learning)
    consig=cara_nl{1};

    bon=consig(:,1:2);
    C = cellfun(@minus,bon(:,2),bon(:,1),'UniformOutput',false);
    C=cell2mat(C.');
    c=median(C)*1000; %Miliseconds
    cc(1)=c;
%   xo
    %%
    if rippletable==0
    
            if win_ten==1  % Executes when Power windows option was selected on GUI.   
                       if spectra_winval==1     
                                        Zlim=[];
                                        if iii==2
                                        Zlim1=[];
                                        Zlim2=[];
                                        Zlim3=[];
                                        Mdam1=[];
                                        Mdam2=[];
                                        Mdam3=[];
                                        end
                                        
                                    if win_stats==0
                                                  block_time=1;
                                                  sanity=0;
                                                            [zlim1,mdam1]=spectra_window(Rat,nFF,level,ro,1,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num,RAT24_test);
                                                            [zlim2,mdam2]=spectra_window(Rat,nFF,level,ro,2,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num,RAT24_test);
                                                            [zlim3,mdam3]=spectra_window(Rat,nFF,level,ro,3,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num,RAT24_test);

                                                            Zlim1=[Zlim1 zlim1];
                                                            Zlim2=[Zlim2 zlim2];
                                                            Zlim3=[Zlim3 zlim3];

                                                            Mdam1=[Mdam1 mdam1];
                                                            Mdam2=[Mdam2 mdam2];
                                                            Mdam3=[Mdam3 mdam3];
                                    else %Statistical test
                                                if cluster_stats==0
                                                                      [zlim1]=spectra_stats(Rat,nFF,level,ro,1,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num,cluster_stats,RAT24_test);
                                                                      Zlim1=[Zlim1 zlim1];

                                                                      [zlim2]=spectra_stats(Rat,nFF,level,ro,2,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num,cluster_stats,RAT24_test);
                                                                      Zlim2=[Zlim2 zlim2];
                                                end
                                                  [zlim3]=spectra_stats(Rat,nFF,level,ro,3,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num,cluster_stats,RAT24_test);
                                                  Zlim3=[Zlim3 zlim3];

                                    end

                                        % zlim{iii-1}=[zlim1; zlim2 ;zlim3];
                       else
                                        %        Zlim =[ 0.0118   48.7217; 0.0007    0.3018; 0.0002    0.1765];
                                        %        Zlim =[  0.0074   48.6926; 0.0006    0.3018; 0.0002    0.1759];
                                      if win_stats==0
                                        [~]=spectra_window(Rat,nFF,level,ro,1,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num,RAT24_test);
                                        [~]=spectra_window(Rat,nFF,level,ro,2,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num,RAT24_test);
                                        [~]=spectra_window(Rat,nFF,level,ro,3,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num,RAT24_test);
                                      else
                %                            if Rat==26
                % %                            Zlim=[-58.2064   58.2064
                % %                                -0.2661    0.2661
                % %                                -1.0000    1.0000];
                %   Zlim=[-60.9514   60.9514
                %    -0.2670    0.2670
                %    -1.0000    1.0000];
                %                           end
                                            if cluster_stats==0

                                                                  [~]=spectra_stats(Rat,nFF,level,ro,1,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num,cluster_stats,RAT24_test);
                                                                  [~]=spectra_stats(Rat,nFF,level,ro,2,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num,cluster_stats,RAT24_test);
                                            end 
                                              [~]=spectra_stats(Rat,nFF,level,ro,3,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num,cluster_stats,RAT24_test);

                                      end
                       end
            else   %Do spectrogram analysis

        %xo
            %%
                        for w=1:3 %Loop for brain regions.

                        %%


                         P1=0;
                         P2=0;
                        %xo

                        block_time=0;
                        sanity=0;
                        
%                          xo % Too long
                        [h]=stats_vs_nl(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath);

                        clear block_time sanity
                        %% Move statistics to the middle
                        center_stats(h)
                        %%

                        %xo
                        %error('stop')
                        if acer==0
                            cd(strcat('/home/adrian/Dropbox/Figures/Figure3/',num2str(Rat)))
                        else
                              %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
                              cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
                        end
% xo
                        % if Rat==24
                        %     cd(nFF{1})
                        % end



                            if outlie==1
                                    string=strcat('Spec_out_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
                                    figure_function(gcf,[],string,[]);
                                    string=strcat('Spec_out_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.eps');
                                    print(string,'-depsc')
                                    string=strcat('Spec_out_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');
                                    saveas(gcf,string)

                            else
                                    % string=strcat('Spec_outliers_cluster_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
                                    % figure_function(gcf,[],string,[]);
                                    % string=strcat('Spec_outliers_cluster_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.eps');
                                    % print(string,'-depsc')
                                    % string=strcat('Spec_outliers_cluster_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');

                                    string=strcat('Spec_',labelconditions{iii},'_',label1{2*w-1},'_samenumber3_Meth_',num2str(meth),'.pdf');
                                    figure_function(gcf,[],string,[]);
                                    string=strcat('Spec_',labelconditions{iii},'_',label1{2*w-1},'_samenumber3_Meth_',num2str(meth),'.eps');
                                    print(string,'-depsc')
                                    string=strcat('Spec_',labelconditions{iii},'_',label1{2*w-1},'_samenumber3_Meth_',num2str(meth),'.fig');
                                    saveas(gcf,string)

                            end

                            %xo
                            close all

                        %%

                        end
            %xo
            end
    end
% xo
    if iii==length(nFF)
       break 
    end
    %xo
    clear sig1_nl sig2_nl p q
    sig1_nl=[];
    sig2_nl=[];
    xo
    end

    %%

    if win_ten==1
        if spectra_winval==1
            %xo
            Zlim=[min(Zlim1) max(Zlim1); min(Zlim2) max(Zlim2); min(Zlim3) max(Zlim3)];
            cd('C:\Users\addri\Dropbox\Window')
            cd(num2str(Rat))
                if equal_num==0
                     cd('all_rip')
                end
                        if win_stats==0
                                        if win_comp==1
                                                save(strcat('Zlim_1sec.mat'),'Zlim')
                                        else
                                                save(strcat('Zlim_100ms.mat'),'Zlim')
                                        end
                        end
%xo
            close all
        end
    end
end
 xo

    if win_ten==1
    %Add Ylabels    
    tg=mtit('HPC','fontsize',14,'xoff',-.6,'yoff',-.16);
    tg=mtit('PAR','fontsize',14,'xoff',-.6,'yoff',-.525);
    tg=mtit('PFC','fontsize',14,'xoff',-.6,'yoff',-.895);
    cd('C:\Users\addri\Dropbox\Window')
    cd(num2str(Rat))

        if equal_num==0
            cd('all_rip')
        end
        %xo
        if win_stats==0
                if win_comp==1
                    printing('1sec')
                else
                    printing('100ms')
                end
        else
                if win_comp==1
                    printing('Stats_1sec')
                else
                    printing('Stats_100ms')
                end
        end
    close all
            if win_comp==0 && win_stats==0
                Mdam=[Mdam1; Mdam2; Mdam3];
                save('Mdam.mat','Mdam')
            end        
    end

    if meth==4 || meth==5 

        if Rat==26
        Base=[{'Baseline1'} {'Baseline2'}];
        end
        if Rat==26 && rat26session3==1
        Base=[{'Baseline3'} {'Baseline2'}];
        end

        if Rat==27 
        Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
        end

        if Rat==27 && rat27session3==1
        Base=[{'Baseline2'} {'Baseline3'}];% We run Baseline 2 first, cause it is the one we prefer.    
        end

        [s.(Base{base})]=riptable;
    end
xo
%end
%xo
% % % % % % if rippletable==0
% % % % % % spec_loop_improve(RAT,block_time,sanity,dura,quinientos,outlie);
% % % % % % %save in right folder
% % % % % % list = dir();
% % % % % % list([list.isdir]) = [];
% % % % % % list={list.name};
% % % % % % FolderRip=[{'all_ripples'} {'500'} {'1000'}];
% % % % % % if Rat==26
% % % % % % Base=[{'Baseline1'} {'Baseline2'}];
% % % % % % end
% % % % % % if Rat==26 && rat26session3==1
% % % % % % Base=[{'Baseline3'} {'Baseline2'}];
% % % % % % end
% % % % % % 
% % % % % % if Rat==27 
% % % % % % Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
% % % % % % end
% % % % % % 
% % % % % % if Rat==27 && rat27session3==1
% % % % % %    Base=[{'Baseline2'} {'Baseline3'}];% We run Baseline 2 first, cause it is the one we prefer.    
% % % % % % end
% % % % % % 
% % % % % % if meth==1
% % % % % % folder=strcat(Base{base},'_',FolderRip{FiveHun+1});
% % % % % % else
% % % % % % Method=[{'Method2' 'Method3' 'Method4'}];
% % % % % % folder=strcat(Base{base},'_',FolderRip{FiveHun+1},'_',Method{meth-1});    
% % % % % % end
% % % % % % 
% % % % % % if mergebaseline==1
% % % % % %     if meth==1
% % % % % %     folder=strcat('Merged','_',FolderRip{FiveHun+1});
% % % % % %     else
% % % % % %     Method=[{'Method2' 'Method3' 'Method4'}];
% % % % % %     folder=strcat('Merged','_',FolderRip{FiveHun+1},'_',Method{meth-1});    
% % % % % %     end
% % % % % % end
% % % % % % 
% % % % % % if exist(folder)~=7
% % % % % % (mkdir(folder))
% % % % % % end
% % % % % % 
% % % % % % for nmd=1:length(list)
% % % % % % movefile (list{nmd}, folder)
% % % % % % end
% % % % % % 
% % % % % % 
% % % % % % clearvars -except RAT acer DUR Block mergebaseline FiveHun meth block_time base rat26session3 rat27session3 randrip sanity
% % % % % % end


xo
base=2;
    
if rippletable==1
            if acer==0
                cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
            else
                  %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
                  cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
            end
            save('NumberRipples','s')
            
            list = dir();
            list([list.isdir]) = [];
            list={list.name};
            FolderRip=[{'all_ripples'} {'500'} {'1000'}];
            Method=[{'Method2' 'Method3' 'Method4'}];
                if Rat==26
                folder=strcat('Baseline1','_',FolderRip{FiveHun+1},'_',Method{meth-1});
                else
                folder=strcat('Baseline2','_',FolderRip{FiveHun+1},'_',Method{meth-1});    
                end
            movefile (list{1}, folder)
end
base=1;

