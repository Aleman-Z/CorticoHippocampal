clear variables
% cd('C:\Users\students\Documents\OS_ephys_da\Data_downsampled')
cd('/home/adrian/Documents/new_OS_downsampled_2020')

%First tune threshold, then run detection for that threshold.
list = {'Try threshold','Run detection','Find SD values'};
[ind_mode] = listdlg('SelectionMode','single','ListString',list);

%Select sleep stage or use all.
list = {'Wake','NREM','Transitional','REM','All'};
[indx1] = listdlg('SelectionMode','single','ListString',list,'InitialValue',2);

switch indx1
    case 1
        ss = 1; 
        stage='Wake';
    case 2
        ss = 3; 
        stage='NREM';
    case 3
        ss = 4; %Transitional
        stage='Trans';
    case 4
        ss = 5; %REM
        stage='REM';
    case 5
        ss = 6; %ALL
        stage='ALL';
        
end

fn=1000; %Sampling frequency.

% xx = inputdlg({'Cortical area (PAR or PFC)'},...
%               'Type your selection', [1 50],{'PFC'}); 
          
%Brain region combinations.
list = {'HPC & PFC','HPC & PAR','PAR & PFC'};
[optionlist] = listdlg('PromptString',{'Select brain areas.'},'SelectionMode','single','ListString',list,'InitialValue',1);
switch optionlist
    case 1
      yy={'HPC'};       
      xx={'PFC'};
    case 2
      yy={'HPC'};    
      xx={'PAR'};  
    case 3
      yy={'PAR'};    
      xx={'PFC'};  
end



% D1=70;
% D2=40;

if ind_mode==1 || ind_mode==2
%Threshold selection 
  prompt = {['Select a threshold value for',' ',yy{1}]};
    dlgtitle = 'Threshold HPC';
    definput = {'70'};
    % opts.Interpreter = 'tex';
    answer = inputdlg(prompt,dlgtitle,[1 40],definput);
    D1=str2num(answer{1}) 
    %100 for Rat 26


    prompt = {['Select a threshold value for',' ',xx{1}]};
    dlgtitle = ['Threshold',' ',xx{1}]; %'Threshold PFC';
    definput = {'40'};
    % opts.Interpreter = 'tex';
    answer = inputdlg(prompt,dlgtitle,[1 40],definput);
    D2=str2num(answer{1}) 
end         
    

nr_swr_HPC=[];
nr_swr_Cortex=[];

rat_folder=getfolder;
%Sort the folder numbers in an ascending way.
[~,w2]=sort(cellfun(@str2num,rat_folder));
rat_folder=rat_folder(w2);

for k=1:length(rat_folder)
%for k=7:length(rat_folder)
    cd(rat_folder{k})    
    g=getfolder;
%xo
    for j=1:length(g)
        cd(g{j})
%end
        G=getfolder;
                
%%        
%Get presleep
cfold=G(or(cellfun(@(x) ~isempty(strfind(x,'pre')),G),cellfun(@(x) ~isempty(strfind(x,'Pre')),G)));
cfold=cfold(and(~contains(cfold,'test'),~contains(cfold,'Test')));

% Get post trials
cfold2=G(or(cellfun(@(x) ~isempty(strfind(x,'post')),G),cellfun(@(x) ~isempty(strfind(x,'Post')),G)));
cfold2=cfold2(and(~contains(cfold2,'test'),~contains(cfold2,'Test')));
%%
%Ignore trial 6
for ind=1:length(cfold2)
  if  ~(contains(cfold2{ind},'trial1') ||contains(cfold2{ind},'trial2')||contains(cfold2{ind},'trial3')||contains(cfold2{ind},'trial4')||contains(cfold2{ind},'trial5')...
        ||contains(cfold2{ind},'Trial1')||contains(cfold2{ind},'Trial2')||contains(cfold2{ind},'Trial3')||contains(cfold2{ind},'Trial4')||contains(cfold2{ind},'Trial5')  )
      
      cfold2{ind}=[];    
  end
end

cfold2=cfold2(~cellfun('isempty',cfold2));

G=[cfold cfold2];

        
              
        if isempty(G)
            no_folder=1;
            %g=NaN;
        else
            no_folder=0;

            for i=1:length(G);

