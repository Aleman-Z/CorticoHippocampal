%Generates spectrograms and table values. 

close all
clear variables

%Rat numbers
rats=[26 27 24 21]; 

%Variables used for different segments of time.
DUR{1}='1sec';
DUR{2}='10sec';
Block{1}='complete';
Block{2}='block1';
Block{3}='block2';

%Calls GUI to select analysis and parameters. Description of GUI on github.
gui_parameters

%Method of Ripple selection. Method 4 gives best results.
meth=4;
s=struct;

%Data location
datapath='D:\internship\';
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

%While loop previously used for merging baselines. Currently not used.
while base<=2-mergebaseline %Should be 1 for MERGEDBASELINES otherwise 2.

    riptable=zeros(4,3);% Variable used to save number of ripples.         

    if Rat==24%Must be 2 for Rat 24.
        rat24base=2;
    else
        rat24base=1;
    end

  if Rat~=24 && rat24base==2
      break
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
    %Loop previously used to analyse different temporal segments. Currently using whole signal.    
    for dura=1:1 %Whole duration of signal.
    % Folder names with data per rat.  
    [nFF,NFF,labelconditions,label1,label2]=rat_foldernames(Rat,rat26session3,rat27session3,rat24base);
%         %% Check if experiment has been run before.
%         if acer==0
%             cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
%         else
%               %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
%               cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
%         end
% 
%         % if Rat==24
%         %     cd(nFF{1})
%         % end
% 
%         if dura==2
%             cd('10sec')
%         end
     
    
    % Use other baseline, beware when using mergebaseline
    if Rat~=24
        if base==2
            nFF{1}=NFF{1};
        end
    end

    if base==3
        break
    end


    %% Go to main directory
    if acer==0
        cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
        addpath /home/raleman/Documents/internship/fieldtrip-master/
        InitFieldtrip()

        cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
        clc
    else
        cd(strcat('D:\internship\',num2str(Rat)))
        addpath D:\internship\fieldtrip-master
        InitFieldtrip()

        % cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
        cd(strcat('D:\internship\',num2str(Rat)))
        clc
    end

    %Select length of window in miliseconds:
    if dura==1
    ro=1200; 
    else
    ro=10200;    
    end
    
     notch=0;
     nrem=3;
     zlim=cell(1,3);     
    %%
    %Block of time loop. Previously used.
    for block_time=0:0 %Should start with 0
        
    %CONDITION LOOP. (Main loop).    
    for iii=2:length(nFF) %Should start with 2 for spectrogram. 1 for power window.
       
    if acer==0
        cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
    else
          %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
          cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
    end

    % if Rat==24
    %     cd(nFF{1})
    % end

    if dura==2
        cd('10sec')
    end

    %Sanity test option. Random number of ripples. Not currently used. 
    if iii==2 && sanity==1
       run('sanity_test.m')
    end
    
    if iii>length(nFF)
        break
    end

    
    if acer==0
        cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
    else
        cd(strcat('D:\internship\',num2str(Rat)))
    end

%Change current folder according to Condition.    
    cd(nFF{iii})
    
    lepoch=2;
    level=1;

%Ripple detection methods. Currently method 4 is being used. Descriptions
%on Dropbox .ppt.

switch meth
    case 1
      [sig1,sig2,ripple,cara,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level_ERASETHIS(level);
    case 2
        [sig1,sig2,ripple,cara,veamos,CHTM,RipFreq2,timeasleep]=median_std;        
    case 3
        chtm=load('vq_loop2.mat');
        chtm=chtm.vq;
        [sig1,sig2,ripple,cara,veamos,RipFreq2,timeasleep,~]=nrem_fixed_thr_Vfiles(chtm,notch);
        CHTM=[chtm chtm];
        
    case 4
        
        if acer==0
            cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
        else
            cd(strcat('D:\internship\',num2str(Rat)))
        end

        cd(nFF{1})

        [timeasleep]=find_thr_base;
        ror=2000/timeasleep;

            if acer==0
                cd(strcat('/home/raleman/Dropbox/Figures/Figure2/',num2str(Rat)))
            else
                  %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
                  cd(strcat('C:\Users\addri\Dropbox\Figures\Figure2\',num2str(Rat)))   
            end


        if Rat==26 || Rat==24 
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
        %openfig('Ripples_per_condition_best.fig')
        openfig(strcat('Ripples_per_condition_',Base{base},'.fig'))

        h = gcf; %current figure handle
        axesObjs = get(h, 'Children');  %axes handles
        dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes

        ydata=dataObjs{2}(8).YData;
        xdata=dataObjs{2}(8).XData;
        % figure()
        % plot(xdata,ydata)
        chtm = interp1(ydata,xdata,ror);
        close

        %xo
        if acer==0
            cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
        else
            cd(strcat('D:\internship\',num2str(Rat)))
        end

        cd(nFF{iii})
        %xo
        [sig1,sig2,ripple,cara,veamos,RipFreq2,timeasleep,~]=nrem_fixed_thr_Vfiles(chtm,notch);
        CHTM=[chtm chtm];
        
        %Fill table with ripple information.
        riptable(iii,1)=ripple;
        riptable(iii,2)=timeasleep;
        riptable(iii,3)=RipFreq2;

end


    %% Select time block (Not used now)
    if block_time==1
    [cara,veamos]=equal_time2(sig1,sig2,cara,veamos,30,0);
    ripple=sum(cellfun('length',cara{1}(:,1))); %Number of ripples after equal times.
    end

    if block_time==2
    [cara,veamos]=equal_time2(sig1,sig2,cara,veamos,60,30);
    ripple=sum(cellfun('length',cara{1}(:,1))); %Number of ripples after equal times.
    end

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
    xo
    clear sig1 sig2
    %Ripple selection. Memory free.
    if Rat~=24
    [p,q,sos]=ripple_selection(p,q,sos,Rat);
    end
    % 

    if iii~=2 && sanity==1 && quinientos==0 
     p=p(randrip);
     q=q(randrip);
    end

    %Equalize number of ripples. 
    if equal_num==1 %&& Rat~=24
       switch Rat
        case 24
            %n=550;
            n=308; %New value

        case 26
            n=180;
        case 27
            n=326;
        otherwise
            error('Error found')
       end

        p=p(1:n);
        q=q(1:n);


    end

    %Memory reasons:
    if length(p)>1000 && Rat~=24 %Novelty or Foraging
     p=p(1,1:1000);
     q=q(1,1:1000);
    end
    %Q=Q([ran]);
    %timecell=timecell([ran]);
    [q]=filter_ripples(q,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);
    %[p]=filter_ripples(q,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);

    %For Older version: Uncomment this.
    % P1=avg_samples(q,create_timecell(ro,length(p)));
    % P2=avg_samples(p,create_timecell(ro,length(p)));


    %[ripple,timeasleep,DEMAIS,y1]=NREM_newest_only_ripple_level(level,nrem,notch,w,lepoch,1);    
    %xo
    %Non learning condition.
    if acer==0
        cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
    else
        cd(strcat('D:\internship\',num2str(Rat)))
    end

    cd(nFF{1}) %Baseline

    %run('newest_load_data_nl.m')
    %[sig1_nl,sig2_nl,ripple2_nl,cara_nl,veamos_nl,CHTM_nl]=newest_only_ripple_nl;
    if win_ten==0 || win_ten==1 && iii==2

            if meth==1
            [sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,RipFreq3,timeasleep2]=newest_only_ripple_level_ERASETHIS(level);
            end

            if meth==2
                [sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,RipFreq3,timeasleep2]=median_std;    
            end

            if meth==3
            chtm=load('vq_loop2.mat');
            chtm=chtm.vq;
                [sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,RipFreq3,timeasleep2,~]=nrem_fixed_thr_Vfiles(chtm,notch);
            CHTM2=[chtm chtm];
            end

            if meth==4 
            [sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,RipFreq3,timeasleep2,~]=nrem_fixed_thr_Vfiles(chtm,notch);
            CHTM2=[chtm chtm];
            riptable(1,1)=ripple_nl;
            riptable(1,2)=timeasleep2;
            riptable(1,3)=RipFreq3;
            end
    end
    %%
    if block_time==1
    [cara_nl,veamos_nl]=equal_time2(sig1_nl,sig2_nl,cara_nl,veamos_nl,30,0);
    ripple_nl=sum(cellfun('length',cara_nl{1}(:,1)));
    end

    if block_time==2
    [cara_nl,veamos_nl]=equal_time2(sig1_nl,sig2_nl,cara_nl,veamos_nl,60,30);
    ripple_nl=sum(cellfun('length',cara_nl{1}(:,1)));    
    end

    consig=cara_nl{1};

    bon=consig(:,1:2);
    C = cellfun(@minus,bon(:,2),bon(:,1),'UniformOutput',false);
    C=cell2mat(C.');
    c=median(C)*1000; %Miliseconds
    cc(1)=c;


    % end
    %  save('thresholdfile.mat','ripple','timeasleep','DEMAIS','y1');                                                                                                                                                                                                                                                                                                                                               
    %%
    if rippletable==0
    %xo
    if win_ten==1    
       if spectra_winval==1    
                        % Call a new function to generate what Lisa asked. 
                        Zlim=[];
                        if iii==2
                        Zlim1=[];
                        Zlim2=[];
                        Zlim3=[];
                        Mdam1=[];
                        Mdam2=[];
                        Mdam3=[];
                        end

                        [zlim1,mdam1]=spectra_window(Rat,nFF,level,ro,1,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num);
                        [zlim2,mdam2]=spectra_window(Rat,nFF,level,ro,2,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num);
                        [zlim3,mdam3]=spectra_window(Rat,nFF,level,ro,3,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num);

                        Zlim1=[Zlim1 zlim1];
                        Zlim2=[Zlim2 zlim2];
                        Zlim3=[Zlim3 zlim3];

                        Mdam1=[Mdam1 mdam1];
                        Mdam2=[Mdam2 mdam2];
                        Mdam3=[Mdam3 mdam3];


                        % zlim{iii-1}=[zlim1; zlim2 ;zlim3];
       else
                        %        Zlim =[ 0.0118   48.7217; 0.0007    0.3018; 0.0002    0.1765];
                        %        Zlim =[  0.0074   48.6926; 0.0006    0.3018; 0.0002    0.1759];
                        [~]=spectra_window(Rat,nFF,level,ro,1,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num);
                        [~]=spectra_window(Rat,nFF,level,ro,2,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num);
                        [~]=spectra_window(Rat,nFF,level,ro,3,labelconditions,label1,label2,iii,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,spectra_winval,Zlim,win_comp,equal_num);       
       end
    else


    %%
    for w=2:3

    %%

    % h=plot_inter_conditions_33(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch);
    if sanity==1
    [h]=plot_inter_conditions_33(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath,randrip);
    %[h]=plot_inter_prueba(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,randrip);
    else
     P1=0;
     P2=0;
    xo

    [h]=plot_inter_conditions_33(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,rat24base,datapath);
    %[h]=plot_inter_prueba(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie);    
    end
    %h=plot_inter_conditions_filtering(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer);
    %xo
    %% Move statistics to the middle
    center_stats(h)
    %%

    %xo
    %error('stop')
    if acer==0
        cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
    else
          %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
          cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
    end

    % if Rat==24
    %     cd(nFF{1})
    % end

    if dura==2
        cd('10sec')
    end

    if sanity~=1
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

    string=strcat('Spec_removed_artifact_Newbase',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
    figure_function(gcf,[],string,[]);
    string=strcat('Spec_removed_artifact_Newbase',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.eps');
    print(string,'-depsc')
    string=strcat('Spec_removed_artifact_Newbase',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');
    saveas(gcf,string)

    end

    else
    if quinientos==0
    string=strcat('Control_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
    figure_function(gcf,[],string,[]);
    string=strcat('Control_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.eps');
    print(string,'-depsc')
    string=strcat('Control_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');
    saveas(gcf,string)
    else
    string=strcat('Control_500_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
    figure_function(gcf,[],string,[]);
    string=strcat('Control_500_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.eps');
    print(string,'-depsc')
    string=strcat('Control_500_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');
    saveas(gcf,string)

    end

    end
    %xo
    close all

    %%

    end
    %xo
    end
    end

    if iii==length(nFF)
       break 
    end
    %xo
    clear sig1_nl sig2_nl p q
    sig1_nl=[];
    sig2_nl=[];
    end

    end

    %%
    %clearvars -except acer Rat
    end
    %xo
    if win_ten==1
        if spectra_winval==1
            %xo
            Zlim=[min(Zlim1) max(Zlim1); min(Zlim2) max(Zlim2); min(Zlim3) max(Zlim3)];
            cd('C:\Users\addri\Dropbox\Window')
            cd(num2str(Rat))
                if equal_num==0
                     cd('all_rip')
                end

            if win_comp==1
                    save(strcat('Zlim_1sec.mat'),'Zlim')
            else
                    save(strcat('Zlim_100ms.mat'),'Zlim')
            end
            close all
        end
    end
    end
%xo

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

if win_comp==1
    printing('1sec')
else
    printing('100ms')
end
close all
        if win_comp==0
            Mdam=[Mdam1; Mdam2; Mdam3];
            save('Mdam.mat','Mdam')
        end        
end
xo
if meth==4

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

%end
xo
if rippletable==0
spec_loop_improve(RAT,block_time,sanity,dura,quinientos,outlie);
%save in right folder
list = dir();
list([list.isdir]) = [];
list={list.name};
FolderRip=[{'all_ripples'} {'500'} {'1000'}];
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

if meth==1
folder=strcat(Base{base},'_',FolderRip{FiveHun+1});
else
Method=[{'Method2' 'Method3' 'Method4'}];
folder=strcat(Base{base},'_',FolderRip{FiveHun+1},'_',Method{meth-1});    
end

if mergebaseline==1
    if meth==1
    folder=strcat('Merged','_',FolderRip{FiveHun+1});
    else
    Method=[{'Method2' 'Method3' 'Method4'}];
    folder=strcat('Merged','_',FolderRip{FiveHun+1},'_',Method{meth-1});    
    end
end

if exist(folder)~=7
(mkdir(folder))
end

for nmd=1:length(list)
movefile (list{nmd}, folder)
end


clearvars -except RAT acer DUR Block mergebaseline FiveHun meth block_time base rat26session3 rat27session3 randrip sanity
end
if base>=2
    break
end
base=2;
end
xo

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

%end
%end
