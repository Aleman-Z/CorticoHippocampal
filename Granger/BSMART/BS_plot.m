function BS_plot(Fxy,Fyx,chx,chy,frang,timen)
fmax=max(frang);

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
            %figure;
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
            %figure;
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
            %freq = [0,fs/2];
            freq = [0,fmax];
            %figure;
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
            %figure;
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
        %figure;
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
        %figure;
        plot(frq,c);
        % axis([0,si(2),0,1]);
        h = gca;
        tstr = sprintf('Channel %d \\rightarrow Channel %d',chx,chy);
        title(tstr);
        xlabel(h,'Frequency (Hz)')
        ylabel(h,'Granger Causality')
    end
end

end