%                  xo
                cd(G{i})
                A = dir('*states*.mat');
                A={A.name};
                
                if sum(contains(A, 'states')) > 0 %More than 2 sleep scoring files
                    A=A(cellfun(@(x) ~isempty(strfind(x,'states')),A));
                    A=A(~(cellfun(@(x) ~isempty(strfind(x,'eeg')),A)));
                    
%                     st2=st(cellfun(@(x) ~isempty(strfind(x,barea)),st)); %Brain area.
                    cellfun(@load,A);

%xo
% HPC=dir('*HPC_*.mat');
HPC=dir(strcat('*',yy{1},'*.mat'));
HPC=HPC.name;
HPC=load(HPC);
HPC=HPC.HPC;
HPC=HPC.*(0.195);

Cortex=dir(strcat('*',xx{1},'*.mat'));
Cortex=Cortex.name;
Cortex=load(Cortex);
% Cortex=Cortex.Cortex;
Cortex=getfield(Cortex,xx{1});
Cortex=Cortex.*(0.195);



                                      

                    if and(~contains(G{i},'trial5'),~contains(G{i},'Trial5')) %Whenever it is not PostTrial 5 
                        
                        % Sleep Scoring data
                        if length(states)<45*60
                            states=[states nan(1,45*60-length(states))]; %Fill with NaNs.
                        else
                            states=states(1:45*60); %Take only 45 min.
                        end
                        
                        %Ephys data
                        if length(HPC)<45*60*fn
                            HPC=[HPC.' (nan(45*60*fn-length(HPC),1).')]; %Fill with NaNs.
                        else
                            HPC=HPC(1:45*60*fn).'; %Take only 45 min.
                        end
                        
                        if length(Cortex)<45*60*fn
                            Cortex=[Cortex.' (nan(45*60*fn-length(Cortex),1).')]; %Fill with NaNs.
                        else
                            Cortex=Cortex(1:45*60*fn).'; %Take only 45 min.
                        end
                                              
        
    if ind_mode==1
        %% Threshold selection
        [swr_hpc,swr_pfc,s_hpc,s_pfc,V_hpc,V_pfc,signal2_hpc,signal2_pfc,sd_swr]=swr_check_thr(HPC,Cortex,states,ss,D1,D2);       
        max_length=cellfun(@length,V_hpc);
        N=max_length==max(max_length);
        % max_length=cellfun(@length,swr_pfc(:,1));
        % N=max_length==max(max_length);

        hpc=V_hpc{N};
        pfc=V_pfc{N};
        hpc2=signal2_hpc{N};
        pfc2=signal2_pfc{N};
        n=find(N);

        plot((1:length(hpc))./fn,5.*zscore(hpc)+100,'Color','black')
        hold on
        plot((1:length(pfc))./fn,5.*zscore(pfc)+150,'Color','black')
        xlabel('Time (Seconds)')


        stem([swr_hpc{n,3}],ones(length([swr_hpc{n}]),1).*350,'Color','blue') %(HPC)
        stem([swr_pfc{n,3}],ones(length([swr_pfc{n}]),1).*350,'Color','red')%Seconds (Cortex)

        % 
        plot((1:length(hpc2))./fn,5.*zscore(hpc2)+220,'Color','black')
        plot((1:length(pfc2))./fn,5.*zscore(pfc2)+290,'Color','black')
        % 
        % 
        yticks([100 150 220 290])
        yticklabels({'HPC',xx{1},'HPC (Bandpassed)',[xx{1} '(Bandpassed)']})
        a = get(gca,'YTickLabel');
        set(gca,'YTickLabel',a,'FontName','Times','fontsize',12)
    'Stop the code here'
        xo
    end
