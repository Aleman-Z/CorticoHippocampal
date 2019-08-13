%gui_sleep_amount
plot_sleep=0;
dname=uigetdir([],'Select folder with Matlab data');

for RAT=1:length(rats)
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


%Colormap
myColorMap = jet(8);                                                                                                                                                                                    
myColorMap =myColorMap([2 4 5 7],:);
myColorMap(2,:)=[0, 204/255, 0];
myColorMap(3,:)=[0.9290, 0.6940, 0.1250];

for iii=1:length(labelconditions) %Up to 4 conditions. OR is 2.
cd(strcat(dname,'/',num2str(rats(RAT))));
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

for k=1:length(g) %all trials. 
myColorMap = jet(length(g));
cd(strcat(dname,'/',num2str(rats(RAT))));
cd( labelconditions2{iii})
cd( g{1,k})
%xo
A = dir('*states*.mat');
A={A.name};

if  ~isempty(A)
       cellfun(@load,A);
end


L= length(states)/60%min

 g1=sum(states==1)/60; %Wake
 g3=sum(states==3)/60; %NREM
 g4=sum(states==4)/60; %Transitional Sleep
 g5=sum(states==5)/60; %REM
%FYI: Some states have a value of 0, so it is normal that sum(G) is not
%same as L.
 G=[g1 g3 g4 g5]; 
 gy=G;
 G=G/L*100
 
 
Z{k}=G;
X{k}=gy;
XX(k,:)=gy;

 
 
end


y=reshape(cell2mat(Z.'),[length(g) 4]);
c = categorical(g);
allscreen()
bb=bar(c,y,'stacked')
ylabel('Cumulative percentage of sleep','FontSize',16)
lg=legend('Wake','NREM','Transitional Sleep','REM')
lg.Location='eastoutside';
lg.FontSize=14
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
xo
end
    
end