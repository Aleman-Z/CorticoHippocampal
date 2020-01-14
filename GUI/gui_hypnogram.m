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

states(states==1)=2;

c=area((1:length(states))/60,states)
xlabel('Time (Minutes)')
%xlabel('Minutes')

yticks([2 3 4 5])

yticklabels({'Wake','NREM','Transitional sleep','REM'})
ylim([1 5])
c.FaceColor=[1 0 0];

cd .. 
printing(strcat('Hypnogram','_Rat',num2str(rats(RAT)),'_',g{k}))    

close all

 
end



if size(label1,1)==3  % If Plusmaze
    break
end

clear Z g X XX
end
    
end
% end