%    xo
    
    if ind_mode==2
        %Count events
        [nr_swr_HPC(i,:), nr_swr_Cortex(i,:), nr_cohfos(i,:),nr_single_hpc(i,:),nr_single_cortex(i,:)]=bin_swr_detection(HPC,Cortex,states,ss,D1,D2,xx,yy,fn); 
    end

    
    if ind_mode==3
        %Find SD values
        [sd_swr]=find_std(HPC,Cortex,states,ss);
        
        Sd_Swr.sd2_hpc_co(i)=sd_swr.sd2_hpc_co;
        Sd_Swr.sd5_hpc_co(i)=sd_swr.sd5_hpc_co;
        Sd_Swr.sd2_pfc_co(i)=sd_swr.sd2_pfc_co;
        Sd_Swr.sd5_pfc_co(i)=sd_swr.sd5_pfc_co;
        Sd_Swr.sd2_hpc_long(i)=sd_swr.sd2_hpc_long;
        Sd_Swr.sd5_hpc_long(i)=sd_swr.sd5_hpc_long;
        Sd_Swr.sd2_pfc_long(i)=sd_swr.sd2_pfc_long;
        Sd_Swr.sd5_pfc_long(i)=sd_swr.sd5_pfc_long;
        
%         if i==5
%             xo
%         end
    end
    
    
                    else % PostTrial 5 case 
