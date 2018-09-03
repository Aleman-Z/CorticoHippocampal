acer=0;
rat24base=1;
sanity=1;
%%
if acer==0
addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
addpath('/home/raleman/Documents/GitHub/CorticoHippocampal')
addpath('/home/raleman/Documents/internship')
else
addpath('D:\internship\analysis-tools-master'); %Open Ephys data loader.
addpath('C:\Users\addri\Documents\internship\CorticoHippocampal')
   
end
%%
%Rat=26;
for Rat=2:2
rats=[26 27 21 24];
Rat=rats(Rat);    
    
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

Score=1;
% 
% if Rat==26
%     Score=2;
% end

myColorMap = jet(8);                                                                                                                                                                                    
myColorMap =myColorMap([2 4 5 7],:);
myColorMap(2,:)=[0, 204/255, 0];
myColorMap(3,:)=[0.9290, 0.6940, 0.1250];
% if Rat==24
%     myColorMap = jet(length(nFF));                                                                                                                                                                                    
% end

%Paper order
nFF=nFF([1 4 3 2]);
labelconditions=labelconditions([1 4 3 2]);


for iii=1:length(nFF)

    
%  clearvars -except nFF iii labelconditions inter granger Rat ro label1 label2 coher selectripples acer mergebaseline nr_27 nr_26 co_26 co_27 nrem notch myColorMap



%for level=1:length(ripple)-1;    
 %for level=1:1
%xo     
for w=1:1

if acer==0
    cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
