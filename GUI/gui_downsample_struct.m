%gui_downsample
%Downsamples ephys data.
%function gui_downsample(channels,label1,labelconditions,labelconditions2,rats)
opts.Interpreter = 'tex';
% Include the desired Default answer
opts.Default = 'No';
% Use the TeX interpreter to format the question
quest = 'Is this the Plusmaze data?';
plusmaze = questdlg(quest,'Select one',...
                  'Yes','No',opts);
if strcmp(plusmaze,'No')
    plusmaze=0;
else
    plusmaze=1;
end
              
%SAMPLING FREQUENCY AND DOWNSAMPLED FREQUENCY.
prompt = {'Enter acquisition frequency (Hz):','Enter new downsampled frequency (Hz):'};
dlgtitle = 'Input';
dims = [1 35];
definput = {'20000','1000'};
answer = inputdlg(prompt,dlgtitle,dims,definput);
fs=str2num(answer{1});
fs_new=str2num(answer{2});

% %% SELECT TRIALS
%    answer = questdlg('Should we use all trials?', ...
%             'Trial selection', ...
%             'Use all','Select trials','Select trials');
%         
% switch answer
%     case 'Use all'
%         disp(['Using all trials.'])
%         an=[];
%     case 'Select trials'
%         prompt = {['Enter trials name common word without index:' sprintf('\n') '(Use commas for multiple names)']};
%         dlgtitle = 'Input';
%         dims = [1 35];
%         %definput = {'20','hsv'};
%         an = inputdlg(prompt,dlgtitle,dims);
%         %an=char(an);
%         %g=g(contains(g,{'PT'}));
% end
%%
an=[];
%%
stage=an;

if ~isempty(stage)
    %Splits Multiple trials
    if ~isempty(stage(~isempty(strfind(an{1},','))))
        stage=stage(~isempty(strfind(an{1},',')));
        stage=stage{1};
        stage=strsplit(stage,',');
    end
end


%Adds trials containing an initial capital letter.
idx = isstrprop(stage,'upper') ;
if ~isempty(idx)
    for indexup=1:length(idx)
         varind=idx{indexup};
         if varind(1)~=1
             vj=stage{indexup};
             vj(1)=upper(vj(1));
             stage= [stage vj];
         end
    end
end
iter_no_saving=0; 

%SELECT RAT(S).
opts.Resize = 'on';
opts.WindowStyle = 'modal';
opts.Interpreter = 'tex';
prompt=strcat('\bf Select a rat#. Options:','{ }',num2str(rats));
answer = inputdlg(prompt,'Input',[2 30],{''},opts);
Rat=str2double(answer{1});
% Rat=str2num(answer{1});


%GET EPHYS AND NEW FOLDER.
dname=uigetdir([],strcat('Select folder with Ephys data for Rat',num2str(Rat)));
dname2=uigetdir([],strcat('Select folder where downsampled data should be saved'));
%%
%SELECT CONDITION.
%xo
%if size(label1,1)~=3 % Not for Plusmaze
if plusmaze==0 % Not for Plusmaze
    
    %Center figure.
    f=figure();
    movegui(gcf,'center');

    %Checkboxes
    Boxcheck = cell(1,4);
    for h1=1:length(labelconditions)
    boxcheck = uicontrol(f,'Style','checkbox','String',labelconditions{h1},'Position',[10 f.Position(4)-30*h1 200 20]);
    boxcheck.FontSize=11;
    boxcheck.Value=1;
    Boxcheck{h1}=boxcheck;   
    end

    set(f, 'NumberTitle', 'off', ...
        'Name', 'Select conditions');

    %Push button
    c = uicontrol;
    c.String = 'Continue';
    c.FontSize=10;
    c.Position=[f.Position(1)/3.5 c.Position(2)-10 f.Position(3)/2 c.Position(4)];

    %Callback
    c.Callback='uiresume(gcbf)';
    uiwait(gcf); 
    boxch=cellfun(@(x) get(x,'Value'),Boxcheck);
    clear Boxcheck
    labelconditions=labelconditions(find(boxch~=0));
    labelconditions2=labelconditions2(find(boxch~=0));

    close(f);
end
%%

AA=getfolder;
B=zeros(size(A));
for kcond=1:length(labelconditions)
    B=B+cell2mat(cellfun(@(x) contains(x,labelconditions{kcond}),A,'UniformOutput',false));
end
AA=AA(logical(B));
%GO TO FOLDER AND READ ALL CONDITION FILES.
iii=1;
% for iii=4:length(labelconditions) 
 while iii<=length(labelconditions)  

cd(dname)% Go to Ephys folder for specified rat.

