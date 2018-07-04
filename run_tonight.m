acer=0;
%%
if acer==0
addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
addpath('/home/raleman/Documents/GitHub/CorticoHippocampal')
addpath('/home/raleman/Documents/internship')
else
addpath('D:\internship\analysis-tools-master'); %Open Ephys data loader.
addpath('C:\Users\Welt Meister\Documents\Donders\CorticoHippocampal\CorticoHippocampal')
   
end
%%
%Rat=26;
for tdura=1:1
for Rat=1:2
rats=[26 27 21];
Rat=rats(Rat);    
acer=0;
    
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


end
if Rat==27
nFF=[
    {'rat27_nl_base_2016-03-28_15-01-17'                   }
    {'rat27_NL_baseline_2016-02-26_12-50-26'               }
    {'rat27_nl_base_III_2016-03-30_14-36-57'               }
    
    {'rat27_plusmaze_base_2016-03-14_14-52-48'             }
    {'rat27_plusmaze_base_II_2016-03-24_14-10-08'          }
    
    {'rat27_for_2016-03-21_15-03-05'                       }
    {'Rat27_for_II_2016-03-23_15-06-59'                    }
    
    %{'rat27_novelty_II_2016-04-13_14-37-58'                }  %NO .MAT files found. 
    %{'rat27_novelty_II_2016-04-13_16-29-42'                } %No (complete).MAT files found.
    {'rat27_novelty_I_2016-04-11_14-34-55'                 }
  
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
    %'Baseline_1'}
    %'Baseline_2'
    %'Baseline_3'
    'PlusMaze_1'} 
    'PlusMaze_2'
    
    'Foraging_1'
    
     'Foraging_2'
     'Novelty_1'
    
    
     
    ];

    
end


if Rat==21
 
 nFF=[  
    {'2015-11-27_13-50-07 5h baseline'             }
    {'rat21 baselin2015-12-11_12-52-58'            }
    {'rat21_learningbaseline2_2015-12-10_15-24-17' }
    {'rat21with45minlearning_2015-12-02_14-25-12'  }
    %{'rat21t_maze_2015-12-14_13-29-07'             }
    {'rat21 post t-maze 2015-12-14_13-30-52'       }
    
];

%%
labelconditions=[
    {    
 %    'Baseline 1'
 %               }
     
 %    'Baseline 2'
     'Novelty 1'
                }
     'Novelty 2'
     'PlusMaze'
    ];
    
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
inter=1;
granger=0;
%Select length of window in seconds:
%ro=[1200];
ro=[10200];

coher=0;
selectripples=1;
mergebaseline=0;
nrem=3;
notch=1;

% tdura=30;
if tdura==1 %For baseline
tin=30;
tend=60;
end

if tdura==2
tin=0;
tend=30;
end

%%

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
% error('stop')
%%
%for tdura=30:30:60
%for tdura=30:30
 for iii=4:4
%length(nFF)
    
 clearvars -except nFF iii labelconditions inter granger Rat ro label1 label2 coher selectripples acer mergebaseline nrem notch tdura tin tend
if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

cd(nFF{iii})


% error('stop here')  
%%
%for level=1:length(ripple)-1;    
 for level=1:1
%  error('stop here')

