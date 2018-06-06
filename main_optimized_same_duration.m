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

for Rat=1:1
rats=[26 27 21];
Rat=rats(Rat);    
    
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
ro=[1200];
coher=0;
selectripples=1;
mergebaseline=1;
nrem=3;
notch=1;
% tdura=30;

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

%%
%for tdura=30:30:60
for tdura=30:30
 for iii=4:4
%length(nFF)
    
 clearvars -except nFF iii labelconditions inter granger Rat ro label1 label2 coher selectripples acer mergebaseline nrem notch tdura
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
lepoch=2;
% error('stop')

chtm=load('vq_loop2.mat');
chtm=chtm.vq;

%Get averaged time signal.
% [sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);    
% [ripple,timeasleep,DEMAIS,y1]=NREM_accurate_spectrogram(nrem,notch,chtm);
%error('stop')

%Check if file already exists
files=dir(fullfile(cd,'*.mat'));
files={files.name};
tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'findrip.mat'), files.', 'UniformOutput',false)));
 
if tst~=1
[sig1,sig2,ripple2,carajo,veamos,RipFreq2,timeasleep]=nrem_fixed_thr(chtm,nrem,notch,[],lepoch);
save findrip.mat   sig1 sig2 ripple2 carajo veamos RipFreq2 timeasleep                                                                                                                                                                                                                                                                                                                                             
else
load('findrip.mat')    
end
 error('stop')
% for t=1:60
[carajo,veamos]=equal_time(sig1,sig2,carajo,veamos,tdura);
ripple=sum(cellfun('length',carajo{1}(:,1)));
% R(t)=ripple;
%end

%Get p and q.
  %Get averaged time signal.
[p,q,timecell,~,~,~]=getwin2(carajo{:,:,level},veamos{level},sig1,sig2,label1,label2,ro,ripple2(level),chtm);

% [p2,q2,timecell2,Q2,~,~]=getwin2(carajo2{:,:,level},veamos2{level},sig1,sig2,label1,label2,ro,ripple2(level),chtm);



% SUS=SU(:,level).';

if selectripples==1
[ran]=rip_outlier(q);
    % 
    p=p([ran]);
    q=q([ran]);
    timecell=timecell([ran]);


    
[ran]=rip_select(q);
    % 
    p=p([ran]);
    q=q([ran]);
    timecell=timecell([ran]);
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

P1=avg_samples(q,timecell);
P2=avg_samples(p,timecell);
%%%%for w=1:size(P2,1)    %Brain region
%% GO TO BASELINE 
for mergebaseline=2:3 %Ignore merged baseline  
if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

%    error('stop')
%% Get average baseline
if mergebaseline==1
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
[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq2,timeasleep2]=nrem_fixed_thr(chtm,nrem,notch,[],lepoch);
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


[carajo_nl,veamos_nl]=equal_time(sig1_nl,sig2_nl,carajo_nl,veamos_nl,tdura);
ripple=sum(cellfun('length',carajo_nl{1}(:,1)));


%     [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,timeasleep2,RipFreq3]=newest_only_ripple_nl_level(level);
    [p_nl,q_nl,timecell,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),chtm);
    
    
        if selectripples==1
            
            [ran_nl]=rip_outlier(q_nl);
            p_nl=p_nl([ran_nl]);
            q_nl=q_nl([ran_nl]);
            timecell=timecell([ran_nl]);


            
            
            [ran_nl]=rip_select(q_nl);

            p_nl=p_nl([ran_nl]);
            q_nl=q_nl([ran_nl]);
            timecell=timecell([ran_nl]);

        end
       
    NU{k}=p_nl;
    QNU{k}=q_nl;
    TNU{k}=timecell;
    
    
    
    
        if acer==0
            cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
        else
            cd(strcat('D:\internship\',num2str(Rat)))
        end
    end
    
    if size(timecell,2)==1000
        p_nl(1:500)=NU{1}(1:500);
        p_nl(501:1000)=NU{2}(1:500);
%         p_nl(667:667+333)=NU{3}(1:334);


        q_nl(1:500)=QNU{1}(1:500);
        q_nl(501:1000)=QNU{2}(1:500);
%         q_nl(667:667+333)=QNU{3}(1:334);
    end
    
     if size(timecell,2)==500
        p_nl(1:250)=NU{1}(1:250);
        p_nl(251:500)=NU{2}(1:250);
%         p_nl(335:335+165)=NU{3}(1:166);


        q_nl(1:250)=QNU{1}(1:250);
        q_nl(251:500)=QNU{2}(1:250);
%         q_nl(335:335+165)=QNU{3}(1:166);
    end
    
toy = [-1.2:.01:1.2];
freq1=justtesting(p_nl,timecell,[1:0.5:30],[],10,toy);    

toy=[-1:.01:1];
freq3=barplot2_ft(q_nl,timecell,[100:1:300],[],toy);

end

if mergebaseline==2

cd(nFF{2}) %Best (Longest) baseline recorded 

    chtm=load('vq_loop2.mat');
    chtm=chtm.vq;

     files=dir(fullfile(cd,'*.mat'));
     files={files.name};
     tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'findrip.mat'), files.', 'UniformOutput',false)));
 
if tst~=1
[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq2,timeasleep2]=nrem_fixed_thr(chtm,nrem,notch,[],lepoch);
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
[carajo_nl,veamos_nl]=equal_time(sig1_nl,sig2_nl,carajo_nl,veamos_nl,tdura);
% ripple3=sum(cellfun('length',carajo_nl{1}(:,1)));
   
%  [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq2,timeasleep2]=nrem_fixed_thr(chtm,nrem,notch,[],lepoch);

%[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,timeasleep2,RipFreq3]=newest_only_ripple_nl_level(level);
ripple3=ripple_nl;

% [p_nl,q_nl,timecell,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),CHTM2(level+1));
[p_nl,q_nl,timecell,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),chtm);


    if selectripples==1

    [ran_nl]=rip_outlier(q_nl);
    p_nl=p_nl([ran_nl]);
    q_nl=q_nl([ran_nl]);
    timecell=timecell([ran_nl]);

    
    [ran_nl]=rip_select(q_nl);
    p_nl=p_nl([ran_nl]);
    q_nl=q_nl([ran_nl]);
    timecell=timecell([ran_nl]);

    end

