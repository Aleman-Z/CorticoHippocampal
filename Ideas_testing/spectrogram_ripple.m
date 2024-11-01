acer=1;
% rat24base=1;
DUR{1}='1sec';
DUR{2}='10sec';
Block{1}='complete';
Block{2}='block1';
Block{3}='block2';

%%
if acer==0
addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
addpath(genpath('/home/raleman/Documents/GitHub/CorticoHippocampal'))
%addpath(('/home/raleman/Documents/GitHub/CorticoHippocampal'))
addpath('/home/raleman/Documents/internship')
else
addpath('D:\internship\analysis-tools-master'); %Open Ephys data loader.
addpath(genpath('C:\Users\addri\Documents\internship\CorticoHippocampal'))
%addpath(('C:\Users\addri\Documents\internship\CorticoHippocampal'))
   
end
%%
%Rat=26;
for RAT=2:2
for rat24base=1:2
 
  if RAT~=3 && rat24base==2
      break
  end

for dura=1:2 %Starts with 1
    
rats=[26 27 24 21];
Rat=rats(RAT);    
    
% for Rat=26:26
if Rat==26
nFF=[
%    {'rat26_Base_II_2016-03-24'                         }
%    {'rat26_Base_II_2016-03-24_09-47-13'                }
%    {'rat26_Base_II_2016-03-24_12-55-58'                }
%    {'rat26_Base_II_2016-03-24_12-57-57'                }
    
   
%    {'rat26_nl_base_III_2016-03-30_10-32-57'            }
%     {'rat26_nl_base_II_2016-03-28_10-40-19'             }
     {'rat26_nl_baseline2016-03-01_11-01-55'             }
    {'rat26_plusmaze_base_2016-03-08_10-24-41'}
    
    
    
    {'rat26_novelty_I_2016-04-12_10-05-55'          }
%     {'rat26_novelty_II_2016-04-13_10-23-29'             }
    {'rat26_for_2016-03-21_10-38-54'                    }
%     {'rat26_for_II_2016-03-23_10-49-50'                 }
    
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
    { 
    
    'Baseline'}
%     'Baseline_2'
%     'Baseline_3'
     'PlusMaze'    
     'Novelty'
%      'Novelty_2'
     'Foraging'
%      'Foraging_2'
    ];


end
if Rat==27
nFF=[
     {'rat27_nl_base_2016-03-28_15-01-17'                   }
   % {'rat27_NL_baseline_2016-02-26_12-50-26'               }
   % {'rat27_nl_base_III_2016-03-30_14-36-57'               }
    
    {'rat27_plusmaze_base_2016-03-14_14-52-48'             }
%     {'rat27_plusmaze_base_II_2016-03-24_14-10-08'          }
    {'rat27_novelty_I_2016-04-11_14-34-55'                 } 
    {'rat27_for_2016-03-21_15-03-05'                       }
    %{'Rat27_for_II_2016-03-23_15-06-59'                    }
    
    %{'rat27_novelty_II_2016-04-13_14-37-58'                }  %NO .MAT files found. 
    %{'rat27_novelty_II_2016-04-13_16-29-42'                } %No (complete).MAT files found.
   
  
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
    'Baseline'}
%     'Baseline_2'
%     'Baseline_3'
    'PlusMaze'
%     'PlusMaze_2'
    'Novelty'
    'Foraging'
    
  %   'Foraging_2'
     
    
    
     
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
     'Learning Baseline'
                }
     
     '45minLearning'
     'Novelty_2'
     't-maze'
     'Post t-maze'
    ];
    
end

if Rat==24
nFF=[  
    {'Baseline1'}
%     {'Baseline2'}
%     {'Baseline3'}
%     {'Baseline4'}
    {'Plusmaze1'}
%     {'Plusmaze2'}
   {'Novelty1'}
   {'Foraging1'}
     
]; 
if  rat24base==2
  nFF{1,:}='Baseline2'; 
end

