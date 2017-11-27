data1 = pre_sube(dat);

data2 = pre_sube_divs(dat);

data3 = pre_subt(dat);

data4 = pre_subt_divs(dat);

%%
moving_window_pairwise;
%%
dat=data2;

order  = 4;
morder = order;
spts   = 1;
epts   = 18;
winlen = 10;
fs = 200;
%frang = 1:0.5:fs/2;
frang = 1:0.25:40;
fmax=max(frang);
%%
BS_order(dat,winlen,10)
% core: moving window multivariate model
%%
mov_bi_model(dat,order,spts,epts,winlen);
%%

[Fxy1,Fyx1] = mov_bi_ga(dat,spts,epts,winlen,morder,fs,frang);
%%
Fxy=Fxy1;
Fyx=Fyx1;

%%
c = size(Fxy,1);
nch = (1+sqrt(1+8*c))/2;
chx=9;
chy=10;
timen=0;
%%
ga_view(Fxy,Fyx,fs,chx,chy)
%%

BS_plot(Fxy,Fyx,chx,chy,fmax,1)
%%
if timen==0
    % timen=0;
    dat  = Fxy;
    dat2 = Fyx;
    si   = size(dat);
    c = si(1);
    channel = (1+sqrt(1+8*c))/2;
    
    % % TODO: donot use symbolic toolbox
    % c    = si(1)*2;
    % s    = sprintf('x^2-x-%d',c);
    % dd   = solve(s);
    % dd   = double(dd);
    % if dd(1)>0
    %     channel=dd(1);
    % else
    %     channel=dd(2);
    % end
    
    
    i = chx;
    j = chy;
    if i < j
        ii = i;k = 0;
        m = channel-1;
        while i > 1
            k = k+m;
            m = m-1;
            i = i-1;
        end
        k = k+j-ii;
        if length(si) == 3
            c = dat(k,:,:); % Fxy
            c = squeeze(c);
            time = [1,si(3)];
            %freq = [0,fs/2];
            freq = [0,fmax];
            figure;
            imagesc(time,freq,c);
            axis xy;
            colorbar;
            tstr = sprintf('Granger Causality: Channel %d \\rightarrow Channel %d',chx,chy);
            title(tstr);
            xlabel('Time')
            ylabel('Frequency (Hz)');
        else % draw GC spectrum
            c = dat(k,:);
            c = c';
            nb = si(2); % number of frequency bin
            frq = linspace(0,fs/2,nb);
            figure;
            plot(frq,c);
            % axis([0,si(2),0,1]);
            h = gca;
            tstr = sprintf('Channel %d \\rightarrow Channel %d',chx,chy);
            title(h,tstr);
            xlabel(h,'Frequency (Hz)')
            ylabel(h,'Granger Causality')
        end
    else
        t=j;
        j=i;
        i=t;
        ii=i;k=0;
        m=channel-1;
        while i>1
            k=k+m;
            m=m-1;
            i=i-1;
        end
        k=k+j-ii;
        if length(si)==3
            c=dat2(k,:,:);  % Fyx
            c=squeeze(c);
            time = [1,si(3)];
            freq = [0,fs/2];
            figure;
            imagesc(time,freq,c);
            axis xy;
            colorbar;
            tstr = sprintf('Granger Causality: Channel %d \\rightarrow Channel %d',chx,chy);
            title(tstr);
            xlabel('Time')
            ylabel('Frequency (Hz)');
        else
            c=dat2(k,:);
            c=c';
            nb = si(2); % number of frequency bin
            frq = linspace(0,fs/2,nb);
            figure;
            plot(frq,c);
            % axis([0,si(2),0,1]);
            h = gca;
            tstr = sprintf('Granger causality: Channel %d \\rightarrow Channel %d',chx,chy);
            title(tstr);
            xlabel(h,'Frequency (Hz)')
            ylabel(h,'Granger Causality')
        end
    end
