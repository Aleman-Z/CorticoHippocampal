function [BB,labelconditions,labelconditions2]=select_folder(Rat,iii,labelconditions,labelconditions2)
% Function to select folders that match specific conditions for a given rat.

A = getfolder; % Get the list of folders in the current directory.

% Initialize folder count variable.
no=0;

% Iterate through each folder in the directory.
for j=1:length(A)
    B=A{j}; % Current folder name.
    k = strfind(B,labelconditions{iii}); % Check if folder name contains condition name.
    
    % If the folder name contains the condition:
    if k >= 1
        no = no + 1; % Increment the folder count.
        BB{no} = B; % Store the folder name in BB.
    end
end

% If there are multiple folders that match the condition:
if no >= 2 
    % Update labelconditions and labelconditions2 with matching folders.
    labelconditions{iii} = BB{1};
    labelconditions = [labelconditions; BB(2:end).'];
    
    labelconditions2{iii} = BB{1};
    labelconditions2 = [labelconditions2; BB(2:end).'];
else
    % If only one folder matches, update labelconditions with the folder.
    labelconditions{iii} = BB{1};
end

% Ensure BB is assigned the first cell element if it is a cell array.
if iscell(BB) == 1
    BB = BB{1};
end

% If there are two folders and iii is the last index in labelconditions:
if no == 2 && iii == length(labelconditions)
    BB = BB{2}; % Assign BB to the second folder.
end

end
