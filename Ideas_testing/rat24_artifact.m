butterfly_plot(q,1)

qq=filter4ripples(q,w)

butterfly_plot(qq,1)
%%
rv=randi(length(q),[1,10]);
qq=q(rv);
butterfly_plot(qq,1)

%%
[H]=min_outlier(p);
pp=p(H);

butterfly_plot(pp(1,:),1)
%%
PP1=avg_samples(q,create_timecell(1200,length(q)));


frequencylog(PP1(1,:))
%%

fn=1000; % New sampling frequency. 
Wn1=[300/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn1); %Filter coefficients
%%
R=filter4ripples(q,1);
plot(mean(R.'))

