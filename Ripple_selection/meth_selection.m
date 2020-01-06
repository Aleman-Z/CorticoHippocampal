%Methods of ripples selection
function [sig1,sig2,ripple,cara,veamos,RipFreq2,timeasleep,ti,vec_nrem, vec_trans ,vec_rem,vec_wake,labels,transitions,transitions2,ripples_times,riptable,chtm,CHTM]=meth_selection(meth,level,notch,Rat,datapath,nFF,acer,iii,w,rat26session3,base,rat27session3)
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
            %Find threshold on Baseline which gives 2000 ripples during the whole NREM.
            if acer==0
                cd(strcat('/home/adrian/Documents/downsampled_NREM_data/',num2str(Rat)))
            else
                cd(strcat(datapath,'/',num2str(Rat)))
            end

            cd(nFF{1}) %Baseline

            [timeasleep]=find_thr_base;
            ror=2000/timeasleep; %2000 Ripples during whole NREM sleep.

            %Find thresholds vs ripple freq plot.
            if acer==0
                cd(strcat('/home/adrian/Dropbox/Figures/Figure2/',num2str(Rat)))
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

            h=openfig(strcat('Ripples_per_condition_',Base{base},'.fig'))

            %h = gcf; %current figure handle
            axesObjs = get(h, 'Children');  %axes handles
            dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes

            ydata=dataObjs{2}(8).YData;
            xdata=dataObjs{2}(8).XData;

            chtm = interp1(ydata,xdata,ror); %Interpolate for value ror.
            close(h)

            %xo
            if acer==0
                cd(strcat('/home/adrian/Documents/downsampled_NREM_data/',num2str(Rat)))
            else
                cd(strcat(datapath,'/',num2str(Rat)))
            end

            cd(nFF{iii})
            w='HPC';
            [sig1,sig2,ripple,cara,veamos,RipFreq2,timeasleep,ti,vec_nrem, vec_trans ,vec_rem,vec_wake,labels,transitions,transitions2,ripples_times]=nrem_fixed_thr_Vfiles(chtm,notch,w);      
            CHTM=[chtm chtm]; %Threshold

            %Fill table with ripple information.
            riptable(iii,1)=ripple; %Number of ripples.
            riptable(iii,2)=timeasleep;
            riptable(iii,3)=RipFreq2;

       case 5

    % if Rat~=24
     chtm=20;
    % chtm=25;
    % else
%     chtm=35;    
    % end
    % chtm=10;

            if acer==0
                cd(strcat('/home/adrian/Documents/downsampled_NREM_data/',num2str(Rat)))
            else
                cd(strcat(datapath,'/',num2str(Rat)))
            end

            cd(nFF{iii})

            [sig1,sig2,ripple,cara,veamos,RipFreq2,timeasleep,ti,vec_nrem, vec_trans ,vec_rem,vec_wake,labels,transitions,transitions2,ripples_times]=nrem_fixed_thr_Vfiles(chtm,notch,w);      
            CHTM=[chtm chtm]; %Threshold

            %Fill table with ripple information.
            riptable(iii,1)=ripple; %Number of ripples.
            riptable(iii,2)=timeasleep;
            riptable(iii,3)=RipFreq2;
    %          continue
    end
end