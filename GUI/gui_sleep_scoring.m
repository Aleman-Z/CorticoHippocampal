function gui_sleep_scoring(channels,label1,labelconditions,labelconditions2,rats)


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
dname2=uigetdir([],strcat('Select folder where downsampled data was saved'));

%Get folders
cd([dname2 '/' num2str(Rat)])
A=getfolder;

    for i=1:length(A)
        
        cd(dname)
        cd(A{i})

        cfold=dir;
        cfold={cfold.name};
        cfold=cfold(cellfun(@(x) ~isempty(strfind(x,'states')),cfold));
        
        for ii=1:length(cfold)
            copyfile(cfold{ii},[dname2 '/' num2str(Rat) '/' A{i}])        
        end
    end
    
messbox('Finished adding files','Success')
    
end