%                         xo
                        %Sleep scoring data
                        if length(states)<45*60*4
                            states=[states nan(1,45*60*4-length(states))]; %Fill with NaNs.
                        else
                            states=states(1:45*60*4); %Take only 45 min.
                        end
                        
                        
                        %Ephys
                        if length(HPC)<45*60*fn*4
                            HPC=[HPC.' (nan(45*60*fn*4-length(HPC),1).')]; %Fill with NaNs.
                        else
                            HPC=HPC(1:45*60*fn*4).'; %Take only 45 min.
                        end
                        
                        if length(Cortex)<45*60*fn*4
                            Cortex=[Cortex.' (nan(45*60*fn*4-length(Cortex),1).')]; %Fill with NaNs.
                        else
                            Cortex=Cortex(1:45*60*fn*4).'; %Take only 45 min.
                        end

                        
                        %Chunk in 4
                        states1=states(1:2700);
                        states2=states(2700+1:2700*2);
                        states3=states(1+2700*2:2700*3);
                        states4=states(1+2700*3:2700*4);
                        
                        HPC_1=HPC(1:2700*fn);
                        HPC_2=HPC(2700*fn+1:2700*2*fn);
                        HPC_3=HPC(1+2700*2*fn:2700*3*fn);
                        HPC_4=HPC(1+2700*3*fn:2700*4*fn);
                        
                        Cortex_1=Cortex(1:2700*fn);
                        Cortex_2=Cortex(2700*fn+1:2700*2*fn);
                        Cortex_3=Cortex(1+2700*2*fn:2700*3*fn);
                        Cortex_4=Cortex(1+2700*3*fn:2700*4*fn);
                        
                        if ind_mode==2
                            [nr_swr_HPC(6,:), nr_swr_Cortex(6,:),nr_cohfos(6,:),nr_single_hpc(6,:),nr_single_cortex(6,:)]=bin_swr_detection(HPC_1,Cortex_1,states1,ss,D1,D2,xx,yy,fn);  
                            [nr_swr_HPC(7,:), nr_swr_Cortex(7,:),nr_cohfos(7,:),nr_single_hpc(7,:),nr_single_cortex(7,:)]=bin_swr_detection(HPC_2,Cortex_2,states2,ss,D1,D2,xx,yy,fn);  
                            [nr_swr_HPC(8,:), nr_swr_Cortex(8,:),nr_cohfos(8,:),nr_single_hpc(8,:),nr_single_cortex(8,:)]=bin_swr_detection(HPC_3,Cortex_3,states3,ss,D1,D2,xx,yy,fn);  
                            [nr_swr_HPC(9,:), nr_swr_Cortex(9,:),nr_cohfos(9,:),nr_single_hpc(9,:),nr_single_cortex(9,:)]=bin_swr_detection(HPC_4,Cortex_4,states4,ss,D1,D2,xx,yy,fn);  
                        end
                        
                        if ind_mode==3
                                    %Find SD values
                                    %[~,~,~,~,~,~,~,~,sd_swr]=swr_check_thr(HPC_1,Cortex_1,states1,ss,70,30);
                                    [sd_swr]=find_std(HPC_1,Cortex_1,states1,ss);
                                    Sd_Swr.sd2_hpc_co(6)=sd_swr.sd2_hpc_co;
                                    Sd_Swr.sd5_hpc_co(6)=sd_swr.sd5_hpc_co;
                                    Sd_Swr.sd2_pfc_co(6)=sd_swr.sd2_pfc_co;
                                    Sd_Swr.sd5_pfc_co(6)=sd_swr.sd5_pfc_co;
                                    Sd_Swr.sd2_hpc_long(6)=sd_swr.sd2_hpc_long;
                                    Sd_Swr.sd5_hpc_long(6)=sd_swr.sd5_hpc_long;
                                    Sd_Swr.sd2_pfc_long(6)=sd_swr.sd2_pfc_long;
                                    Sd_Swr.sd5_pfc_long(6)=sd_swr.sd5_pfc_long;
                                    
                                    
                                    %[~,~,~,~,~,~,~,~,sd_swr]=swr_check_thr(HPC_2,Cortex_2,states2,ss,70,30);
                                    [sd_swr]=find_std(HPC_2,Cortex_2,states2,ss);
                                    Sd_Swr.sd2_hpc_co(7)=sd_swr.sd2_hpc_co;
                                    Sd_Swr.sd5_hpc_co(7)=sd_swr.sd5_hpc_co;
                                    Sd_Swr.sd2_pfc_co(7)=sd_swr.sd2_pfc_co;
                                    Sd_Swr.sd5_pfc_co(7)=sd_swr.sd5_pfc_co;
                                    Sd_Swr.sd2_hpc_long(7)=sd_swr.sd2_hpc_long;
                                    Sd_Swr.sd5_hpc_long(7)=sd_swr.sd5_hpc_long;
                                    Sd_Swr.sd2_pfc_long(7)=sd_swr.sd2_pfc_long;
                                    Sd_Swr.sd5_pfc_long(7)=sd_swr.sd5_pfc_long;
                                    
                                    %[~,~,~,~,~,~,~,~,sd_swr]=swr_check_thr(HPC_3,Cortex_3,states3,ss,70,30);
                                    [sd_swr]=find_std(HPC_3,Cortex_3,states3,ss);
                                    Sd_Swr.sd2_hpc_co(8)=sd_swr.sd2_hpc_co;
                                    Sd_Swr.sd5_hpc_co(8)=sd_swr.sd5_hpc_co;
                                    Sd_Swr.sd2_pfc_co(8)=sd_swr.sd2_pfc_co;
                                    Sd_Swr.sd5_pfc_co(8)=sd_swr.sd5_pfc_co;
                                    Sd_Swr.sd2_hpc_long(8)=sd_swr.sd2_hpc_long;
                                    Sd_Swr.sd5_hpc_long(8)=sd_swr.sd5_hpc_long;
                                    Sd_Swr.sd2_pfc_long(8)=sd_swr.sd2_pfc_long;
                                    Sd_Swr.sd5_pfc_long(8)=sd_swr.sd5_pfc_long;       
                                    
                                    %[~,~,~,~,~,~,~,~,sd_swr]=swr_check_thr(HPC_4,Cortex_4,states4,ss,70,30);
                                    [sd_swr]=find_std(HPC_4,Cortex_4,states4,ss);
                                    Sd_Swr.sd2_hpc_co(9)=sd_swr.sd2_hpc_co;
                                    Sd_Swr.sd5_hpc_co(9)=sd_swr.sd5_hpc_co;
                                    Sd_Swr.sd2_pfc_co(9)=sd_swr.sd2_pfc_co;
                                    Sd_Swr.sd5_pfc_co(9)=sd_swr.sd5_pfc_co;
                                    Sd_Swr.sd2_hpc_long(9)=sd_swr.sd2_hpc_long;
                                    Sd_Swr.sd5_hpc_long(9)=sd_swr.sd5_hpc_long;
                                    Sd_Swr.sd2_pfc_long(9)=sd_swr.sd2_pfc_long;
                                    Sd_Swr.sd5_pfc_long(9)=sd_swr.sd5_pfc_long;                                      

                        end

    
                    end



%%

                    cd ..
                else
                    cd .. %Means there is no sleep scoring file.
                end
                
% if i==5
%     xo
% end            
            end
                cd ..

        end
        
   if ind_mode==2
