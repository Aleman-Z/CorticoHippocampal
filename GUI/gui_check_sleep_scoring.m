function gui_check_sleep_scoring(channels,label1,labelconditions,labelconditions2,rats,fs)


%SELECT RAT(S).
opts.Resize = 'on';
opts.WindowStyle = 'modal';
opts.Interpreter = 'tex';
prompt=strcat('\bf Select a rat#. Options:','{ }',num2str(rats));
answer = inputdlg(prompt,'Input',[2 30],{''},opts);
Rat=str2double(answer{1});
% Rat=str2num(answer{1}); 

%GET FOLDER.
dname2=uigetdir([],strcat('Select folder where downsampled data was saved'));

%Get folders
cd([dname2 '/' num2str(Rat)])
A=getfolder;

    for i=1:length(A)
        cd(A{i})
        
        cfold=dir;
        cfold={cfold.name};
        cfold=cfold(cellfun(@(x) ~isempty(strfind(x,'states')),cfold));

        %Load .mat files
        for ii=1:length(cfold)
           load(cfold{ii})
        end
        
        len_states=length(states);
        
        %Get HPC file and check its length
        cfold=dir;
        cfold={cfold.name};
        cfold=cfold(cellfun(@(x) ~isempty(strfind(x,'HPC')),cfold));
        
        HPC=load(cfold{1});
        HPC=HPC.HPC;
        
        len_HPC=length(HPC)/fs;
        len_HPC=round(len_HPC)-1;
                
        if len_HPC~=len_states
%             errordlg('Lengths do not match','File Error');
            errordlg(A{i},'Lengths do not match');            
        end
        
        cd ..
    end
messbox('Finished checking','Finished')
    
end