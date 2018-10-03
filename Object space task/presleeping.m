num=2;
str2=cell(2,1);
str2{1,1}='/home/raleman/Documents/internship/Lisa_files/data/Presleep1';
str2{2,1}='/home/raleman/Documents/internship/Lisa_files/data/Presleep2';

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
