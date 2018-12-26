function p=filter4ripples(p,w,str)


    fn=1000; % New sampling frequency. 
%    Wn1=[290/(fn/2)]; % Cutoff=500 Hz
%     Wn1=[100/(fn/2) 250/(fn/2)]; % Cutoff=500 Hz
    Wn1=[200/(fn/2)];
    [b2,a2] = butter(10,Wn1,str); %Filter coefficients
    
    
for j=1:length(p)
p{j}(w,:)=(filtfilt(b2,a2,p{j}(w,:)));
end

%     for j=1:length(p)
%           R(j,:)= filtfilt(b2,a2,R(j,:));
%     end

end