function p=filter4ripples(p,w)


    fn=1000; % New sampling frequency. 
    Wn1=[200/(fn/2)]; % Cutoff=500 Hz
    [b2,a2] = butter(3,Wn1,'high'); %Filter coefficients

    
for j=1:length(p)
p{j}(w,:)=filtfilt(b2,a2,p{j}(w,:));
end

%     for j=1:length(p)
%           R(j,:)= filtfilt(b2,a2,R(j,:));
%     end

end