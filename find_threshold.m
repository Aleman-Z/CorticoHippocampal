
%Load ADRITOOLS
addpath(genpath('C:\Users\students\Documents\Swatantra\ADRITOOLS-master'))

%Load CorticoHippocampal
addpath(genpath('C:\Users\students\Documents\Swatantra\CorticoHippocampal'))

%Load RGS14 github
addpath(genpath('C:\Users\students\Documents\Swatantra\LFP_RGS14'))

ss=3;

%Rat 4
cd('C:\Users\students\Documents\plusmaze_toilet_data_correct\rat4')

G=getfolder();

for j=1:length(G) % Iterate across study days.
cd('C:\Users\students\Documents\plusmaze_toilet_data_correct\rat4')
cd(G{j})

prepost=getfolder();

for i=1: length(prepost)
cd('C:\Users\students\Documents\plusmaze_toilet_data_correct\rat4')
cd(G{j})

    cd(prepost{i})
    
    %Read brain areas and load states file.
%% HPC     
HPC=dir(strcat('*','HPC','*.mat'));
HPC=HPC.name;
HPC=load(HPC);
HPC=getfield(HPC,'HPC_ripple');


Cortex=dir(strcat('*','PFC','*.mat'));
Cortex=Cortex.name;
Cortex=load(Cortex);
Cortex=getfield(Cortex,'PFC');
Cortex=Cortex.*(0.195);
    

%Load sleep scoring
A = dir('*states*.mat');
A={A.name};

if  ~isempty(A)
       cellfun(@load,A);
else
      error('No Scoring found')    
end


[sd_swr]=find_std(HPC,Cortex,states,ss);
Sd_Swr.sd5_hpc_co(j,i)=sd_swr.sd5_hpc_co;
Sd_Swr.sd5_pfc_co(j,i)=sd_swr.sd5_pfc_co;

    
end


end
thresholds_perday_hpc=mean(Sd_Swr.sd5_hpc_co,2);
thresholds_perday_cortex=mean(Sd_Swr.sd5_pfc_co,2);

tr(1)=mean(thresholds_perday_hpc);
tr(2)=mean(thresholds_perday_cortex);

offset1={'5'};
offset2={'5'};

%%

D1 = round(tr(1) + str2num(cell2mat(offset1)));
D2 = round(tr(2) + str2num(cell2mat(offset2)));

[swr_hpc,swr_pfc,s_hpc,s_pfc,V_hpc,V_pfc,signal2_hpc,signal2_pfc] = swr_check_thr(HPC,Cortex,states,ss,D1,D2);

['Found ' num2str(sum(s_hpc)) ' hippocampal ripples']
['Found ' num2str(sum(s_pfc)) ' cortical ripples']

%% Find epoch with most detections
max_length=cellfun(@length,swr_hpc(:,1));
N=max_length==max(max_length);


hpc=V_hpc{N};
pfc=V_pfc{N};
hpc2=signal2_hpc{N};
pfc2=signal2_pfc{N};
n=find(N);
if length(n)>1
    'Multiple epochs with same number of events'
end
n=n(1);
%%
prompt = {'Select window length (msec):','Brain area:'};
dlgtitle = 'Input';
dims = [1 35];
definput = {'100','PFC'};
answer = inputdlg(prompt,dlgtitle,dims,definput);
 win_len=str2num(answer{1});
 BR=answer{2};
 %%
close all
plot((1:length(hpc))./1000,5.*zscore(hpc)+100,'Color','black')
hold on
plot((1:length(pfc))./1000,5.*zscore(pfc)+150,'Color','black')
xlabel('Time (Seconds)')


plot((1:length(hpc2))./1000,5.*zscore(hpc2)+220,'Color','black')
plot((1:length(pfc2))./1000,5.*zscore(pfc2)+290,'Color','black')


yticks([100 150 220 290])
yticklabels({'HPC','PFC','HPC (Bandpassed)',['PFC' '(Bandpassed)']})
b=gca;
b.FontSize=12;


if strcmp(BR,'PFC')
    sn=swr_pfc{n,3};
else
    sn=swr_hpc{n,3};
end

if isempty(sn)
    errordlg('No Events found','Error');
    xo
end


prompt = {['Select event ID number. Max value:' num2str(length(sn))]};
dlgtitle = 'Input';
dims = [1 35];
definput = {'1'};
answer2 = inputdlg(prompt,dlgtitle,dims,definput);
answer2=str2num(answer2{1});

 
if ~ isempty(swr_hpc{n})
    stem([swr_hpc{n,3}],ones(length([swr_hpc{n}]),1).*250,'Color','blue') %(HPC)
end
hold on
if ~ isempty(swr_pfc{n})
    stem([swr_pfc{n,3}],ones(length([swr_pfc{n}]),1).*250,'Color','red')%Seconds (Cortex)
end

%xlim([sn(answer2)-win_len/1000 sn(answer2)+win_len/1000])

