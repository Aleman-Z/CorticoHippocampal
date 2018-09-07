%This one requires running data from Non Learning condition
function plot_inter_high_improve(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,timecell,sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer,block_time,NFF,mergebaseline,FiveHun,meth,rat26session3,rat27session3,notch,sanity,quinientos,outlie,varargin)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % cd(nFF{3})
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %run('newest_load_data_nl.m')
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %[sig1_nl,sig2_nl,ripple2_nl,carajo_nl,veamos_nl,CHTM_nl]=newest_only_ripple_nl;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2]=newest_only_ripple_nl;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % ripple3=ripple_nl;
% ripple3=ripple_nl;
%ran=randi(length(p),100,1);
randrip=varargin;
randrip=cell2mat(randrip);

% % % % % % % sig1_nl=cell(7,1);
% % % % % % % 
% % % % % % % sig1_nl{1}=Mono17_nl;
% % % % % % % sig1_nl{2}=Bip17_nl;
% % % % % % % sig1_nl{3}=Mono12_nl;
% % % % % % % sig1_nl{4}=Bip12_nl;
% % % % % % % sig1_nl{5}=Mono9_nl;
% % % % % % % sig1_nl{6}=Bip9_nl;
% % % % % % % sig1_nl{7}=Mono6_nl;
% % % % % % % 
% % % % % % % 
% % % % % % % sig2_nl=cell(7,1);
% % % % % % % 
% % % % % % % sig2_nl{1}=V17_nl;
% % % % % % % sig2_nl{2}=S17_nl;
% % % % % % % sig2_nl{3}=V12_nl;
% % % % % % % % sig2{4}=R12;
% % % % % % % sig2_nl{4}=S12_nl;
% % % % % % % %sig2{6}=SSS12;
% % % % % % % sig2_nl{5}=V9_nl;
% % % % % % % % sig2{7}=R9;
% % % % % % % sig2_nl{6}=S9_nl;
% % % % % % % %sig2{10}=SSS9;
% % % % % % % sig2_nl{7}=V6_nl;
% % % % % % %  
% % % % % % % % ripple=length(M);
% % % % % % % 
% % % % % % % %Number of ripples per threshold.
% % % % % % % ripple_nl=sum(s17_nl);

% [p_nl,q_nl,timecell_nl,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),thr_nl(level+1));
%This one:
% % % [p_nl,q_nl,~,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),CHTM2(level+1));

% if meth==3
% [p_nl,q_nl,~,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),chtm);        
% else
[p_nl,q_nl,~,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),CHTM2(level+1));    
% end

if quinientos==0
    
if outlie==1 
ache=max_outlier(p_nl);
p_nl=p_nl(ache);
q_nl=q_nl(ache);
end
    
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

if sanity==1 && quinientos==0
 p_nl=p_nl(randrip);
 q_nl=q_nl(randrip);
end

[q_nl]=filter_ripples(q_nl,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);

if mergebaseline==1
%% 
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

% [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,RipFreq3,timeasleep2]=newest_only_ripple_level_ERASETHIS(level);
if meth==1
[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,RipFreq3,timeasleep2]=newest_only_ripple_level_ERASETHIS(level);
end

if meth==2
[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,RipFreq3,timeasleep2]=median_std;
end

if meth==3
chtm=load('vq_loop2.mat');
chtm=chtm.vq;
[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq3,timeasleep2,~]=nrem_fixed_thr_Vfiles(chtm,notch);
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

if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end
cd(NFF{1})

%xo
[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq3,timeasleep2,~]=nrem_fixed_thr_Vfiles(chtm,notch);
CHTM2=[chtm chtm];
end
%This seems incomplete:
% if meth==4
% [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq3,timeasleep2,~]=nrem_fixed_thr_Vfiles(chtm,notch);
% CHTM2=[chtm chtm];
% end

if block_time==1
[carajo_nl,veamos_nl]=equal_time2(sig1_nl,sig2_nl,carajo_nl,veamos_nl,30,0);
ripple_nl=sum(cellfun('length',carajo_nl{1}(:,1)));
end

if block_time==2
[carajo_nl,veamos_nl]=equal_time2(sig1_nl,sig2_nl,carajo_nl,veamos_nl,60,30);
ripple_nl=sum(cellfun('length',carajo_nl{1}(:,1)));    
end

[p_nl,q_nl,~,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),CHTM2(level+1));
% [ran_nl]=select_rip(p_nl,FiveHun);
% 
% p_nl=p_nl([ran_nl]);
% q_nl=q_nl([ran_nl]);
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

if sanity==1 && quinientos==0
 p_nl=p_nl(randrip);
 q_nl=q_nl(randrip);
end

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
    
    
end

%cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

