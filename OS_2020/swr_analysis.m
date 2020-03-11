clear variables
% cd('C:\Users\students\Documents\OS_ephys_da\Data_downsampled')
cd('/home/adrian/Documents/new_OS_downsampled_2020')

list = {'Wake','NREM','Transitional','REM','All'};
[indx1] = listdlg('SelectionMode','single','ListString',list);

switch indx1
    case 1
        ss = 1; 
        stage='Wake';
    case 2
        ss = 3; 
        stage='NREM';
    case 3
        ss = 4; %Transitional
        stage='Trans';
    case 4
        ss = 5; %REM
        stage='REM';
    case 5
        ss = 6; %ALL
        stage='ALL';
        
end

xx = inputdlg({'Cortical area (PAR or PFC)'},...
              'Type your selection', [1 50]); 

% list = {'HPC','PFC','PAR'};
% [indx2] = listdlg('SelectionMode','single','ListString',list);
% 
% switch indx2
%     case 1
%         barea='HPC';
%     case 2
%         barea='PFC';
%     case 3
%         barea='PAR'
% end

rat_folder=getfolder;
for k=1:length(rat_folder)
%for k=7:length(rat_folder)
    cd(rat_folder{k})    
    g=getfolder;
%xo
    for j=1:length(g)
        cd(g{j})
%end
        G=getfolder;
                
%%        
%Get presleep
cfold=G(or(cellfun(@(x) ~isempty(strfind(x,'pre')),G),cellfun(@(x) ~isempty(strfind(x,'Pre')),G)));
cfold=cfold(and(~contains(cfold,'test'),~contains(cfold,'Test')));

% Get post trials
cfold2=G(or(cellfun(@(x) ~isempty(strfind(x,'post')),G),cellfun(@(x) ~isempty(strfind(x,'Post')),G)));
cfold2=cfold2(and(~contains(cfold2,'test'),~contains(cfold2,'Test')));
%%
%Ignore trial 6
for ind=1:length(cfold2)
  if  ~(contains(cfold2{ind},'trial1') ||contains(cfold2{ind},'trial2')||contains(cfold2{ind},'trial3')||contains(cfold2{ind},'trial4')||contains(cfold2{ind},'trial5')...
        ||contains(cfold2{ind},'Trial1')||contains(cfold2{ind},'Trial2')||contains(cfold2{ind},'Trial3')||contains(cfold2{ind},'Trial4')||contains(cfold2{ind},'Trial5')  )
      
      cfold2{ind}=[];    
  end
end

cfold2=cfold2(~cellfun('isempty',cfold2));

G=[cfold cfold2];

        
              
        if isempty(G)
            no_folder=1;
            %g=NaN;
        else
            no_folder=0;

            for i=1:length(G);

%                  xo
                cd(G{i})
                A = dir('*states*.mat');
                A={A.name};
                
                if sum(contains(A, 'states')) > 0 %More than 2 sleep scoring files
                    A=A(cellfun(@(x) ~isempty(strfind(x,'states')),A));
                    A=A(~(cellfun(@(x) ~isempty(strfind(x,'eeg')),A)));
                    
%                     st2=st(cellfun(@(x) ~isempty(strfind(x,barea)),st)); %Brain area.
                    cellfun(@load,A);


HPC=dir('*HPC_*.mat');
HPC=HPC.name;
HPC=load(HPC);
HPC=HPC.HPC;
HPC=HPC.*(0.195);

Cortex=dir(strcat('*',xx{1},'*.mat'));
Cortex=Cortex.name;
Cortex=load(Cortex);
% Cortex=Cortex.Cortex;
Cortex=getfield(Cortex,xx{1});
Cortex=Cortex.*(0.195);


