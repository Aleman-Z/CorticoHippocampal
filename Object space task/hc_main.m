num=6;

%function downsamp(num)
str2=cell(6,1);
str2{1,1}='/home/raleman/Documents/internship/Lisa_files/day 3 HC/post_trial1';
str2{2,1}='/home/raleman/Documents/internship/Lisa_files/day 3 HC/post_trial2';
str2{3,1}='/home/raleman/Documents/internship/Lisa_files/day 3 HC/post_trial3';
str2{4,1}='/home/raleman/Documents/internship/Lisa_files/day 3 HC/post_trial4';
str2{5,1}='/home/raleman/Documents/internship/Lisa_files/day 3 HC/post_trial5';
str2{6,1}='/home/raleman/Documents/internship/Lisa_files/day 3 HC/presleep';

% str2{1,1}='/home/raleman/Documents/internship/Lisa_files/data/PT1';
% str2{2,1}='/home/raleman/Documents/internship/Lisa_files/data/PT2';
% str2{3,1}='/home/raleman/Documents/internship/Lisa_files/data/PT3';
% str2{4,1}='/home/raleman/Documents/internship/Lisa_files/data/PT4';
% str2{5,1}='/home/raleman/Documents/internship/Lisa_files/data/PT5';

%str2{6,1}='/home/raleman/Documents/internship/Lisa_files/data/PT6';
cd(str2{num,1});
fs=20000;

Wn=[500/(fs/2) ]; % Cutoff=500 Hz
[b,a] = butter(3,Wn); %Filter coefficients for LPF

load('C9.mat')
V9=filtfilt(b,a,C9);
V9=decimator(V9,20);
save('V9.mat','V9')

load('C17.mat')
V17=filtfilt(b,a,C17);
V17=decimator(V17,20);
save('V17.mat','V17')