%if size(label1,1)~=3 %Not Plusmaze
if plusmaze==0 %Not Plusmaze
    
    [BB,labelconditions,labelconditions2]=select_folder(Rat,iii,labelconditions,labelconditions2);
    % In case of a repeated condition, update labelcondition and add
    % repeated condition to the end.
    cd(BB)
    A=getfolder;    
else
    A=getfolder;    
end

%%

%Look for trial
if ~isempty(stage)
    Var=zeros(size(A));
    for j=1:length(stage)
    aver=cellfun(@(x) strfind(x,stage{j}),A,'UniformOutput',false);
    aver=cellfun(@(x) length(x),aver,'UniformOutput',false);
    Var=or(cell2mat(aver),Var);
    end
else
    Var=ones(size(A));    
end

%In case of extra folder
if Var==0 %Error: Var is a vector
    xo
 cd(A{1})
        A=getfolder;
        %Look for trial
        Var=zeros(size(A));
        for j=1:length(stage)
        aver=cellfun(@(x) strfind(x,stage{j}),A,'UniformOutput',false);
        aver=cellfun(@(x) length(x),aver,'UniformOutput',false);
        Var=or(cell2mat(aver),Var);
        end 
end
% xo
if ~isempty(stage)
    A=A(Var);
end

A=A.';

%% Label suggestion (Not used when All-trials option was selected)
str2=cell(size(A,1),1);

if ~isempty(stage)
    
   for j=1:length(stage)
       cont=0;
       for n=1:size(A,1)
              
            if n==1
                
            end
           
           %if contains(A{n},stage{j})
            if ~isempty(strfind(A{n},stage{j}))                
              cont=cont+1;  
              str2{n,1}=strcat(stage{j},num2str(cont));   

            end       
       end
     %str2{n,1}=strcat(stage{1},num2str(n));
   end
else
 str2=A;   
end   
   %%
%xo   
%LABEL TRIALS.

f = figure(2);
set(f, 'NumberTitle', 'off', ...
    'Name',strcat('Rat',num2str(Rat),'_',labelconditions{iii}));

c = uicontrol('Style','text','Position',[1 380 450 30]);
% c = uicontrol('Style','text','Position',[1 380 450 20]);
% c.String = {'Edit the Label column with the correct trial index according to the dates.'};
% c.String =sprintf('%s\n%s','Edit the Label column with the correct trial index according to the dates.','Leave blank if trial is corrupted.');
%{'Edit the Label column with the correct trial index according to the dates' 'Leave blank if trial is corrupted.'};
c.String =sprintf('%s\n%s','Select trials.','Leave blank label if trial is corrupted.');
c.FontSize=10;
c.FontAngle='italic';

uit = uitable(f);
% d = {A,str2};
uit.Data = [A str2];
uit.ColumnName={'File name'; 'Label'};
uit.ColumnWidth= {200,80};
% uit.Position = [20 20 258 78];


        
set(uit,'ColumnEditable',true(1,2))
h = uicontrol('Position',[350 20 100 40],'String','Confirm',...
              'Callback','uiresume(gcbf)');
h.FontSize=10;
uiwait(gcf); 
str2= get(uit,'Data');   
str2=str2(:,2);
%Remove corrupted trials.
close(f);
str1=A;
str1=str1(not(cellfun('isempty',str2)));
A=A(not(cellfun('isempty',str2)));
str2=str2(not(cellfun('isempty',str2)));
%%
%xo
F=waitbar(0,'Please wait...');
for num=1:length(str1)
       
 chfol=getfolder;
 if length(chfol)==1
     cd(chfol{1})
 end
 
    cd(str1{num,1});
%     xo
 if iter_no_saving~=1   

 
        Wn=[fs_new/fs ]; % Cutoff=fs_new/2 Hz. 
        [b,a] = butter(3,Wn); %Filter coefficients for LPF.

    vr=getfield(channels,strcat('Rat',num2str(Rat)));%Electrode channels. 
%xo
    cfold=dir;
    cfold={cfold.name};
%     cfold=cfold(cellfun(@(x) contains(x,'CH'),cfold));    
    cfold=cfold(cellfun(@(x) ~isempty(strfind(x,'CH')),cfold));
    if isempty(cfold)
        dname3=uigetdir([],strcat('Select folder where ephys data is stored'));
        cd(dname3)
            cfold=dir;
            cfold={cfold.name};

    end
    
