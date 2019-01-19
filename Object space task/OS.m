close all
clear variables
clc
%OS main
fs=20000; %Sampling frequency of acquisition.  
acer=1;
addingpath(acer);

%HPC, PFC, EEG FRONTAL, EEG PARIETAL.
channels.Rat1 = [ 46 11 6 5];
channels.Rat3 = [ 31 49 NaN 54]; %To confirm
channels.Rat4 = [ 37 34 NaN NaN];  %Two prefrontal. Right:29. Left:16. 
%Two parietal: Anterior (5) , Posterior (12)

channels.Rat6 = [ 2 33 34 36];
channels.Rat9 = [ 49 30 3 9];
channels.Rat11 = [ 11 45 55 56];

% rats=[1 3 4 6]; %First drive
rats=[1 3 4 6 9 11]; %First and second drive

labelconditions=[
    { 
    
    'OD'}
    'OR'
    'CON'    
%     'OR_N'
    ];

labelconditions2=[
    { 
    
    'OD'}
    'OR'
    'CN'    %CON IS A RESERVED WORD FOR WINDOWS
%     'OR_N'
    ];

figColorMap(1,:)=[0.49, 0.18, 0.56]; %Foraging Violet. 
% figColorMap(3,:)=[0.9290, 0.6940, 0.1250]; %Yellow Novelty
figColorMap(2,:)=[0, 0, 0]; %Black plusmaze
figColorMap(3,:)=[0.65, 0.65, 0.65]; %GREY CONTROL

sidebyside=1; %Plots conditions side by side. 
aver_trial=1;
%%
fbar=waitbar(0,'Please wait...');
for RAT=1:length(rats) %4
Rat=rats(RAT); 

