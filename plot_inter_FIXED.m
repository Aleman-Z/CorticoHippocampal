%This one requires running data from Non Learning condition
function plot_inter_FIXED(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,timecell,sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,q,selectripples,acer,timecell_nl,P1_nl,P2_nl,p_nl,q_nl,freq1,freq3,freq2,freq4)
%function plot_inter_conditions_27(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,timecell,sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,selectripples)

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % cd(nFF{3})
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %run('newest_load_data_nl.m')
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %[sig1_nl,sig2_nl,ripple2_nl,carajo_nl,veamos_nl,CHTM_nl]=newest_only_ripple_nl;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2]=newest_only_ripple_nl;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % ripple3=ripple_nl;

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % ripple3=ripple_nl;

%ran=randi(length(p),100,1);

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

% % % % % % % % % % % % % % [p_nl,q_nl,timecell_nl,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),CHTM2(level+1));
% % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % load(strcat('randnum2_',num2str(level),'.mat'))
% % % % % % % % % % % % % % % % % % % ran_nl=ran;
% % % % % % % % % % % % % % if selectripples==1
% % % % % % % % % % % % % % 
% % % % % % % % % % % % % % [ran_nl]=rip_select(p);
% % % % % % % % % % % % % % % av=cat(1,p_nl{1:end});
% % % % % % % % % % % % % % % %av=cat(1,q_nl{1:end});
% % % % % % % % % % % % % % % av=av(1:3:end,:); %Only Hippocampus
% % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % %AV=max(av.');
% % % % % % % % % % % % % % % %[B I]= maxk(AV,1000);
% % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % %AV=max(av.');
% % % % % % % % % % % % % % % %[B I]= maxk(max(av.'),1000);
% % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % [ach]=max(av.');
% % % % % % % % % % % % % % % achinga=sort(ach,'descend');
% % % % % % % % % % % % % % % achinga=achinga(1:1000);
% % % % % % % % % % % % % % % B=achinga;
% % % % % % % % % % % % % % % I=nan(1,length(B));
% % % % % % % % % % % % % % % for hh=1:length(achinga)
% % % % % % % % % % % % % % %    % I(hh)= min(find(ach==achinga(hh)));
% % % % % % % % % % % % % % % I(hh)= find(ach==achinga(hh),1,'first');
% % % % % % % % % % % % % % % end
% % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % [ajal ind]=unique(B);
% % % % % % % % % % % % % % % if length(ajal)>500
% % % % % % % % % % % % % % % ajal=ajal(end-499:end);
% % % % % % % % % % % % % % % ind=ind(end-499:end);
% % % % % % % % % % % % % % % end
% % % % % % % % % % % % % % % dex=I(ind);
% % % % % % % % % % % % % % % ran_nl=dex.';
% % % % % % % % % % % % % % 
% % % % % % % % % % % % % % p_nl=p_nl([ran_nl]);
% % % % % % % % % % % % % % q_nl=q_nl([ran_nl]);
% % % % % % % % % % % % % % timecell_nl=timecell_nl([ran_nl]);
% % % % % % % % % % % % % % 
% % % % % % % % % % % % % % 
% % % % % % % % % % % % % % end


%Need: P1, P2 ,p, q. 
% % % % % % % % % % % % % P1_nl=avg_samples(q_nl,timecell_nl);
% % % % % % % % % % % % % P2_nl=avg_samples(p_nl,timecell_nl);
% % % if acer==0
% % %     cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
% % % 
% % % else
% % %     cd(strcat('D:\internship\',num2str(Rat)))    
% % % end
% % % cd(nFF{iii})

%%
%Plot both: No ripples and Ripples. 
allscreen()
H1=subplot(3,4,1);
plot(timecell_nl{1},P2_nl(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
Hc1=narrow_colorbar();
title('Wide Band NO Learning')
win1=[min(P2_nl(w,:)) max(P2_nl(w,:)) min(P2(w,:)) max(P2(w,:))];
win1=[(min(win1)) round(max(win1))];
ylim(win1)

%%
H3=subplot(3,4,3)
plot(timecell_nl{1},P1_nl(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
Hc3=narrow_colorbar()
title('High Gamma NO Learning')

win2=[min(P1_nl(w,:)) max(P1_nl(w,:)) min(P1(w,:)) max(P1(w,:))];
win2=[(min(win2)) (max(win2))];
ylim(win2)

%%

H2=subplot(3,4,2)
plot(timecell{1},P2(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
Hc2=narrow_colorbar()
title(strcat('Wide Band',{' '},labelconditions{iii-3}))
%title(strcat('Wide Band',{' '},labelconditions{iii}))
ylim(win1)

%%
H4=subplot(3,4,4)
plot(timecell{1},P1(w,:))
xlim([-1,1])
%xlim([-0.8,0.8])
grid minor
Hc4=narrow_colorbar()
%title('High Gamma RIPPLE')
title(strcat('High Gamma',{' '},labelconditions{iii-3}))
%title(strcat('High Gamma',{' '},labelconditions{iii}))
ylim(win2)

%% Time Frequency plots
% Calculate Freq1 and Freq2
toy = [-1.2:.01:1.2];

% if selectripples==1
% 
%     if length(p)>length(p_nl)
%     p=p(1:length(p_nl));        
%     timecell=timecell(1:length(p_nl));
%     end
% 
%     if length(p)<length(p_nl)
%     p_nl=p_nl(1:length(p));
%     timecell_nl=timecell_nl(1:length(p));
%     end
% end

%This is what I uncommented:
% freq1=justtesting(p_nl,timecell_nl,[1:0.5:30],w,10,toy);
% freq2=justtesting(p,timecell,[1:0.5:30],w,0.5,toy);
 
% FREQ1=justtesting(p_nl,timecell_nl,[0.5:0.5:30],w,10,toy);
% FREQ2=justtesting(p,timecell,[0.5:0.5:30],w,0.5,toy);


% Calculate zlim
%% Baseline normalization (UNCOMMENT THE NEXT LINES IF YOU NEED IT)
% % % % % % % % % % % % % % % % % % % % % % % % cfg=[];
% % % % % % % % % % % % % % % % % % % % % % % % cfg.baseline=[-1 -0.5];
% % % % % % % % % % % % % % % % % % % % % % % % %cfg.baseline='yes';
% % % % % % % % % % % % % % % % % % % % % % % % cfg.baselinetype ='db';
% % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % freq10=ft_freqbaseline(cfg,freq1);
% % % % % % % % % % % % % % % % % % % % % % % % freq20=ft_freqbaseline(cfg,freq2);
% % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % [achis]=baseline_norm(freq1,w);
% % % % % % % % % % % % % % % % % % % % % % % % [achis2]=baseline_norm(freq2,w);
% % % % % % % % % % % % % % % % % % % % % % % % climdb=[-3 3];



% Freq10=ft_freqbaseline(cfg,FREQ1);
% Freq20=ft_freqbaseline(cfg,FREQ2);

%%
% % % % % cfg              = [];
% % % % % cfg.channel      = freq1.label{w};
% % % % % [ zmin1, zmax1] = ft_getminmax(cfg, freq10);
% % % % % [zmin2, zmax2] = ft_getminmax(cfg, freq20);
% % % % % 
% % % % % zlim=[min([zmin1 zmin2]) max([zmax1 zmax2])];
% % % % % 
% % % % % zlim=[-max(abs(zlim)) max(abs(zlim))];

%%
% % % % % % % % % % % % % % % % % % % cfg              = [];
% % % % % % % % % % % % % % % % % % % cfg.zlim=zlim;% Uncomment this!
% % % % % % % % % % % % % % % % % % % cfg.channel      = freq1.label{w};
% % % % % % % % % % % % % % % % % % % cfg.colormap=colormap(jet(256));

% % cfg.baseline       = 'yes';
% % % cfg.baseline       = [ -0.1];
% % 
% % cfg.baselinetype   =  'absolute'; 
% % cfg.renderer       = [];
% % %cfg.renderer       = 'painters', 'zbuffer', ' opengl' or 'none' (default = [])
% %     cfg.colorbar       = 'yes';

%% NEW SECTION I ADDED
achis=freq1.powspctrm;
achis=squeeze(mean(achis,1));
achis=squeeze(achis(w,:,:));

achis2=freq2.powspctrm;
achis2=squeeze(mean(achis2,1));
achis2=squeeze(achis2(w,:,:));


%%
ax1 =subplot(3,4,5);
contourf(toy,freq1.freq,achis,40,'linecolor','none'); 
colormap(jet(256));%narrow_colorbar();
% set(gca,'clim',climdb,'ydir','normal','xlim',[-1 1])
set(gca,'ydir','normal','xlim',[-1 1])


c1=colorbar();

h1 = get(H1, 'position'); % get axes position
hn1= get(Hc1, 'Position'); % Colorbar Width for c1


x1 = get(ax1, 'position'); % get axes position
cw1= get(c1, 'Position'); % Colorbar Width for c1


cw1(3)=hn1(3);
cw1(1)=hn1(1);
set(c1,'Position',cw1)
 

x1(3)=h1(3);
set(ax1,'Position',x1)

% freq1=justtesting(p_nl,timecell_nl,[1:0.5:30],w,10)
title('Wide Band NO Learning')
%xlim([-1 1])
%%
% subplot(3,4,6)
%%ft_singleplotTFR(cfg, freq20); 

ax2 =subplot(3,4,6);
contourf(toy,freq2.freq,achis2,40,'linecolor','none'); 
colormap(jet(256));%narrow_colorbar();
%set(gca,'clim',climdb,'ydir','normal','xlim',[-1 1])
set(gca,'ydir','normal','xlim',[-1 1])


c2=colorbar();

h2 = get(H2, 'position'); % get axes position
hn2= get(Hc2, 'Position'); % Colorbar Width for c1


x2 = get(ax2, 'position'); % get axes position
cw2= get(c2, 'Position'); % Colorbar Width for c1


cw2(3)=hn2(3);
cw2(1)=hn2(1);
set(c2,'Position',cw2)
 

x2(3)=h2(3);
set(ax2,'Position',x2)

% freq2=justtesting(p,timecell,[1:0.5:30],w,0.5)
%title('Wide Band RIPPLE')
title(strcat('Wide Band',{' '},labelconditions{iii-3}))
%title(strcat('Wide Band',{' '},labelconditions{iii}))

xlim([-1 1])

%%
%
[stats]=stats_between_trials(freq1,freq2,label1,w);
% 
 subplot(3,4,10)
% 
cfg = [];
cfg.channel = label1{2*w-1};
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
cfg.zlim = 'maxabs';
cfg.colorbar       = 'yes';
cfg.colormap=colormap(jet(256));
grid minor
ft_singleplotTFR(cfg, stats);
% title('Condition vs No Learning')
title(strcat(labelconditions{iii-3},' vs No Learning'))
%title(strcat(labelconditions{iii},' vs No Learning'))

%%
%Calculate Freq3 and Freq4
toy=[-1:.01:1];
% 
% if selectripples==1
% 
%     if length(q)>length(q_nl)
%     q=q(1:length(q_nl));        
%     timecell=timecell(1:length(q_nl));
%     end
% 
%     if length(q)<length(q_nl)
%     q_nl=q_nl(1:length(q));
%     timecell_nl=timecell_nl(1:length(q));
%     end
% end

%THis is what I uncommented:
% freq3=barplot2_ft(q_nl,timecell_nl,[100:1:300],w,toy);
% freq4=barplot2_ft(q,timecell,[100:1:300],w,toy);
%% UNCOMMENT THIS IF YOU WANT TO NORMALIZE WRT TO THE BASELINE
% % % % % % % % % % % % cfg=[];
% % % % % % % % % % % % cfg.baseline=[-1 -0.5];
% % % % % % % % % % % % %cfg.baseline='yes';
% % % % % % % % % % % %  cfg.baselinetype='db';
% % % % % % % % % % % % freq30=ft_freqbaseline(cfg,freq3);
% % % % % % % % % % % % freq40=ft_freqbaseline(cfg,freq4);
% % % % % % % % % % % % [achis3]=baseline_norm(freq3,w);
% % % % % % % % % % % % [achis4]=baseline_norm(freq4,w);
% % % % % % % % % % % % climdb=[-3 3];

%% NEW SECTION I ADDED
achis3=freq3.powspctrm;
achis3=squeeze(mean(achis3,1));
achis3=squeeze(achis3(w,:,:));

achis4=freq4.powspctrm;
achis4=squeeze(mean(achis4,1));
achis4=squeeze(achis4(w,:,:));



%%
% Calculate zlim

% % % % cfg              = [];
% % % % cfg.channel      = freq3.label{w};
% % % % [ zmin1, zmax1] = ft_getminmax(cfg, freq30);
% % % % [zmin2, zmax2] = ft_getminmax(cfg, freq40);
% % % % 
% % % % zlim=[min([zmin1 zmin2]) max([zmax1 zmax2])];
% % % % 
% % % %  zlim=[-max(abs(zlim)) max(abs(zlim))];

%%
% % % % cfg              = [];
% % % %  cfg.zlim=zlim;
% % % % cfg.channel      = freq3.label{w};
% % % % cfg.colormap=colormap(jet(256));

%%
%subplot(3,4,7)
%ft_singleplotTFR(cfg, freq30); 
ax3 =subplot(3,4,7);
contourf(toy,freq3.freq,achis3,40,'linecolor','none'); 
colormap(jet(256));%narrow_colorbar();
% set(gca,'clim',climdb,'ydir','normal','xlim',[-1 1])
set(gca,'ydir','normal','xlim',[-1 1])


c3=colorbar();

h3 = get(H3, 'position'); % get axes position
hn3= get(Hc3, 'Position'); % Colorbar Width for c1


x3 = get(ax3, 'position'); % get axes position
cw3= get(c3, 'Position'); % Colorbar Width for c1


cw3(3)=hn3(3);
cw3(1)=hn3(1);
set(c3,'Position',cw3)
 

x3(3)=h3(3);
set(ax3,'Position',x3)

% freq3=barplot2_ft(q_nl,timecell_nl,[100:1:300],w);
title('High Gamma NO Learning')
%%

ax4 =subplot(3,4,8);

contourf(toy,freq4.freq,achis4,40,'linecolor','none'); 
colormap(jet(256));%narrow_colorbar();
% set(gca,'clim',climdb,'ydir','normal','xlim',[-1 1])
set(gca,'ydir','normal','xlim',[-1 1])


c4=colorbar();

h4 = get(H4, 'position'); % get axes position
hn4= get(Hc4, 'Position'); % Colorbar Width for c1


x4 = get(ax4, 'position'); % get axes position
cw4= get(c4, 'Position'); % Colorbar Width for c1


cw4(3)=hn4(3);
cw4(1)=hn4(1);
set(c4,'Position',cw4)
 

x4(3)=h4(3);
set(ax4,'Position',x4)



% freq4=barplot2_ft(q,timecell,[100:1:300],w)
%freq=justtesting(q,timecell,[100:1:300],w,0.5)
%title('High Gamma RIPPLE')
%%%%%%%%%%%%%%ft_singleplotTFR(cfg, freq40); 

title(strcat('High Gamma',{' '},labelconditions{iii-3}))
%title(strcat('High Gamma',{' '},labelconditions{iii}))

%%

[stats1]=stats_between_trials(freq3,freq4,label1,w);
% %
 subplot(3,4,12)
cfg = [];
cfg.channel = label1{2*w-1};
cfg.parameter = 'stat';
cfg.maskparameter = 'mask';
cfg.zlim = 'maxabs';
cfg.colorbar       = 'yes';
cfg.colormap=colormap(jet(256));
grid minor
ft_singleplotTFR(cfg, stats1);
%title('Ripple vs No Ripple')
title(strcat(labelconditions{iii-3},' vs No Learning'))
%title(strcat(labelconditions{iii},' vs No Learning'))
%% EXTRA STATISTICS
% % % % [stats1]=stats_between_trials(freq30,freq40,label1,w);
% % % % % %
% % % %  subplot(3,4,11)
% % % % cfg = [];
% % % % cfg.channel = label1{2*w-1};
% % % % cfg.parameter = 'stat';
% % % % cfg.maskparameter = 'mask';
% % % % cfg.zlim = 'maxabs';
% % % % cfg.colorbar       = 'yes';
% % % % cfg.colormap=colormap(jet(256));
% % % % grid minor
% % % % ft_singleplotTFR(cfg, stats1);
% % % % %title('Ripple vs No Ripple')
% % % % title(strcat(labelconditions{iii-3},' vs No Learning (Baseline)'))
% % % % % % %title(strcat(labelconditions{iii},' vs No Learning'))
% % % % % % %%
% % % % 
% % % % 
% % % % [stats1]=stats_between_trials(freq10,freq20,label1,w);
% % % % % %
% % % %  subplot(3,4,9)
% % % % cfg = [];
% % % % cfg.channel = label1{2*w-1};
% % % % cfg.parameter = 'stat';
% % % % cfg.maskparameter = 'mask';
% % % % cfg.zlim = 'maxabs';
% % % % cfg.colorbar       = 'yes';
% % % % cfg.colormap=colormap(jet(256));
% % % % grid minor
% % % % ft_singleplotTFR(cfg, stats1);
% % % % %title('Ripple vs No Ripple')
% % % % title(strcat(labelconditions{iii-3},' vs No Learning (Baseline)'))
% % % % %title(strcat(labelconditions{iii},' vs No Learning'))

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