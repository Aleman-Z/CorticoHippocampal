function gui_periodogram(channels,rats,label1,labelconditions,labelconditions2)
%%
dname=uigetdir([],'Select folder with Matlab data');
% figure('Renderer', 'painters', 'Position', [50 50 200 300])
f=figure();
movegui(gcf,'center');
f.Position=[f.Position(1) f.Position(2) 350 f.Position(4)/3];
movegui(gcf,'center');

%Checkboxes
sidebyside = uicontrol('Style','checkbox','String','Side by side plot','Position',[10 f.Position(4)-30 200 20]);
sidebyside.FontSize=11;
% sidebyside=c_side.Value;
aver_trial = uicontrol('Style','checkbox','String','Average trials','Position',[10 f.Position(4)-60 200 20]);
aver_trial.FontSize=11;
% aver_trial=c.Value;
scoring = uicontrol('Style','checkbox','String','Use scoring labels','Position',[10 f.Position(4)-90 200 20]);
scoring.FontSize=11;
% scoring=c.Value;

set(f, 'NumberTitle', 'off', ...
    'Name', 'Select an option');

%Push button
c = uicontrol;
c.String = 'Continue';
c.FontSize=10;
c.Position=[f.Position(1)/7 c.Position(2)-10 f.Position(3)/2 c.Position(4)];

%Callback
c.Callback='uiresume(gcbf)';
uiwait(gcf); 
scoring=scoring.Value;
sidebyside=sidebyside.Value;
aver_trial=aver_trial.Value;
close(f);

%%

fbar=waitbar(0,'Please wait...');
for RAT=1:length(rats)
    %length(rats) %4
Rat=rats(RAT); 
cd(strcat(dname,'/',num2str(rats(RAT))));
%xo
gg=getfolder;
gg=gg.';
gg(ismember(gg,'OR_N'))=[];
gg(ismember(gg,'OD_N(incomplete)'))=[];
gg=sort(gg); %Sort alphabetically.
labelconditions2=gg;
gg(ismember(gg,'CN'))={'CON'};
labelconditions=gg;


%Alphabetical order:
%     {'CON'}
%     {'HC' }
%     {'OD' }
%     {'OR' }
n=length(gg);
switch n
    case 4
        figColorMap(1,:)=[0.49, 0.18, 0.56]; %Foraging Violet. 
        figColorMap(2,:)=[0.65, 0.65, 0.65]; %GREY CONTROL
        figColorMap(3,:)=[0.9290, 0.6940, 0.1250]; %Yellow Novelty
        figColorMap(4,:)=[0, 0, 0]; %Black plusmaze    
    case 5
        figColorMap(1,:)=[0.49, 0.18, 0.56]; %Foraging Violet. 
        figColorMap(2,:)=[0.65, 0.65, 0.65]; %GREY CONTROL
        figColorMap(3,:)=[0.2, 0.9, 0.1]; %GREY CONTROL (HC2)
        figColorMap(4,:)=[0.9290, 0.6940, 0.1250]; %Yellow Novelty
        figColorMap(5,:)=[0, 0, 0]; %Black plusmaze   
    case 6
        figColorMap(1,:)=[0.49, 0.18, 0.56]; %Foraging Violet. 
        figColorMap(2,:)=[0.65, 0.65, 0.65]; %GREY CONTROL
        figColorMap(3,:)=[0.2, 0.9, 0.1]; %GREY CONTROL
        figColorMap(4,:)=[0.9, 0.3, 0.1]; %GREY CONTROL
        figColorMap(5,:)=[0.9290, 0.6940, 0.1250]; %Yellow Novelty
        figColorMap(6,:)=[0, 0, 0]; %Black plusmaze  
    otherwise
        xo;
end
%xo


for iii=1:length(labelconditions) %Up to 4 conditions. OR is 2.
    
cd( labelconditions2{iii})
g=getfolder;

if iii==1
answer = questdlg('Should we use all trials?', ...
	'Trial selection', ...
	'Use all','Select trials','Select trials');

% Handle response
switch answer
    case 'Use all'
        disp(['Using all.'])
        an=[];
    case 'Select trials'
        prompt = {'Enter trials name common word without index:'};
        dlgtitle = 'Input';
        dims = [1 35];
        %definput = {'20','hsv'};
        an = inputdlg(prompt,dlgtitle,dims);
        %an=char(an);
%        g=g(contains(g,{'PT'}));
end

end

if ~isempty(an)
g=g(contains(g,an));
end
%xo
% g=g(contains(g,{'PT'}));

% if scoring==1
%    g=g(~contains(g,{'_'})); 
% end
%%

%Something about trial 4th
% if Rat==1 && strcmp(labelconditions{iii},'OD') 
% a = 1:length(g);
% a(a == 4) = [];
% g=g(a);
% end

