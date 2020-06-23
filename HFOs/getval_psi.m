function [PSI_all,psi,psi2,granger,granger2,g1,g1_f,G,g_f,FB,FB1]=getval_psi(P,Q,labelconditions3,label1,s,w,fn)


    n=min([length(P.(labelconditions3{1}).(label1{w}){s}) length(P.(labelconditions3{2}).(label1{w}){s})...
        length(P.(labelconditions3{3}).(label1{w}){s}) length(P.(labelconditions3{4}).(label1{w}){s})]);
    


type_hfo{1}='cohfos';
type_hfo{2}='single';


for condition=1:length(labelconditions3)

    %Order ripples
    p=P.(labelconditions3{condition}).(label1{w}){s}; 
    q=Q.(labelconditions3{condition}).(label1{w}){s}; 
    % R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,:)))),q));
    %R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,121-50:121+50)))),q));
    R=(cellfun(@(equis1) max(abs(hilbert(equis1(1,151-25:151+25)))),q));
    [~,r]=sort(R,'descend');
    p=p(r);
    q=q(r);
    p=p(1:n);
    q=q(1:n);


    %Max 1000 ripples.
    if length(q)>200
        q=q(1:200);
        p=p(1:200);
%         q_nl=q_nl(1:1000);
%         p_nl=p_nl(1:1000);
    end

    if w==1 %HPC-centered ripples.
         p=cellfun(@(equis1) flip(equis1),p,'UniformOutput',false);
         q=cellfun(@(equis1) flip(equis1),q,'UniformOutput',false);
%          p_nl=cellfun(@(equis1) flip(equis1),p_nl,'UniformOutput',false);
%          q_nl=cellfun(@(equis1) flip(equis1),q_nl,'UniformOutput',false);
    end
    
    ro=1200;
    
    [freq,freq2]=psi_paper(p,create_timecell(ro,length(p)),[0:0.5:300],fn); %freq2 is parametric
    
%Fieldtrip approach
% connectivity estimation
cfg           = [];
cfg.method    = 'psi';
cfg.bandwidth = 3;
psi           = ft_connectivityanalysis(cfg, freq);
psi2           = ft_connectivityanalysis(cfg, freq2); %Parametric
cfg        = [];
cfg.method = 'granger';
granger    = ft_connectivityanalysis(cfg, freq);
cfg        = [];
cfg.method = 'granger';
granger2    = ft_connectivityanalysis(cfg, freq2);


    G{condition}=psi.psispctrm;%Non-parametric (Pairwise)
    g1{condition}=psi2.psispctrm;%Parametric
    
[FB{condition}]=gc_freqbands(psi,0,'psi');%Non-parametric (Pairwise)
[FB1{condition}]=gc_freqbands(psi2,0,'psi');%Parametric


    
    
%Federico approach
%Need to compute TF wavelet on Fieldtrip.
freqrange=[0.5:0.5:300];
data1.trial=p;
data1.time=create_timecell(ro,length(p)); %Might have to change this one 
data1.fsample=fn;
data1.label=cell(3,1);

data1.label{1}='PAR';
data1.label{2}='PFC';
data1.label{3}='HPC';
%
equis=0.5;
%%       
cfg = [];
cfg.method = 'mtmconvol';
%cfg.method = 'wavelet';

cfg.taper = 'hanning';
% cfg.taper = 'dpss';