cd(strcat('F:\Lisa_files\',num2str(rats(RAT))));
% xo

for iii=1:length(labelconditions) %Up to 4 conditions. OR is 2.
    
cd( labelconditions2{iii})
g=getfolder;

if Rat==1 && iii==1 
a = 1:length(g);
a(a == 4) = [];
g=g(a);
end

PXX=cell(length(g),1);
%PX=cell(length(g),1);
PX=[];
%PX=double.empty(5,0);
%xo
for k=1:length(g) %all trials. 
myColorMap = jet(length(g));                                                                                                                                                                                        
cd( g{1,k})

sos=load('sos.mat');
sos=sos.sos;
%xo
[a1,nb]=sleep_criteria(sos);

%If no sleep is found ignore trial:
if nb==0 %|| nb==1
    
a = 1:length(g);
a(a == k) = [];
g=g(a);
myColorMap=myColorMap(1:length(g),:);
cd ..

    break
end


V9=load('V9.mat');
V9=V9.V9;
V9=V9.*(0.195);
V17=load('V17.mat');
V17=V17.V17;
V17=V17.*(0.195);

%xo

v9=cell(size(a1,1),1);
v17=cell(size(a1,1),1);
for h=1:size(a1,1)
v9{h,1}=V9(a1(h,1):a1(h,2));
v17{h,1}=V17(a1(h,1):a1(h,2));
end

% v17={V17};


[NC]=epocher(v17,2);

av=mean(NC,1);
av=artifacts(av,10);

%Limits artifacts to a maximum of 10
if sum(av)>=10
av=artifacts(av,20);    
end
%xo
av=not(av);
%Removing artifacts.
NC=NC(:,av);

% NCount(iii,1)=size(NC,2);

%Notch filter
Fsample=1000;
%Fline=[50 100 150 200 250 300 66.5 133.5 266.5];
Fline=[50 150 250];
nu1=300;
nu2=30;
% nu1=0.5;
% nu2=0.5;

% xo
% % % % % % % % % % % % if Rat==11 && iii==3 %&& k==5
% % % % % % % % % % % % Fline=[31 32 33.2 34 66.4 99.6 166.5 232.9];
% % % % % % % % % % % % % 
% % % % % % % % % % % % % %[NC] = ft_notch(NC, Fsample,Fline,20,0.5);
% % % % % % % % % % % % % [NC] = ft_notch(NC, Fsample,Fline,0.5,0.5);
% % % % % % % % % % % % % 
% % % % % % % % % % % % nu1=500;
% % % % % % % % % % % % nu2=200;
% % % % % % % % % % % % % xo
% % % % % % % % % % % % end

%[NC] = ft_notch(NC, Fsample,Fline,20,0.5);

%[NC] = ft_notch(NC, Fsample,Fline,nu1,nu2);


[pxx,f]=pmtm(NC,4,[],1000);

PXX{k}=pxx;



px=mean(pxx,2);
% PX{k}=px;
PX(k,:)=px.';
if aver_trial~=1
    if sidebyside==1 
        if k==1
            if iii==1
                allscreen()
            end
            subplot(1,3,iii)
        end
    end
end
% figure()
if aver_trial~=1
s=semilogy(f,(px),'Color',myColorMap(k,:),'LineWidth',2);
s.Color(4) = 0.8;
hold on
end
%xo
% for k=1:length(iv3)
%    if iv3(k)==1
%        nb=nb+1;
%    end
% end

% v2 = zeros(size(v)); % Initialize vector of same length.
% props = regionprops(logical(v), 'Area', 'PixelIdxList');
% for k = 1 : length(props)
%   v2(props(k).PixelIdxList(1)) = props(k).Area;
% end



% vin=find(vtr~=1); % index for "nrem" times. 

cd ..


clear v9 v17 NC 

end
%xo

if size(PX,1)==6
   PX=PX(1:5,:); 
end

if aver_trial==1
% subplot(1,3,iii)  
acolor=figColorMap(iii,:);
s=semilogy(f,(mean(PX)),'Color',acolor,'LineWidth',2);
s.Color(4) = 0.8; 
hold on
fill([f.' fliplr(f.')],[mean(PX)+std(PX) fliplr(mean(PX)-std(PX))],acolor,'linestyle','none','FaceAlpha', 0.4);
end


xlim([0 300])
xlabel('Frequency (Hz)')
%ylabel('10 Log(x)')
ylabel('Power')

%title(strcat('Power in NREM',{' '} ,label1{2*w-1} ,{' '},'signals'))
if sidebyside==1 && aver_trial~=1
title(strcat(labelconditions{iii},{' '} ,'HPC' ,{' '},'power'))    
else
title(strcat('Power in NREM',{' '} ,'HPC' ,{' '},'signals'));    
end
%xo

if sum(cellfun(@(x) strcmp(x,'PT_retest') ,g))>=1
    g(cellfun(@(x) strcmp(x,'PT_retest') ,g))={'PT_r_e_t_e_s_t'};
end

if aver_trial~=1
    L = line(nan(length(g.')), nan(length(g.')),'LineStyle','none'); % 'nan' creates 'invisible' data
    set(L, {'MarkerEdgeColor'}, num2cell(myColorMap, 2),...
        {'MarkerFaceColor'},num2cell(myColorMap, 2),... % setting the markers to filled squares
        'Marker','s'); 

    legend(L, g.')
else
    L = line(nan(length(labelconditions)), nan(length(labelconditions)),'LineStyle','none'); % 'nan' creates 'invisible' data
    set(L, {'MarkerEdgeColor'}, num2cell(figColorMap, 2),...
        {'MarkerFaceColor'},num2cell(figColorMap, 2),... % setting the markers to filled squares
        'Marker','s'); 

    legend(L, labelconditions) 
end

% sum(cellfun(@(x) isempty(x),PX))>=1

% xo
%string=strcat('300Hz_Rat_',num2str(Rat),'_',labelconditions{iii},'_','HPC','.pdf');
string=strcat('300Hz_Rat_',num2str(Rat),'_',labelconditions{iii},'_','HPC','.pdf');
% string=strcat('Whole_Rat_',num2str(Rat),'_',labelconditions{iii},'_','HPC','.pdf');

if sidebyside==0
    
printing(string);
close all    
end

cd ..
end
% xo
if sidebyside==1
 string=strcat('300Hz_Rat',num2str(Rat),'_AveragedTrialsSTD_','HPC'); 
 printing(string);
close all
end
progress_bar(RAT,length(rats),fbar)    
end

%%


