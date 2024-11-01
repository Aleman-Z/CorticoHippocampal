clear variables
acer=1;
rat24base=2; %Rat 24 base.
plot_sleep=0;
%%
%Rat=26;
for RAT=1:3
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
     {'rat26_nl_base_II_2016-03-28_10-40-19'             }
%     {'rat26_nl_baseline2016-03-01_11-01-55'             }
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
   % {'rat27_nl_base_2016-03-28_15-01-17'                   }
   % {'rat27_NL_baseline_2016-02-26_12-50-26'               }
    {'rat27_nl_base_III_2016-03-30_14-36-57'               }
    
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
%     addpath /home/raleman/Documents/internship/fieldtrip-master/
%     InitFieldtrip()

    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
    clc
else
    cd(strcat('D:\internship\',num2str(Rat)))
%     addpath D:\internship\fieldtrip-master
%     InitFieldtrip()

    % cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
    cd(strcat('D:\internship\',num2str(Rat)))
    clc
end

%% Select experiment to perform. 

Score=1;

myColorMap = jet(8);                                                                                                                                                                                    
myColorMap =myColorMap([2 4 5 7],:);
myColorMap(2,:)=[0, 204/255, 0];
myColorMap(3,:)=[0.9290, 0.6940, 0.1250];
% if Rat==24
%     myColorMap = jet(length(nFF));                                                                                                                                                                                    
% end


for iii=1:length(nFF)

    
%  clearvars -except nFF iii labelconditions inter granger Rat ro label1 label2 coher selectripples acer mergebaseline nr_27 nr_26 co_26 co_27 nrem notch myColorMap



%for level=1:length(ripple)-1;    
 %for level=1:1
     
for w=1:1

if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

cd(nFF{iii})

xo
if Rat==24
   load('states.mat')
else
    if Score==2 && (strcmp(labelconditions{iii},'Baseline') || strcmp(labelconditions{iii},'PlusMaze'))
         load('states2.mat')
    else
        st=strcat(nFF{iii},'-states.mat');
        load(st) 
    end
end
% 
 %xo
% Z{iii}=states;
% % %%
L= length(states)/60%min

 g1=sum(states==1)/60; %Wake
 g3=sum(states==3)/60; %NREM
 g4=sum(states==4)/60; %Transitional Sleep
 g5=sum(states==5)/60; %REM
%FYI: Some states have a value of 0, so it is normal that sum(G) is not
%same as L.
 G=[g1 g3 g4 g5]; 
 g=G;
 G=G/L*100

Z{iii}=G;
X{iii}=g;
XX(iii,:)=g;
 %  v=G;
% %%
% f=figure();
%    %v =sort(v,'descend');
% bb=bar([v; nan(1,length(v))], 'Stacked');
% %set(gca,'xtick',1)}
% xlim([0 3])
% lg=legend(fliplr(bb),strcat('State1:','{ }',num2str(round(v(4))),'%'),strcat('State2:','{ }',num2str(round(v(3))),'%'),strcat('State3:','{ }',num2str(round(v(2))),'%'),strcat('State4:','{ }',num2str(round(v(1))),'%'));
% % camroll(-90)
% lg.Location='east'
% %lg.FontSize=18
% 


end


%%

end
% xo
%end


if plot_sleep==1
        if Rat~=24 || rat24base==1 || rat24base==2
        %%
        % ax=figure();
        allscreen()
        y = [Z{1};Z{2};Z{3};Z{4}];
        c = categorical({'Baseline','Plusmaze','Novelty','Foraging'});
        bb=bar(c,y,'stacked')
        ylabel('Cumulative percentage of sleep','FontSize',16)
        lg=legend('Wake','NREM','Transitional Sleep','REM')
        lg.Location='eastoutside';
        lg.FontSize=14
        ax = gca;
        ax.XAxis.FontSize = 16;
        ax.YAxis.FontSize = 16;
        set(bb,{'FaceColor'},{'w';'k';[0.5 0.5 0.5];'r'});
        %%
%         dim = [.14 .2 .2 .2];
%         st1=strcat('Wake: ','{  }',num2str(round(X{1}(1))), ' min','{      }');
%         st2=strcat('NREM: ','{ }',num2str(round(X{1}(2))), ' min','{       }');
%         st3=strcat('T.S.: ','{     }',num2str(round(X{1}(3))), ' min','{     }');
%         st4=strcat('REM: ','{    }',num2str(round(X{1}(4))), ' min','{      }');
%         st6='------------------------';
%         st5=strcat('Total: ','{ }',num2str(sum(round(X{1}))), ' min','{      }');
% 
% 
%         str=[st1;st2;st3;st4;st6;st5];
%         %str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
%         A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
%         A.BackgroundColor=[1 1 1]



        else
        if length(nFF)~=8   
        %% Rat 24    
        allscreen()
        y = [Z{1};Z{2};Z{3};Z{4};Z{5};Z{6}];
        c = categorical({'Baseline 1','Baseline 2','Baseline 3','Baseline 4','Plusmaze 1','Plusmaze 2'});
        bb=bar(c,y,'stacked')
        ylabel('Cumulative percentage of sleep','FontSize',16)
        lg=legend('Wake','NREM','Transitional Sleep','REM')
        lg.Location='eastoutside';
        lg.FontSize=14
        ax = gca;
        ax.XAxis.FontSize = 16;
        ax.YAxis.FontSize = 16;


        else
        %% Rat 24 plus novelty and forage
        allscreen()
        y = [Z{1};Z{2};Z{3};Z{4};Z{5};Z{6};Z{7};Z{8}];
        c = categorical({'Baseline 1','Baseline 2','Baseline 3','Baseline 4','Plusmaze 1','Plusmaze 2','Novelty 1','Foraging 1'});
        bb=bar(c,y,'stacked')
        ylabel('Cumulative percentage of sleep','FontSize',16)
        lg=legend('Wake','NREM','Transitional Sleep','REM')
        lg.Location='eastoutside';
        lg.FontSize=14
        ax = gca;
        ax.XAxis.FontSize = 16;
        ax.YAxis.FontSize = 16;
        %%
        end
        %%    
        end
        
        %%
% allscreen()
% y = [Z{1}];
% % c = categorical({'Wake','NREM','Transitional Sleep','REM'});
% bb=bar(y,'stacked')
%%
% figure; 
% b1=bar(sum(v), 'b')
% hold on
% bar(v(1), 'm')
% hold off
% hold on
% bar(v(2), 'r')
% bar(v(3), 'g')
% bar(v(4), 'y')
%%


%%
% allscreen()
% y = [Z{1};Z{2};Z{3};Z{4}];
% c = categorical({'Baseline','Plusmaze','Novelty','Foraging'});
% bar(c,y,'stacked')
% ylabel('Percentage of sleep','FontSize',16)
% lg=legend('Wake','NREM','Transitional Sleep','REM')
% lg.Location='West';
% lg.FontSize=14
% ax = gca;
% ax.XAxis.FontSize = 16;
% ax.YAxis.FontSize = 16;
% % lg2=legend('Wake','NREM','Transitional Sleep','REM')
% % lg2.Location='East';
% % lg2.FontSize=14
% 
%%
% grid on
xo
if acer==0
    cd(strcat('/home/raleman/Dropbox/Figures/Figure2/',num2str(Rat)))
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd(strcat('C:\Users\addri\Dropbox\Figures\Figure2\',num2str(Rat)))   
end


if Score==2
    cd('new_scoring')
end

if Rat~=24
printing('Sleep_amount');
else
printing(strcat('Sleep_amount_',nFF{1}));
end

close all
end
% xo
%%
Stage= {'Wake';'NREM';'Transitional Sleep';'REM'};
% NoLearning=XX(1,:);
% PlusMaze=XX(2,:);
% Novelty=XX(3,:);
% Foraging=XX(4,:);
  NoLearning={
        (strcat(num2str(XX([1],1))));...
        (strcat(num2str(XX([1],2))));...
        (strcat(num2str(XX([1],3))));...
        (strcat(num2str(XX([1],4))));...
    }

    PlusMaze={
        (strcat(num2str(XX([2],1))));...
        (strcat(num2str(XX([2],2))));...
        (strcat(num2str(XX([2],3))));...
        (strcat(num2str(XX([2],4))));... 
        }


    Novelty={
        (strcat(num2str(XX([3],1))));...
        (strcat(num2str(XX([3],2))));...
        (strcat(num2str(XX([3],3))));...
        (strcat(num2str(XX([3],4))));...
}


    Foraging={

   (strcat(num2str(XX([4],1))));...
        (strcat(num2str(XX([4],2))));...
        (strcat(num2str(XX([4],3))));...
        (strcat(num2str(XX([4],4))));...
    }
  
TT=table(Stage,NoLearning,PlusMaze,Novelty,Foraging)
VV{RAT}=TT;

% g1=sum(states==1)/60; %Wake
%  g3=sum(states==3)/60; %NREM
%  g4=sum(states==4)/60; %Transitional Sleep
%  g5=sum(states==5)/60; %REM
if acer==1
cd('C:\Users\addri\Dropbox\Window')
else
cd('/home/raleman/Dropbox/Window')    
end
cd(num2str(Rat))
writetable(VV{1},'Sleep_stages.xls','Sheet',1,'Range','B2:F6')


%%
clearvars -except acer RAT rat24base plot_sleep Rat VV

end
xo

if acer==1
cd('C:\Users\addri\Dropbox\Window')
else
cd('/home/raleman/Dropbox/Window')    
end

cd(num2str(26))

writetable(VV{1},'Sleep_stages.xlsm','Sheet',1,'Range','B2:F6')
writetable(VV{2},'Sleep_stages.xls','Sheet',1,'Range','B2:F6')
writetable(VV{3},'Sleep_stages.xls','Sheet',1,'Range','B2:F6')