%cfg.pad='nextpow2';
cfg.pad=4;
%cfg.padtype='edge';
cfg.foi = freqrange;
%cfg.t_ftimwin = 0.4 * ones(size(cfg.foi));
cfg.t_ftimwin = 0.1.*ones(size(4./cfg.foi')); 
% cfg.tapsmofrq =20.*ones(size(4./cfg.foi'));


% +  
%cfg.toi=toy;
% cfg.toi       = -1:0.1:1;
cfg.toi       =data1.time{1};
% cfg.output         = 'pow';
cfg.output         = 'fourier';

cfg.keeptrials = 'yes';


freq = ft_freqanalysis(cfg, data1);
%% Wavelet 

cfg = [];
cfg.method = 'wavelet';
cfg.foi = freqrange;
cfg.toi       =data1.time{1};
cfg.output='fourier';
%'powandcsd'

cfg.width=10;
% cfg.gwidth=3;

% cfg.pad     = 10;
freq = ft_freqanalysis(cfg, data1);

%%
% cfg = [];
% cfg.method     = 'wavelet';
% cfg.pad=4;
% cfg.width      = 7;
% cfg.toi       =data1.time{1};
% cfg.foi = freqrange;
% freq2 = ft_freqanalysis(cfg, data1);
%%
% cfg=[];ft_singleplotTFR(cfg, freq2);
aver=squeeze(mean(freq.fourierspctrm,1));
%aver=aver(:,:,101:end-100);

%aver=aver(1,:,201:end-200);
% aver=squeeze(aver(1,:,:));

% [granger]=createauto_timefreq(data1,freqrange);
% %Non parametric
% [granger]=createauto_np(data1,freqrange,[]);

%     cfg           = [];
%     cfg.method    = 'mtmfft';
%     cfg.taper     = 'dpss'; 
%     cfg.output    = 'fourier'; 
%     cfg.tapsmofrq = 2; %1/1.2
% %     cfg.tapsmofrq = 4; %1/1.2
%     
%     cfg.pad = 10;
%     cfg.foi=freqrange;
%     %[0:1:500]
%     freq          = ft_freqanalysis(cfg, data1);


    F= [1 2; 1 3; 2 3] ;

    lab{2}='PFC -> PAR';
    lab{1}='PAR -> PFC';

    lab{4}='HPC -> PAR';
    lab{3}='PAR -> HPC';

    lab{6}='HPC -> PFC';
    lab{5}='PFC -> HPC';
    
 for j=1:3
     
 f=F(j,:);
    
%     cwt_sig_area_1=squeeze(freq.fourierspctrm(:,f(1),:));
%     cwt_sig_area_1=transpose(cwt_sig_area_1);
%     cwt_sig_area_2=squeeze(freq.fourierspctrm(:,f(2),:));
%     cwt_sig_area_2=transpose(cwt_sig_area_2);
     cwt_sig_area_1=squeeze(aver(f(1),:,:));
%      cwt_sig_area_1=cwt_sig_area_1(:,201:end-200);
     cwt_sig_area_2=squeeze(aver(f(2),:,:));
%      cwt_sig_area_2=cwt_sig_area_2(:,201:end-200);
%Replace nans with average values.
cwt_sig_area_1(isnan(cwt_sig_area_1))=mean(mean(cwt_sig_area_1(~isnan(cwt_sig_area_1))));
cwt_sig_area_2(isnan(cwt_sig_area_2))=mean(mean(cwt_sig_area_2(~isnan(cwt_sig_area_2))));


    psi_val(2*j-1,:)=PSI_Analysis(cwt_sig_area_1,cwt_sig_area_2,freq.freq);
    

%     cwt_sig_area_1=squeeze(freq.fourierspctrm(:,f(2),:));
%     cwt_sig_area_1=transpose(cwt_sig_area_1);
%     cwt_sig_area_2=squeeze(freq.fourierspctrm(:,f(1),:));
%     cwt_sig_area_2=transpose(cwt_sig_area_2);
     cwt_sig_area_1=squeeze(aver(f(2),:,:));
     cwt_sig_area_2=squeeze(aver(f(1),:,:));
%Replace nans with average values.
cwt_sig_area_1(isnan(cwt_sig_area_1))=mean(mean(cwt_sig_area_1(~isnan(cwt_sig_area_1))));
cwt_sig_area_2(isnan(cwt_sig_area_2))=mean(mean(cwt_sig_area_2(~isnan(cwt_sig_area_2))));


    psi_val(2*j,:)=PSI_Analysis(cwt_sig_area_1,cwt_sig_area_2,freq.freq);
   
    
 end    

PSI_all.(labelconditions3{condition})=psi_val;
%     G{condition}=gran.grangerspctrm;%Non-parametric (Pairwise)
%     g1{condition}=gran1.grangerspctrm;%Parametric
%     g2{condition}=grangercon.grangerspctrm;%Non-parametric (Conditional)
%     
% [FB{condition}]=gc_freqbands(gran,0);%Non-parametric (Pairwise)
% [FB1{condition}]=gc_freqbands(gran1,0);%Parametric

% g_f=gran.freq;
% g1_f=gran1.freq;
 
% granger_paper4(g1,g1_f,labelconditions3,[0 300]) %All
% printing(['Parametric'])
% close all
% 
% granger_paper4(G,g_f,labelconditions3,[0 300]) %All
% printing(['Non_parametric'])
% close all
                 
end

g_f=psi.freq;
g1_f=psi2.freq;


end