% % % % % %Convert signal to 1 sec epochs.
% % % % % e_t=1;
% % % % % e_samples=e_t*(1000); %fs=1kHz
% % % % % ch=length(HPC);
% % % % % nc=floor(ch/e_samples); %Number of epochs
% % % % % NC=[];
% % % % % NC2=[];
% % % % % 
% % % % % for kk=1:nc    
% % % % %   NC(:,kk)= HPC(1+e_samples*(kk-1):e_samples*kk);
% % % % %   NC2(:,kk)= Cortex(1+e_samples*(kk-1):e_samples*kk);
% % % % % end
% % % % % 
% % % % % vec_bin=states;
% % % % % if ss~=6
% % % % %     vec_bin(vec_bin~=ss)=0;
% % % % %     vec_bin(vec_bin==ss)=1;
% % % % % else
% % % % %     vec_bin(1:end)=1;    
% % % % % end
% % % % % %xo
% % % % % %Cluster one values:
% % % % % v2=ConsecutiveOnes(vec_bin);
% % % % % 
% % % % % v_index=find(v2~=0);
% % % % % v_values=v2(v2~=0);
% % % % % 
% % % % % for epoch_count=1:length(v_index)
% % % % % v_hpc{epoch_count,1}=reshape(NC(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
% % % % % v_cortex{epoch_count,1}=reshape(NC2(:, v_index(epoch_count):v_index(epoch_count)+(v_values(1,epoch_count)-1)), [], 1);
% % % % % end 
%xo
                    
                   

                    if and(~contains(G{i},'trial5'),~contains(G{i},'Trial5')) %Whenever it is not PostTrial 5 
                        
                        % Sleep Scoring data
                        if length(states)<45*60
                            states=[states nan(1,45*60-length(states))]; %Fill with NaNs.
                        else
                            states=states(1:45*60); %Take only 45 min.
                        end
                        
                        %Ephys data
                        if length(HPC)<45*60*1000
                            HPC=[HPC.' (nan(45*60*1000-length(HPC),1).')]; %Fill with NaNs.
                        else
                            HPC=HPC(1:45*60*1000).'; %Take only 45 min.
                        end
                        
                        if length(Cortex)<45*60*1000
                            Cortex=[Cortex.' (nan(45*60*1000-length(Cortex),1).')]; %Fill with NaNs.
                        else
                            Cortex=Cortex(1:45*60*1000).'; %Take only 45 min.
                        end
                        
                        
                    else % PostTrial 5 case 
                        
                        %Sleep scoring data
                        if length(states)<45*60*4
                            states=[states nan(1,45*60*4-length(states))]; %Fill with NaNs.
                        else
                            states=states(1:45*60*4); %Take only 45 min.
                        end
                        
                        
                        %Ephys
                        if length(HPC)<45*60*1000*4
                            HPC=[HPC.' (nan(45*60*1000*4-length(HPC),1).')]; %Fill with NaNs.
                        else
                            HPC=HPC(1:45*60*1000*4).'; %Take only 45 min.
                        end
                        
                        if length(Cortex)<45*60*1000*4
                            Cortex=[Cortex.' (nan(45*60*1000*4-length(Cortex),1).')]; %Fill with NaNs.
                        else
                            Cortex=Cortex(1:45*60*1000*4).'; %Take only 45 min.
                        end

                        
                        %Chunk in 4
                        states1=states(1:2700);
                        states2=states(2700+1:2700*2);
                        states3=states(1+2700*2:2700*3);
                        states4=states(1+2700*3:2700*4);
                        
                        HPC_1=HPC(1:2700*1000);
                        HPC_2=HPC(2700*1000+1:2700*2*1000);
                        HPC_3=HPC(1+2700*2*1000:2700*3*1000);
                        HPC_4=HPC(1+2700*3*1000:2700*4*1000);
                        
                        Cortex_1=Cortex(1:2700*1000);
                        Cortex_2=Cortex(2700*1000+1:2700*2*1000);
                        Cortex_3=Cortex(1+2700*2*1000:2700*3*1000);
                        Cortex_4=Cortex(1+2700*3*1000:2700*4*1000);
                        
                        
    
                    end
%     xo
%Binning sleep scoring data
                    bin_size=5*60; %5minutes
                    nbins=size(states,2)/bin_size;

                    slpscr_binned = {};
                    for n=1:nbins
                       slpscr_binned= [slpscr_binned states(:,1+(n-1)*bin_size:bin_size*(n))];
                    end

