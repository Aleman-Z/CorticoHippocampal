function [a1,gr]=sleep_criteria(sos)

% Verifying time
t=1:length(sos);%samples
t=t*(1/1000);

[vtr]=findsleep(sos.',median(sos.')/100,t.'); %1 for those above threshold.
vtr=not(vtr); %1 for "nrem times. 

v=vtr.';
v2=ConsecutiveOnes(v);
fivesec=5*1000; %Number of samples equivalent to 5 seconds. 
v3=(v2>fivesec);
v3=v3.*v2;  %Only those above 5 seconds. 
iv3=v3>0; %Logic 
nb=sum(iv3); %Number of clusters
fi=find(iv3==1); %Indexes
for k=1:nb
   gr{k}= fi(1,k):fi(1,k)+v3(fi(1,k))-1;
end

gr=gr.';
[a1] = [cellfun(@min,gr) cellfun(@max,gr)];

end