%      files=dir(fullfile(cd,'*.mat'));
%      files={files.name};
%      tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'freq1same.mat'), files.', 'UniformOutput',false)));
%  
% if tst~=1   
toy = [-1.2:.01:1.2];
freq1=justtesting(p_nl,timecell,[1:0.5:30],[],10,toy);
% save freq1same.mat freq1                                                                                                                                                                                                                                                                                                                                                
% else
% load('freq1same.mat')            
% end    
    

%      files=dir(fullfile(cd,'*.mat'));
%      files={files.name};
%      tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'freq3same.mat'), files.', 'UniformOutput',false)));
%  
% if tst~=1   
toy=[-1:.01:1];
freq3=barplot2_ft(q_nl,timecell,[100:1:300],[],toy);
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


if mergebaseline==3

cd(nFF{1}) %Best (Longest) baseline recorded 

    chtm=load('vq_loop2.mat');
    chtm=chtm.vq;

     files=dir(fullfile(cd,'*.mat'));
     files={files.name};
     tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'findrip.mat'), files.', 'UniformOutput',false)));
 
if tst~=1
% [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq2,timeasleep2]=nrem_fixed_thr(chtm,nrem,notch,[],lepoch);
[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq2,timeasleep2]=nrem_fixed_thr(chtm,nrem,notch,[],lepoch);
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
    load('findrip.mat')
end
end
        
%  [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,RipFreq2,timeasleep2]=nrem_fixed_thr(chtm,nrem,notch,[],lepoch);

%[sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,timeasleep2,RipFreq3]=newest_only_ripple_nl_level(level);
ripple3=ripple_nl;
[carajo_nl,veamos_nl]=equal_time(sig1_nl,sig2_nl,carajo_nl,veamos_nl,tdura);

% [p_nl,q_nl,timecell,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),CHTM2(level+1));
[p_nl,q_nl,timecell,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),chtm);


    if selectripples==1

    [ran_nl]=rip_outlier(q_nl);
    p_nl=p_nl([ran_nl]);
    q_nl=q_nl([ran_nl]);
    timecell=timecell([ran_nl]);
     
        
        
    [ran_nl]=rip_select(q_nl);
    p_nl=p_nl([ran_nl]);
    q_nl=q_nl([ran_nl]);
    timecell=timecell([ran_nl]);

    end
    
% 
%      files=dir(fullfile(cd,'*.mat'));
%      files={files.name};
%      tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'freq1same.mat'), files.', 'UniformOutput',false)));
%  
% if tst~=1   
toy = [-1.2:.01:1.2];
freq1=justtesting(p_nl,timecell,[1:0.5:30],[],10,toy);
% save freq1same.mat freq1                                                                                                                                                                                                                                                                                                                                                
% else
% load('freq1same.mat')            
% end

%      files=dir(fullfile(cd,'*.mat'));
%      files={files.name};
%      tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'freq3same.mat'), files.', 'UniformOutput',false)));
%  
% if tst~=1   
toy=[-1:.01:1];
freq3=barplot2_ft(q_nl,timecell,[100:1:300],[],toy);
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


P1_nl=avg_samples(q_nl,timecell);
P2_nl=avg_samples(p_nl,timecell);


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
titl{1}='MergedBaselines1&2';
titl{2}='Baseline2';
titl{3}='Baseline1';

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
toy = [-1.2:.01:1.2];
freq2=justtesting(p,timecell,[1:0.5:30],[],0.5,toy);
% save freq2same.mat freq2                                                                                                                                                                                                                                                                                                                                                
% else
% load('freq2same.mat')            
% end

