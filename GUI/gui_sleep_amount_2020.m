%gui_sleep_amount
%function gui_sleep_amount(channels,label1,labelconditions,labelconditions2,rats)
plot_sleep=0;
dname=uigetdir([],'Select folder with Matlab data');

for RAT=1:length(rats)
Rat=rats(RAT);    
cd(strcat(dname,'/',num2str(rats(RAT))));
%xo
gg=getfolder;
gg=gg.';

if size(label1,1)~=3  % IF not Plusmaze
gg(ismember(gg,'OR_N'))=[];
gg(ismember(gg,'OD_N(incomplete)'))=[];
gg=sort(gg); %Sort alphabetically.
labelconditions2=gg;
gg(ismember(gg,'CN'))={'CON'};
end

labelconditions=gg;


%Colormap
myColorMap = jet(8);                                                                                                                                                                                    
myColorMap =myColorMap([2 4 5 7],:);
myColorMap(2,:)=[0, 204/255, 0];
myColorMap(3,:)=[0.9290, 0.6940, 0.1250];

%Loop conditions
for iii=1:length(labelconditions) %Up to 4 conditions. OR is 2.
cd(strcat(dname,'/',num2str(rats(RAT))));

if size(label1,1)~=3  % IF not Plusmaze
cd( labelconditions2{iii})
g=getfolder;
else
% cd( labelconditions{iii})    
g=gg;    
end

if size(label1,1)~=3  % If not Plusmaze

        %SELECT TRIALS
        if iii==1 %Ask only once
        answer = questdlg('Should we use all trials?', ...
            'Trial selection', ...
            'Use all','Select trials','Select trials');

        % Handle response
        switch answer
            case 'Use all'
                disp(['Using all.'])
                an=[];
            case 'Select trials'
                prompt = {['Enter trials name common word without index:' sprintf('\n') '(Use commas for multiple names)']};
                dlgtitle = 'Input';
                dims = [1 35];
                %definput = {'20','hsv'};
                an = inputdlg(prompt,dlgtitle,dims);
                %an=char(an);
        %        g=g(contains(g,{'PT'}));
        end
        %xo
        end

        if ~isempty(an)
        g=g(contains(g,strsplit(an{1},',')));
        end

        %Find trials without scoring
        Gg=[];
        g_length=length(g);
        for kk=1:g_length
        cd(strcat(dname,'/',num2str(rats(RAT))));
        cd( labelconditions2{iii})
        cd( g{1,kk})
        %xo
        A = dir('*states*.mat');
        A={A.name};

        if  isempty(A)
            warning(['No scoring found for',' ',g{1,kk}])
        %     g(find(strcmp(g, g{1,kk})))=[]; %Remove trial without scoring.
        %     xo
            %continue
        else
        Gg=[Gg g(kk)];

        end

        end
        g=Gg;

        if isempty(g)
            continue
        end

end


for k=1:length(g) %all trials. 
myColorMap = jet(length(g));
cd(strcat(dname,'/',num2str(rats(RAT))));
if size(label1,1)~=3  % If not Plusmaze
        cd( labelconditions2{iii})
end
    
    if size(label1,1)~=3  % If not Plusmaze
        cd( g{1,k})
    else
        cd( g{k,1})        
    end
%xo
A = dir('*states*.mat');
A={A.name};

cellfun(@load,A);
% if  ~isempty(A)
%        cellfun(@load,A);
% else
%     warning('No scoring found')
%     g(find(strcmp(g, g{1,k})))=[]; %Remove trial without scoring.
% %     xo
%     continue
% end


L= length(states)/60;%min

 g1=sum(states==1)/60; %Wake
 g3=sum(states==3)/60; %NREM
 g4=sum(states==4)/60; %Transitional Sleep
 g5=sum(states==5)/60; %REM
%FYI: Some states have a value of 0, so it is normal that sum(G) is not
%same as L.
 G=[g1 g3 g4 g5]; 
 gy=G;
 G=G/L*100;
 
 
Z{k}=G;
X{k}=gy;
XX(k,:)=gy;

 
 
end

if iii==1 && RAT==1
ndir=uigetdir('C:','Select folder to save table values');
end
cd(ndir)

y=reshape(cell2mat(Z.'),[length(g) 4]);

c = categorical(cellfun(@(x) (strrep(x,'_','-')),g,'UniformOutput',false) );
allscreen()
bb=bar(c,y,'stacked')
ylabel('Cumulative percentage of sleep','FontSize',16)
lg=legend('Wake','NREM','Transitional Sleep','REM')
lg.Location='eastoutside';
lg.FontSize=14
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
set(bb,{'FaceColor'},{'w';'k';[0.5 0.5 0.5];'r'});
ylim([0 100])
%xo
if size(label1,1)==3  % If Plusmaze
printing(strcat('Sleep_stages','_Rat',num2str(rats(RAT))))
else
printing(strcat('Sleep_stages','_Rat',num2str(rats(RAT)),'_',labelconditions{iii}))    
end
close all

Stage= {'Wake';'NREM';'Transitional Sleep';'REM'};
% NoLearning=XX(1,:);
% PlusMaze=XX(2,:);
% Novelty=XX(3,:);
% Foraging=XX(4,:);


ye=cellfun(@(x) (strrep(x,'-','_')),g,'UniformOutput',false);
for l=1:length(g)
aver={(strcat(num2str(XX([l],1))));(strcat(num2str(XX([l],2))));(strcat(num2str(XX([l],3))));(strcat(num2str(XX([l],4))));};
eval([ye{l},strcat('=aver;')]);
end


ch=join(ye,",");
ch=ch{1};
TT=eval(strcat('table(Stage,',ch,')'));
VV{RAT}=TT;
% xo


% cd(num2str(Rat))
if size(label1,1)==3  % If Plusmaze
writetable(VV{1},strcat('Sleep_stages','_Rat',num2str(rats(RAT)),'.xls'),'Sheet',1,'Range','B2:F6')    
else
writetable(VV{1},strcat('Sleep_stages','_Rat',num2str(rats(RAT)),'_',labelconditions{iii},'.xls'),'Sheet',1,'Range','B2:F6')    
end


if size(label1,1)==3  % If Plusmaze
    break
end

clear Z g X XX
end
    
end
% end