%Binning sleep scoring data                    
                    bin_size2=5*60*1000; %5minutes
                    nbins=size(HPC,2)/bin_size2;
                    
                    HPC_binned = {};
                    for n=1:nbins
                       HPC_binned = [HPC_binned HPC(:,1+(n-1)*bin_size2:bin_size2*(n)).'];
                    end
                    
                    Cortex_binned = {};
                    for n=1:nbins
                       Cortex_binned = [Cortex_binned Cortex(:,1+(n-1)*bin_size2:bin_size2*(n)).'];
                    end

 xo
%Band pass filter design:
fn=1000; % New sampling frequency. 
Wn1=[100/(fn/2) 300/(fn/2)]; % Cutoff=100-300 Hz
% Wn1=[50/(fn/2) 80/(fn/2)]; 
[b1,a1] = butter(3,Wn1,'bandpass'); %Filter coefficients

%LPF 300 Hz:
fn=1000; % New sampling frequency. 
Wn1=[320/(fn/2)]; % Cutoff=320 Hz
[b2,a2] = butter(3,Wn1); %Filter coefficients
%%
Dwndat_binned=cellfun(@(equis) filtfilt(b2,a2,equis), dwndat_binned ,'UniformOutput',false);
Dwndat_binned=cellfun(@(equis) filtfilt(b1,a1,equis), Dwndat_binned ,'UniformOutput',false); %100-300 Hz
Dwndat_binned=cellfun(@(equis) times((1/0.195), equis)  ,Dwndat_binned,'UniformOutput',false); %Remove convertion factor for ripple detection
%%
% All states
fn=1000;
ti=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,Dwndat_binned,'UniformOutput',false);
D1=100;
[Sx_hpc,Ex_hpc,Mx_hpc] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2, D1, (D1)*(1/2), [] ),Dwndat_binned,ti,'UniformOutput',false);    
%xo

N=1;
allscreen()
%ax1=subplot(1,2,1)
plot(ti{N},Dwndat_binned{N})
hold on
stem(Mx_hpc{N},ones(size(Mx_hpc{N}))*1000)
%%
xo
dwndat2=filtfilt(b2,a2,dwndat);
dwndat2=filtfilt(b1,a1,dwndat2);
dwndat2=dwndat2.*(1/0.195);

Ti=cellfun(@(equis) reshape(linspace(0, length(equis)-1,length(equis))*(1/fn),[],1) ,{dwndat2},'UniformOutput',false);
D1=200;
[S_hpc,E_hpc,M_hpc] =cellfun(@(equis1,equis2) findRipplesLisa(equis1, equis2, D1, (D1)*(1/2), [] ),{dwndat2.'},Ti,'UniformOutput',false);    

%%

                    for m = 1:length(dwndat_binned)

                        stateloc = find(slpscr_binned{m}==ss);
                        stateloc2={};
                        data=slpscr_binned{m}==ss;

                        if sum(data)>0;



                            nonZeroElements = data ~= 0;
                            % Define the closest regions can be.  If they are farther away than this,
                            % then they will be considered as separate regions.
                            if strcmp(barea,'HPC')
                            minSeparation = 1;
                            else
                            minSeparation = 2;                    
                            end

                            nonZeroElements = ~bwareaopen(~nonZeroElements, minSeparation);
                            [labeledRegions, numRegions] = bwlabel(nonZeroElements);

                            MC=[];
                            for p = 1:numRegions
                                stateloc2{p}=dwndat_binned{m}(min(find(labeledRegions==p))*1000-999:max(find(labeledRegions==p))*1000);
                                [NC,~]=epocher( {stateloc2{p}},1);
                                MC=[MC ;NC.'];

                            end
                              [pxx,f]=pmtm(MC.',4,[],1000);
                              meanp = mean(pxx,2);
                              [minDistance1, indexOfMin1] = min(abs(f-5));
                              [minDistance2, indexOfMin2] = min(abs(f-8));
                              ratiotheta = [ratiotheta sum(meanp(indexOfMin1:indexOfMin2))/ sum(meanp)];
                              meanp_pt = [meanp_pt meanp];
                              save(strcat('meanp_PT_',stage,'_',g{j},'_',G{i},'_',barea),'meanp_pt')

                              
                        else
                                ratiotheta=[ratiotheta NaN];
                                meanp_pt = [meanp_pt NaN];
                                save(strcat('meanp_PT_',stage,'_',g{j},'_',G{i}),'meanp_pt')

                        end
                        
                    end
                    cd ..
                else
                    cd ..
                end
                

            meanp_sd = [meanp_sd {meanp_pt}];
            save(strcat('Meanpower_SD_',stage,'_',g{j},'_',barea), 'meanp_sd')
            ratiothetasd = [ratiothetasd {ratiotheta}];
            save(strcat('ratiotheta_SD_',stage,'_',g{j},'_',barea),'ratiothetasd')
            
            end
                cd ..
        end
        
          
    end

    cd ..
end


