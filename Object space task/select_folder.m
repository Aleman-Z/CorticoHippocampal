function [BB, labelconditions, labelconditions2] = select_folder(Rat, iii, labelconditions, labelconditions2)
% SELECT_FOLDER Selects a folder based on the Rat ID and conditions.
%   This function navigates to the directory for a specific rat, searches
%   for folders matching the specified condition label, and organizes the 
%   folders found into output variables BB, labelconditions, and labelconditions2.

% Inputs:
%   Rat              - ID of the rat
%   iii              - Index of the condition in labelconditions
%   labelconditions  - Cell array with condition labels
%   labelconditions2 - Cell array with secondary condition labels

% Outputs:
%   BB               - Selected folder name(s) matching condition
%   labelconditions  - Updated condition labels
%   labelconditions2 - Updated secondary condition labels

% Get all folders in the current directory
A = getfolder;

% Initialize the folder count for matching conditions
no = 0;
BB = {};

% Loop through all folders and identify those matching the condition label
for j = 1:length(A)
    B = A{j};
    k = strfind(B, labelconditions{iii}); % Check if folder name contains the condition label
    if ~isempty(k) % If a match is found
        no = no + 1;
        BB{no} = B; % Store matching folder
    end
end

% Update labels based on the number of matching folders found
if no >= 2
    % Store the first match in the labelconditions arrays
    labelconditions{iii} = BB{1};
    labelconditions = [labelconditions; BB(2:end).']; % Append remaining matches
    labelconditions2{iii} = BB{1};
    labelconditions2 = [labelconditions2; BB(2:end).'];
else
    % If only one match found, use that for the current condition label
    labelconditions{iii} = BB{1};
end

% Convert BB to a string if it only contains one element
if iscell(BB) && length(BB) == 1
    BB = BB{1};
end

% If exactly two matches found and this is the last condition, use the second match
if no == 2 && iii == length(labelconditions)
    BB = BB{2};    
end

end
