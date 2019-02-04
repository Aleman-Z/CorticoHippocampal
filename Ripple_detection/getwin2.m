%function [p,q,timecell,Q,P1,P2]=getwin2(cara,veamos,sig1,sig2,ro)
function [p,q,Q,sos]=getwin2(cara,veamos,sig1,sig2,ro)


%,ripple,thr
% fn=1000;
% isempty(sig2{2})

i=1;
%allscreen()
%[p1, p4, z1, z4]=generate2(cara,veamos, sig1{i},sig2{i},ro);
[z1, z4]=generate2(cara,veamos, sig1{i},sig2{i},ro);

i=3;
%allscreen()
%[p2, p5, z2, z5]=generate2(cara,veamos, sig1{i},sig2{i},ro);
[z2, z5]=generate2(cara,veamos, sig1{i},sig2{i},ro);

%i=7;
i=5;
% allscreen()
%[p3, p6, z3, z6]=generate2(cara,veamos, sig1{i},sig2{i},ro);
[z3, z6]=generate2(cara,veamos, sig1{i},sig2{i},ro);

%Look for accelerometer windows. 
if ~isempty(sig2{2})
i=2;
[sos]=generate2(cara,veamos, sig1{i},sig2{i},ro); 
sos=cellfun(@transpose,sos,'UniformOutput',0);
% sos=sos.';
else
sos=[];    
end

% %i=11;
% i=7;
% % allscreen()
% [p7, p8, z7, z8]=generate2(cara,veamos, sig1{i},sig2{i},ro);
%     

p=cell(length(z1),1);
q=cell(length(z1),1);
% timecell=cell(length(z1),1);

%UNCOMMENT IF YOU WANT THE ENVELOPE:
% Q=cell(length(z1),1);


for i=1:length(z1)
 
%    p{i,1}=[z1{i}.';z2{i}.';z3{i}.';z7{i}.']; %Widepass
%    q{i,1}=[z4{i}.';z5{i}.';z6{i}.';z8{i}.']; %Bandpassed
   p{i,1}=[z1{i}.';z2{i}.';z3{i}.']; %Widepass
   q{i,1}=[z4{i}.';z5{i}.';z6{i}.']; %Bandpassed
   
%    timecell{i,1}=[0:length(p7)-1]*(1/fn)-(ro/1000);

   %Q{i,1}=[envelope1(z4{i}.');envelope1(z5{i}.');envelope1(z6{i}.');envelope1(z8{i}.')]; %Bandpassed
  
  %Uncomment the following if you need the envelope
%   Q{i,1}=[envelope1(z4{i}.');envelope1(z5{i}.');envelope1(z6{i}.')]; %Bandpassed 
end

p=p.';
q=q.';
%timecell=timecell.';

%UNCOMMENT IF YOU WANT THE ENVELOPE:
%Q=Q.';


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


% P1=[p1;p2;p3;p7];
% P2=[p4;p5;p6;p8];

% P1=[p1;p2;p3];
% P2=[p4;p5;p6];

%Comment this if you need Q:
Q=[];
end