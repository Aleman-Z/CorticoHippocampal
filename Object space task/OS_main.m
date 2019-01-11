close all
clear all
%OS main
fs=20000; %Sampling frequency of acquisition.  
acer=1;
addingpath(acer);

%%
for RAT=1:4 %4
rats=[1 3 4 6]; %First drive
Rat=rats(RAT); 


labelconditions=[
    { 
    
    'OR'}
    'CON'    
    'OD'
    'OR_N'
    ];

for iii=1:4 %Up to 4. 
    
[BB]=select_folder(Rat,iii,labelconditions);
cd(BB)   
xo    
    
    
    
end



end