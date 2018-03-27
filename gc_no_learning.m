function [p_nl,q_nl,timecell_nl]=gc_no_learning(level,ro,label1,label2,sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2)
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % cd(strcat('/home/raleman/Documents/internship/',num2str(Rat)))
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % cd(nFF{3})
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %run('newest_load_data_nl.m')
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %[sig1_nl,sig2_nl,ripple2_nl,carajo_nl,veamos_nl,CHTM_nl]=newest_only_ripple_nl;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % [sig1_nl,sig2_nl,ripple_nl,carajo_nl,veamos_nl,CHTM2]=newest_only_ripple_nl;
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % ripple3=ripple_nl;
ripple3=ripple_nl;
%ran=randi(length(p),100,1);

% % % % % % % sig1_nl=cell(7,1);
% % % % % % % 
% % % % % % % sig1_nl{1}=Mono17_nl;
% % % % % % % sig1_nl{2}=Bip17_nl;
% % % % % % % sig1_nl{3}=Mono12_nl;
% % % % % % % sig1_nl{4}=Bip12_nl;
% % % % % % % sig1_nl{5}=Mono9_nl;
% % % % % % % sig1_nl{6}=Bip9_nl;
% % % % % % % sig1_nl{7}=Mono6_nl;
% % % % % % % 
% % % % % % % 
% % % % % % % sig2_nl=cell(7,1);
% % % % % % % 
% % % % % % % sig2_nl{1}=V17_nl;
% % % % % % % sig2_nl{2}=S17_nl;
% % % % % % % sig2_nl{3}=V12_nl;
% % % % % % % % sig2{4}=R12;
% % % % % % % sig2_nl{4}=S12_nl;
% % % % % % % %sig2{6}=SSS12;
% % % % % % % sig2_nl{5}=V9_nl;
% % % % % % % % sig2{7}=R9;
% % % % % % % sig2_nl{6}=S9_nl;
% % % % % % % %sig2{10}=SSS9;
% % % % % % % sig2_nl{7}=V6_nl;
% % % % % % %  
% % % % % % % % ripple=length(M);
% % % % % % % 
% % % % % % % %Number of ripples per threshold.
% % % % % % % ripple_nl=sum(s17_nl);

% [p_nl,q_nl,timecell_nl,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),thr_nl(level+1));
[p_nl,q_nl,timecell_nl,~,~,~]=getwin2(carajo_nl{:,:,level},veamos_nl{level},sig1_nl,sig2_nl,label1,label2,ro,ripple_nl(level),CHTM2(level+1));

% % % % % load(strcat('randnum2_',num2str(level),'.mat'))
% % % % % ran_nl=ran;


av=cat(1,p_nl{1:end});
%av=cat(1,q_nl{1:end});
av=av(1:3:end,:); %Only Hippocampus

%AV=max(av.');
%[B I]= maxk(AV,1000);

%AV=max(av.');
%[B I]= maxk(max(av.'),1000);


[ach]=max(av.');
achinga=sort(ach,'descend');
achinga=achinga(1:1000);
B=achinga;
I=nan(1,length(B));
for hh=1:length(achinga)
   % I(hh)= min(find(ach==achinga(hh)));
I(hh)= find(ach==achinga(hh),1,'first');
end


[ajal ind]=unique(B);
if length(ajal)>500
ajal=ajal(end-499:end);
ind=ind(end-499:end);
end
dex=I(ind);

ran_nl=dex.';

p_nl=p_nl([ran_nl]);
q_nl=q_nl([ran_nl]);
timecell_nl=timecell_nl([ran_nl]);
end