%      files=dir(fullfile(cd,'*.mat'));
%      files={files.name};
%      tst=sum(cell2mat(cellfun(@(equis)  strcmp(equis,'freq4same.mat'), files.', 'UniformOutput',false)));
%  
% if tst~=1   
toy=[-1:.01:1];
freq4=barplot2_ft(q,timecell,[100:1:300],w,toy);
% save freq4same.mat freq4                                                                                                                                                                                                                                                                                                                                                
% else
% load('freq4same.mat')            
% end    


plot_inter_FIXED(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,timecell,sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,chtm,q,selectripples,acer,P1_nl,P2_nl,p_nl,q_nl,freq1,freq3,freq2,freq4)
%plot_inter_FIXED(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,timecell,sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,selectripples);
string=strcat(label1{2*w-1},'_',num2str(tdura),'_',titl{mergebaseline},'.png');
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
    if acer==0
      %cd(strcat('/home/raleman/Dropbox/SWR/rat 27/NoLearning_vs_Conditions_2/Baseline3/',labelconditions{iii-3}))
      cd(strcat('/home/raleman/Dropbox/SameDuration/',num2str(Rat)))

    else
      cd(strcat('C:\Users\Welt Meister\Dropbox\SameDuration\',num2str(Rat)))   
    end
        
%end

if exist(labelconditions{iii-3})~=7
(mkdir(labelconditions{iii-3}))
end
cd((labelconditions{iii-3}))

saveas(gcf,string)
end
 
% if ro==1700
%     run('plot_pre_post.m')
%     string=strcat('NEW2_pre_post_',label1{2*w-1},'_',num2str(level),'.png');
%     saveas(gcf,string)
% end

%&& granger==0

% if ro==1200 && inter==0 && granger==0
% run('plot_both.m')
% % string=strcat('NEW2_between_',label1{2*w-1},'_',num2str(level),'.png');
%  string=strcat('NoRipple_',label1{2*w-1},'_',num2str(level),'.png');
%  saveas(gcf,string)
% end

close all

%if w==1 && granger==1

% if w==2 && coher==1
%     allscreen()    
%     [coh]=barplot_COH(q,timecell,[100:2:300])
%     title('Time-Frequency Coherence (Bandpassed: 100-300 Hz)')
%     string=strcat('COH_','Bandpass_Ripple_',num2str(level),'.png');
%     saveas(gcf,string)
%     close all
% 
%     allscreen()
%     [coh]=barplot_COH(p,timecell,[1:1:30])
%     title('Time-Frequency Coherence (Wideband)')
%     string=strcat('COH_','Wideband_Ripple_',num2str(level),'.png');
%     saveas(gcf,string)
%     close all
% 
% end

% if  w==2 && granger==1
% 
% if Rat==26
%     %cd(strcat('/home/raleman/Dropbox/SWR/NoLearning_vs_Conditions_2/',labelconditions{iii-3},'/test'))
%     cd(strcat('/home/raleman/Dropbox/SWR/NoLearning_vs_Conditions_2/',labelconditions{iii-3}))
% 
% end
% 
% if Rat==27
%     cd(strcat('/home/raleman/Dropbox/SWR/rat 27/NoLearning_vs_Conditions_2/Baseline3/',labelconditions{iii-3}))
% end
%     
%         
% % if Rat==27
% % % cd( strcat('/home/raleman/Dropbox/SWR/Connectivity_measures/',labelconditions{iii}))
% % cd( strcat('/home/raleman/Dropbox/SWR_2/rat_27/Connectivity measures/',labelconditions{iii}))
% % end
% 
% 
% %Wideband
% [gran,gran1]=gc_paper(p,timecell,'Widepass',ro);
% [p_nl,q_nl,timecell]=gc_no_learning(level,ro,label1,label2,sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2);
% [gran_nl,gran1_nl]=gc_paper(p_nl,timecell,'Widepass',ro);
% 
% granger_paper(gran,gran_nl,labelconditions{iii-3})
% string=strcat('GC_','Widepass_Ripples_NP_',num2str(level),'.png');
% 
% saveas(gcf,string)
% close all
% 
% granger_paper(gran1,gran1_nl,labelconditions{iii-3})
% string=strcat('GC_','Widepass_Ripples_P_',num2str(level),'.png');
% 
% saveas(gcf,string)
% close all
% 
% %Bandpassed
% 
% [gran,gran1]=gc_paper(q,timecell,'Bandpassed',ro);
% % [p_nl,q_nl,timecell]=gc_no_learning(level,ro,label1,label2,sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2);
% [gran_nl,gran1_nl]=gc_paper(q_nl,timecell,'Bandpassed',ro);
% 
% granger_paper(gran,gran_nl,labelconditions{iii-3})
% string=strcat('GC_','Bandpassed_Ripples_NP_',num2str(level),'.png');
% 
% saveas(gcf,string)
% close all
% 
% granger_paper(gran1,gran1_nl,labelconditions{iii-3})
% string=strcat('GC_','Bandpassed_Ripples_P_',num2str(level),'.png');
% 
% saveas(gcf,string)
% close all
% 
% end


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
end