xo
%         allscreen()
%         subplot(1,2,1)
        imagesc(nr_swr_HPC); colorbar(); colormap('gray')
        xticks([1.5:9.5])
        xticklabels({'5','10','15','20','25','30','35','40','45'})
        yticks([1:9])
        yticklabels({'PS','PT1','PT2','PT3','PT4','PT5_1','PT5_2','PT5_3','PT5_4'})
        title('HPC HFOs')
        printing(['HPC_' g{j} '_' stage])
        close all
        
%         subplot(1,2,2)
        imagesc(nr_swr_Cortex); colorbar(); colormap('gray')
        xticks([1.5:9.5])
        xticklabels({'5','10','15','20','25','30','35','40','45'})
        yticks([1:9])
        yticklabels({'PS','PT1','PT2','PT3','PT4','PT5_1','PT5_2','PT5_3','PT5_4'})
        title([xx{1} ' HFOs'])
        printing(['Cortex_' g{j} '_' stage])
        close all       
        
        imagesc(nr_cohfos); colorbar(); colormap('gray')
        xticks([1.5:9.5])
        xticklabels({'5','10','15','20','25','30','35','40','45'})
        yticks([1:9])
        yticklabels({'PS','PT1','PT2','PT3','PT4','PT5_1','PT5_2','PT5_3','PT5_4'})
        title(['Coocurring' ' HFOs'])
        printing(['Coocurring_' g{j} '_' stage])
        close all
        
        %Single HPC
        imagesc(nr_single_hpc); colorbar(); colormap('gray')
        xticks([1.5:9.5])
        xticklabels({'5','10','15','20','25','30','35','40','45'})
        yticks([1:9])
        yticklabels({'PS','PT1','PT2','PT3','PT4','PT5_1','PT5_2','PT5_3','PT5_4'})
        title(['Single HPC' ' HFOs'])
        printing(['Single_HPC_' g{j} '_' stage])
        close all
        
        %Single PFC
        imagesc(nr_single_cortex); colorbar(); colormap('gray')
        xticks([1.5:9.5])
        xticklabels({'5','10','15','20','25','30','35','40','45'})
        yticks([1:9])
        yticklabels({'PS','PT1','PT2','PT3','PT4','PT5_1','PT5_2','PT5_3','PT5_4'})
        title(['Single Cortex' ' HFOs'])
        printing(['Single_Cortex_' g{j} '_' stage])
        close all
        
   end
    
   if ind_mode==3
%        xo
       %Sd_Swr
    TT=table;
    TT.Variables=...
        [
                [{g{j}};{'x'};{'x'};{'x'};{'x'};{'x'};{'x'};{'x'}] ...
        [{'HPC_2SD_Concatenated'};{'HPC_2SD_Longest'};{'HPC_5SD_Concatenated'};{'HPC_5SD_Longest'};{'PFC_2SD_Concatenated'};{'PFC_2SD_Longest'};{'PFC_5SD_Concatenated'};{'PFC_5SD_Longest'}] ...
    num2cell([ Sd_Swr.sd2_hpc_co;Sd_Swr.sd2_hpc_long;Sd_Swr.sd5_hpc_co;Sd_Swr.sd5_hpc_long ...
        ;Sd_Swr.sd2_pfc_co;Sd_Swr.sd2_pfc_long;Sd_Swr.sd5_pfc_co;Sd_Swr.sd5_pfc_long ...
      ]) ...
    num2cell([ mean(Sd_Swr.sd2_hpc_co); mean(Sd_Swr.sd2_hpc_long); mean(Sd_Swr.sd5_hpc_co);mean(Sd_Swr.sd5_hpc_long) ...
        ;mean(Sd_Swr.sd2_pfc_co);mean(Sd_Swr.sd2_pfc_long);mean(Sd_Swr.sd5_pfc_co);mean(Sd_Swr.sd5_pfc_long) ...
      ])...
      ];
      
   
    TT.Properties.VariableNames={'Condition';'Metric';'PS';'PT1';'PT2';'PT3';'PT4';'PT5_1';'PT5_2';'PT5_3';'PT5_4';'Average Value'};
    t1=repmat({'x'},[1 12]);
        if j==1
            T=[TT];
        else
            T=[T;t1;TT];
        end
    
   end
              
          
    end
    %xo
    writetable(T,strcat('SD_values','.xls'),'Sheet',1,'Range','A1:Z50')
    cd ..
end