% if ro==1200 && inter==0 && granger==0
% run('newest_load_data.m')
% else
% [sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    
% end
% lepoch=2;
% error('stop')

%Get right threshold for this session. 
chtm=load('vq_loop2.mat');
chtm=chtm.vq;

%Get averaged time signal.
% [sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    
% [ripple,timeasleep,DEMAIS,y1]=NREM_accurate_spectrogram(nrem,notch,chtm);
%error('stop')

%Check if file with ripples already exists
files=dir(fullfile(cd,'*.mat'));
files={files.name};
tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'findrip.mat'), files.', 'UniformOutput',false)));
% error('stop') 
if tst~=1
[sig1,sig2,ripple2,carajo,veamos,RipFreq2,timeasleep]=nrem_fixed_thr(chtm,nrem,notch,[],[]);
save findrip.mat   sig1 sig2 ripple2 carajo veamos RipFreq2 timeasleep                                                                                                                                                                                                                                                                                                                                             
else
load('findrip.mat')    
end

%Delete bipolar recordings.
sig1{2}=0;
sig1{4}=0;
sig1{6}=0;

sig2{2}=0;
sig2{4}=0;
sig2{6}=0;



%error('stop')
% for t=1:60
% [carajo,veamos]=equal_time2(sig1,sig2,carajo,veamos,tend,tin);
[carajo,veamos]=equal_time2(sig1,sig2,carajo,veamos,30,0);

ripple=sum(cellfun('length',carajo{1}(:,1))); %Number of ripples after equal times. 
% R(t)=ripple;
%end

% error('stop')
%Get p and q.
  %Get averaged time signal.
tic
[p,q,~,~,~,~]=getwin2(carajo{:,:,level},veamos{level},sig1,sig2,label1,label2,ro,ripple2(level),chtm);
toc
% [p2,q2,timecell2,Q2,~,~]=getwin2(carajo2{:,:,level},veamos2{level},sig1,sig2,label1,label2,ro,ripple2(level),chtm);



% SUS=SU(:,level).';

if selectripples==1
[ran]=rip_outlier(q);
    % 
    p=p([ran]);
    q=q([ran]);
%     timecell=timecell([ran]);


    
[ran]=rip_select(q);
    % 
    p=p([ran]);
    q=q([ran]);
%     timecell=timecell([ran]);
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



% ran=I.'; % Select ripples with highest magnitudes. 


%Finding .mat files 
% Files=dir(fullfile(cd,'*.mat'));

P1=avg_samples(q,create_timecell(ro));
P2=avg_samples(p,create_timecell(ro));
%%%%for w=1:size(P2,1)    %Brain region
%% GO TO BASELINE 
for mergebaseline=1:2 %Ignore merged baseline  
if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

%     error('stop')
%% Get average baseline
if mergebaseline==3
    for k=1:2 %get baselines (Number of baselines varies among rats)

    strcat('Merging baseline:',{' '},num2str(k))

    cd(nFF{k})    

    
    chtm=load('vq_loop2.mat');
    chtm=chtm.vq;

%     error('stipo')
     files=dir(fullfile(cd,'*.mat'));
     files={files.name};
     tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'findrip.mat'), files.', 'UniformOutput',false)));
 
if tst~=1
[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq2,timeasleep2]=nrem_fixed_thr(chtm,nrem,notch,[],[]);
save findrip.mat   sig1_nl sig2_nl ripple_nl carajo_nl veamos_nl RipFreq2 timeasleep2                                                                                                                                                                                                                                                                                                                                             
else
%load('findrip.mat')
if Rat==26
    aa=load('findrip.mat');
    sig1_nl=aa.sig1;
    sig2_nl=aa.sig2;
    ripple_nl=aa.ripple2; 
    carajo_nl=aa.carajo;
    veamos_nl=aa.veamos; 
    RipFreq2=aa.RipFreq2; 
    timeasleep2=aa.timeasleep;
    clear aa
else
    load('findrip.mat');
end
end

%[carajo,veamos]=equal_time2(sig1,sig2,carajo,veamos,60,30);

[carajo_nl,veamos_nl]=equal_time2(sig1_nl,sig2_nl,carajo_nl,veamos_nl,tend,tin);
ripple=sum(cellfun('length',carajo_nl{1}(:,1)));

% error('stop')
%     [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,timeasleep2,RipFreq3]=newest_only_ripple_nl_level(level);
    [p_nl,q_nl,~,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),chtm);
    
    
        if selectripples==1
            
            [ran_nl]=rip_outlier(q_nl);
            p_nl=p_nl([ran_nl]);
            q_nl=q_nl([ran_nl]);