%labelconditions=nFF;
labelconditions=[
    { 
    'Baseline'}
%     'Baseline_2'
%     'Baseline_3'
    'PlusMaze'
%     'PlusMaze_2'
    'Novelty'
    'Foraging'
    
  %   'Foraging_2'
     
    
    
     
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
% inter=1;
%Select length of window in seconds:
if dura==1
ro=[1200];
else
ro=[10200];    
end
% coher=0;
% selectripples=1;
% mergebaseline=0;
notch=0;
nrem=3;
myColorMap = jet(8);
% Score=1;
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
myColorMap = jet(8);                                                                                                                                                                                    
myColorMap =myColorMap([2 4 5 7],:);
myColorMap(2,:)=[0, 204/255, 0];
myColorMap(3,:)=[0.9290, 0.6940, 0.1250];

%Rat 24
% if Rat==24
%     myColorMap = jet(length(nFF));                                                                                                                                                                                    
% end

% xo
for block_time=0:2 %Should start with 0
for w=1:1
    
for iii=1:length(nFF) %Should start with 2!
%xo
if acer==0
    cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
end

if Rat==24
    cd(nFF{1})
end

if dura==2
    cd('10sec')
end

string1=strcat('Spec_',labelconditions{iii},'_',label1{2*2-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
string2=strcat('Spec_',labelconditions{iii},'_',label1{2*3-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');


while exist(string1, 'file')==2 && exist(string2, 'file')==2
iii=iii+1;

if iii>length(nFF)
    break
end
   string1=strcat('Spec_',labelconditions{iii},'_',label1{2*2-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
   string2=strcat('Spec_',labelconditions{iii},'_',label1{2*3-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');

end

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

cd(nFF{iii})
lepoch=2;

 level=1;
 
%Get averaged time signal.
% [sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level(level);
% if strcmp(labelconditions{iii},'Baseline') || strcmp(labelconditions{iii},'PlusMaze')
% [ripple,timeasleep,DEMAIS,y1]=NREM_newest_only_ripple_level(level,nrem,notch,w,lepoch,Score);
% else

%[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=NREM_get_ripples(level,nrem,notch,w,lepoch,Score)
% [Sig1,Sig2,Ripple,Carajo,Veamos,CHTM2,RipFreq22,Timeasleep]=newest_only_ripple_level(level,lepoch)
[sig1,sig2,ripple,carajo,veamos,CHTM,RipFreq2,timeasleep]=newest_only_ripple_level_ERASETHIS(level);


%% Select time block 
if block_time==1
[carajo,veamos]=equal_time2(sig1,sig2,carajo,veamos,30,0);
ripple=sum(cellfun('length',carajo{1}(:,1))); %Number of ripples after equal times.
end

if block_time==2
[carajo,veamos]=equal_time2(sig1,sig2,carajo,veamos,60,30);
ripple=sum(cellfun('length',carajo{1}(:,1))); %Number of ripples after equal times.
end

%%

%[NSig1,NSig2,NRipple,NCarajo,NVeamos,NCHTM2,NRipFreq22,NTimeasleep]=data_newest_only_ripple_level(level,lepoch)
[p,q,~,~,~,~]=getwin2(carajo{:,:,level},veamos{level},sig1,sig2,label1,label2,ro,ripple(level),CHTM(level+1));
clear sig1 sig2
%Ripple selection. Memory free. 
[ran]=select_rip(p);

% 
p=p([ran]);
q=q([ran]);
%Q=Q([ran]);
%timecell=timecell([ran]);
[p]=filter_ripples(p,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);
[q]=filter_ripples(q,[66.67 100 150 266.7 133.3 200 300 333.3 266.7 233.3 250 166.7 133.3],.5,.5);
 


%  
% P1=avg_samples(q,create_timecell(ro,length(p)));
% P2=avg_samples(p,create_timecell(ro,length(p)));
% %[ripple,timeasleep,DEMAIS,y1]=NREM_newest_only_ripple_level(level,nrem,notch,w,lepoch,1);    


% if acer==0
%     cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
% else
%     cd(strcat('D:\internship\',num2str(Rat)))
% end
% 
% cd(nFF{1}) %Baseline

% %run('newest_load_data_nl.m')
% %[sig1_nl,sig2_nl,ripple2_nl,carajo_nl,veamos_nl,CHTM_nl]=newest_only_ripple_nl;
% [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,timeasleep2,RipFreq3]=newest_only_ripple_nl_level(level);
% 
% if block_time==1
% [carajo_nl,veamos_nl]=equal_time2(sig1_nl,sig2_nl,carajo_nl,veamos_nl,30,0);
% ripple_nl=sum(cellfun('length',carajo_nl{1}(:,1)));
% end
% 
% if block_time==2
% [carajo_nl,veamos_nl]=equal_time2(sig1_nl,sig2_nl,carajo_nl,veamos_nl,60,30);
% ripple_nl=sum(cellfun('length',carajo_nl{1}(:,1)));    
% end
% 

% xo
% end
%  save('thresholdfile.mat','ripple','timeasleep','DEMAIS','y1');                                                                                                                                                                                                                                                                                                                                               
%%
% for w=1:3

%%

% h=plot_inter_conditions_33(Rat,nFF,level,ro,w,labelconditions,label1,label2,iii,P1,P2,p,create_timecell(ro,length(p)),sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2,q,timeasleep2,RipFreq3,RipFreq2,timeasleep,ripple,CHTM,acer);
% %%
% pos = get(h,'Position');
% new = mean(cellfun(@(v)v(1),pos(1:2)));
% set(h(9),'Position',[new,pos{9}(2:end)])
% 
% pos = get(h,'Position');
% new = mean(cellfun(@(v)v(1),pos(3:4)));
% set(h(10),'Position',[new,pos{10}(2:end)])
% %%
% set(h(1),'Position',[pos{1}(1:2),pos{1+4}(3:end)])
% set(h(2),'Position',[pos{2}(1:2),pos{2+4}(3:end)])
% set(h(3),'Position',[pos{3}(1:2),pos{3+4}(3:end)])
% set(h(4),'Position',[pos{4}(1:2),pos{4+4}(3:end)])
% 
% %%
% H=gcf;
% ca = get(H, 'Children');  %axes handles
% Pos = get(ca,'Position');
% 
% set(ca(2),'Position', [Pos{1}(1)+0.1496,Pos{2}(2:end)])
% set(ca(8),'Position', [Pos{7}(1)+Pos{7}(3)+0.0078 ,Pos{8}(2:end)])
%%

 for cont=1:length(q)
    [f,G]=frequencylog(q{cont}(w,:),'no');
    %gg(cont,:)=abs(G(1,end/2:end));
    gg(cont,:)=abs(G(1,1:length(f)));
 end

gt=mean(gg);
% area(f*500,smooth(gt,29),'FaceColor',myColorMap(iii,:));alpha(0.5);
%plot(f*500,smooth(gt,29),'Color',myColorMap(iii,:));
K(iii)=fill(f*500,smooth(gt,29),myColorMap(iii,:));alpha(0.5);
hold on

% %error('stop')
% if acer==0
%     cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
% else
%       %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
%       cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
% end
% 
% if Rat==24
%     cd(nFF{1})
% end
% 
% if dura==2
%     cd('10sec')
% end
% 
% string=strcat('Spec_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
% figure_function(gcf,[],string,[]);
% string=strcat('Spec_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.eps');
% print(string,'-depsc')
% string=strcat('Spec_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');
% saveas(gcf,string)
% 
% close all

%%

end
legend(labelconditions)
xo
% K=gcf;
ydata = get(K, 'YData');  %data from low-level grahics objects
ydata=cell2mat(ydata);
ydata=reshape(ydata,[length(ydata)/4 4]);
ymax=max(ydata);
[B,I] = sort(ymax,'descend');
uistack(K(I(1)),'bottom')
uistack(K(I(4)),'top')
xlim([0 400])
grid minor
title('Spectrogram of Hippocampal ripples')
xlabel('Frequency (Hz)')
ylabel('Power (log)')

% uistack(K(I(2)),'down')
% uistack(K(I(3)),'up')



% J=K;
% J=[K(4) K(3) K(2) K(1)]
%  uistack(K(2),'bottom')
%end

end
% xo
end


end

%%
%clearvars -except acer Rat
end
end
%end