%     if strcmp(label1{1},'HPC')
%             cf1=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(vr(1)) '.'])),cfold)) cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(vr(1)) '_'])),cfold))];
%             cf2=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(vr(2)) '.'])),cfold)) cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(vr(2)) '_'])),cfold))];
% 
%     else
%             cf1=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(vr(2)) '.'])),cfold)) cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(vr(2)) '_'])),cfold))];
%             cf2=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(vr(1)) '.'])),cfold)) cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(vr(1)) '_'])),cfold))];
%     end
    
for k=1:length(label1)
    cf.(label1{k})=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(vr(k)) '.'])),cfold)) cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(vr(k)) '_'])),cfold))];
       if size(cf.(label1{k}),1)~=1 ||  size(cf.(label1{k}),2)~=1 %Repeated
            %Center figure.
            f=figure();
            movegui(gcf,'center');
            %Checkboxes
            Boxcheck = cell(1,length(cf.(label1{k})));
            for h1=1:length(cf.(label1{k}))
            boxcheck = uicontrol(f,'Style','checkbox','String',cf.(label1{k}){h1},'Position',[10 f.Position(4)-30*h1 200 20]);
            boxcheck.FontSize=11;
            boxcheck.Value=1;
            Boxcheck{h1}=boxcheck;   
            end

            set(f, 'NumberTitle', 'off', ...
                'Name', ['Select channel:    ' labelconditions{iii} '/' str1{num}]);

            %Push button
            c = uicontrol;
            c.String = 'Continue';
            c.FontSize=10;
            c.Position=[f.Position(1)/3.5 c.Position(2)-10 f.Position(3)/2 c.Position(4)];

            %Callback
            c.Callback='uiresume(gcbf)';
            uiwait(gcf); 
            boxch=cellfun(@(x) get(x,'Value'),Boxcheck);
            clear Boxcheck
            
            cf.(label1{k})=cf.(label1{k})(find(boxch~=0));
            close(f);

       end
end
%     cf2=cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(vr(2))])),cfold));
    
% if size(label1,1)==3 %Plusmaze
% %        cf3=cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(vr(3))])),cfold));
%         cf3=[cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(vr(3)) '.'])),cfold)) cfold(cellfun(@(x) ~isempty(strfind(x,['CH' num2str(vr(3)) '_'])),cfold))];
% end
    
% if size(cf1,1)~=1 || size(cf2,1)~=1 || size(cf1,2)~=1 || size(cf2,2)~=1
% if size(cf1,1)~=1 ||  size(cf1,2)~=1 
% 
% %Center figure.
% f=figure();
% movegui(gcf,'center');
% %Checkboxes
%             Boxcheck = cell(1,length(cf1));
%             for h1=1:length(cf1)
%             boxcheck = uicontrol(f,'Style','checkbox','String',cf1{h1},'Position',[10 f.Position(4)-30*h1 200 20]);
%             boxcheck.FontSize=11;
%             boxcheck.Value=1;
%             Boxcheck{h1}=boxcheck;   
%             end
% 
%             set(f, 'NumberTitle', 'off', ...
%                 'Name', ['Select channel:    ' str1{num}]);
% 
%             %Push button
%             c = uicontrol;
%             c.String = 'Continue';
%             c.FontSize=10;
%             c.Position=[f.Position(1)/3.5 c.Position(2)-10 f.Position(3)/2 c.Position(4)];
% 
%             %Callback
%             c.Callback='uiresume(gcbf)';
%             uiwait(gcf); 
%             boxch=cellfun(@(x) get(x,'Value'),Boxcheck);
%             clear Boxcheck
%             
%             cf1=cf1(find(boxch~=0));
%             close(f);
% %         error('Ambiguous channel')
% %         xo
% end


