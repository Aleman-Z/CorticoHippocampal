function [cara,veamos]=equal_time2(sig1,sig2,cara,veamos,tdura,tdura2) 
fn=1000;
signal2=cellfun(@(equis) times((1/0.195), equis)  ,sig1{1},'UniformOutput',false);
ti=cellfun(@(equis) linspace(0, length(equis)-1,length(equis))*(1/fn) ,signal2,'UniformOutput',false);

consig=cara{1};

c1=consig(:,1);
c2=consig(:,2);
for r=1:length(c1)
c3{r}=abs(c1{r}-c2{r});  
C3(r,1)=sum(c3{r});
end
C3=sum(C3); %Total time of ripples in NREM. 

% timeasleep2=timeasleep*60; %seconds
n_ti=ti(veamos{1});

am_sleep=(cellfun(@max,n_ti)); %Amount of sleep per epoch. 
B_sleep = cumsum(am_sleep);

% tdura=60; %Condition duration (Minutes)
tdura=tdura*60; %Seconds
t_pre=interp1(B_sleep,[1:length(B_sleep)],tdura);
t_index=ceil(t_pre);



%sig1 sig2  cara veamos
%Redefine variables:
cara={cara{1}(1:t_index,:)};


% veamos={veamos{1}(veamos{1}<=t_index)};
veamos={veamos{1}(1:t_index,:)}; %THIS MIGHT BE WRONG, nah mate.



%Modify cara

B_sleep(t_index-1); %Lower bound
B_sleep(t_index); %Upper bound

t_dif=tdura-B_sleep(t_index-1); %seconds
aja=cara{1}(end,:);

aja{1}=aja{1}((aja{1}<=t_dif));
aja{2}=aja{2}((aja{1}<=t_dif));
aja{3}=aja{3}((aja{1}<=t_dif));

cara{1}(end,:)=aja;


%
if tdura2~=0
tdura2=tdura2*60;
t_pre2=interp1(B_sleep,[1:length(B_sleep)],tdura2);
t_index2=floor(t_pre2);
cara={cara{1}(t_index2:end,:)};
veamos={veamos{1}(t_index2:end,:)};

B_sleep(t_index2); %Lower bound
B_sleep(t_index2+1); %Upper bound

t_dif2=abs(tdura2-B_sleep(t_index2+1)); %seconds

% t_dif=t_dif*(1000); %samples


%Lower bound
aja=cara{1}(1,:);

aja{1}=aja{1}((aja{1}>=t_dif2));
aja{2}=aja{2}((aja{1}>=t_dif2));
aja{3}=aja{3}((aja{1}>=t_dif2));

cara{1}(1,:)=aja;
end

end