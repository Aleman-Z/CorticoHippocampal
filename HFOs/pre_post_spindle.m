function [Sx_pre,Mx_pre,Ex_pre,Sx_post,Mx_post,Ex_post]=pre_post_spindle(Sx,Mx,Ex)
% 
%     Sx_hpc{1}
%     Mx_hpc{1}
%     Ex_hpc{1}
%     dura=Ex_hpc{1}-Sx_hpc{1};
 dura=Ex-Sx;
Sx_pre=Sx-dura;
Mx_pre=Mx-dura;
Ex_pre=Ex-dura;

Sx_post=Sx+dura;
Mx_post=Mx+dura;
Ex_post=Ex+dura;
% 
%     Sx_hpc{1}+dura
%     Mx_hpc{1}+dura
%     Ex_hpc{1}+dura

end