%             timecell=timecell([ran_nl]);


            
            
            [ran_nl]=rip_select(q_nl);

            p_nl=p_nl([ran_nl]);
            q_nl=q_nl([ran_nl]);
%             timecell=timecell([ran_nl]);

        end
       
    NU{k}=p_nl;
    QNU{k}=q_nl;
    TNU{k}=create_timecell(ro);
    
    
    
    
        if acer==0
            cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
        else
            cd(strcat('D:\internship\',num2str(Rat)))
        end
    end
    
    if size(create_timecell(ro),2)==1000
        p_nl(1:500)=NU{1}(1:500);
        p_nl(501:1000)=NU{2}(1:500);
%         p_nl(667:667+333)=NU{3}(1:334);


        q_nl(1:500)=QNU{1}(1:500);
        q_nl(501:1000)=QNU{2}(1:500);
%         q_nl(667:667+333)=QNU{3}(1:334);
    end
    
     if size(create_timecell(ro),2)==500
        p_nl(1:250)=NU{1}(1:250);
        p_nl(251:500)=NU{2}(1:250);
%         p_nl(335:335+165)=NU{3}(1:166);


        q_nl(1:250)=QNU{1}(1:250);
        q_nl(251:500)=QNU{2}(1:250);
%         q_nl(335:335+165)=QNU{3}(1:166);
    end
if ro==1200   
toy = [-1.2:.01:1.2];
else
toy = [-10.2:.1:10.2];    
end

freq1=justtesting(p_nl,create_timecell(ro),[1:0.5:30],[],10,toy);    
%error('stop')
if ro==1200 
toy=[-1:.01:1];
else
toy=[-10:.1:10];    
end

freq3=barplot2_ft(q_nl,create_timecell(ro),[100:1:300],[],toy);

else %NOT MERGING  BASELINES
    cd(nFF{mergebaseline}) %Best (Longest) baseline recorded 

    chtm=load('vq_loop2.mat');
    chtm=chtm.vq;

     files=dir(fullfile(cd,'*.mat'));
     files={files.name};
     tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'findrip.mat'), files.', 'UniformOutput',false)));
 
if tst~=1
[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq2,timeasleep2]=nrem_fixed_thr(chtm,nrem,notch,[],[]);
save findrip.mat   sig1_nl sig2_nl ripple_nl carajo_nl veamos_nl RipFreq2 timeasleep2                                                                                                                                                                                                                                                                                                                                             
else
%load('findrip.mat')        
if Rat==26
    aa=load('findrip.mat');
    sig1_nl=aa.sig1;
    sig2_nl=aa.sig2;
    ripple_nl=aa.ripple2; 
    carajo_nl=aa.carajo;
    veamos_nl=aa.veamos; 
    RipFreq2=aa.RipFreq2; 
    timeasleep2=aa.timeasleep;
    clear aa
else
    load('findrip.mat');    
end
end


%Delete bipolar recordings.
sig1_nl{2}=0;
sig1_nl{4}=0;
sig1_nl{6}=0;

sig2_nl{2}=0;
sig2_nl{4}=0;
sig2_nl{6}=0;


[carajo_nl,veamos_nl]=equal_time2(sig1_nl,sig2_nl,carajo_nl,veamos_nl,tend,tin);

%[carajo_nl,veamos_nl]=equal_time(sig1_nl,sig2_nl,carajo_nl,veamos_nl,tdura);

% ripple3=sum(cellfun('length',carajo_nl{1}(:,1)));
   
%  [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq2,timeasleep2]=nrem_fixed_thr(chtm,nrem,notch,[],lepoch);

%[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,timeasleep2,RipFreq3]=newest_only_ripple_nl_level(level);
ripple3=ripple_nl;

% [p_nl,q_nl,timecell,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),CHTM2(level+1));
tic
[p_nl,q_nl,~,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),chtm);
toc
clear sig1 sig2 sig1_nl sig2_nl

    if selectripples==1

    [ran_nl]=rip_outlier(q_nl);
    p_nl=p_nl([ran_nl]);
    q_nl=q_nl([ran_nl]);
