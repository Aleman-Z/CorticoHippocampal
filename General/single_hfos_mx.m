
function [achis,achis2]=single_hfos_mx(cohfos1,achis,achis2)

    for k=1:length(cohfos1)
        
        achis2(find(achis==cohfos1(k)))=[];
        achis(find(achis==cohfos1(k)))=[];
    %     [vv]=find(Mx_hpc{1}==cohfos1{1}(k));
    %     v=[v vv];

    end

end