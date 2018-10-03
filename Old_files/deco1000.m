function [D1, D2, D3, D4,D5 ]=deco1000(p3,p4)

%name='db4';
name='haar';

cellnames={'250Hz-500 Hz';'125Hz-250 Hz';'60Hz-125 Hz';'30Hz-60Hz';'15Hz-30Hz' };

%N = wmaxlev(length(p4),name)
N=5;
[C,L] = wavedec(p4,N,name);

[D1, D2, D3, D4,D5 ] = detcoef(C,L,[1 2 3 4 5 ]);


% figure('units','normalized','outerposition',[0 0 1 1])



for i=1:N
subplot(N,2,2*i-1)
% plot(linspace(-0.2,0.2,length(D1)),D1,'')
plot(linspace(-1,1,length(eval(strcat('D',num2str(i))))),eval(strcat('D',num2str(i))),'LineWidth',2)
%title(cellnames{i})
title(strcat('Wavelet component #', num2str(i)));
% xticks([-0.5 -0.4 -0.3 -0.2 -0.1 0 0.1 0.2 0.3 0.4 0.5])
% xticklabels({'-0.5', '-0.4', '-0.3', '-0.2', '-0.1', '0', '0.1', '0.2', '0.3', '0.4', '0.5'})
xticks([-1 -0.8 -0.6 -0.4 -0.2  0  0.2  0.4  0.6  0.8  1])
xticklabels({'-1',  '-0.8',  '-0.6','-0.4', '-0.2', '0', '0.2', '0.4','0.6','0.8',  '1'})

grid on
xlabel('Time(sec)')
ylabel('uV')
end

% % 
% % %N = wmaxlev(length(p3),name)
% % [C,L] = wavedec(p3,N,name);
% % 
% % [D1, D2, D3, D4,D5 ] = detcoef(C,L,[1 2 3 4 5]);
% % 
% % 
% % % figure('units','normalized','outerposition',[0 0 1 1])
% % 
% % 
% % 
% % for i=1:N
% % subplot(N,2,2*i)
% % % plot(linspace(-0.2,0.2,length(D1)),D1,'')
% % plot(linspace(-0.2,0.2,length(eval(strcat('D',num2str(i))))),eval(strcat('D',num2str(i))),'LineWidth',2)
% % title(cellnames{i})
% % grid on
% % xlabel('Time(sec)')
% % ylabel('uV')
% % end
% % 
% % [C,L] = wavedec(p4,N,name);
% % 
% % [D1, D2, D3, D4,D5 ] = detcoef(C,L,[1 2 3 4 5 ]);


end