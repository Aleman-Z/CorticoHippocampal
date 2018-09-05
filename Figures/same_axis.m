close all
clear all

acer=0;
labelconditions=[
    {     
    'Baseline'}
     'PlusMaze'    
     'Novelty'
     'Foraging'
    ];

c = categorical(labelconditions); 
labelconditions=[
    { 
    
    'Baseline'}
     'PlusMaze'    
     'Novelty'
     'Foraging'
    ];

label1=cell(7,1);
label1{1}='Hippo';
label1{2}='Hippo';
label1{3}='Parietal';
label1{4}='Parietal';
label1{5}='PFC';
label1{6}='PFC';
label1{7}='Reference';

DUR{1}='1sec';
DUR{2}='10sec';
Block{1}='complete';
Block{2}='block1';
Block{3}='block2';
sanity=0;
quinientos=0;
ldura=1; %1 for 1 sec, 2 for 10 sec. 
%%
if acer==0
addpath('/home/raleman/Documents/MATLAB/analysis-tools-master'); %Open Ephys data loader. 
addpath(genpath('/home/raleman/Documents/GitHub/CorticoHippocampal'))
addpath(genpath('/home/raleman/Documents/GitHub/ADRITOOLS'))
addpath('/home/raleman/Documents/internship')
addpath /home/raleman/Documents/internship/fieldtrip-master/
InitFieldtrip()
else
addpath('D:\internship\analysis-tools-master'); %Open Ephys data loader.
addpath(genpath('C:\Users\addri\Documents\internship\CorticoHippocampal'))
addpath(genpath('C:\Users\addri\Documents\GitHub\ADRITOOLS'))

addpath D:\internship\fieldtrip-master
InitFieldtrip()
end
%%

for Rat=2:2
    
if Rat==1
    
    if acer==0
         cd('/home/raleman/Dropbox/Figures/Figure3/26/Baseline2_1000_Method4')
          if ldura==2
              cd('..')
              cd('10sec')
          end
    else
          %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
          cd('C:/Users/addri/Dropbox/Figures/Figure3/26/Baseline2_1000_Method4')
          if ldura==2
              cd('..')
              cd('10sec')
          end
    end
end

