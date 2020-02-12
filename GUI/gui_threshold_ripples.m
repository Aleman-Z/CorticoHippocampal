%gui_threshold_ripples
%% Find location
close all
dname=uigetdir([],'Select folder with Matlab data');
cd(dname)
%%
%Select rat number
opts.Resize = 'on';
opts.WindowStyle = 'modal';
opts.Interpreter = 'tex';
prompt=strcat('\bf Select a rat#. Options:','{ }',num2str(rats));
answer = inputdlg(prompt,'Input',[2 30],{''},opts);
Rat=str2num(answer{1});
cd(num2str(Rat))
%%
gg=getfolder;
gg=gg.';
if size(label1,1)~=3  % IF not Plusmaze
    gg(ismember(gg,'OR_N'))=[];
    gg(ismember(gg,'OD_N(incomplete)'))=[];
    gg=sort(gg); %Sort alphabetically.
    labelconditions2=gg;
    gg(ismember(gg,'CN'))={'CON'};
end
labelconditions=gg;

%% Select experiment to perform. 
inter=1;
%Select length of window in seconds:
ro=[1200];
coher=0;
selectripples=1;
notch=0; %Might need to be 1.
nrem=3;
level=1;
%%
for iii=1:length(labelconditions) 

    if size(label1,1)~=3  % IF not Plusmaze

        cd( labelconditions2{iii})
        g=getfolder;

        if iii==1
            answer = questdlg('Should we use all trials?', ...
                'Trial selection', ...
                'Use all','Select trials','Select trials');

            % Handle response
            switch answer
                case 'Use all'
                    disp(['Using all.'])
                    an=[];
                case 'Select trials'
                    prompt = {['Enter trials name common word without index:' sprintf('\n') '(Use commas for multiple names)']};
                    dlgtitle = 'Input';
                    dims = [1 35];
                    %definput = {'20','hsv'};
                    an = inputdlg(prompt,dlgtitle,dims);
                    %an=char(an);
            %        g=g(contains(g,{'PT'}));
            end

        end

        if ~isempty(an)
        g=g(contains(g,strsplit(an{1},',')));
        end
  
    else
      g=gg;  
    end
  %% Colormap
       % n=length(g);
        myColorMap=jet(length(g));    
        
        % Ask for brain area.
xx = inputdlg({'Brain area'},...
              'Type your selection', [1 30]); 
%%
% f=waitbar(0,'Please wait...');
    for k=1:length(g)
    cd(g{k})
    %xo
%     w=1;
    lepoch=2;
      %xo
        if size(label1,1)~=3  % IF not Plusmaze  
             [ripple,timeasleep,DM,y1]=gui_ripple_level(level,nrem,notch,w,lepoch);
        else
              [ripple,timeasleep,DM,y1]=gui_ripple_level_2020_par(xx); %(level,nrem,notch,w,lepoch); %Cortical ripples
        end
    
    if isempty(y1)
        g{k}='N/A'
        cd ..
%         progress_bar(k,length(g),f)
        continue 
    end
    %%
    plot(DM,ripple/(timeasleep*60),'*','Color',myColorMap(k,:))
    %plot(DM,ripple/(timeasleep*60),'*')
    xlabel('Threshold value (uV)')
    ylabel('HFOs per second')

    hold on
    plot(DM,y1/(timeasleep*60),'LineWidth',2,'Color',myColorMap(k,:))
    %plot(DM,y1/(timeasleep*60),'LineWidth',2)
        if size(label1,1)~=3  % IF not Plusmaze 
            title(strcat('Rate of HFOs per Threshold value for',{' '},labelconditions{iii}))
        else
            title(strcat('Rate of HFOs per Threshold value'))            
        end
    %Legends
%     interp1(DM,y1/(timeasleep*60),30) %plot(x_pos,y_pos,'r*')
    
    cd ..
%     progress_bar(k,length(g),f)
    end
    cd ..
    %Add legends
    set(gca, 'XDir','reverse')
    ye=cellfun(@(x) (strrep(x,'_','-')),g,'UniformOutput',false);
    h=add_legend(ye,myColorMap)
    set(h,'Location','Northwest')
%     xo
%     if size(label1,1)~=3  % IF not Plusmaze 
%       string=strcat('Ripple_thresholds_Rat',num2str(Rat),'_',labelconditions{iii}); 
%     else
%       string=strcat('Ripple_thresholds_Rat',num2str(Rat));         
%     end
    if size(label1,1)~=3  % IF not Plusmaze 
      string=strcat('HFOs_thresholds_',xx{1},'_Rat',num2str(Rat),'_',labelconditions{iii}); 
    else
      string=strcat('HFOs_thresholds_',xx{1},'_Rat',num2str(Rat));         
    end

    printing(string)
    close all
    
    if size(label1,1)==3 %If Plusmaze
        break;
    end
       
end