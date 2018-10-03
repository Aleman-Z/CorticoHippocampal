%Monopolar 
 Ro=[200 500 1000];
for i=1:3
  ro=Ro(i);  
  [p,q,timecell]=getwin(carajo,veamos,sig1,sig2,label1,label2,ro);
  close all
   q=cut(q);
   p=cut(p);
   [ww]=getenvel(q);
  timecell=cut(timecell);
gcc(ww,timecell,'Bandpass',ro)   
   %error('Stop')
 string=strcat(num2str(ro),'_GC_envel','Monopolar','Bandpassed','.png');
cd Envel
fig=gcf;
fig.InvertHardcopy='off';
saveas(gcf,string)
cd ..  
 close all
 
end
%%
%Bipolar
 Ro=[200 500 1000];
for i=1:3
  ro=Ro(i);  
  [p,q,timecell]=getwinbip(carajo,veamos,sig1,sig2,label1,label2,ro);
  close all
  q=cut(q);
  p=cut(p);
  timecell=cut(timecell);
  [ww]=getenvelbipolar(q);
 gcbipc(ww,timecell,'Bandpassed',ro)
  
  string=strcat(num2str(ro),'_GC_','Bipolar','Bandpassed','.png');
cd Envel
fig=gcf;
fig.InvertHardcopy='off';

saveas(gcf,string)
cd ..  
 close all
 
 
end
