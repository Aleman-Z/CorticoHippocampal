%freq3
function [mdam, sdam]=smaller_window(freq3,w)

dam=((squeeze(mean(squeeze(freq3.powspctrm(:,w,:,1+50:end-50)),1)))); %Average all ripples.
mdam=mean(dam(:)); %Mean value 
sdam=std(dam(:));

%     FG3=freq3;
%     FG3.time=[-.05:.001:.05];
%     FG3.powspctrm=freq3.powspctrm(:,:,:,1+50:end-50);
% 
%     [ zmin100, zmax100] = ft_getminmax(cfg, FG3);
end