else
    cd(strcat('D:\internship\',num2str(Rat)))
end

cd(nFF{iii})

%xo
if Rat==24
   load('states.mat')
else
    if Score==2 && (strcmp(labelconditions{iii},'Baseline') || strcmp(labelconditions{iii},'PlusMaze'))
%    if Score==2 

        load('states2.mat')
    else
        st=strcat(nFF{iii},'-states.mat');
        load(st) 
    end
end
%%
% xo
%1,3,4,5
s1=(states==1);
s3=(states==3);
s4=(states==4);
s5=(states==5);

 %Wake
 %NREM
 %Transitional Sleep
 %REM
nb(iii,:)=[nbouts(s1,Score) nbouts(s3,Score) nbouts(s4,Score) nbouts(s5,Score)];

LL(iii,:)=[{lbouts(s1)} {lbouts(s3)} {lbouts(s4)} {lbouts(s5)}];

%%




%%
%%

%%

%%
% xo
% Z{iii}=states;
% % %%
L= length(states)/60%min

 g1=sum(states==1)/60; %Wake
 g3=sum(states==3)/60; %NREM
 g4=sum(states==4)/60; %Transitional Sleep
 g5=sum(states==5)/60; %REM

 G=[g1 g3 g4 g5];
 g=G;
 G=G/L*100

Z{iii}=G;
X{iii}=g; 
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
 %xo
%end
% (LL(1,:))
%%
% LQ = [cell2mat(LL(1,1)) cell2mat(LL(1,2))  cell2mat(LL(1,3))  cell2mat(LL(1,4))];    
% grp = [zeros(1,cellfun('length',LL(1,1))),ones(1,cellfun('length',LL(1,2))),2*ones(1,cellfun('length',LL(1,3))),3*ones(1,cellfun('length',LL(1,4)))];
%%
labstage{1}='Wake';
labstage{2}='NREM';
labstage{3}='Transitional Sleep';
labstage{4}='REM';
%Wake
 %NREM
 %Transitional Sleep
 %REM
%%
if acer==0
    cd(strcat('/home/raleman/Dropbox/Figures/Figure3/',num2str(Rat)))
else
      %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
      cd(strcat('C:\Users\addri\Dropbox\Figures\Figure3\',num2str(Rat)))   
end
%%
xo
if sanity==1
     b=struct2cell(dir);

    if ~any(ismember(b(1,:),'LL.mat'))
        [LL]=control_bouts(LL); 
        save('LL.mat','LL')
    else
        load('LL.mat')
    end   
end
%%
if sanity==1
    H=2;
else
    H=4;
end
%% Individual plots
for h=1:H
LQ = [cell2mat(LL(1,h)) cell2mat(LL(2,h))  cell2mat(LL(3,h))  cell2mat(LL(4,h))];    
grp = [zeros(1,cellfun('length',LL(1,h))),ones(1,cellfun('length',LL(2,h))),2*ones(1,cellfun('length',LL(3,h))),3*ones(1,cellfun('length',LL(4,h)))];

%%
% allscreen()
%bb=boxplot(LQ,grp,'Notch','on' );
%subplot(1,2,1)
bb=boxplot(LQ./60,grp);
set(bb(7,:),'Visible','off');
ave=gca;
ave.XTickLabel=labelconditions;
ylabel('Bout Duration (min)')
T=title(labstage{h})
% ylim([-2 15])
ylim auto
T.FontSize=13;
%%
if sanity==1
string=strcat('Control_Bouts_Duration_',labstage{h},'.pdf');
figure_function(gcf,[],string,[]);
string=strcat('Control_Bouts_Duration_',labstage{h},'.eps');
print(string,'-depsc')
string=strcat('Control_Bouts_Duration_',labstage{h},'.fig');
saveas(gcf,string)
    
else
string=strcat('Bouts_Duration_',labstage{h},'.pdf');
figure_function(gcf,[],string,[]);
string=strcat('Bouts_Duration_',labstage{h},'.eps');
print(string,'-depsc')
string=strcat('Bouts_Duration_',labstage{h},'.fig');
saveas(gcf,string)
    
end

%%
kk=categorical(labelconditions)
bar(kk,nb(:,h))
ylabel('Number of bouts')
T=title(labstage{h})
ylim auto
%%
if sanity==1
string=strcat('Control_Bouts_Number_',labstage{h},'.pdf');
figure_function(gcf,[],string,[]);
string=strcat('Control_Bouts_Number_',labstage{h},'.eps');
print(string,'-depsc')
string=strcat('Control_Bouts_Number_',labstage{h},'.fig');
saveas(gcf,string)

else
string=strcat('Bouts_Number_',labstage{h},'.pdf');
figure_function(gcf,[],string,[]);
string=strcat('Bouts_Number_',labstage{h},'.eps');
print(string,'-depsc')
string=strcat('Bouts_Number_',labstage{h},'.fig');
saveas(gcf,string)
    
end

%%

pause(2)
close all

end


%% subplots
if sanity==1
    H=2;
else
    H=4;
end
%%
for h=1:H
LQ = [cell2mat(LL(1,h)) cell2mat(LL(2,h))  cell2mat(LL(3,h))  cell2mat(LL(4,h))];    
grp = [zeros(1,cellfun('length',LL(1,h))),ones(1,cellfun('length',LL(2,h))),2*ones(1,cellfun('length',LL(3,h))),3*ones(1,cellfun('length',LL(4,h)))];

%%
allscreen()
%bb=boxplot(LQ,grp,'Notch','on' );
subplot(1,2,1)
bb=boxplot(LQ./60,grp);
set(bb(7,:),'Visible','off');
ave=gca;
ave.XTickLabel=labelconditions;
ylabel('Bout Duration (min)')
%title(labstage{h})
% ylim([-2 15])
ylim auto
subplot(1,2,2)
kk=categorical(labelconditions)
bar(kk,nb(:,h))
ylabel('Number of bouts')
T=title(labstage{h})
ylim auto
%%
% T.Position=[T.Position(1)/2 T.Position(2) T.Position(3)];
T.Position=[-0.15 T.Position(2) T.Position(3)];
T.FontSize=15;
%%
%xo
if sanity==1
string=strcat('Control_Bouts_',labstage{h},'.pdf');
figure_function(gcf,[],string,[]);
string=strcat('Control_Bouts_',labstage{h},'.eps');
print(string,'-depsc')
string=strcat('Control_Bouts_',labstage{h},'.fig');
saveas(gcf,string)

else
string=strcat('Bouts_',labstage{h},'.pdf');
figure_function(gcf,[],string,[]);
string=strcat('Bouts_',labstage{h},'.eps');
print(string,'-depsc')
string=strcat('Bouts_',labstage{h},'.fig');
saveas(gcf,string)
    
end

pause(2)
close all

end
%%


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
%%
dim = [.14 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{1}(1))), ' min','{      }');
st2=strcat('NREM: ','{ }',num2str(round(X{1}(2))), ' min','{       }');
st3=strcat('T.S.: ','{     }',num2str(round(X{1}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{1}(4))), ' min','{      }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{1}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]
%%
dim = [.307 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{4}(1))), ' min','{      }');
st2=strcat('NREM: ','{ }',num2str(round(X{4}(2))), ' min','{        }');
if Rat==27
st3=strcat('T.S.: ','{     }',num2str(round(X{4}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{4}(4))), ' min','{       }');
else
st3=strcat('T.S.: ','{     }',num2str(round(X{4}(3))), ' min','{     }');
st4=strcat('REM: ','{     }',num2str(round(X{4}(4))), ' min','{         }');    
end
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{4}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
B=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
B.BackgroundColor=[1 1 1]
%%

dim = [.472 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{3}(1))), ' min','{      }');
if Rat==27
st2=strcat('NREM: ','{ }',num2str(round(X{3}(2))), ' min','{       }');
else
st2=strcat('NREM: ','{ }',num2str(round(X{3}(2))), ' min','{        }');    
end
st3=strcat('T.S.: ','{     }',num2str(round(X{3}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{3}(4))), ' min','{       }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{3}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
C=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
C.BackgroundColor=[1 1 1]

%%

dim = [.64 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{2}(1))), ' min','{      }');
st2=strcat('NREM: ','{ }',num2str(round(X{2}(2))), ' min','{        }');
st3=strcat('T.S.: ','{     }',num2str(round(X{2}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{2}(4))), ' min','{       }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{2}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
D=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
D.BackgroundColor=[1 1 1]

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

dim = [.12 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{1}(1))), ' min','{      }');
st2=strcat('NREM: ','{ }',num2str(round(X{1}(2))), ' min','{       }');
st3=strcat('T.S.: ','{     }',num2str(round(X{1}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{1}(4))), ' min','{      }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{1}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]
    
%A.Position=[0.1200 0.2259 0.1115 0.1741];
A.Position=[0.1195    0.2259    0.1045    0.1741];

dim = [.23 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{2}(1))), ' min','{      }');
st2=strcat('NREM: ','{ }',num2str(round(X{2}(2))), ' min','{        }');
st3=strcat('T.S.: ','{     }',num2str(round(X{2}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{2}(4))), ' min','{       }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{2}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]

ch=3;
dim = [.34 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{ch}(1))), ' min','{      }');
st2=strcat('NREM: ','{ }',num2str(round(X{ch}(2))), ' min','{        }');
st3=strcat('T.S.: ','{     }',num2str(round(X{ch}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{ch}(4))), ' min','{       }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{ch}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]

ch=4;
dim = [.45 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{ch}(1))), ' min','{      }');
st2=strcat('NREM: ','{ }',num2str(round(X{ch}(2))), ' min','{        }');
st3=strcat('T.S.: ','{     }',num2str(round(X{ch}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{ch}(4))), ' min','{       }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{ch}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]

ch=5;
dim = [.56 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{ch}(1))), ' min','{       }');
st2=strcat('NREM: ','{ }',num2str(round(X{ch}(2))), ' min','{       }');
st3=strcat('T.S.: ','{     }',num2str(round(X{ch}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{ch}(4))), ' min','{      }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{ch}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]
%%
ch=6;
dim = [.67 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{ch}(1))), ' min','{       }');
st2=strcat('NREM: ','{ }',num2str(round(X{ch}(2))), ' min','{       }');
st3=strcat('T.S.: ','{     }',num2str(round(X{ch}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{ch}(4))), ' min','{      }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{ch}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]
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
ch=1;
dim = [.09 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{ch}(1))), ' min','{      }');
st2=strcat('NREM: ','{ }',num2str(round(X{ch}(2))), ' min','{       }');
st3=strcat('T.S.: ','{     }',num2str(round(X{ch}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{ch}(4))), ' min','{      }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{ch}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]
%%
ch=2;
dim = [.18 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{ch}(1))), ' min','{      }');
st2=strcat('NREM: ','{ }',num2str(round(X{ch}(2))), ' min','{        }');
st3=strcat('T.S.: ','{     }',num2str(round(X{ch}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{ch}(4))), ' min','{       }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{ch}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]
%%
ch=3;
dim = [.26 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{ch}(1))), ' min','{      }');
st2=strcat('NREM: ','{ }',num2str(round(X{ch}(2))), ' min','{        }');
st3=strcat('T.S.: ','{     }',num2str(round(X{ch}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{ch}(4))), ' min','{       }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{ch}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]
%%
ch=4;
dim = [.34 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{ch}(1))), ' min','{      }');
st2=strcat('NREM: ','{ }',num2str(round(X{ch}(2))), ' min','{        }');
st3=strcat('T.S.: ','{     }',num2str(round(X{ch}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{ch}(4))), ' min','{       }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{ch}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]
%%
ch=5;
dim = [.44 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{ch}(1))), ' min','{       }');
st2=strcat('NREM: ','{ }',num2str(round(X{ch}(2))), ' min','{       }');
st3=strcat('T.S.: ','{     }',num2str(round(X{ch}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{ch}(4))), ' min','{      }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{ch}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]
%%
ch=6;
dim = [.525 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{ch}(1))), ' min','{       }');
st2=strcat('NREM: ','{ }',num2str(round(X{ch}(2))), ' min','{       }');
st3=strcat('T.S.: ','{     }',num2str(round(X{ch}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{ch}(4))), ' min','{      }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{ch}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]
%%
ch=7;
dim = [.61 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{ch}(1))), ' min','{      }');
st2=strcat('NREM: ','{ }',num2str(round(X{ch}(2))), ' min','{        }');
st3=strcat('T.S.: ','{     }',num2str(round(X{ch}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{ch}(4))), ' min','{       }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{ch}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]
%%
ch=8;
dim = [.70 .2 .2 .2];
st1=strcat('Wake: ','{  }',num2str(round(X{ch}(1))), ' min','{       }');
st2=strcat('NREM: ','{ }',num2str(round(X{ch}(2))), ' min','{       }');
st3=strcat('T.S.: ','{     }',num2str(round(X{ch}(3))), ' min','{     }');
st4=strcat('REM: ','{    }',num2str(round(X{ch}(4))), ' min','{      }');
st6='------------------------';
st5=strcat('Total: ','{ }',num2str(sum(round(X{ch}))), ' min','{      }');


str=[st1;st2;st3;st4;st6;st5];
%str = [ strcat('Wake:',num2str(round(X{1}(1))), ' min'); strcat('NREM:',num2str(round(X{1}(2))), '  min'); strcat('T.S. :',num2str(round(X{1}(3))), '  min');strcat('REM:  ',num2str(round(X{1}(4))), '  min')];
A=annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',12);
A.BackgroundColor=[1 1 1]    
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
string=strcat('Sleep_amount','.eps');
% saveas(gcf,string)
print(string,'-depsc')

string=strcat('Sleep_amount','.fig');
saveas(gcf,string)

string=strcat('Sleep_amount','.pdf');
figure_function(gcf,[],string,[]);

else

string=strcat('Sleep_amount_',nFF{1},'.eps');
% saveas(gcf,string)
print(string,'-depsc')

string=strcat('Sleep_amount_',nFF{1},'.fig');
saveas(gcf,string)

string=strcat('Sleep_amount_',nFF{1},'.pdf');
figure_function(gcf,[],string,[]);

end


close all

%%
clearvars -except acer Rat

end
