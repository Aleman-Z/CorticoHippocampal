% Filtering
w=2;
butterfly_plot(p,w)
%xlim([1150 1250])
%%
qq=filter4ripples(p,w,'high')%Filter

butterfly_plot(qq,w)

%[0 250]
%% Select max (or min) Amp and discard. 

[H]=min_outlier(p,w);
pp=p(H);

butterfly_plot(pp,w)
%%
 for j=1:length(p)
      em(j)=max(abs(p{j}(2,:))); % Best result works when detection is done on Parietal. 
      %hold on
 end
  [em,nu]=unique(em);
 %1150:1250
%% Sorting attempt: Best result,
[c1,c2]=sort(em,'descend');
c2=nu(c2); 
pp=p(:,c2(240:end));
butterfly_plot(pp,2)


%%
% H=outlier_index(em,0.00001); %Not an outlier>1. Else 0. 
H=em<45;
ha=1:length(p);
ha=ha(H);

pp=p(:,ha);
butterfly_plot(pp,w)

%%
P=cell2mat(p);
P=P(w,:);
P=P.';
R=reshape(P,[length(p) size(p{1},2)]);
%%
%R=R(:,1150:1250);
%R=max(abs(diff(R.')));
R=min((R.'));

hist(R)
%%
for j=1:size(R,1)
plot(R(j,:))
hold on
end
%% Random method
rv=randi(length(p),[1,400]);
qq=p(rv);
butterfly_plot(qq,1)
%%
qq=p(RV);
butterfly_plot(qq,1)

%%
%%
PP1=avg_samples(qq,create_timecell(1200,length(p)));

frequencylog(PP1(w,:))
%%

fn=1000; % New sampling frequency. 
Wn1=[300/(fn/2)]; % Cutoff=500 Hz
[b2,a2] = butter(3,Wn1); %Filter coefficients
%%
R=filter4ripples(q,1);
plot(mean(R.'))
%% Min
   for j=1:length(p)
      plot(p{j}(w,:))
      W(j)=min(p{j}(w,:));
      hold on
%       pause(0.01)
      title(j)
   end
%%
figure()
ww=artifacts(W,0.0000000000000000000000000000000000001);
for j=1:length(p)
    if ww(j)==0
    plot(p{j}(w,:))
    hold on
    end
%     W(j)=median(p{j}(w,:));
end
%%
ppp=p(not(ww));
butterfly_plot(ppp,2)
%%
%% Max
clear W
   for j=1:length(ppp)
      plot(ppp{j}(w,:))
      W(j)=max(ppp{j}(w,:));
      hold on
%       pause(0.01)
      title(j)
   end
%%
figure()
ww2=artifacts(W,0.0000000000000000000000000000000000001);
for j=1:length(ppp)
    if ww2(j)==0
    plot(ppp{j}(w,:))
    hold on
    end
%     W(j)=median(p{j}(w,:));
end
%%
ppp=ppp(not(ww2));
%%
butterfly_plot(ppp,2)
%% Difference
clear W
   for j=1:length(p)
      plot(p{j}(w,:))
      W(j)=max(diff(p{j}(w,:)));
      hold on
%       pause(0.01)
      title(j)
   end
%%
figure()
ww=artifacts(W,0.0000000000000000000000000000000000001);
for j=1:length(p)
    if ww(j)==0
    plot(p{j}(w,:))
    hold on
    end
%     W(j)=median(p{j}(w,:));
end


P=p(not(ww));
butterfly_plot(P,2)
%%
plot(p{1}(1,:))
hold on
plot(p{1}(2,:))
plot(p{1}(3,:))
%%
butterfly_plot(p,1)
figure()
butterfly_plot(p,2)
figure()
butterfly_plot(p,3)
%%
w=2
butterfly_plot(p,w)
%%
PP1=avg_samples(p,create_timecell(1200,length(p)));
frequencylog(PP1(w,:))
%%
frequencylog(p{1}(w,:));

[f,Y] = frequency(p{1}(w,:));
%%
plot(p{1}(w,:))

%%
qq=filter4ripples(p,w)

butterfly_plot(qq,w)
%%
PP1=avg_samples(qq,create_timecell(1200,length(qq)));
frequencylog(PP1(w,:))

%%
rv=randi(length(q),[1,10]);
qq=q(rv);
butterfly_plot(qq,1)
