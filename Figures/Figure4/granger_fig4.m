close all
clear all

%Rat numbers
rats=[26 27 24 21]; 

% rat24base=1;
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
cluster_stats=0;
RAT24_test=1;


ripdur=1; % Duration of ripples. 

%Cross-frequency coupling variables. 
crosscop=0; % 1 for cross coupling analysis. 
cfc_stat=1; %Print statistics.
clus=0;%Cluster statistics.

old_analysis=0;
%xo
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
%for rat24base=1:1
     if Rat==24%Must be 2 for Rat 24.
            rat24base=2;
     else
            rat24base=1;
     end

  if Rat~=24 && rat24base==2
      break
  end

for dura=1:1 %Starts with 1

    
 % Folder names with data per rat.  
 [nFF,NFF,labelconditions,label1,label2]=rat_foldernames(Rat,rat26session3,rat27session3,rat24base);
      

%% Check if experiment has been run before.
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
%xo
% 
% %Ignore this for a moment
% FolderRip=[{'all_ripples'} {'500'} {'1000'}];
% if Rat==26
% Base=[{'Baseline1'} {'Baseline2'}];
% end
% 
% if Rat==26 && rat26session3==1
% Base=[{'Baseline3'} {'Baseline2'}];
% end
% 
% if Rat==27 
% Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
% end
% 
% if meth==1
% Folder=strcat(Base{base},'_',FolderRip{FiveHun+1});
% else
% Method=[{'Method2' 'Method3' 'Method4'}];
% Folder=strcat(Base{base},'_',FolderRip{FiveHun+1},'_',Method{meth-1});    
% end
% 
% if exist(Folder)==7 && base==1
% base=base+1;
% end
%%
 % Use other baseline, caution when using mergebaseline
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

%% Select experiment to perform. 
% inter=1;
%Select length of window in seconds:
if dura==1
ro=[1200];
%ro=[250];
else
ro=[10200];    
end
% coher=0;
% selectripples=1;
notch=0;
nrem=3;
% myColorMap = jet(8);
[myColorMap]=StandardColors;
% Score=1;
%%

%Make labels
label1=cell(7,1);
label1{1}='HPC';
label1{2}='HPC';
label1{3}='PAR';
label1{4}='PAR';
label1{5}='PFC';
label1{6}='PFC';
label1{7}='Reference';

label2=cell(7,1);
label2{1}='Monopolar';
label2{2}='Bipolar';
label2{3}='Monopolar';
label2{4}='Bipolar';
label2{5}='Monopolar';
label2{6}='Bipolar';
label2{7}='Monopolar';

%%
%xo
% myColorMap = jet(8);                                                                                                                                                                                    
% myColorMap =myColorMap([2 4 5 7],:);
% myColorMap(2,:)=[0, 204/255, 0];
% myColorMap(3,:)=[0.9290, 0.6940, 0.1250];

%Order changed
% nFF=nFF([1 4 3 2]);
% labelconditions=labelconditions([1 4 3 2]);


%Rat 24
% if Rat==24
%     myColorMap = jet(length(nFF));                                                                                                                                                                                    
% end

 
for block_time=0:0 %Should start with 0
 fl=waitbar(0,'Please wait...');   
for iii=1:length(nFF) %Should be 1 for Granger. 4 is faster though. Good for debugging. 
%for iii=1:1 %Should start with 2!
%for vert=2:length(nFF)
%Skip other conditions. 
% if iii==2
%     iii=4;
% end
    %xo
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

if iii==2 && sanity==1
   run('sanity_test.m');
