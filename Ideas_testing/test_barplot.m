%%
p=p(1,1:100);
p_nl=p_nl(1,1:100);

q=q(1,1:100);
q_nl=q_nl(1,1:100);

%%
freq1=justtesting(p_nl,create_timecell(ro,length(p_nl)),[1:0.5:30],w,10,toy);
freq2=justtesting(p,create_timecell(ro,length(p)),[1:0.5:30],w,0.5,toy);
%%
freq3=barplot2_ft(q_nl,create_timecell(ro,length(q_nl)),[100:1:300],w,toy);
freq4=barplot2_ft(q,create_timecell(ro,length(q)),[100:1:300],w,toy);
%%
av1=squeeze(mean(squeeze(freq3.powspctrm(:,w,:,:)),1));
av2=squeeze(mean(squeeze(freq4.powspctrm(:,w,:,:)),1));

subplot(1,2,1)
im(av1)
set(gca,'YDir','normal')
subplot(1,2,2)
im(av2)
h=gca;
set(gca,'YDir','normal')
%%
[Freq3]=barr(q_nl,create_timecell(ro,length(q_nl)),[100:1:300],w,toy);
[Freq4]=barr(q,create_timecell(ro,length(q)),[100:1:300],w,toy);

%%
figure()
av1=squeeze(mean(squeeze(Freq3.powspctrm(:,w,:,:)),1));
av2=squeeze(mean(squeeze(Freq4.powspctrm(:,w,:,:)),1));

subplot(1,2,1)
im(av1)
set(gca,'YDir','normal')
subplot(1,2,2)
im(av2)
h=gca;
set(gca,'YDir','normal')

