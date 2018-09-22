function autotest_single(q,timecell,label,ro)
fn=1000;
data1.trial=q;
data1.time= timecell; %Might have to change this one 
data1.fsample=fn;
data1.label=cell(3,1);
data1.label{1}='Hippocampus';
data1.label{2}='Parietal';
data1.label{3}='PFC';
% data1.label{4}='Reference';

% os=[1,2,3,5,10,20];

%Parametric model Order 10
[granger5]=createauto(data1,10)

%Non parametric
[granger]=createauto_np(data1)

% cfg2         = [];
% cfg2.order   = 20;
% cfg2.toolbox = 'bsmart';
% mdata2       = ft_mvaranalysis(cfg2, data1);
% 
% cfg2        = [];
% cfg2.method = 'mvar';
% mfreq2      = ft_freqanalysis(cfg2, mdata2);
% 
% cfg2           = [];
% cfg2.method    = 'granger';
% granger2       = ft_connectivityanalysis(cfg2, mfreq2);



lab=cell(9,1);
lab{1}='HPC -> HPC';
lab{2}='HPC -> Parietal';
lab{3}='HPC -> PFC';
% lab{4}='Hippo -> Reference';

lab{4}='Parietal -> HPC';
lab{5}='Parietal -> Parietal';
lab{6}='Parietal -> PFC';
% lab{8}='Parietal -> Reference';

lab{7}='PFC -> HPC';
lab{8}='PFC -> Parietal';
lab{9}='PFC -> PFC';
% lab{12}='PFC -> Reference';

% lab{13}='Reference -> Hippo';
% lab{14}='Reference -> Parietal';
% lab{15}='Reference -> PFC';
% lab{16}='Reference -> Reference';


% figure
conta=0;
compt=0;
figure('units','normalized','outerposition',[0 0 1 1])
%for j=1:length(freq1.time)
    compt=compt+1; 
    conta=0;
for row=1:length(data1.label)
for col=1:length(data1.label)
%   if col==row
%       col=col+1;
%   end
  subplot(length(data1.label),length(data1.label),(row-1)*length(data1.label)+col);
     
 plot(granger5.freq, squeeze(granger5.grangerspctrm(row,col,:)),'Color',[0 1 1])
 hold on
 plot(granger.freq, squeeze(granger.grangerspctrm(row,col,:)),'Color',[1 0 0])
%   plot(granger8.freq, squeeze(granger4.grangerspctrm(row,col,:)),'Color',[0 1 1])

if col~=row
    max1=[max(squeeze(granger.grangerspctrm(row,col,:))) ...
        
        max(squeeze(granger5.grangerspctrm(row,col,:))) ...          
    ];
   max1=max(max1);
   
   %Opposite direction. 
    max2=[max(squeeze(granger.grangerspctrm(col,row,:))) ...
        max(squeeze(granger5.grangerspctrm(col,row,:))) ...          
    ];
   max2=max(max2);
   
  Mmax=max([max1 max2]);
   ylim([0 Mmax])
end
  
%  ylim auto
  xlim([0 300])
  xlabel('Frequency (Hz)')
  grid minor
  conta=conta+1;
  %xo
  if conta==1 || conta==5 || conta==9 
%      
%      legend(num2str(os(1)),num2str(os(2)),num2str(os(3)),num2str(os(4)),num2str(os(5)),num2str(os(6)),'NP')
%      %legend(num2str(os(1)),num2str(os(2)),num2str(os(3)),num2str(os(4)),num2str(os(5)),num2str(os(6)),num2str(os(7)),num2str(os(8)))
%   % legend('NP:Multitaper','Parametric: AR(10)','NP:MTMFFT')  
  legend('Parametric: AR(10)','NP:MTMFFT')    
  set(gca,'Color','k')
  end

%   if conta==4
%       error('stop')
%   end
  title(lab{conta})
end
end
%end
%xo
% mtit('Monopolar','fontsize',14,'color',[1 0 0],'position',[.5 1 ])
% mtit(label,'fontsize',14,'color',[1 0 0],'position',[.5 0.75 ])
% mtit(strcat('(+/-',num2str(ro),'ms)'),'fontsize',14,'color',[1 0 0],'position',[.5 0.5 ])
compt
end