%    timecell=timecell([ran_nl]);

    
    [ran_nl]=rip_select(q_nl);
    p_nl=p_nl([ran_nl]);
    q_nl=q_nl([ran_nl]);
 %   timecell=timecell([ran_nl]);

    end
%error('stop')

%      files=dir(fullfile(cd,'*.mat'));
%      files={files.name};
%      tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'freq1same.mat'), files.', 'UniformOutput',false)));
%  
% if tst~=1
if ro==1200
toy = [-1.2:.01:1.2];
else
toy = [-10.2:.1:10.2]; %[-10.2:.2:10.2];    
end    
tic
freq1=justtesting(p_nl,create_timecell(ro),[1:0.5:30],[],10,toy);
toc
% save freq1same.mat freq1                                                                                                                                                                                                                                                                                                                                                
% else
% load('freq1same.mat')            
% end
%  error('stop')
[freq1]=norm_spec(freq1);    

%      files=dir(fullfile(cd,'*.mat'));
%      files={files.name};
%      tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'freq3same.mat'), files.', 'UniformOutput',false)));
%  
% if tst~=1   
if ro==1200
toy=[-1:.01:1];
else
toy=[-10:.1:10]; %[-10:.2:10];    
end
freq3=barplot2_ft(q_nl,create_timecell(ro),[100:2:300],[],toy);
[freq3]=norm_spec(freq3);    