end
% xo
% 
% string1=strcat('Spec_',labelconditions{iii},'_',label1{2*2-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
% string2=strcat('Spec_',labelconditions{iii},'_',label1{2*3-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
% 
% 
% while exist(string1, 'file')==2 && exist(string2, 'file')==2
% iii=iii+1;
% 
% if iii>length(nFF)
%     break
% end
%    string1=strcat('Spec_',labelconditions{iii},'_',label1{2*2-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
%    string2=strcat('Spec_',labelconditions{iii},'_',label1{2*3-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
% 
% end

if iii>length(nFF)
    break
end

% string=strcat('Spec_',labelconditions{iii},'_',label1{2*2-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
% if exist(string, 'file') == 2
% string=strcat('Spec_',labelconditions{iii},'_',label1{2*3-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');    
%       if exist(string, 'file') == 2
%            iii=iii+1;
%       end
% end
%  clearvars -except nFF iii labelconditions inter granger Rat ro label1 label2 coher selectripples acer mergebaseline nr_27 nr_26 co_26 co_27 nrem notch myColorMap



%for level=1:length(ripple)-1;    
 %for level=1:1
     

 
if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

%Change current folder according to Condition.    
cd(nFF{iii})
lepoch=2;

 level=1;
 
%Get averaged time signal.
% [sig1,sig2,ripple,cara,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);
% if strcmp(labelconditions{iii},'Baseline') || strcmp(labelconditions{iii},'PlusMaze')
% [ripple,timeasleep,DEMAIS,y1]=NREM_newest_only_ripple_level(level,nrem,notch,w,lepoch,Score);
% else
%xo
%[sig1,sig2,ripple,cara,veamos,CHTM,RipFreq2,timeasleep]=NREM_get_ripples(level,nrem,notch,w,lepoch,Score)
% [Sig1,Sig2,Ripple,cara,Veamos,CHTM2,RipFreq22,Timeasleep]=newest_only_ripple_level(level,lepoch)
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

        %xo
        if acer==0
            cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
        else
            cd(strcat('D:\internship\',num2str(Rat)))
        end

        cd(nFF{iii})
        %xo
        [sig1,sig2,ripple,cara,veamos,RipFreq2,timeasleep,~]=nrem_fixed_thr_Vfiles(chtm,notch);      
        CHTM=[chtm chtm]; %Threshold
        
        %Fill table with ripple information.
        riptable(iii,1)=ripple; %Number of ripples.
        riptable(iii,2)=timeasleep;
        riptable(iii,3)=RipFreq2;

end

%Nose=[Nose RipFreq2];


%% Select time block 
if block_time==1
[cara,veamos]=equal_time2(sig1,sig2,cara,veamos,30,0);
ripple=sum(cellfun('length',cara{1}(:,1))); %Number of ripples after equal times.
end

if block_time==2
[cara,veamos]=equal_time2(sig1,sig2,cara,veamos,60,30);
ripple=sum(cellfun('length',cara{1}(:,1))); %Number of ripples after equal times.
end

%%

%%
%xo
[p,q,~,sos]=getwin2(cara{1},veamos{1},sig1,sig2,ro);


%Ripple selection: Removes outliers and sorts ripples from strongest to weakest. 
if Rat~=24 || RAT24_test==1
[p,q,sos]=ripple_selection(p,q,sos,Rat);
end

if iii~=2 && sanity==1 && quinientos==0 %4 is Plusmaze! Changed it to 2.
 p=p(randrip);
 q=q(randrip);
end

%Equalize number of ripples. 
%(Same number of ripples found on Plusmaze after ripple selection). 
if equal_num==1 %&& Rat~=24
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

    p=p(1:n);
    q=q(1:n);

end
%xo
%Cross-coupling analysis. 
if crosscop==1
    
%     ache=max_outlier(p,Rat);
%     p=p(ache);
%     q=q(ache);
%     %Find strongests ripples. 
%     [p,q]=sort_rip(p,q);
[p,q,sos]=ripple_selection(p,q,sos,Rat);

[p]=filter_ripples(p,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);
[q]=filter_ripples(q,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);

%     [CFC]=crossfreq(p,0.5:0.5:15,30:1:100,ro,'coh');

%     [plv]=crossfreq(p,0.5:0.5:15,30:1:100,ro,'plv');
%     [mvl]=crossfreq(p,0.5:0.5:15,30:1:100,ro,'mvl');
%     [mi]=crossfreq(p,0.5:0.5:15,30:1:100,ro,'mi');

%Due to memory limits reduce this to same number of ripples as plusbase. 
%xo
if iii~=2 %Not Plusmaze
    if Rat==26
        n=180;
    end
    if Rat==27
        n=326;
    end
    if Rat==24
        n=133;
    end
            p=p(1:n);
            q=q(1:n);
end


if acer==0
    cd(strcat('/home/raleman/Dropbox/Figures/CrossFreqCoupling/',num2str(Rat)))
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd(strcat('C:\Users\addri\Dropbox\Figures\CrossFreqCoupling\',num2str(Rat)))   
end

%INTRA brain regions.
% plot_cross(CFC,1,label1) %HPC
% printing(strcat('CFC_',labelconditions{iii},'_',label1{1*2},'_vs_',label1{1*2}))
% close all
% 
% plot_cross(CFC,2,label1) %PAR
% printing(strcat('CFC_',labelconditions{iii},'_',label1{2*2},'_vs_',label1{2*2}))
% close all
% 
% plot_cross(CFC,3,label1) %PFC
% printing(strcat('CFC_',labelconditions{iii},'_',label1{3*2},'_vs_',label1{3*2}))
% close all
% save(strcat('CFC_',labelconditions{iii}),'CFC')
% clear CFC;
%xo

if cfc_stat==0

    %Inter brain regions 
    [hpc_LF,hpc_HF]=crossfreq_single(pchannel(p,1),0.5:0.5:15,30:1:100,ro);%HPC
    [par_LF,par_HF]=crossfreq_single(pchannel(p,2),0.5:0.5:15,30:1:100,ro);%PAR
    [pfc_LF,pfc_HF]=crossfreq_single(pchannel(p,3),0.5:0.5:15,30:1:100,ro);%PFC

    cfc_print(hpc_LF,hpc_HF,label1,labelconditions,iii,1,1);
    cfc_print(par_LF,par_HF,label1,labelconditions,iii,2,2);
    cfc_print(pfc_LF,pfc_HF,label1,labelconditions,iii,3,3);
    %MIXED hpc
    cfc_print(hpc_LF,par_HF,label1,labelconditions,iii,1,2);
    cfc_print(hpc_LF,pfc_HF,label1,labelconditions,iii,1,3);
    %Mixed par
    cfc_print(par_LF,hpc_HF,label1,labelconditions,iii,2,1);
    cfc_print(par_LF,pfc_HF,label1,labelconditions,iii,2,3);
    %mixed pfc
    cfc_print(pfc_LF,hpc_HF,label1,labelconditions,iii,3,1);
    cfc_print(pfc_LF,par_HF,label1,labelconditions,iii,3,2);
    
    
else
%Stats
%xo
firstrun=0;

if firstrun==1
%Inter brain regions 
% [hpc_LF,hpc_HF]=crossfreq_single(pchannel(p,1),0.5:0.5:15,30:1:100,ro);%HPC
% [par_LF,par_HF]=crossfreq_single(pchannel(p,2),0.5:0.5:15,30:1:100,ro);%PAR
% [pfc_LF,pfc_HF]=crossfreq_single(pchannel(p,3),0.5:0.5:15,30:1:100,ro);%PFC

[co_1_LF,co_1_HF]=crossfreq_single(pchannel(p,1),0.5:0.5:15,30:1:100,ro);%HPC
[co_2_LF,co_2_HF]=crossfreq_single(pchannel(p,2),0.5:0.5:15,30:1:100,ro);%PAR
[co_3_LF,co_3_HF]=crossfreq_single(pchannel(p,3),0.5:0.5:15,30:1:100,ro);%PFC

no=0;
f=waitbar(0,'Please wait...');
for n1=1:3
    for n2=1:3
        cfc_save(n1,n2,co_1_LF,co_2_LF,co_3_LF,co_1_HF,co_2_HF,co_3_HF,labelconditions,iii);
        no=no+1;
        progress_bar(no,9,f)
    end
end

xo
[hpc_hpc]=xfreq(co_1_LF,co_1_HF,'coh','yes');

%Calculate CFC
[hpc_hpc]=xfreq(hpc_LF,hpc_HF,'coh','yes');
save('1_1.mat','hpc_hpc')
clear hpc_hpc

[par_par]=xfreq(par_LF,par_HF,'coh','yes');
[pfc_pfc]=xfreq(pfc_LF,pfc_HF,'coh','yes');
%MIXED hpc
[hpc_par]=xfreq(hpc_LF,par_HF,'coh','yes');
[hpc_pfc]=xfreq(hpc_LF,pfc_HF,'coh','yes');
%MIXED par
[par_hpc]=xfreq(par_LF,hpc_HF,'coh','yes');
[par_pfc]=xfreq(par_LF,pfc_HF,'coh','yes');
%MIXED pfc
[pfc_hpc]=xfreq(pfc_LF,hpc_HF,'coh','yes');
[pfc_par]=xfreq(pfc_LF,par_HF,'coh','yes');


    

else
 
%  n1=1;
%  n2=1;
no=0;
f=waitbar(0,'Please wait...');

 for n1=1:3
     for n2=1:3
 av1=load(strcat(num2str(n1),'_',num2str(n2),'_Baseline','.mat'));
 av1=av1.dumvar;
 av2=load(strcat(num2str(n1),'_',num2str(n2),'_PlusMaze','.mat'));
 av2=av2.dumvar;
    
%%
% 
% xo
% 
% [hpc_LF,hpc_HF]=crossfreq_single(pchannel(p,1),0.5:0.5:15,30:1:100,ro);%HPC 
% [Hpc_hpc]=xfreq(hpc_LF,hpc_HF,'coh','yes');
% xo
% 
% av1=load('Hpc_hpc_base.mat'); 
% av1=av1.Hpc_hpc;
% av2=load('Hpc_hpc_plus.mat');%Plus
% av2=av2.Hpc_hpc;

AV1.powspctrm=(av1.crsspctrm);
AV1.dimord= 'rpt_chan_freq_time';
% je(1:size(AV1.powspctrm,1))=av1.label;
% AV1.label=je.';
% clear je
AV1.label=av1.label;
AV1.freq=av1.freqlow;
AV1.time=av1.freqhigh;


AV2.powspctrm=(av2.crsspctrm);
AV2.dimord= 'rpt_chan_freq_time';
% je(1:size(AV2.powspctrm,1))=av2.label;
% AV2.label=je.';
% clear je
AV2.label=av2.label;
AV2.freq=av2.freqlow;
AV2.time=av2.freqhigh;
xo
if clus==1
[stats]=stats_between_cfc(AV1,AV2,label1,1);

%%
allscreen()
cfg = [];
cfg.channel = label1{2*1-1}; %No use
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
cfg.zlim = 'maxabs';
cfg.colorbar       = 'yes';
cfg.colormap=colormap(jet(256));
%grid minor
ft_singleplotTFR(cfg, stats);

g=title(strcat(labelconditions{4},' vs No Learning'))
g.FontSize=12;
%title(strcat(labelconditions{iii},' vs No Learning'))
% n1=1;
% n2=1;

y=ylabel({'Freq (Hz)',label1{2*n1}})
x=xlabel({label1{2*n2},'Freq (Hz)'})
x.FontSize=12;
y.FontSize=12;
else
zmap=stats_high(AV1,AV2,1);

allscreen()
colormap(jet(256))
zmap(zmap == 0) = NaN;
J=imagesc(AV1.time,AV1.freq,zmap)
y=ylabel({'Freq (Hz)',label1{2*n1}})
x=xlabel({label1{2*n2},'Freq (Hz)'})
x.FontSize=12;
y.FontSize=12;
%title('tf power map, thresholded')
set(gca,'ydir','no')
% c=narrow_colorbar()
set(J,'AlphaData',~isnan(zmap))
g=title(strcat(labelconditions{4},' vs No Learning'))
g.FontSize=12;

c=colorbar();
cm=max(abs(c.Limits));
c.Limits=[-cm cm];
caxis([-cm cm])

g=title(strcat(labelconditions{iii},' vs No Learning'));
g.FontSize=12;

end
%xo

%%
if clus==1
    printing(strcat('CFC_Stats_',label1{n1*2},'_vs_',label1{n2*2}))
else
    printing(strcat('CFC_Stats_Pixel2_',label1{n1*2},'_vs_',label1{n2*2}))
end

close all
no=no+1;
progress_bar(no,9,f)

end
end
%xo


end
end

else %Not crossfreq. coupling
%xo

%Freeing Memory. Use maximum of 1000 strongests ripples. 
if length(p)>1000 && (Rat~=24|| RAT24_test==1) %Novelty or Foraging
 p=p(1,1:1000);
 q=q(1,1:1000);
end

[p]=filter_ripples(p,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);
[q]=filter_ripples(q,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);
    
    %GRANGER ANALYSIS    
    %Widepassed
    [gran,gran1,grangercon]=gc_paper(p,create_timecell(ro,length(p)),'Wideband',ro,10,[0:1:300],fn);
    %[gran,gran1,grangercon]=gc_paper(p,create_timecell(ro,length(p)),'Widepass',ro,10,[0:2:300]);

    g{iii}=gran.grangerspctrm;%Non-parametric (Pairwise)
    g1{iii}=gran1.grangerspctrm;%Parametric
    g2{iii}=grangercon.grangerspctrm;%Non-parametric (Conditional)
    %g3{iii}=gran1.grangerspctrm;
[FB{iii}]=gc_freqbands(gran,0);
[FB1{iii}]=gc_freqbands(gran1,0);
[FB2{iii}]=gc_freqbands(grangercon,1);
%xo

%     if iii==4
%         error('stop here')
%     end 
    
end



% %Bandpassed
% [Gran,Gran1]=gc_paper(q,create_timecell(ro,length(q)),'Widepass',ro,10,[100:1:300]);
% 
% G{iii}=Gran.grangerspctrm;
% G1{iii}=Gran1.grangerspctrm;
progress_bar(iii,length(nFF),fl)
end
%xo
end
end
%end
   break
end
%end

%Frequency ranges. 
g_f=gran.freq;
g1_f=gran1.freq;
% G_f=Gran.freq;
% G1_f=Gran1.freq;

%xo
%Plot 
%%
if acer==0
    cd(strcat('/home/raleman/Dropbox/Figures/Figure4/',num2str(Rat)))
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd(strcat('C:\Users\addri\Dropbox\Figures\Figure4\',num2str(Rat)))   
end
cd('April')
if equal_num==0
cd('All_ripples')    
end
% xo
save('FreqVal2.mat','FB','FB1','FB2')
xo
% C = cell(1,4);
% C{1}=convcond(g2{1});
% C{2}=convcond(g2{2});
% C{3}=convcond(g2{3});
% C{4}=convcond(g2{4});

% 
% [C{1:4}]=cellfun(@(x) convcond(x),g2,'UniformOutput',false);

%Prints 2D Granger for Baseline and Plusmaze plus their bootstrapped statistics. 
% granger_2D_baseplus_stats(g,g_f,labelconditions,[0 300]) %g1 looks better due to higher number of samples. 
% granger_2D_baseplus_stats(g1,g1_f,labelconditions,[0 300]) %g1 looks better due to higher number of samples. 
% granger_2D_baseplus_stats_only(g,g_f,labelconditions,[0 300],0) %g1 looks better due to higher number of samples. 
% granger_2D_baseplus_stats_only(g1,g1_f,labelconditions,[0 300],0) %g1 looks better due to higher number of samples. 


%Wideband
%Non-parametric (Pairwise)
 granger_paper4(g,g_f,labelconditions,[0 300]) %All
 printing('Non_parametric_Pairwise')
 close all
%  granger_baseline_learning(g,g_f,labelconditions,[0 300]) %Control and Plusmaze

%Individual plots (Not needed anymore)
% granger_paper4_row(g,g_f,labelconditions,[0 300],1)
% printing('I1_GC_NP_Widepass_1sec')
% close all
% granger_paper4_row(g,g_f,labelconditions,[0 300],2)
% printing('I2_GC_NP_Widepass_1sec')
% close all
% granger_paper4_row(g,g_f,labelconditions,[0 300],3)
% printing('I3_GC_NP_Widepass_1sec')
% close all 

 %To save time>
% g{2}=g{1};
% g{3}=g{1};
% g1{2}=g1{1};
% g1{3}=g1{1};

if old_analysis==1
% granger_baseline_learning_stats(g,g_f,labelconditions,[0 300],GRGRNP,GRGRNP_base,0.00000000005)
 granger_baseline_learning_stats(g,g_f,labelconditions,[0 300],GRGRNP,GRGRNP_base,0.00005)

 % granger_baseline_learning_stats(g1,g1_f,labelconditions,[0 300],GRGR,GRGR_base,0.00000000005)
 granger_baseline_learning_stats(g1,g1_f,labelconditions,[0 300],GRGR,GRGR_base,0.0001)

granger_paper4_with_stripes_dual(g,g_f,labelconditions,[0 300]) %Parametric (501 samples due to fs/2+1)
printing_image('Stripes_300_GC_NP_Widepass_1sec')

%printing_image('GC_NP_Widepass_1sec')
%printing_image('GC_NP_Widepass_0.5sec')
% printing_image('GC_NP_Widepass_0.25sec')
close all

granger_2D_testall(g,g_f,labelconditions,[0 300]) %g1 looks better due to higher number of samples. 
printing_image('GC2D_NP_Widepass_1sec')
close all

granger_baseline_learning(g1,g1_f,labelconditions,[0 300])
load('GRGR_base.mat');
load('GRGR.mat');
 granger_baseline_learning_stats(g1,g1_f,labelconditions,[0 300],GRGR,GRGR_base,0.00000000005)



granger_paper4_with_stripes(g1,g1_f,labelconditions,[0 300]) %Parametric (501 samples due to fs/2+1)
printing_image('Stripes_300_GC_P_Widepass_1sec')
% printing_image('GC_P_Widepass_1sec')
%printing_image('GC_P_Widepass_0.5sec')
% printing_image('GC_P_Widepass_0.25sec')
close all
%Individual plots 
granger_paper4_row(g1,g1_f,labelconditions,[0 300],1)
printing('I1_GC_P_Widepass_1sec')
close all
granger_paper4_row(g1,g1_f,labelconditions,[0 300],2)
printing('I2_GC_P_Widepass_1sec')
close all
granger_paper4_row(g1,g1_f,labelconditions,[0 300],3)
printing('I3_GC_P_Widepass_1sec')
close all

granger_2D_testall(g1,g1_f,labelconditions,[0 300]) %g1 looks better due to higher number of samples. 
printing_image('GC2D_P_Widepass_1sec')
close all

end

granger_2D_testall_nostats(g,g_f,labelconditions,[0 300],'yes') %g1 looks better due to higher number of samples. 
printing('GC2D_NP')
close all

granger_paper4(g1,g1_f,labelconditions,[0 300]) %Parametric (501 samples due to fs/2+1)
printing('Parametric')
close all

granger_2D_testall_nostats(g1,g1_f,labelconditions,[0 300],'yes') %g1 looks better due to higher number of samples. 
printing('GC2D_P')
close all



% granger_paper4(C,g_f,labelconditions,[0 300]) %Non-Parametric (Conditional)
granger_paper4_cond(g2,g_f,labelconditions,[0 300]) %Non-Parametric (Conditional)
printing('Non_parametric_Conditional')
close all
 
% granger_2D_testall_nostats(C,g_f,labelconditions,[0 300],'yes') %g1 looks better due to higher number of samples. 
% printing('GC2D_NP')
% close all


%Bandpass
if old_analysis==1
granger_paper4(G,G_f,labelconditions,[100 300])
granger_paper4_with_stripes(G,G_f,labelconditions,[100 300])
printing_image('Stripes_300_GC_NP_Bandpass_1sec')
% printing_image('GC_NP_Bandpass_1sec')
% printing_image('GC_NP_Bandpass_0.5sec')
% printing_image('GC_NP_Bandpass_0.25sec')
close all

granger_2D_testall(G,G_f,labelconditions,[100 300]) %g1 looks better due to higher number of samples. 
printing_image('GC2D_NP_Bandpass_1sec')
close all


granger_paper4(G1,G1_f,labelconditions,[100 300])
granger_paper4_with_stripes(G1,G1_f,labelconditions,[100 300])
printing_image('Stripes_300_GC_P_Bandpass_1sec')
% printing_image('GC_P_Bandpass_1sec')
% printing_image('GC_P_Bandpass_0.5sec')
% printing_image('GC_P_Bandpass_0.25sec')
close all

granger_2D_testall(G1,G1_f,labelconditions,[100 300]) %g1 looks better due to higher number of samples. 
printing_image('GC2D_P_Bandpass_1sec')
close all

%% 2D NO STATS ALL
granger_2D_baseplus_nostats(g,g_f,labelconditions,[0 300]) %g1 looks better due to higher number of samples. 
printing_image('GC2D_ns_baseplus_NP_Widepass_1sec')
close all

granger_2D_baseplus_nostats(g1,g1_f,labelconditions,[0 300]) %g1 looks better due to higher number of samples. 
printing_image('GC2D_ns_baseplus_P_Widepass_1sec')
close all

granger_2D_baseplus_nostats(G,G_f,labelconditions,[100 300]) %g1 looks better due to higher number of samples. 
printing_image('GC2D_ns_baseplus_NP_Bandpass_1sec')
close all

granger_2D_baseplus_nostats(G1,G1_f,labelconditions,[100 300]) %g1 looks better due to higher number of samples. 
printing_image('GC2D_ns_baseplus_P_Bandpass_1sec')
close all

%% 2D NO STATS ALL
granger_2D_testall_nostats(g,g_f,labelconditions,[0 300],'yes') %g1 looks better due to higher number of samples. 
printing_image('GC2D_ns_NP_Widepass_1sec')
close all

granger_2D_testall_nostats(g1,g1_f,labelconditions,[0 300],'yes') %g1 looks better due to higher number of samples. 
printing_image('GC2D_ns_P_Widepass_1sec')
close all

granger_2D_testall_nostats(G,G_f,labelconditions,[100 300],'yes') %g1 looks better due to higher number of samples. 
printing_image('GC2D_ns_NP_Bandpass_1sec')
close all

granger_2D_testall_nostats(G1,G1_f,labelconditions,[100 300],'yes') %g1 looks better due to higher number of samples. 
printing_image('GC2D_ns_P_Bandpass_1sec')
close all

%% Stats among conditions
F= [1 2; 1 3; 2 3] ;

lab{1}='HPC -> Parietal';
lab{2}='Parietal -> HPC';

lab{3}='HPC -> PFC';
lab{4}='PFC -> HPC';

lab{5}='Parietal -> PFC';
lab{6}='PFC -> Parietal';


lab2{1}='HPC_Parietal';
lab2{2}='Parietal_HPC';
lab2{3}='HPC_PFC';
lab2{4}='PFC_HPC';
lab2{5}='Parietal_PFC';
lab2{6}='PFC_Parietal';


for nv=1:3
f=F(nv,:); %Pair

%First direction
granger_2D_stats_conditions(g,g_f,labelconditions,[0 300],f)
mtit(lab{2*nv-1})
printing_image(strcat('Stat_',lab2{2*nv-1},'_','NP_Widepass_1sec'))
close all
%Opposite direction
granger_2D_stats_conditions(g,g_f,labelconditions,[0 300],flip(f))
mtit(lab{2*nv})
printing_image(strcat('Stat_',lab2{2*nv},'_','NP_Widepass_1sec'))
close all

%First direction
granger_2D_stats_conditions(g1,g1_f,labelconditions,[0 300],f)
mtit(lab{2*nv-1})
printing_image(strcat('Stat_',lab2{2*nv-1},'_','P_Widepass_1sec'))
close all

%Opposite direction
granger_2D_stats_conditions(g1,g1_f,labelconditions,[0 300],flip(f))
mtit(lab{2*nv})
printing_image(strcat('Stat_',lab2{2*nv},'_','P_Widepass_1sec'))
close all

% % % 
% % % %First direction
% % % granger_2D_stats_conditions(G,G_f,labelconditions,[100 300],f)
% % % mtit(lab{2*nv-1})
% % % printing_image(strcat('Stat_',lab2{2*nv-1},'_','NP_Bandpass_1sec'))
% % % close all
% % % 
% % % 
% % % %Opposite direction
% % % granger_2D_stats_conditions(G,G_f,labelconditions,[100 300],flip(f))
% % % mtit(lab{2*nv})
% % % printing_image(strcat('Stat_',lab2{2*nv},'_','NP_Bandpass_1sec'))
% % % close all
% % % 
% % % %First direction
% % % granger_2D_stats_conditions(G1,G1_f,labelconditions,[100 300],f)
% % % mtit(lab{2*nv-1})
% % % printing_image(strcat('Stat_',lab2{2*nv-1},'_','P_Bandpass_1sec'))
% % % close all
% % % 
% % % %Opposite direction
% % % granger_2D_stats_conditions(G1,G1_f,labelconditions,[100 300],flip(f))
% % % mtit(lab{2*nv})
% % % printing_image(strcat('Stat_',lab2{2*nv},'_','P_Bandpass_1sec'))
% % % close all

end
end
%%

% 
% %Non-parametric
% granger_paper2(gran,labelconditions{iii})
% hold on
% %Parametric
% granger_paper2(gran1,labelconditions{iii})
% hold on

%END 
%%
xo

xq=0:0.5:500;



%Q=Q([ran]);
%timecell=timecell([ran]);
%[p]=filter_ripples(q,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);

% %% PERIODOGRAM CODE
% clear U VQ MU
% 
% for k=1:length(q)
% % plot(q{k})   
% %  hold on
% % [fi,am]=periodogram(q{6});
%  [pxx,f]= periodogram(q{k},hann(length(q{k})),length(q{k}),1000);
% %  semilogy(f,(pxx))
%  vq1 = interp1(f,pxx,xq,'PCHIP');
%  VQ(k,:)=vq1;
% %  U(k)=interp1(VQ(k,:),xq,max(VQ(k,:)));
%  U(k)=interp1(VQ(k,:),xq,mean(VQ(k,:)));
% MU(k)=interp1(VQ(k,:),xq,max(VQ(k,:)));
%  %%
% %  semilogy(f,(pxx))
% %  hold on
% %  semilogy(xq,(vq1))
%  k/length(q)*100
% end
% UU{iii}=U;
% MUU{iii}=MU;
% %%
% 
% consig=cara{1};
% 
% bon=consig(:,1:2);
% C = cellfun(@minus,bon(:,2),bon(:,1),'UniformOutput',false);
% C=cell2mat(C.');
% data_SEM = std(C)/sqrt( length(C));       % SEM Across Columns
% CC{iii,:}=C;
% %xo
% c=median(C)*1000; %Miliseconds
% ccc=mean(C)*1000;
% % c=median(c)*1000; %Miliseconds
% cc(iii)=c;
% cccc(iii)=ccc;
% 
% consig=consig(:,3);
% 
% aver=cellfun(@(x) diff(x), consig,'UniformOutput',false);
% aver=[aver{:}];
% Aver{iii,:}=aver;
% Sem(iii,:)=data_SEM;
% 
% %lq(iii,:)=cellfun('length',q)/1000; %sec
% lq{iii}=cellfun('length',q)/1000; %sec
% %end
% %%
%  xo
% %%
% 
% if ripdur==1
% LQ = [lq(1,:) lq(2,:)  lq(3,:)  lq(4,:)];
%     
% grp = [zeros(1,size(lq,2)),ones(1,size(lq,2)),2*ones(1,size(lq,2)),3*ones(1,size(lq,2))];
% 
% bb=boxplot(LQ*1000,grp,'Notch','on' );
% %ylim([0 0.10*1000])
% ylim([0 160])
% set(bb(7,:),'Visible','off');
% ave=gca;
% ave.XTickLabel=labelconditions;
% ylabel('Time (ms)')
%    
%     
% end
% %% 
% UM = [UU{1} UU{2}  UU{3}  UU{4}];
% grp = [zeros(1,length(UU{1})),ones(1,length(UU{2})),2*ones(1,length(UU{3})),3*ones(1,length(UU{4}))];
% bb=boxplot(UM,grp,'Notch','on' );
% %set(bb(7,:),'Visible','off');
% ave=gca;
% ave.XTickLabel=labelconditions;
% ylabel('Frequency (Hz)')
% %ylim([60 300])
% %%
% UM = [MUU{1} MUU{2}  MUU{3}  MUU{4}];
% grp = [zeros(1,length(UU{1})),ones(1,length(UU{2})),2*ones(1,length(UU{3})),3*ones(1,length(UU{4}))];
% bb=boxplot(UM,grp,'Notch','on' );
% set(bb(7,:),'Visible','off');
% ave=gca;
% ave.XTickLabel=labelconditions;
% ylabel('Frequency (Hz)')
% %ylim([90 220])
% ylim([90 230])
% %% Violin
% violin(UU,[9 9 9 9],'facecolor',[[180/256 180/256 180/256];[38/256 43/256 226/256];[1 1 0];[0 0 0]],'medc','k','mc','')
% ave=gca;
% ylabel('Frequency (Hz)')
% ave.XTickLabel=[' '; labelconditions(1);' '; labelconditions(2);' '; labelconditions(3);' '; labelconditions(4);' ';];
% legend off
% %%
% violin(MUU,[5 5 5 5],'facecolor',[[180/256 180/256 180/256];[38/256 43/256 226/256];[1 1 0];[0 0 0]],'medc','k','mc','')
% ave=gca;
% ylabel('Frequency (Hz)')
% ave.XTickLabel=[' '; labelconditions(1);' '; labelconditions(2);' '; labelconditions(3);' '; labelconditions(4);' ';];
% legend off
% 
% %%
% if acer==0
%     cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
% else
%       %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
%       cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
% end
% %%
% if sanity==1
% 
% string=strcat('Control_Peak_Frequency_','Allconditions','_',Block{block_time+1},'_');
% printing(string);
% 
% else
% string=strcat('Peak_Frequency_','Allconditions','_',Block{block_time+1},'_');
% printing(string);
%     
% 
% string=strcat('Peak_Frequency_Violin_','Allconditions','_',Block{block_time+1},'_');
% printing(string);
% end
% %%
% if sanity==1
% 
% string=strcat('Control_Average_Frequency_','Allconditions','_',Block{block_time+1},'_');
% printing(string);
% 
% else
% string=strcat('Average_Frequency_','Allconditions','_',Block{block_time+1},'_');
% printing(string);
% 
% string=strcat('Average_Frequency_Violin_','Allconditions','_',Block{block_time+1},'_');
% printing(string);
% end
% %%
% %%
% xo
% %%
% string=strcat('Control_RippleDuration_','Allconditions','_',Block{block_time+1},'_');
% printing(string);
% 
% %%
% %%
% %histogram(aver,'Normalization','probability','BinWidth',0.1); xlim([0 4])
% 
% 
% %UNCOMMENT THE FOLLOWING>
% % % % % % % % % % % end
% % % % % % % % % % % end
% % % % % % % % % % % xo
% % % % % % % % % % % if iii==length(nFF)
% % % % % % % % % % %    break 
% % % % % % % % % % % end
% % % % % % % % % % % 
% % % % % % % % % % % end
% % % % % % % % % % % 
% % % % % % % % % % % end
% % % % % % % % % % % 
% % % % % % % % % % % %%
% % % % % % % % % % % %clearvars -except acer Rat
% % % % % % % % % % % end
% % % % % % % % % % % xo
% % % % % % % % % % % 
% % % % % % % % % % % %end
% % % % % % % % % % % %xo
