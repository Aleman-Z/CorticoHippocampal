
achis=q{1};
s=10; %step
d=length(achis)/s;

%%
for st=1:s
 ach{st,1}=achis(:,(st-1)*d+1:((st-1)*d+1)+d-1)   
FFF{st,1}=mvgc_adapted(ach{st,1},fn);

end
%%

gg=[];
for ol=1:s
 vii=FFF{ol,1}   
vhvh2=(squeeze(vii(2,3,:)));
gg=[gg vhvh2];
end
%%
imagesc(linspace(-450,450,5),0:500,gg)
xlabel('Time (ms)')
ylabel('Frequency')
colorbar()
colormap(jet(256))
set(gca,'YDir','normal')

title('Time-Frequency Granger Causality')
%%
ach1=achis(:,1:10);
[FF1]=mvgc_adapted(ach1,1000);
%%
ach2=achis(:,11:20);
[FF2]=mvgc_adapted(ach2,1000);
%%

k = 0;
for i = 1:4
    for j = 1:4
        k = k+1;
        if i ~= j
%             error('stop')
            vhvh1=(squeeze(FFF(i,j,:)));
            vhvh2=(squeeze(FF2(i,j,:)));
            aha=[vhvh1 vhvh2]
        end
    end
end
  