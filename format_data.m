function [ft_data1]=format_data(q,timecell,freqrange,label,equis,toy)
%[100:1:300]

ft_data1 = [];
ft_data1.fsample = 1000;
%tt=linspace(-5,5,1000);
%ft_data1.trial = q(1:1); % q should be larger than +/-500 ms. Better to use 1 sec. 
%ft_data1.trial = q(1,end-199:end); % q should be larger than +/-500 ms. Better to use 1 sec. 
ft_data1.trial = q(1,1:end); % q should be larger than +/-500 ms. Better to use 1 sec. 


%ft_data1.time = (timecell(1,end-199:end));
ft_data1.time = (timecell(1,1:end));

%ft_data1.time = {[tt;tt;tt;tt]};


%ft_data1.label = {'Hippo'; 'Parietal'; 'PFC';'REF'};
ft_data1.label = {'Hippo'; 'Parietal'; 'PFC'};


end