% save freq3same.mat freq3                                                                                                                                                                                                                                                                                                                                                
% else
% load('freq3same.mat')            
% end    


    if acer==0
            cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
    else
            cd(strcat('D:\internship\',num2str(Rat)))
    end
end


P1_nl=avg_samples(q_nl,create_timecell(ro));
P2_nl=avg_samples(p_nl,create_timecell(ro));
clear p_nl q_nl
clear sig1 sig2 sig1_nl sig2_nl
%  error('stop')
%%
%run('newest_load_data_nl.m')
%[sig1_nl,sig2_nl,ripple2_nl,carajo_nl,veamos_nl,CHTM_nl]=newest_only_ripple_nl;
% % % % % % % % % % [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,timeasleep2,RipFreq3]=newest_only_ripple_nl_level(level);
% % % % % % % % % % ripple3=ripple_nl;
% % % % % % % % % % 
% % % % % % % % % % [p_nl,q_nl,timecell,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),CHTM2(level+1));
% % % % % % % % % % 
% % % % % % % % % % if selectripples==1
% % % % % % % % % % 
% % % % % % % % % % [ran_nl]=rip_select(p_nl);
% % % % % % % % % % 
% % % % % % % % % % p_nl=p_nl([ran_nl]);
% % % % % % % % % % q_nl=q_nl([ran_nl]);
% % % % % % % % % % timecell=timecell([ran_nl]);
% % % % % % % % % % 
% % % % % % % % % % end


%%
for w=2:3    

%%
if iii>=4 && inter==1
% run('plot_inter_FIXED.m')
% error('Stop here')
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % ripple3=ripple_nl;
titl{3}='MergedBaselines1&2';
titl{2}='Baseline2';
titl{1}='Baseline1';

    if acer==0
            cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
    else
            cd(strcat('D:\internship\',num2str(Rat)))
    end

cd(nFF{iii}) %


%      files=dir(fullfile(cd,'*.mat'));
%      files={files.name};
%      tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'freq2same.mat'), files.', 'UniformOutput',false)));
%  
% if tst~=1
if ro==1200
toy = [-1.2:.01:1.2];
else
toy = [-10.2:.1:10.2]; %[-10.2:.2:10.2];    
end

freq2=justtesting(p,create_timecell(ro),[1:0.5:30],[],0.5,toy);

[freq2]=norm_spec(freq2);    

% save freq2same.mat freq2                                                                                                                                                                                                                                                                                                                                                
% else
% load('freq2same.mat')            
% end

%      files=dir(fullfile(cd,'*.mat'));
%      files={files.name};
%      tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'freq4same.mat'), files.', 'UniformOutput',false)));
%  
% if tst~=1
if ro==1200
toy=[-1:.01:1];
else
toy=[-10:.1:10]; %[-10:.2:10];    
end

if ro==1200
freq4=barplot2_ft(q,create_timecell(ro),[100:1:300],w,toy);
else
freq4=barplot2_ft(q,create_timecell(ro),[100:2:300],w,toy); %Memory reasons.     
end

[freq4]=norm_spec(freq4);    

% save freq4same.mat freq4
% else
% load('freq4same.mat')            
% end    

if ro==1200
plot_inter_FIXED(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,[],create_timecell(ro),[],[],ripple_nl,carajo_nl,veamos_nl,chtm,[],selectripples,acer,P1_nl,P2_nl,[],[],freq1,freq3,freq2,freq4)
else
plot_inter_FIXED_10(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,[],create_timecell(ro),[],[],ripple_nl,carajo_nl,veamos_nl,chtm,[],selectripples,acer,P1_nl,P2_nl,[],[],freq1,freq3,freq2,freq4)    
end
%plot_inter_FIXED(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,timecell,sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,selectripples);
string=strcat(label1{2*w-1},'_',titl{mergebaseline},'.png');
%cd('/home/raleman/Dropbox/SWR/NL_vs_Conditions_2')
%cd('/home/raleman/Dropbox/SWR/rat 27/NL_vs_Conditions_2/Baseline3/plusmaze2')
%cd('/home/raleman/Dropbox/SWR/rat 27/NoLearning_vs_Conditions_2/Baseline3/')


% %if Rat==26
%     %cd(strcat('/home/raleman/Dropbox/SWR/NoLearning_vs_Conditions_2/',labelconditions{iii-3},'/test'))
%    if acer==0
%     cd(strcat('/home/raleman/Dropbox/SWR/NoLearning_vs_Conditions_2/',labelconditions{iii-3}))
%    else
%     cd(strcat('C:\Users\Welt Meister\Dropbox\1000\',num2str(Rat)))   
%    end

%end

%if Rat==27
%UNCOMMENT THIS:
% % % % % % % % % % % % if tdura==2
% % % % % % % % % % % %     if acer==0
% % % % % % % % % % % %       %cd(strcat('/home/raleman/Dropbox/SWR/rat 27/NoLearning_vs_Conditions_2/Baseline3/',labelconditions{iii-3}))
% % % % % % % % % % % %       cd(strcat('/home/raleman/Dropbox/SD30_normtime/',num2str(Rat)))
% % % % % % % % % % % % 
% % % % % % % % % % % %     else
% % % % % % % % % % % %       cd(strcat('C:\Users\Welt Meister\Dropbox\SD30_normtime\',num2str(Rat)))   
% % % % % % % % % % % %     end
% % % % % % % % % % % % end
   
if tdura==1
    if acer==0
      %cd(strcat('/home/raleman/Dropbox/SWR/rat 27/NoLearning_vs_Conditions_2/Baseline3/',labelconditions{iii-3}))
      cd(strcat('/home/raleman/Dropbox/SD60_normtime_first/',num2str(Rat)))

    else
      cd(strcat('C:\Users\Welt Meister\Dropbox\SD60_normtime_first\',num2str(Rat)))   
    end
end

%end

if exist(labelconditions{iii-3})~=7
(mkdir(labelconditions{iii-3}))
end
cd((labelconditions{iii-3}))

saveas(gcf,string)
end
 
close all

end
end

 
end
%%
 end
%end
clearvars -except aver Rat tdura
end
end

cd('/home/raleman/Documents/internship')
run_tonight_maxpower;
% run('run_tonight_maxpower.m')