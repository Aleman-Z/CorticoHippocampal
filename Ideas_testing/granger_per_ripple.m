for cont=1:length(p)
[gran_s,gran1_s]=gc_paper_single(p,create_timecell(ro,1),'Widepass',ro,10,[0:2:300],cont);
V{cont}=gran_s.grangerspctrm;
(cont/length(p))*100
end
%%
for cont2=1:length(V)
VE(cont2,:)=squeeze(V{cont2}(1,2,:));
end
%%
plot(gran.freq,mean(VE))
hold on
plot(gran.freq,squeeze(gran.grangerspctrm(1,2,:)))

%%
plot(squeeze(gran_s.grangerspctrm(1,2,:)))
hold on
plot(squeeze(gran.grangerspctrm(1,2,:)))

%%
