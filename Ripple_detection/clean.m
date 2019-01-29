
function [ncellx,ncellr]=clean(cellx,cellr)
clear ncellx

notnan=cellfun('length',cellx);
estos=(notnan~=1);
ncellx=cellx(estos,1);
ncellr=cellr(estos,1);

ncellx=ncellx.';
ncellr=ncellr.';
end