fs=256;
T=10;
t=(1/256):(1/256):T;
f1=5;
f2=10;
f3=15;
f4=30;
f5=50;
f6=100;
S1=sin(5*pi*t);
S2=sawtooth(1*pi*t);
S3=sinc(11*t);
S4=exp(.8*t)-.3;
%S4=;
S5=5*square(-2*t);
% S6=sawtooth(5*t);
% S7=sin(8*t);
t1=(1/256):(1/256):T/2;
t2=T/2+(1/256):(1/256):T;
S6=5*sin(-.3*t1);
S7=-2*sin(9*t2)+2;

 S8=[S6 S7];
figure(1)
%whitebg;
subplot(3,2,1);
plot(t,S1,'-m');
subplot(3,2,2);
plot(t,S2,'-b');
%r=[ecg(fs(T/n) n];


subplot(3,2,3);
plot(t,S3,'-r');
subplot(3,2,4);
plot(t,S4,'--y');
subplot(3,2,5);
plot(t,S5,'--c');
subplot(3,2,6);
plot(t,S8,'--g');
S=[S1;S2;S3;S4;S5;S8];%6 Se�ales de entrada 
B=2*rand(6)-1;%Matriz de mezclas que tenga valores entre -1 y 1.
X=B*S;% Observaciones
% x1=X(1,:);
% x2=X(2,:);
% x3=X(3,:);
% x4=X(4,:);
% x5=X(5,:);
% x8=X(6,:);
%%
for i=1:6
    subplot(6,1,i)
plot(S(i,:))
end
%%
tic
[A B]=fastica(X);
toc
y=B*X;

y1=y(1,:);
y2=y(2,:);
y3=y(3,:);
y4=y(4,:);
y5=y(5,:);
y6=y(6,:);

%%
 figure(2)
% 
%%whitebg;
subplot(3,2,1);
plot(t,y1,'-m');
subplot(3,2,2);
plot(t,y2,'-b');
%r=[ecg(fs(T/n) n];

subplot(3,2,3);
plot(t,y3,'-r');
subplot(3,2,4);
plot(t,y4,'--y');
subplot(3,2,5);
plot(t,y5,'--c');
subplot(3,2,6);
plot(t,y6,'--g');
%%


for i=1:6
  subplot(6,2,2*i)
  plot(y(i,:))
  subplot(6,2,(2*i)-1)
  plot(S(i,:))
  
end
%%
[ese]=orderICA(S,y);
%%

for i=1:6
    subplot(6,2,2*i-1)
plot(S(i,:))

    subplot(6,2,2*i)
    plot(ese(i,:)) 
end

%%
figure()
for i=1:6
    subplot(6,1,i)
    plot(ese(i,:)) 
end

% % %% Adding Matcorr
% % 
% % [corr,indx,indy,corrs] = matcorr(S,y,0,2);
% % % 
% % nuS=S(indx,:);
% % nuy=y(indy,:);
% % 
% % corrsign=(corr<0);
% % 
% % for i=1:6
% %   if corrsign(i,1)==1
% %       nuy(i,:)=nuy(i,:)*(-1);
% %   end    
% % end
% % 
% % for i=1:6
% %   subplot(6,2,2*i)
% %   plot(nuy(i,:))
% %   subplot(6,2,(2*i)-1)
% %   plot(nuS(i,:))
% %   
% % end
% % %%
% % [nS,ny]=orderICA(S,y);
% % 
