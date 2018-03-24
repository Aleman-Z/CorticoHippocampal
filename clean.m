
function [ncellx,ncellr]=clean(cellx,cellr)
clear ncellx

notnan=cellfun('length',cellx);
estos=(notnan~=1);
ncellx=cellx(estos,1);
ncellr=cellr(estos,1);


% conta=1;
% for i=1:length(cellx)
%     ele=length(cellx{i});
%     if ele==401 || ele==1001 || ele==2001  || ele== 480001 || ele== 288001 || ele== 4001 || ele== 8001 || ele== 2401|| ele== 3401
%       ncellx{conta}=cellx{i};
%       ncellr{conta}=cellr{i};
%       conta=conta+1;
%     end
% end
ncellx=ncellx.';

ncellr=ncellr.';
end