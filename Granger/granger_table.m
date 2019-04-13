function [HPC_PAR,PAR_HPC,HPC_PFC,PFC_HPC,PAR_PFC,PFC_PAR]=granger_table(FB,num)
%%HPC->PAR
for j=1:num%13
 HPC_PAR(j,:)=[FB{1}(1,1,j) FB{2}(1,1,j) FB{3}(1,1,j) FB{4}(1,1,j)];   
end

%%PAR->HPC
for j=1:num
 PAR_HPC(j,:)=[FB{1}(1,2,j) FB{2}(1,2,j) FB{3}(1,2,j) FB{4}(1,2,j)];   
end

%%HPC->PFC
for j=1:num
 HPC_PFC(j,:)=[FB{1}(2,1,j) FB{2}(2,1,j) FB{3}(2,1,j) FB{4}(2,1,j)];   
end


%%PFC->HPC
for j=1:num
 PFC_HPC(j,:)=[FB{1}(2,2,j) FB{2}(2,2,j) FB{3}(2,2,j) FB{4}(2,2,j)];   
end

%%PAR->PFC
for j=1:num
 PAR_PFC(j,:)=[FB{1}(3,1,j) FB{2}(3,1,j) FB{3}(3,1,j) FB{4}(3,1,j)];   
end

%%PFC->PAR
for j=1:num
 PFC_PAR(j,:)=[FB{1}(3,2,j) FB{2}(3,2,j) FB{3}(3,2,j) FB{4}(3,2,j)];   
end
end
% [FB{1}(1,1,1) FB{2}(1,1,1) FB{3}(1,1,1) FB{4}(1,1,1);...
%   FB{1}(1,1,2) FB{2}(1,1,2) FB{3}(1,1,2) FB{4}(1,1,2)...  
%   FB{1}(1,1,3) FB{2}(1,1,3) FB{3}(1,1,2) FB{4}(1,1,2)...
%   FB{1}(1,1,4) FB{2}(1,1,4) FB{3}(1,1,2) FB{4}(1,1,2)...
%   FB{1}(1,1,5) FB{2}(1,1,5) FB{3}(1,1,2) FB{4}(1,1,2)...
%   FB{1}(1,1,6) FB{2}(1,1,6) FB{3}(1,1,2) FB{4}(1,1,2)...
%   FB{1}(1,1,7) FB{2}(1,1,7) FB{3}(1,1,2) FB{4}(1,1,2)...
%   FB{1}(1,1,8) FB{2}(1,1,8) FB{3}(1,1,2) FB{4}(1,1,2)...
%   FB{1}(1,1,9) FB{2}(1,1,9) FB{3}(1,1,2) FB{4}(1,1,2)...
%   FB{1}(1,1,10) FB{2}(1,1,10) FB{3}(1,1,2) FB{4}(1,1,2)...
%   ]