else
    dat = Fxy;
    dat2 = Fyx;
    si = size(dat);
    c = si(1);
    channel = (1+sqrt(1+8*c))/2;
    
    % c  = si(1)*2;
    % s  = sprintf('x^2-x-%d',c);
    % dd = solve(s);
    % dd = double(dd);
    % if dd(1) > 0
    %     channel = dd(1);
    % else
    %     channel = dd(2);
    % end
    
    i = chx;
    j = chy;
    if i < j
        ii = i;k = 0;
        m = channel-1;
        while i > 1
            k = k+m;
            m = m-1;
            i = i-1;
        end
        k = k+j-ii;
        if length(si) == 3
            c = dat(k,:,timen); % Fxy
        else
            if timen > 1
                errordlg('please input correct time','parameter lost'); return;
            else
                c = dat(k,:);   % Fxy
            end
        end
        % figure('Name','Granger Causality','NumberTitle','off')
        nb = si(2); % number of frequency bin
        %frq = linspace(0,fs/2,nb);
        frq = linspace(0,fmax,nb);
        figure;
        plot(frq,c);
        % axis([0,si(2),0,1]);
        h = gca;
        tstr = sprintf('Channel %d \\rightarrow Channel %d',chx,chy);
        title(tstr);
        xlabel(h,'Frequency (Hz)')
        ylabel(h,'Granger Causality')
    else
        t=j;
        j=i;
        i=t;
        ii=i;k=0;
        m=channel-1;
        while i>1
            k=k+m;
            m=m-1;
            i=i-1;
        end
        k=k+j-ii;
        if length(si)==3
            c = dat2(k,:,timen);    % Fyx
        else
            if timen > 1
                errordlg('please input correct time','parameter lost'); return;
            else
                c = dat2(k,:);      % Fyx
            end
        end
        nb = si(2); % number of frequency bin
        %frq = linspace(0,fs/2,nb);
        frq = linspace(0,fmax,nb);
        figure;
        plot(frq,c);
        % axis([0,si(2),0,1]);
        h = gca;
        tstr = sprintf('Channel %d \\rightarrow Channel %d',chx,chy);
        title(tstr);
        xlabel(h,'Frequency (Hz)')
        ylabel(h,'Granger Causality')
    end
end
%%
load('test71_pre.mat')

frang=1:0.5:40;
fs=200;

order=4;
spts   = 1;
epts   = 18;
winlen = 10;
BS_order(dat,winlen,10)
%%
[Fxy, Fyx]=BS_main(dat,order, spts, epts, winlen,fs,frang);
%%
chx=9;
chy=10;
allscreen()
subplot(1,2,1)
BS_plot(Fxy,Fyx,chx,chy,frang,1)
subplot(1,2,2)
BS_plot(Fxy,Fyx,chx,chy,frang,0)
%% Arranging p and q to use them in BSMART
%dat. 
%15 channels.
%137 trials.
%18 points. 

load('test71_pre.mat')
load('p.mat')
load('q.mat')
%%

% 4 channels
% 77 trials 
% 400 points

%400x4x77
np=nan(length(p{1}),4,length(p));
for i=1:77
 aver=p{i};   
 aver=aver.';
 np(:,:,i)=aver;
end

nq=nan(length(p{1}),4,length(q));
for i=1:77
 aver=q{i};   
 aver=aver.';
 nq(:,:,i)=aver;
end
%%
dat=nq;
frang=1:1:300;
fs=1000;

order=4;
spts   = 1;
epts   = 400;
winlen = 10;
%%
data1 = pre_sube(dat);

data2 = pre_sube_divs(dat);

data3 = pre_subt(dat);

data4 = pre_subt_divs(dat);
%%
BS_order(data4)
%title('data2')
%%
dat=data2;
[Fxy3, Fyx3]=BS_main(dat,order, spts, epts, winlen,fs,frang);
%%
hippo=1;
parietal=2;
pfc=3;
ref=4;


% chx=2;
% chy=1;
chx=pfc;
chy=hippo;

allscreen()
% subplot(1,2,1)
% BS_plot(Fxy2,Fyx2,chx,chy,frang,149)
% subplot(1,2,2)
% BS_plot(Fxy2,Fyx2,chx,chy,frang,0)
%
% combos = nchoosek([1:4],2);
% Combos=[combos;fliplr(combos)];
% CCOmbos=[1 2; 2 1;]

% comb(:,1)=[ones(4,1);2*ones(4,1);3*ones(4,1);4*ones(4,1) ]
% comb(:,2)=[[1:4]';[1:4]';[1:4]';[1:4]' ]

comb(:,1)=[ones(3,1);2*ones(3,1);3*ones(3,1) ]
comb(:,2)=[[1:3]';[1:3]';[1:3]' ]

%%
% Fxynew=Fxy3.*(Fxy3>0.10);
% Fyxnew=Fyx3.*(Fyx3>0.10);
th=0.2

Fxynew=(Fxy3>th);
Fyxnew=(Fyx3>th);


allscreen()
for ii=1:9
subplot(3,3,ii)
if comb(ii,1)~=comb(ii,2)
BS_plot2(Fxynew,Fyxnew,comb(ii,1),comb(ii,2),frang)
%ylim([0 20])
%xlim([100 300])
else
set(gca,'Color','k')   
end

end
%%
Co=[1 2; 2 1; 1 3; 3 1; 2 3; 3 2];

for i=1:length(Co)
subplot(3,2,i)
BS_plot2(Fxy3,Fyx3,Co(i,1),Co(i,2),frang)
    
end

