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
gg(ismember(gg,'OR_N'))=[];
gg(ismember(gg,'OD_N(incomplete)'))=[];
gg=sort(gg); %Sort alphabetically.
labelconditions2=gg;
gg(ismember(gg,'CN'))={'CON'};
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
                prompt = {'Enter trials name common word without index:'};
                dlgtitle = 'Input';
                dims = [1 35];
                %definput = {'20','hsv'};
                an = inputdlg(prompt,dlgtitle,dims);
                %an=char(an);
        %        g=g(contains(g,{'PT'}));
        end

    end

    if ~isempty(an)
    g=g(contains(g,an));
    end
%% Colormap
n=length(g);
myColorMap=jet(n);
%%
% f=waitbar(0,'Please wait...');
    for k=1:length(g)
    cd(g{k})    
    w=1;
    lepoch=2;
      %xo
    [ripple,timeasleep,DEMAIS,y1]=gui_ripple_level(level,nrem,notch,w,lepoch)
    if isempty(y1)
        g{k}='N/A'
        cd ..
%         progress_bar(k,length(g),f)
        continue 
    end
    %%
    plot(DEMAIS,ripple/(timeasleep*60),'*','Color',myColorMap(k,:))
    %plot(DEMAIS,ripple/(timeasleep*60),'*')
    xlabel('Threshold value (uV)')
    ylabel('Ripples per second')

    hold on
    plot(DEMAIS,y1/(timeasleep*60),'LineWidth',2,'Color',myColorMap(k,:))
    %plot(DEMAIS,y1/(timeasleep*60),'LineWidth',2)
    title(strcat('Rate of ripples per Threshold value for',{' '},labelconditions{iii}))
    
    %Legends
    
    
    cd ..
%     progress_bar(k,length(g),f)
    end
    cd ..
    %Add legends
    set(gca, 'XDir','reverse')
    h=add_legend(g,myColorMap)
    set(h,'Location','Northwest')
%     xo
    string=strcat('Ripple_thresholds_Rat',num2str(Rat),'_',labelconditions{iii}); 
    printing(string)
    close all
       
end