clear R
for h=1:length(p)
    x=(p{h}(1,:));
    ix=(p{h}(3,:));
    y = resample(x,1,2) ;
    % plot(x)
    r = xcorr(x,500,'biased');
    r2=xcorr(y);
    r3=xcorr(ix);
    
    
    R(h,:)=r3;
    plot(r3)
    hold on
end
%%
% stem(-(N-1):(N-1),mean(R))
stem(mean(R))
%xlim([400 600])
%
%xlim([-400 400])
%%

N=length(p{1}(1,:));
stem(-(N-1):(N-1),r,'.')
xlim([-50 50])
%%
N=length(y);
stem(-(N-1):(N-1),r2,'.')
xlim([-50 50])