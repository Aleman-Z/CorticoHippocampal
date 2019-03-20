% 
%     if meth==1
%         [sig1,sig2,ripple,cara,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level_ERASETHIS(level);
%     %     [Nsig1,Nsig2,Nripple,Ncara,Nveamos,NCHTM,NRipFreq2,Ntimeasleep]=newest_only_ripple_nl_level(level);
%     end
% 
%     if meth==2
%         [sig1,sig2,ripple,cara,veamos,CHTM,RipFreq2,timeasleep]=median_std;    
%     end

%     if meth==3
%     chtm=load('vq_loop2.mat');
%     chtm=chtm.vq;
%         [sig1,sig2,ripple,cara,veamos,RipFreq2,timeasleep,~]=nrem_fixed_thr_Vfiles(chtm,notch);
%     CHTM=[chtm chtm];
%     end
    %%
    if meth==4   
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
    riptable(iii,1)=ripple;
    riptable(iii,2)=timeasleep;
    riptable(iii,3)=RipFreq2;

    end