%cd(strcat('D:\internship\',num2str(Rat)))
cd(nFF{iii})


%% Time Frequency plots

%Calculate Freq3 and Freq4
%toy=[-1:.01:1];
if ro==1200
toy=[-1:.01:1];
else
%toy=[-10:.1:10];
toy=[-10:.01:10];
end

if length(q)>length(q_nl)
q=q(1:length(q_nl));        
% timecell=timecell(1:length(q_nl));
end

if length(q)<length(q_nl)
q_nl=q_nl(1:length(q));
% timecell_nl=timecell_nl(1:length(q));
end

if ro==1200
freq3=barplot2_ft(q_nl,create_timecell(ro,length(q_nl)),[100:1:300],w,toy);
freq4=barplot2_ft(q,create_timecell(ro,length(q)),[100:1:300],w,toy);
else
freq3=barplot2_ft(q_nl,create_timecell(ro,length(q_nl)),[100:2:300],w,toy); %Memory reasons
freq4=barplot2_ft(q,create_timecell(ro,length(q)),[100:2:300],w,toy);
end

%%
zmap=stats_high(freq3,freq4,w);

subplot(3,4,12);

colormap(jet(256))
zmap(zmap == 0) = NaN;
J=imagesc(freq3.time,freq3.freq,zmap)
xlabel('Time (s)'), ylabel('Frequency (Hz)')
%title('tf power map, thresholded')
set(gca,'xlim',xlim,'ydir','no')
% c=narrow_colorbar()
set(J,'AlphaData',~isnan(zmap))
c=narrow_colorbar()
 c.YLim=[-max(abs(c.YLim)) max(abs(c.YLim))];
caxis([-max(abs(c.YLim)) max(abs(c.YLim))])
c=narrow_colorbar()

g=title(strcat(labelconditions{iii},' vs No Learning'));
g.FontSize=12;

%% 
 
%  
% cfg = [];
% cfg.channel = label1{2*w-1};
% cfg.parameter = 'stat';
% cfg.maskparameter = 'mask';
% cfg.zlim = 'maxabs';
% cfg.colorbar       = 'yes';
% cfg.colormap=colormap(jet(256));
% %grid minor
% ft_singleplotTFR(cfg, stats1);
% %title('Ripple vs No Ripple')
% g=title(strcat(labelconditions{iii},' vs No Learning'));
% g.FontSize=12;
% %title(strcat(labelconditions{iii},' vs No Learning'))
% xlabel('Time (s)')
% %ylabel('uV')
% ylabel('Frequency (Hz)')

%% EXTRA STATISTICS
% [stats1]=stats_between_trials(freq30,freq40,label1,w);
% % %
%  subplot(3,4,11)
% cfg = [];
% cfg.channel = label1{2*w-1};
% cfg.parameter = 'stat';
% cfg.maskparameter = 'mask';
% cfg.zlim = 'maxabs';
% cfg.colorbar       = 'yes';
% cfg.colormap=colormap(jet(256));
% grid minor
% ft_singleplotTFR(cfg, stats1);
% %title('Ripple vs No Ripple')
% title(strcat(labelconditions{iii-3},' vs No Learning (Baseline)'))
%title(strcat(labelconditions{iii},' vs No Learning'))
%%
% [stats1]=stats_between_trials(freq10,freq20,label1,w);
% % %
%  subplot(3,4,9)
% cfg = [];
% cfg.channel = label1{2*w-1};
% cfg.parameter = 'stat';
% cfg.maskparameter = 'mask';
% cfg.zlim = 'maxabs';
% cfg.colorbar       = 'yes';
% cfg.colormap=colormap(jet(256));
% grid minor
% ft_singleplotTFR(cfg, stats1);
% %title('Ripple vs No Ripple')
% title(strcat(labelconditions{iii-3},' vs No Learning (Baseline)'))
% %title(strcat(labelconditions{iii},' vs No Learning'))

%%
% %% Baseline parameters
% mtit('No Learning:','fontsize',14,'color',[1 0 0],'position',[.1 0.25 ])
% 
% mtit(strcat('Events:',num2str(ripple3(level))),'fontsize',14,'color',[1 0 0],'position',[.1 0.10 ])
% labelthr=strcat('Thr:',num2str(round(CHTM2(level+1))));
% mtit(strcat(labelthr),'fontsize',14,'color',[1 0 0],'position',[.1 0.15 ])
% 
% mtit(strcat(label1{2*w-1},' (',label2{1},')'),'fontsize',14,'color',[1 0 0],'position',[.1 0.2 ])
% 
% 
% mtit(strcat('Rip/sec:',num2str(RipFreq3(level))),'fontsize',14,'color',[1 0 0],'position',[.1 0.05 ])
% 
% 
% mtit(cell2mat(strcat({'Sleep:'},{num2str(timeasleep2)},{' '},{'min'})),'fontsize',14,'color',[1 0 0],'position',[.1 0.005 ])
% 
% %% Condition
% mtit(labelconditions{iii-3},'fontsize',14,'color',[1 0 0],'position',[.65 0.25 ])
% 
% mtit(strcat('Events:',num2str(ripple(level))),'fontsize',14,'color',[1 0 0],'position',[.65 0.10 ])
% labelthr=strcat('Thr:',num2str(round(CHTM(level+1))));
% mtit(strcat(labelthr),'fontsize',14,'color',[1 0 0],'position',[.65 0.15 ])
% 
% mtit(strcat(label1{2*w-1},' (',label2{1},')'),'fontsize',14,'color',[1 0 0],'position',[.65 0.2 ])
% 
% mtit(strcat('Rip/sec:',num2str(RipFreq2(level))),'fontsize',14,'color',[1 0 0],'position',[.65 0.05 ])
% 
% mtit(cell2mat(strcat({'Sleep:'},{num2str(timeasleep)},{' '},{'min'})),'fontsize',14,'color',[1 0 0],'position',[.65 0.005 ])

end