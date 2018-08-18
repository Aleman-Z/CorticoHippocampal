function [PPP]=lowpassrip(p,w,ro,high)
fn=1000; % New sampling frequency. 
Wn1=[35/(fn/2) ]; % Cutoff=500 Hz
if high==1
[b1,a1] = butter(3,Wn1,'high'); %Filter coefficients   
else
[b1,a1] = butter(3,Wn1); %Filter coefficients    
end

P=cellfun(@(equis) filtfilt(b1,a1,equis(w,:)), p ,'UniformOutput',false);
P=cell2mat(P);
PP=cell2mat(p);

PP(w,:)=P;
AV=reshape(PP,[3 ro*2+1 length(p)]);

PPP=[];
for z=1:length(p)
  PPP= [PPP {AV(:,:,z)} ];
end
end