PXX=cell(length(g),1);
%PX=cell(length(g),1);
PX=[];
%PX=double.empty(5,0);
%xo
for k=1:length(g) %all trials. 
    if k>length(g)
        break
    end
myColorMap = jet(length(g));                                                                                                                                                                                        
cd( g{1,k})
% xo
    A = dir('*states*.mat');
    A={A.name};
     
    if scoring==1 && ~isempty(A)
           cellfun(@load,A);
    end
%         %If no labelled data is found
%          if isempty(A) %&& scoring==1
%            messbox('No states file found. Switching to own method','Error') 
%            xo
%            scoring=0;
%          else
%            scoring=1;
%          end
        
if scoring==1 && ~isempty(A) && ~isempty(find(transitions(:,1)==3))
    % A = dir(cd);
    % A=A(~ismember({A.name},{'.','..'})); %Remove dots
    % A={A.name}

    [transitions]=sort_scoring(transitions); %

else
    
    if scoring==1
%                  messbox('No states file found or no stage data.','Error')
                   errordlg(strcat('Scoring File not found for Rat',num2str(Rat),{' '},labelconditions{iii},{' '},g{k}),'Error');
                  g{k}=strcat(g{k},'_A_c_c_e_l');
    end
    
    sos=load('sos.mat');
    sos=sos.sos; 
    %xo
    [a1,nb]=sleep_criteria(sos);
    %end
    %If no sleep is found ignore trial:
    if nb==0  %|| nb==1
        g=g(~strcmp(g,g{k}));
        myColorMap=myColorMap(1:length(g),:);
        cd ..

        if k>=length(g)   
        % a = 1:length(g);
        % a(a == k) = [];
        % g=g(a);

            break
        else
        cd( g{1,k})

        sos=load('sos.mat');
        sos=sos.sos;
        %xo
        [a1,nb]=sleep_criteria(sos);
            if nb==0
                xo
            end

        end
    end
end

%Load data
V9=load('V9.mat');
V9=V9.V9;
V9=V9.*(0.195);
V17=load('V17.mat');
V17=V17.V17;
V17=V17.*(0.195);

%xo

if scoring==1 && ~isempty(A) && ~isempty(find(transitions(:,1)==3))
[v9,~]=reduce_data(V9,transitions,1000,3);
[v17,~]=reduce_data(V17,transitions,1000,3);

else
    v9=cell(size(a1,1),1);
    v17=cell(size(a1,1),1);
    for h=1:size(a1,1)
    v9{h,1}=V9(a1(h,1):a1(h,2));
    v17{h,1}=V17(a1(h,1):a1(h,2));
    end    
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

%xo
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
            switch n
                case 4
                       subplot(1,4,iii)
                case 5   
                       subplot(1,5,iii)
                case 6
                       subplot(1,6,iii)
                otherwise
                    xo
            end
        end
    end
end
% figure()
if aver_trial~=1
figure(1)    
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
%Find index of values closer to 100 and 250 Hz.
[~,l1]=min(abs(f-100));
[~,l2]=min(abs(f-250));
New_PX{iii}=mean(PX(:,l1:l2),2);
% if size(PX,1)==6
%    PX=PX(1:5,:); 
% end
if iii>=2
[z]=merge_mat(z,New_PX{iii});
else
z=New_PX{iii};    
end

if aver_trial==1
    % subplot(1,3,iii)  
    acolor=figColorMap(iii,:);
    s=semilogy(f,(mean(PX)),'Color',acolor,'LineWidth',2);
    s.Color(4) = 0.8; 
    hold on
    % fill([f.' fliplr(f.')],[mean(PX)+std(PX) fliplr(mean(PX)-std(PX))],acolor,'linestyle','none','FaceAlpha', 0.4);
end


xlim([0 300])
xlabel('Frequency (Hz)')
ylabel('Power')

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
%xo
%string=strcat('300Hz_Rat_',num2str(Rat),'_',labelconditions{iii},'_','HPC','.pdf');
string=strcat('300Hz_Rat_',num2str(Rat),'_NREM_',labelconditions{iii},'_','HPC','.pdf');
% string=strcat('Whole_Rat_',num2str(Rat),'_',labelconditions{iii},'_','HPC','.pdf');

if sidebyside==0
xo    
printing(string);
close all    
end

cd ..
clear myColorMap
end
 xo
tab=array2table(z,'VariableNames',labelconditions);
filename = 'tab.xlsx';
% writetable(tab,filename,'Sheet',1,'Range','A1')

if sidebyside==1
 string=strcat('300Hz_Rat',num2str(Rat),'_NREM_','HPC'); 
% xo
%  printing(string);
close all
end
progress_bar(RAT,length(rats),fbar)
clear figColorMap
end

end