%% Envelope of q.

function [ww]=getenvel(q)
ww=cell(1,length(q));

for i=1:length(q)
   w=q{i}; 
   for j=1:4
   envel=w(j,:);
   ev(j,:)=envelope1(envel);
   end
   ww{i}=ev;
end
end
% % 
% % %%
% % t=linspace(-2,2,length(checa));
% % plot(t,envelope1(checa,1000)); hold on;
% % plot(t,checa)
% % title('Envelope of ripple')
% % grid minor
% % xlabel('time')
% % %%
% % wacha=envelope2(linspace(-2,2,length(checa)),checa,1000);
% % %%
% % plot(); hold on;
% % plot(checa)
% % %%
% % aver=envelope1(w);
% % %%
% % veam=ww{1};
% % vea=q{1};
% % %%
% % plot(veam(4,:))
% % hold on
%% plot(vea(4,:))
