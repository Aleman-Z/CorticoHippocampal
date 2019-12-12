    'MERGING BASELINES'
    L1=length(p_nl);

    NU{1}=p_nl;
    QNU{1}=q_nl;
%% Other Baseline
    if acer==0
        cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
    else
        cd(strcat('D:\internship\',num2str(Rat)))
    end

    cd(NFF{1}) %Baseline

    % [sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,CHTM2,RipFreq3,timeasleep2]=newest_only_ripple_level_ERASETHIS(level);
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

        [timeasleep]=find_thr_base;
        ror=2000/timeasleep;

        if acer==0
            cd(strcat('/home/raleman/Dropbox/Figures/Figure2/',num2str(Rat)))
        else
              %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
              cd(strcat('C:\Users\addri\Dropbox\Figures\Figure2\',num2str(Rat)))   
        end

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

    base=2; %VERY IMPORTANT!
    %openfig('Ripples_per_condition_best.fig')
    h=openfig(strcat('Ripples_per_condition_',Base{base},'.fig'))

    %h = gcf; %current figure handle
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes

    ydata=dataObjs{2}(8).YData;
    xdata=dataObjs{2}(8).XData;
    % figure()
    % plot(xdata,ydata)
    chtm = interp1(ydata,xdata,ror);
    close(h)

    if acer==0
        cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
    else
        cd(strcat('D:\internship\',num2str(Rat)))
    end
    cd(NFF{1})

    %xo
    [sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,RipFreq3,timeasleep2,~]=nrem_fixed_thr_Vfiles(chtm,notch);
    CHTM2=[chtm chtm];
    end

if meth==5
chtm=30;
        if acer==0
            cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
        else
            cd(strcat(datapath,'/',num2str(Rat)))
        end

        cd(nFF{1})
        
    [sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,RipFreq3,timeasleep2,~,~, ~ ,~,~,~,~,~,~]=nrem_fixed_thr_Vfiles(chtm,notch,w);      
    CHTM2=[chtm chtm]; %Threshold
    
end
%This seems incomplete:
% if meth==4
% [sig1_nl,sig2_nl,ripple_nl,cara_nl,veamos_nl,RipFreq3,timeasleep2,~]=nrem_fixed_thr_Vfiles(chtm,notch);
% CHTM2=[chtm chtm];
% end

if block_time==1
[cara_nl,veamos_nl]=equal_time2(sig1_nl,sig2_nl,cara_nl,veamos_nl,30,0);
ripple_nl=sum(cellfun('length',cara_nl{1}(:,1)));
end

if block_time==2
[cara_nl,veamos_nl]=equal_time2(sig1_nl,sig2_nl,cara_nl,veamos_nl,60,30);
ripple_nl=sum(cellfun('length',cara_nl{1}(:,1)));    
end

%[p_nl,q_nl,~,~]=getwin2(cara_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),CHTM2(level+1));
[p_nl,q_nl,~,~]=getwin2(cara_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,ro);

%%
clear sig1_nl sig2_nl

if quinientos==0
[ran_nl]=select_rip(p_nl,FiveHun);
p_nl=p_nl([ran_nl]);
q_nl=q_nl([ran_nl]);

else
     if iii~=2
        [ran_nl]=select_quinientos(p_nl,length(randrip)); 
        p_nl=p_nl([ran_nl]);
        q_nl=q_nl([ran_nl]);
     %    ran=1:length(randrip);
     end
end

%timecell_nl=timecell_nl([ran_nl]);
if sanity==1 && quinientos==0
 p_nl=p_nl(randrip);
 q_nl=q_nl(randrip);
end

%%
[q_nl]=filter_ripples(q_nl,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);

NU{2}=p_nl;
QNU{2}=q_nl;
L2=length(p_nl);
amount=min([L1 L2]);
 
% p_nl(1:amount)=NU{1}(1:amount);
% p_nl(amount+1:2*amount)=NU{2}(1:amount);

p_nl(1:2*amount)=[NU{1}(1:amount) NU{1}(1:amount)];
p_nl(2:2:end)=[NU{2}(1:length(p_nl(2:2:end)))];


% q_nl(1:amount)=QNU{1}(1:amount);
% q_nl(amount+1:2*amount)=QNU{2}(1:amount);
q_nl(1:2*amount)=[QNU{1}(1:amount) QNU{1}(1:amount)];
q_nl(2:2:end)=[QNU{2}(1:length(q_nl(2:2:end)))];
