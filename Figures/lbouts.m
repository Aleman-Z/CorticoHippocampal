function [L]=lbouts(s5)

i = find(diff(s5)) ;
  n = [i numel(s5)] - [0 i];
  c = arrayfun(@(X) X-1:-1:0, n , 'un',0);
  y = cat(2,c{:});

fd=(diff(y)); %Number of bouts in total. 
fd(fd~=-1)=1;
fd(fd==-1)=0;
G=find(fd);

ng=nan(length(G)+1,1);

for o=1:length(G)
   D= diff([s5(G(o)) s5(G(o)+1)]);
   if D== 1
      ng(o+1)=1;
   else
      ng(o+1)=0;
   end 
   if o==1
       ng(o)=not(ng(o+1));
   end
end

nu=[1:length(ng)].*ng.';
nu=nu(nu~=0);

L=n(nu); %Seconds
end