if Rat==2
    
    if acer==0
         cd('/home/raleman/Dropbox/Figures/Figure3/27/Baseline2_1000_Method4')
          if ldura==2
              cd('..')
              cd('10sec')
          end
    else
          %cd(strcat('C:\Users\Welt Meister\Dropbox\Figures\Figure2\',num2str(Rat)))   
          cd('C:/Users/addri/Dropbox/Figures/Figure3/27/Baseline2_1000_Method4')
          if ldura==2
              cd('..')
              cd('10sec')
          end
    end
end


    %%
for dura=ldura:ldura
for block_time=0:0
for w=2:3    
    for iii=2:length(labelconditions)
        if sanity~=1
        string=strcat('Spec_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');    
        else
            if quinientos==1
                string=strcat('Control_500_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');    

            else
                string=strcat('Control_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');    

            end
        end
        %xo
        openfig(string)  
        
        h = gcf; %current figure handle
        axesObjs = get(h, 'Children');  %axes handles
        dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
        VER1(iii-1,:)=[axesObjs(6).YLim];
        VER2(iii-1,:)=[axesObjs(8).YLim];
    end
    mVER1=[ min(VER1(:,1)) max(VER1(:,2))];
    mVER2=[ min(VER2(:,1)) max(VER2(:,2))];
    close all
    
    for iii=2:length(labelconditions)
    
    
    if sanity~=1
    string=strcat('Spec_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');
    else
        if quinientos==1
             string=strcat('Control_500_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');           
        else
             string=strcat('Control_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');       
        end
    end
        openfig(string)    
    %figure(1)
    h = gcf; %current figure handle
        axesObjs = get(h, 'Children');  %axes handles
        dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    axesObjs(4).YLim=mVER1;
    axesObjs(6).YLim=mVER1;
    axesObjs(8).YLim=mVER2;
    axesObjs(10).YLim=mVER2;
    
    %%
 % figure()
 nv1=(dataObjs{3}.CData);
nv2=(dataObjs{5}.CData);
nv3=(dataObjs{9}.CData);
nv4=(dataObjs{7}.CData);
 
    subplot(3,4,5)
       I=imagesc(nv1);
    caxis(mVER1)
%colormap(jet(256))
c1=narrow_colorbar()
% cax1=caxis;%  -1.6465    8.3123
% c1.YLim=[do(1) do(4)];
I.CDataMapping = 'scaled';
gg=gca;
gg.YTickLabel=flip(gg.YTickLabel);
colormap(jet(256))
%set(gca,'YDir','normal')
c1=narrow_colorbar()
gg.XTick=[1 50 100 150 200];
if dura==2
gg.XTickLabel=[{-10} {-5} {0} {5} {10}];    
else
gg.XTickLabel=[{-1} {-0.5} {0} {0.5} {1}];    
end
xlabel('Time (s)')
% title(strcat('Wide Band','{ }',lab))
ylabel('Frequency (Hz)')
title('Wide Band No Learning')
%
i=I.CData;
set(gca, 'YTick',[1 size(i,1)/2/3 size(i,1)/2/3*2 size(i,1)/2 size(i,1)/2/3*4 size(i,1)/2/3*5] , 'YTickLabel', [30 25 20 15 10 5]) % 20 ticks
%%
%figure()

 nv=(dataObjs{5}.CData);
    subplot(3,4,6)
       I=imagesc(nv2)
    caxis(mVER1)
%colormap(jet(256))
c1=narrow_colorbar()
% cax1=caxis;%  -1.6465    8.3123
% c1.YLim=[do(1) do(4)];
I.CDataMapping = 'scaled';
gg=gca;
gg.YTickLabel=flip(gg.YTickLabel);
colormap(jet(256))
%set(gca,'YDir','normal')
c1=narrow_colorbar()
gg.XTick=[1 50 100 150 200];
%gg.XTickLabel=[{-1} {-0.5} {0} {0.5} {1}];
if dura==2
gg.XTickLabel=[{-10} {-5} {0} {5} {10}];    
else
gg.XTickLabel=[{-1} {-0.5} {0} {0.5} {1}];    
end

xlabel('Time (s)')
title(strcat('Wide Band','{ }',labelconditions{iii}))
ylabel('Frequency (Hz)')

%
i=I.CData;
set(gca, 'YTick',[1 size(i,1)/2/3 size(i,1)/2/3*2 size(i,1)/2 size(i,1)/2/3*4 size(i,1)/2/3*5] , 'YTickLabel', [30 25 20 15 10 5]) % 20 ticks
%%
%figure()

 nv=(dataObjs{9}.CData);
    subplot(3,4,7)
       I=imagesc(flip(nv3,1))
    caxis(mVER2)
%colormap(jet(256))
c1=narrow_colorbar()
% cax1=caxis;%  -1.6465    8.3123
% c1.YLim=[do(1) do(4)];
I.CDataMapping = 'scaled';
gg=gca;
gg.YTickLabel=flip(gg.YTickLabel);
colormap(jet(256))
%set(gca,'YDir','normal')
c1=narrow_colorbar()
gg.XTick=[1 50 100 150 200];
%gg.XTickLabel=[{-1} {-0.5} {0} {0.5} {1}];
if dura==2
gg.XTickLabel=[{-10} {-5} {0} {5} {10}];    
else
gg.XTickLabel=[{-1} {-0.5} {0} {0.5} {1}];    
end

xlabel('Time (s)')
% title(strcat('Wide Band','{ }',lab))
ylabel('Frequency (Hz)')
title('High Gamma No Learning')

%
i=I.CData;
set(gca, 'YTick',[1  size(i,1)/4 size(i,1)/2 size(i,1)/4*3    size(i,1)] , 'YTickLabel', [300 250 200 150 100]) % 20 ticks
%%
%%
% figure()
 nv=(dataObjs{7}.CData);
    subplot(3,4,8)
       I=imagesc(flip(nv4,1))
    caxis(mVER2)
%colormap(jet(256))
c1=narrow_colorbar()
% cax1=caxis;%  -1.6465    8.3123
% c1.YLim=[do(1) do(4)];
I.CDataMapping = 'scaled';
gg=gca;
gg.YTickLabel=flip(gg.YTickLabel);
colormap(jet(256))
%set(gca,'YDir','normal')
c1=narrow_colorbar()
gg.XTick=[1 50 100 150 200];
%gg.XTickLabel=[{-1} {-0.5} {0} {0.5} {1}];
if dura==2
gg.XTickLabel=[{-10} {-5} {0} {5} {10}];    
else
gg.XTickLabel=[{-1} {-0.5} {0} {0.5} {1}];    
end

xlabel('Time (s)')
% title(strcat('Wide Band','{ }',lab))
title(strcat('High Gamma','{ }',labelconditions{iii}))
ylabel('Frequency (Hz)')
%
i=I.CData;
set(gca, 'YTick',[1  size(i,1)/4 size(i,1)/2 size(i,1)/4*3    size(i,1)] , 'YTickLabel', [300 250 200 150 100]) % 20 ticks
%xo
if sanity ~=1
string=strcat('Spec2_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
figure_function(gcf,[],string,[]);
string=strcat('Spec2_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.eps');
print(string,'-depsc')
string=strcat('Spec2_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');
saveas(gcf,string)
else
    if quinientos==1
        
        string=strcat('Control2_500_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
        figure_function(gcf,[],string,[]);
        string=strcat('Control2_500_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.eps');
        print(string,'-depsc')
        string=strcat('Control2_500_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');
        saveas(gcf,string)            

    else
        string=strcat('Control2_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.pdf');
        figure_function(gcf,[],string,[]);
        string=strcat('Control2_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.eps');
        print(string,'-depsc')
        string=strcat('Control2_',labelconditions{iii},'_',label1{2*w-1},'_',Block{block_time+1},'_',DUR{dura},'.fig');
        saveas(gcf,string)            
    end
end

    end
%xo
%%
end
end
end
end