% if size(cf2,1)~=1 ||  size(cf2,2)~=1 
% 
% %Center figure.
% f=figure();
% movegui(gcf,'center');
% %Checkboxes
%             Boxcheck = cell(1,length(cf2));
%             for h1=1:length(cf2)
%             boxcheck = uicontrol(f,'Style','checkbox','String',cf2{h1},'Position',[10 f.Position(4)-30*h1 200 20]);
%             boxcheck.FontSize=11;
%             boxcheck.Value=1;
%             Boxcheck{h1}=boxcheck;   
%             end
% 
%             set(f, 'NumberTitle', 'off', ...
%                 'Name', ['Select channel:    ' str1{num}]);
% 
%             %Push button
%             c = uicontrol;
%             c.String = 'Continue';
%             c.FontSize=10;
%             c.Position=[f.Position(1)/3.5 c.Position(2)-10 f.Position(3)/2 c.Position(4)];
% 
%             %Callback
%             c.Callback='uiresume(gcbf)';
%             uiwait(gcf); 
%             boxch=cellfun(@(x) get(x,'Value'),Boxcheck);
%             clear Boxcheck
%             
%             cf2=cf2(find(boxch~=0));
%             close(f);
%             
% %         error('Ambiguous channel')
% %         xo
% end
%xo
%if size(label1,1)==3 %Plusmaze
if plusmaze==1 %Plusmaze

    if size(cf3,1)~=1 ||  size(cf3,2)~=1 

    %Center figure.
    f=figure();
    movegui(gcf,'center');
    %Checkboxes
                Boxcheck = cell(1,length(cf3));
                for h1=1:length(cf3)
                boxcheck = uicontrol(f,'Style','checkbox','String',cf3{h1},'Position',[10 f.Position(4)-30*h1 200 20]);
                boxcheck.FontSize=11;
                boxcheck.Value=1;
                Boxcheck{h1}=boxcheck;   
                end

            set(f, 'NumberTitle', 'off', ...
                'Name', ['Select channel:    ' str1{num}]);

                %Push button
                c = uicontrol;
                c.String = 'Continue';
                c.FontSize=10;
                c.Position=[f.Position(1)/3.5 c.Position(2)-10 f.Position(3)/2 c.Position(4)];

                %Callback
                c.Callback='uiresume(gcbf)';
                uiwait(gcf); 
                boxch=cellfun(@(x) get(x,'Value'),Boxcheck);
                clear Boxcheck

                cf3=cf3(find(boxch~=0));
                close(f);

    %         error('Ambiguous channel')
    %         xo
    end 
    
end

for k=1:length(label1)
    getchannel=getfield(cf,label1{k});
    [s.(label1{k}), ~, ~] = load_open_ephys_data_faster(getchannel{1});
    s.(label1{k})=filtfilt(b,a,s.(label1{k}));
    s.(label1{k})=downsample(s.(label1{k}),fs/fs_new);
end

% %Hippocampus
%     if contains(cf1{1},'.mat') % In case of merged .mat file
%         load(cf1{1})
%         HPC=merged;
%         clear merged
%     else
%         [HPC, ~, ~] = load_open_ephys_data_faster(cf1{1});            
%     end
% 
%     HPC=filtfilt(b,a,HPC);
%     HPC=downsample(HPC,fs/fs_new);
% 
%     %PFC
%     [PFC, ~, ~] = load_open_ephys_data_faster(cf2{1});
%     PFC=filtfilt(b,a,PFC);
%     PFC=downsample(PFC,fs/fs_new);
%     %strcat('100_CH',num2str(vr(1)),'.continuous')
% 
%     if size(label1,1)==3
% 
%     [PAR, ~, ~] = load_open_ephys_data_faster(cf3{1});
%     PAR=filtfilt(b,a,PAR);
%     PAR=downsample(PAR,fs/fs_new); 
%         
%     end     
    
 end

cd(dname2)
%Rat folder
if ~isfolder(num2str(Rat))
    mkdir(num2str(Rat))
end
cd(num2str(Rat))

% if size(label1,1)~=3 %Not Plusmaze 
if plusmaze==0 %Not Plusmaze 
    % if ~exist(labelconditions2{iii}, 'dir')
    if ~isfolder(labelconditions2{iii})    
       mkdir(labelconditions2{iii})
    end
    cd(labelconditions2{iii})
end
%xo

% if ~exist(str2{num}, 'dir')
%    mkdir(str2{num})
% end
% % xo
% cd(str2{num})
if iter_no_saving~=1
    for k=1:length(label1)
%         eval([label1{k} '=' mat2str(getfield(s,label1{k})) ';']);        
%         save([[label1{k} '_'] cf.(label1{k}){1} '.mat'],label1{k})
         save(str1{num}, '-struct', 's');
    end
    
%  save(['HPC_' cf1{1} '.mat'],'HPC')
%  save(['PFC_' cf2{1} '.mat'],'PFC')
% 
% if size(label1,1)==3
%  save(['PAR_' cf3{1} '.mat'],'PAR')
% end 
 ftext = fopen( str1{num}, 'w' );  
 fclose(ftext);
end
clear PFC HPC PAR %sos

% if size(label1,1)==3
%     clear PAR %sos
% end
%xo
% if size(label1,1)==3 %Plusmaze
if plusmaze==1 %Plusmaze
cd(strcat(dname))    
else
cd(strcat(dname,'/',BB))    
end

progress_bar(num,length(str1),F)
end

% if size(label1,1)==3  %Plusmaze
if plusmaze==1  %Plusmaze
    break %Out of while loop and terminate.
else
    iii=iii+1;    
end

%xo
end

%end