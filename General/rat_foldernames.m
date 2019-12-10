function [nFF,NFF,labelconditions,label1,label2]=rat_foldernames(Rat,rat26session3,rat27session3,rat24base)

%Rat 26
    if Rat==26
    nFF=[
    %    {'rat26_Base_II_2016-03-24'                         }
    %    {'rat26_Base_II_2016-03-24_09-47-13'                }
    %    {'rat26_Base_II_2016-03-24_12-55-58'                }
    %    {'rat26_Base_II_2016-03-24_12-57-57'                }


    %   {'rat26_nl_base_III_2016-03-30_10-32-57'            }
     %    {'rat26_nl_base_II_2016-03-28_10-40-19'             }
         {'rat26_nl_baseline2016-03-01_11-01-55'             }
        {'rat26_plusmaze_base_2016-03-08_10-24-41'}



        {'rat26_novelty_I_2016-04-12_10-05-55'          }
    %     {'rat26_novelty_II_2016-04-13_10-23-29'             }
        {'rat26_for_2016-03-21_10-38-54'                    }
    %     {'rat26_for_II_2016-03-23_10-49-50'                 }

        ];
    
    
    %Used when testing different baselines.
    if strcmp(nFF{1},'rat26_nl_baseline2016-03-01_11-01-55')
    NFF=[ {'rat26_nl_base_II_2016-03-28_10-40-19'             }];    
    end
    if strcmp(nFF{1},'rat26_nl_base_II_2016-03-28_10-40-19')
    NFF=[ {'rat26_nl_baseline2016-03-01_11-01-55'             }];
    end
    
    if strcmp(nFF{1},'rat26_nl_baseline2016-03-01_11-01-55') && rat26session3==1
       nFF{1}='rat26_nl_base_III_2016-03-30_10-32-57'; 
    end
    
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
    
%Rat 27    
    if Rat==27
    nFF=[
       {'rat27_nl_base_2016-03-28_15-01-17'                   } %Baseline 2: Use this one. 
       % {'rat27_NL_baseline_2016-02-26_12-50-26'               }
       % {'rat27_nl_base_III_2016-03-30_14-36-57'               }

       {'rat27_plusmaze_base_2016-03-14_14-52-48'             }
       %{'rat27_plusmaze_base_II_2016-03-24_14-10-08'          }
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
    %NFF=[{'rat27_NL_baseline_2016-02-26_12-50-26'               }];
    if strcmp(nFF{1},'rat27_NL_baseline_2016-02-26_12-50-26')
    NFF=[ {  'rat27_nl_base_2016-03-28_15-01-17'           }];    
    end
    if strcmp(nFF{1}, 'rat27_nl_base_2016-03-28_15-01-17')
    NFF=[ {'rat27_NL_baseline_2016-02-26_12-50-26'   }];
    end
    if rat27session3==1
        if strcmp(nFF{1}, 'rat27_nl_base_2016-03-28_15-01-17')
        NFF=[ {'rat27_nl_base_III_2016-03-30_14-36-57'   }];
        end
    end

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

%Rat 21    
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

%Rat 24    
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


    NFF=[];
    end
    
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
    

end