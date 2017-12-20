function [p,q,timecell,Q,P1,P2]=getwin2(carajo,veamos,sig1,sig2,label1,label2,ro,ripple,thr)

fn=1000;
%if ro==200
i=1;
%allscreen()
[p1, p4, z1, z4]=generate2(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i},ro);
% mtit(strcat('Events:',num2str(ripple)),'fontsize',14,'color',[1 0 0],'position',[.5 0.8 ])
% labelthr=strcat('Thr:',num2str(thr));
% mtit(strcat(' (',labelthr,')'),'fontsize',14,'color',[1 0 0],'position',[.5 0.9 ])
% string=strcat('OPT',num2str(ro),'_WAV_thr_Hipp_bipolar',num2str(thr),label1{i},label2{i},'.png')
% % % % % % % % % % % % % % % % % saveas(gcf,string)
% close all

i=3;
%allscreen()
[p2, p5, z2, z5]=generate2(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i},ro);
% mtit(strcat('Events:',num2str(ripple)),'fontsize',14,'color',[1 0 0],'position',[.5 0.8 ])
% labelthr=strcat('Thr:',num2str(thr));
% mtit(strcat(' (',labelthr,')'),'fontsize',14,'color',[1 0 0],'position',[.5 0.9 ])
% string=strcat('OPT',num2str(ro),'_WAV_thr_Hipp_bipolar',num2str(thr),label1{i},label2{i},'.png');
% close all

%i=7;
i=5;
% allscreen()
[p3, p6, z3, z6]=generate2(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i},ro);
% mtit(strcat('Events:',num2str(ripple)),'fontsize',14,'color',[1 0 0],'position',[.5 0.8 ])
% labelthr=strcat('Thr:',num2str(thr));
% mtit(strcat(' (',labelthr,')'),'fontsize',14,'color',[1 0 0],'position',[.5 0.9 ])
% string=strcat('OPT',num2str(ro),'_WAV_thr_Hipp_bipolar',num2str(thr),label1{i},label2{i},'.png');
% close all

%i=11;
i=7;
% allscreen()
[p7, p8, z7, z8]=generate2(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i},ro);
% mtit(strcat('Events:',num2str(ripple)),'fontsize',14,'color',[1 0 0],'position',[.5 0.8 ])
% labelthr=strcat('Thr:',num2str(thr));
% mtit(strcat(' (',labelthr,')'),'fontsize',14,'color',[1 0 0],'position',[.5 0.9 ])
% string=strcat('OPT',num2str(ro),'_WAV_thr_Hipp_bipolar',num2str(thr),label1{i},label2{i},'.png')
% close all
%end
    
% if ro==500;
% i=1;
% [p1, p4, z1, z4,cfs,f]=generate500(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i},ro);
% 
% 
% i=3;
% [p2, p5, z2, z5]=generate500(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i},ro);
% 
% %i=7;
% i=5;
% [p3, p6, z3, z6]=generate500(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i},ro);
% 
% %i=11;
% i=7;
% [p7, p8, z7, z8]=generate500(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i},ro);
% end
% 
% if ro==1000;
% i=1;
% [p1, p4, z1, z4]=generate1000(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i},ro);
% 
% 
% i=3;
% [p2, p5, z2, z5]=generate1000(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i},ro);
% 
% %i=7;
% i=5;
% [p3, p6, z3, z6]=generate1000(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i},ro);
% 
% %i=11;
% i=7;
% [p7, p8, z7, z8]=generate1000(carajo,veamos, sig1{i},sig2{i},label1{i},label2{i},ro);
% end

p=cell(length(z1),1);
q=cell(length(z1),1);
timecell=cell(length(z1),1);
Q=cell(length(z1),1);


for i=1:length(z1)
%    p{i,1}=[z1{i}.';z2{i}.';z3{i}.'];
%    q{i,1}=[z4{i}.';z5{i}.';z6{i}.'];
   p{i,1}=[z1{i}.';z2{i}.';z3{i}.';z7{i}.']; %Widepass
   q{i,1}=[z4{i}.';z5{i}.';z6{i}.';z8{i}.']; %Bandpassed
   timecell{i,1}=[0:length(p7)-1]*(1/fn)-(ro/1000);
  Q{i,1}=[envelope1(z4{i}.');envelope1(z5{i}.');envelope1(z6{i}.');envelope1(z8{i}.')]; %Bandpassed
end

p=p.';
q=q.';
timecell=timecell.';
Q=Q.';


% GETTING THE ENVELOPE

%P=cell(length(z1),1);
% Q=cell(length(z1),1);


% % % for i=1:length(z1)
% % % %    p{i,1}=[z1{i}.';z2{i}.';z3{i}.'];
% % % %    q{i,1}=[z4{i}.';z5{i}.';z6{i}.'];
% % %  %  P{i,1}=[envelope1(z1{i}.',1000); envelope1(z2{i}.',1000); envelope1(z3{i}.',1000);envelope1(z7{i}.',1000)]; %Widepass
% % %  Q{i,1}=[envelope1(z4{i}.');envelope1(z5{i}.');envelope1(z6{i}.');envelope1(z8{i}.')]; %Bandpassed
% % %    
% % % end

%P=P.';
% Q=Q.';


P1=[p1;p2;p3;p7];
P2=[p4;p5;p6;p8];

end