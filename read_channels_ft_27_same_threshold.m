addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
addpath('/home/raleman/Documents/GitHub/CorticoHippocampal')
addpath('/home/raleman/Documents/internship')

%%
%Rat=26;

for Rat=26:27
if Rat==26
nFF=[
%    {'rat26_Base_II_2016-03-24'                         }
%    {'rat26_Base_II_2016-03-24_09-47-13'                }
%    {'rat26_Base_II_2016-03-24_12-55-58'                }
%    {'rat26_Base_II_2016-03-24_12-57-57'                }
    
   
    {'rat26_nl_base_III_2016-03-30_10-32-57'            }
    {'rat26_nl_base_II_2016-03-28_10-40-19'             }
    {'rat26_nl_baseline2016-03-01_11-01-55'             }
    {'rat26_plusmaze_base_2016-03-08_10-24-41'}
    
    
    
    {'rat26_novelty_I_2016-04-12_10-05-55'          }
    {'rat26_novelty_II_2016-04-13_10-23-29'             }
    {'rat26_for_2016-03-21_10-38-54'                    }
    {'rat26_for_II_2016-03-23_10-49-50'                 }
    
    ];

% labelconditions=[
%     {'Baseline_1' 
%      'Baseline_2'}
%      'Baseline_3'
%      'PlusMaze'
%      'Novelty_1'
%      'Novelty_2'
%      'Foraging_1'
%      'Foraging_2'
%     ];

labelconditions=[
    {'PlusMaze'
                }
     
     'Novelty_1'
     'Novelty_2'
     'Foraging_1'
     'Foraging_2'
    ];


else
nFF=[
    {'rat27_nl_base_2016-03-28_15-01-17'                   }
    {'rat27_NL_baseline_2016-02-26_12-50-26'               }
    {'rat27_nl_base_III_2016-03-30_14-36-57'               }
    
    {'rat27_for_2016-03-21_15-03-05'                       }
    {'Rat27_for_II_2016-03-23_15-06-59'                    }
    
    %{'rat27_novelty_II_2016-04-13_14-37-58'                }  %NO .MAT files found. 
    %{'rat27_novelty_II_2016-04-13_16-29-42'                } %No (complete).MAT files found.
    {'rat27_novelty_I_2016-04-11_14-34-55'                 }
    {'rat27_plusmaze_base_2016-03-14_14-52-48'             }
    {'rat27_plusmaze_base_II_2016-03-24_14-10-08'          }
%     {'rat27_plusmaze_dis_2016-03-10_14-35-18'              }
%     {'rat27_plusmaze_dis_II_2016-03-16_14-36-07'           }
%     {'rat27_plusmaze_dis_II_2016-03-18_14-46-24'           }
%     {'rat27_plusmaze_jit_2016-03-08_14-46-31'              }
%     {'rat27_plusmaze_jit_II_2016-03-16_15-02-27'           }
%     {'rat27_plusmaze_swrd_qPCR_2016-04-15_14-28-41'        }
%     {'rat27_watermaze_dis_morning_2016-04-06_10-18-36'     }
%     {'rat27_watermaze_jitter_afternoon_2016-04-06_15-41-51'}  
    ]

labelconditions=[
    { 
    'Baseline_1'}
    'Baseline_2'
    'Baseline_3'
    'Foraging_1' 
    
     'Foraging_2'
     'Novelty_1'
     'PlusMaze_1'
    'PlusMaze_2'
    
     
    ];

    
end

%% Go to main directory
cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
addpath /home/raleman/Documents/internship/fieldtrip-master/
InitFieldtrip()

cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
clc
%% Select experiment to perform. 
inter=1;
granger=0;
%%

 %for iii=7:length(nFF)
%for iii=1:length(nFF)

 for iii=4:length(nFF)


%for iii=3:3
    
 clearvars -except nFF iii labelconditions inter granger Rat 
%for iii=1:4

cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
cd(nFF{iii})

% art=0;

%Select length of window in seconds:
ro=[1200];

