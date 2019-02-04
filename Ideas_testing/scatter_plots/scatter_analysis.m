function [SS,D]=scatter_analysis(S1,S2,n1,n2);    
figure(1)
scatter(S1{n1},S2{n2})
for j=1:length(S1{n1})
   g= text(S1{n1}(j),S2{n2}(j),num2str(S1{1}(j)));
   g.FontSize=11;
   g.FontWeight='bold';
end
grid minor
xlabel('Sorted Samples (Power Signal 1)')
ylabel('Sorted Samples (Power Signal 2)')
hl = lsline;
B = [ones(size(hl.XData(:))), hl.XData(:)]\hl.YData(:);
m= B(2);
b = B(1);
%%

for j=1:length(S1{n1})
    X=S1{n1}(j);
    Y=S2{n2}(j);
   [d,ix] = max(abs(Y-m*X-b));
   D(:,j) = d/sqrt(1+m^2);
   SS(:,j)=S1{1}(j);

end
%%
% % val=mean(abs(S1{3}-S1{6}));
% semilogy(SS,(D))
% hold on
% % semilogy(SS,(D)*0+val)
% grid minor
% xlim([0 250])

end