%run('load_data.m')
%run('new_load_data.m')
% error('stop')
%if ro==1200 && inter==0 || granger==1
if ro==1200 && inter==0 && granger==0
run('newest_load_data.m')
else
[sig1,sig2,ripple2,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple;    
%run('newest_load_data_only_ripple_chtm.m')
end
% Rearrange (clean)

%Make labels
label1=cell(7,1);
label1{1}='Hippo';
label1{2}='Hippo';
label1{3}='Parietal';
label1{4}='Parietal';
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

% % % % % % % % % % % % % % % % % % % % sig1=cell(7,1);
% % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % sig1{1}=Mono17;
% % % % % % % % % % % % % % % % % % % % sig1{2}=Bip17;
% % % % % % % % % % % % % % % % % % % % sig1{3}=Mono12;
% % % % % % % % % % % % % % % % % % % % sig1{4}=Bip12;
% % % % % % % % % % % % % % % % % % % % sig1{5}=Mono9;
% % % % % % % % % % % % % % % % % % % % sig1{6}=Bip9;
% % % % % % % % % % % % % % % % % % % % sig1{7}=Mono6;
% % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % sig2=cell(7,1);
% % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % sig2{1}=V17;
% % % % % % % % % % % % % % % % % % % % sig2{2}=S17;
% % % % % % % % % % % % % % % % % % % % sig2{3}=V12;
% % % % % % % % % % % % % % % % % % % % % sig2{4}=R12;
% % % % % % % % % % % % % % % % % % % % sig2{4}=S12;
% % % % % % % % % % % % % % % % % % % % %sig2{6}=SSS12;
% % % % % % % % % % % % % % % % % % % % sig2{5}=V9;
% % % % % % % % % % % % % % % % % % % % % sig2{7}=R9;
% % % % % % % % % % % % % % % % % % % % sig2{6}=S9;
% % % % % % % % % % % % % % % % % % % % %sig2{10}=SSS9;
% % % % % % % % % % % % % % % % % % % % sig2{7}=V6;
% % % % % % % % % % % % % % % % % % % %  
% % % % % % % % % % % % % % % % % % % % % ripple=length(M);
% % % % % % % % % % % % % % % % % % % % % ripple=sum(s172);
% % % % % % % % % % % % % % % % % % % % ripple=ripple2;
%Number of ripples per CHTMeshold.
% ripple2=sum(s217);

 % Monopolar signals only
%Ro=[200 500];

%for i=1:length(Ro)
%i=1;
%   error('stop here')  
%%
ripple=ripple2;
%for level=1:length(ripple)-1;    
 for level=1:1
%   allscreen()
  %[p,q,timecell,cfs,f]=getwin(carajo,veamos,sig1,sig2,label1,label2,ro);
  %Get p and q.
  %Get averaged time signal.
[p,q,timecell,Q,~,~]=getwin2(carajo{:,:,level},veamos{level},sig1,sig2,label1,label2,ro,ripple(level),CHTM(level+1));
% SUS=SU(:,level).';
 av=cat(1,p{1:end});
%av=cat(1,q{1:end});

av=av(1:3:end,:); %Only Hippocampus
%AV=max(av.');
%[B I]= maxk(AV,1000);
[B I]= maxk(max(av.'),1000); %Look for the 1000 ripples with highest amplitude. THIS SHOULD BE MEAN instead of Max since some peaks go downwards and no upwards. 
[ajal ind]=unique(B); %Repeated ripples, which are very close to each other. 
if length(ajal)>500
ajal=ajal(end-499:end);
ind=ind(end-499:end);
end
dex=I(ind);



%if ro==1200 && inter==0 || granger==1
if ro==1200 && inter==0 && granger==0

SUS=SU{level}.';
% SUS2=SU2(:,level).';
SUS2=SU2{level}.';
%SUQ2=SUQ(:,level).';
SUQ2=SUQ{level}.';

SUStimecell=timecell(1:length(SUS));
SUS2timecell=timecell(1:length(SUS2));
SUQ2timecell=timecell(1:length(SUQ2));

P1_SUS=avg_samples(SUS,SUStimecell);
P2_SUS=avg_samples(SUS2,SUS2timecell);

end
%p is wideband signal. 
%q is bandpassed signal. 
%timecell are the time labels. 
%Q is the envelope of the Bandpassed signal.  

% [p2,q2,timecell2,Q2,~,~]=getwin2(carajo2{:,:,level},veamos2{level},sig1,sig2,label1,label2,ro,ripple2(level),CHTM2(level+1));

%close all
%P1 bandpassed
%P2 widepassdw
% error('stop here please')

%Finding .mat files 
Files=dir(fullfile(cd,'*.mat'));

% % % % % % % % if ro==1200 
% % % % % % % %     if sum(strcmp({Files.name}, strcat('randnum2_',num2str(level),'.mat')))
% % % % % % % %       load(strcat('randnum2_',num2str(level),'.mat'))
% % % % % % % %     else
% % % % % % % % 
% % % % % % % %       ran=randi(length(p),100,1);
% % % % % % % %       save(strcat('randnum2_',num2str(level)),'ran')
% % % % % % % % 
% % % % % % % %     end
% % % % % % % % 
% % % % % % % % else
% % % % % % % %      if sum(strcmp({Files.name}, strcat('randnum17_',num2str(level),'.mat')))
% % % % % % % %       load(strcat('randnum17_',num2str(level),'.mat'))
% % % % % % % %     else
% % % % % % % % 
% % % % % % % %       ran=randi(length(p),100,1);
% % % % % % % %       save(strcat('randnum17_',num2str(level)),'ran')
% % % % % % % % 
% % % % % % % %     end
% % % % % % % %     
% % % % % % % % end

% ran=I.'; % Select ripples with highest magnitudes. 
ran=dex.';
% 
% ran=randi(length(p),100,1);
%load(strcat('randnum2_',num2str(level),'.mat'))
p=p([ran]);
q=q([ran]);
Q=Q([ran]);
timecell=timecell([ran]);
 
% p2=p2([ran]);
% q2=q2([ran]);
% Q2=Q2([ran]);
% timecell2=timecell2([ran]);

% p=p(1:100);
% q=q(1:100);
% Q=Q(1:100);
% timecell=timecell(1:100);

P1=avg_samples(q,timecell);
P2=avg_samples(p,timecell);

% SUStimecell=timecell(1:length(SUS));
% SUS2timecell=timecell(1:length(SUS2));
% SUQ2timecell=timecell(1:length(SUQ2));
% 
% P1_SUS=avg_samples(SUS,SUStimecell);
% P2_SUS=avg_samples(SUS2,SUS2timecell);

% P12=avg_samples(q2,timecell2);
% P22=avg_samples(p2,timecell2);

% save(strcat('randnum2_',num2str(level)),'ran')

%for w=1:size(P2,1)-1

%%%%for w=1:size(P2,1)    %Brain region
cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
cd(nFF{3})

%run('newest_load_data_nl.m')
%[sig1_nl,sig2_nl,ripple2_nl,carajo_nl,veamos_nl,CHTM_nl]=newest_only_ripple_nl;
[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,timeasleep2,RipFreq3]=newest_only_ripple_nl;
ripple3=ripple_nl;


for w=1:3    
% %     error('stop here')
% run('plot_no_ripples.m')
% string=strcat('NEW_SPEC_',label1{2*w-1},'_','NORIP',num2str(level),'.png');
% %saveas(gcf,string)
% close all
% 
% baseline1=[-1, -0.8];
% baseline2=[0.8, 1];
% 
% run('plot_ripples.m')
% 
% string=strcat('NEW_SPEC_',label1{2*w-1},'_',num2str(level),'.png');
% %saveas(gcf,string)

%     error('stop here')

% error('stop here')
%%

if iii>=4 && inter==1
% run('plot_inter_conditions_27.m')
% error('Stop here')
plot_inter_conditions_27(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,timecell,sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM);
string=strcat('TESTIntra_conditions_',label1{2*w-1},'_',num2str(level),'.png');
%cd('/home/raleman/Dropbox/SWR/NL_vs_Conditions_2')
%cd('/home/raleman/Dropbox/SWR/rat 27/NL_vs_Conditions_2/Baseline3/plusmaze2')
%cd('/home/raleman/Dropbox/SWR/rat 27/NoLearning_vs_Conditions_2/Baseline3/')


if Rat==26
    %cd(strcat('/home/raleman/Dropbox/SWR/NoLearning_vs_Conditions_2/',labelconditions{iii-3},'/test'))
    cd(strcat('/home/raleman/Dropbox/SWR/NoLearning_vs_Conditions_2/',labelconditions{iii-3}))

end

if Rat==27
    cd(strcat('/home/raleman/Dropbox/SWR/rat 27/NoLearning_vs_Conditions_2/Baseline3/',labelconditions{iii-3}))
end

saveas(gcf,string)
end

if ro==1700
    run('plot_pre_post.m')
    string=strcat('NEW2_pre_post_',label1{2*w-1},'_',num2str(level),'.png');
    saveas(gcf,string)
end

%&& granger==0
if ro==1200 && inter==0 && granger==0
run('plot_both.m')
% string=strcat('NEW2_between_',label1{2*w-1},'_',num2str(level),'.png');
 string=strcat('NoRipple_',label1{2*w-1},'_',num2str(level),'.png');
 saveas(gcf,string)
end

close all

if w==1 && granger==1
% allscreen()    
% [granger]=barplot_GC(cut(q),cut(timecell),[100:20:300])
% title(strcat('Time-Frequency Granger Causality (Bandpassed: 100-300 Hz)',' CHTM:',num2str(CHTM(level))))
% 
% string=strcat('TFGC_','Bandpass_',num2str(level),'.png');
% saveas(gcf,string)
% close all

if Rat==27
% cd( strcat('/home/raleman/Dropbox/SWR/Connectivity_measures/',labelconditions{iii}))
cd( strcat('/home/raleman/Dropbox/SWR_2/rat_27/Connectivity measures/',labelconditions{iii}))
end


allscreen()    
[coh]=barplot_COH(q,timecell,[100:2:300])
title('Time-Frequency Coherence (Bandpassed: 100-300 Hz)')
string=strcat('COH_','Bandpass_Ripple_',num2str(level),'.png');
saveas(gcf,string)
close all

% % % % % % % % allscreen()    
% % % % % % % % [coh]=barplot_COH(SUS,SUStimecell,[100:2:300])
% % % % % % % % title('Time-Frequency Coherence (Bandpassed: 100-300 Hz)')
% % % % % % % % string=strcat('NEW_TFCOH_','Bandpass_NoRipple_',num2str(level),'.png');
% % % % % % % % saveas(gcf,string)
% % % % % % % % close all

% allscreen()
% [granger]=barplot_GC(cut(p),cut(timecell),[2:2:30])
% title('Time-Frequency Granger Causality (Wideband)')
% string=strcat('TFGC_','Wideband_',num2str(level),'.png');
% saveas(gcf,string)
% close all

allscreen()
[coh]=barplot_COH(p,timecell,[1:1:30])
title('Time-Frequency Coherence (Wideband)')
string=strcat('COH_','Wideband_Ripple_',num2str(level),'.png');
saveas(gcf,string)
close all


% % % % % % % % % % % % % % allscreen()
% % % % % % % % % % % % % % [coh]=barplot_COH(SUS2,SUS2timecell,[1:1:30])
% % % % % % % % % % % % % % title('Time-Frequency Coherence (Wideband)')
% % % % % % % % % % % % % % string=strcat('NEW_TFCOH_','Wideband_NoRipple_',num2str(level),'.png');
% % % % % % % % % % % % % % saveas(gcf,string)
% % % % % % % % % % % % % % close all


%allscreen()
% % % % % % % % % % % % % % gc(Q,timecell,'Envelope',ro)
% % % % % % % % % % % % % % string=strcat('NEW_GC_','Envelope_Ripples_',num2str(level),'.png');
% % % % % % % % % % % % % % saveas(gcf,string)
% % % % % % % % % % % % % % close all

%Here onwards (2)

%allscreen()
% % % % % % % % % % % % % % % % % % % % gc(SUQ2,SUQ2timecell,'Envelope',ro)
% % % % % % % % % % % % % % % % % % % % string=strcat('NEW_GC_','Envelope_NoRipples_',num2str(level),'.png');
% % % % % % % % % % % % % % % % % % % % saveas(gcf,string)
% % % % % % % % % % % % % % % % % % % % close all


%allscreen()
gc(p,timecell,'Widepass',ro)
string=strcat('GC_','Widepass_Ripples_',num2str(level),'.png');
saveas(gcf,string)
close all

%allscreen()
% % % % % % % % % % % % % % % % % % % gc(SUS2,SUS2timecell,'Widepass',ro)
% % % % % % % % % % % % % % % % % % % string=strcat('NEW_GC_','Widepass_No_Ripples_',num2str(level),'.png');
% % % % % % % % % % % % % % % % % % % saveas(gcf,string)
% % % % % % % % % % % % % % % % % % % close all


%allscreen()
gc(q,timecell,'Bandpassed',ro)
string=strcat('GC_','Bandpassed_Ripples_',num2str(level),'.png');
saveas(gcf,string)
close all

%allscreen()
% % % % % % % % % % % % % % % % % % gc(SUS,SUStimecell,'Bandpassed',ro)
% % % % % % % % % % % % % % % % % % string=strcat('NEW_GC_','Bandpassed_NoRipples_',num2str(level),'.png');
% % % % % % % % % % % % % % % % % % saveas(gcf,string)
% % % % % % % % % % % % % % % % % % close all

%w=size(P2,1);

end


end
%
% chanindx = find(strcmp(freq.label, 'Hippo'));
% figure; imagesc(squeeze(freq.powspctrm(1,chanindx,:,:)));
%

%figure; 

%
% subplot(3,2,4)
% barplot2_ft(q,timecell,[100:1:300],w)


%
% barplot2_ft(q,timecell,[0:.1:30],2)
% figure()
% barplot2_ft(Q,timecell,[0:.01:30],'REF')
% barplot2_ft(Q,timecell,[1:.1:30],'PFC')


%error('stop')
  
  
% % % % % % % % % % % % % % % % % % % % % % % % % CHECALE BIEN  
% % % % % % % % % % % % % % % % % % % % % % % % % %   new_index=1;
% % % % % % % % % % % % % % % % % % % % % % % % % % [TI,TN, cellx,cellr,to,tu]=win(carajo{:,:,level},veamos{level},sig1{new_index},sig2{new_index},ro);
% % % % % % % % % % % % % % % % % % % % % % % % % % [z1,z4]=clean(cellx,cellr);
% % % % % % % % % % % % % % % % % % % % % % % % % % [p3 ,p4]=eta2(z1,z4,ro,1000);

%

% 
% 
% new_index=3;
% [TI,TN, cellx,cellr,to,tu]=win(carajo{:,:,level},veamos{level},sig1{new_index},sig2{new_index},ro);
% [z2,z5]=clean(cellx,cellr);
% [p3 ,p4]=eta2(z2,z5,ro,1000);
% 
% new_index=5;
% [TI,TN, cellx,cellr,to,tu]=win(carajo{:,:,level},veamos{level},sig1{new_index},sig2{new_index},ro);
% [z3,z6]=clean(cellx,cellr);
% [p3 ,p4]=eta2(z3,z6,ro,1000);
% 
% new_index=7;
% [TI,TN, cellx,cellr,to,tu]=win(carajo{:,:,level},veamos{level},sig1{new_index},sig2{new_index},ro);
% [z7,z8]=clean(cellx,cellr);
% [p3 ,p4]=eta2(z7,z8,ro,1000);

%
  
%Use p and q and Q for Granger.
  
% % % % % % % % % % % % % % % % % % % % % % CHECALE BIEN P'AL GRANGER  
% % % % % % % % % % % % % % % % % % % % % %   close all
% % % % % % % % % % % % % % % % % % % % % %    q=cut(q);
% % % % % % % % % % % % % % % % % % % % % %    p=cut(p);
% % % % % % % % % % % % % % % % % % % % % %    %Q=cut(Q);
% % % % % % % % % % % % % % % % % % % % % %    Q=cut(Q);
% % % % % % % % % % % % % % % % % % % % % %   timecell=cut(timecell);
% % % % % % % % % % % % % % % % % % % % % %   


  
%   [Fxy3, Fyx3]=BS(p,q);
%   BS_CHTM(Fxy3,Fyx3,0.1);
  

  
  %autotest(q,timecell,'Bandpassed',ro)

 %%% CHECALE BIEN 
% % % % % % % % % % % % % % % % % % %  gc(q,timecell,'Bandpassed',ro)
% % % % % % % % % % % % % % % % % % %    
% % % % % % % % % % % % % % % % % % %  string=strcat(num2str(ro),'_GC_','Monopolar','Bandpassed','.png');

 
 
 %cd Nuevo
%cd Spectrograms_CHTMeshold_45
%cd testGC
% cd ARorder

% % % % % % % % % CHECALE
% % % % % % % % % fig=gcf;
% % % % % % % % % fig.InvertHardcopy='off';
% % % % % % % % % saveas(gcf,string)
% % % % % % % % % %cd ..  
% % % % % % % % %  close all
 
 %autotest(p,timecell,'Widepassed',ro)

 %CHECALE
% % % % % % % % % % % % % % % % % % %  gc(p,timecell,'Widepass',ro)
% % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % string=strcat(num2str(ro),'_GC_','Monopolar','Widepass','.png');

%cd Nuevo
%cd Spectrograms_CHTMeshold_45
%cd testGC
%cd ARorder

%%%%%%%%%%%%%%%%%CHECALE
% % % % % % % % % % % % % % % % fig=gcf;
% % % % % % % % % % % % % % % % fig.InvertHardcopy='off';
% % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % saveas(gcf,string)
% % % % % % % % % % % % % % % % %cd ..  
% % % % % % % % % % % % % % % %  close all
% % % % % % % % % % % % % % % %  % Envelope 
% % % % % % % % % % % % % % % %  gc(Q,timecell,'Envelope',ro)
% % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % string=strcat(num2str(ro),'_GC_','Monopolar','Envelope','.png');
% % % % % % % % % % % % % % % % %cd Nuevo
% % % % % % % % % % % % % % % % %cd Spectrograms_CHTMeshold_45
% % % % % % % % % % % % % % % % %cd testGC
% % % % % % % % % % % % % % % % %cd ARorder
% % % % % % % % % % % % % % % % fig=gcf;
% % % % % % % % % % % % % % % % fig.InvertHardcopy='off';
% % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % saveas(gcf,string)
% % % % % % % % % % % % % % % % %cd ..  
% % % % % % % % % % % % % % % %  close all
 
 
%  T = cell2mat(q); 
% [F]=mvgc_adapted(T,fn);
% allscreen()
% plot_granger(F,fn)
% mtit('Monopolar','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
% mtit('Bandpassed','fontsize',14,'color',[1 0 0],'position',[.5 0.75 ])
% mtit(strcat('(+/-',num2str(ro),'ms)'),'fontsize',14,'color',[1 0 0],'position',[.5 0.5 ])
% 
% 
%  T = cell2mat(p); 
% [F]=mvgc_adapted(T,fn);
% allscreen()
% plot_granger(F,fn)
% mtit('Monopolar','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
% mtit('Wideband','fontsize',14,'color',[1 0 0],'position',[.5 0.75 ])
% mtit(strcat('(+/-',num2str(ro),'ms)'),'fontsize',14,'color',[1 0 0],'position',[.5 0.5 ])
% 
%  T = cell2mat(Q); 
% [F]=mvgc_adapted(T,fn);
% allscreen()
% plot_granger(F,fn)
% mtit('Monopolar','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
% mtit('Envelope','fontsize',14,'color',[1 0 0],'position',[.5 0.75 ])
% mtit(strcat('(+/-',num2str(ro),'ms)'),'fontsize',14,'color',[1 0 0],'position',[.5 0.5 ])

end
%%
end
end