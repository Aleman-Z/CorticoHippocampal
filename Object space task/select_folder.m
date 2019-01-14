function [BB]=select_folder(Rat,iii,labelconditions)

    cd(strcat('F:/ephys/rat',num2str(Rat)));
%     A = dir(cd);
%     A={A.name};
A=getfolder;

    no=0;
    for j=1:length(A)
    B=A{j}
    k = strfind(B,labelconditions{iii})
    if k>=1
        no=no+1;
        BB{no}=B;
    end
    end

    if no==2 %Save BB with the plain OR. 

    %     for j=1:length(BB)
           v1=strfind(BB{1},labelconditions{4});
%            v2=strfind(BB{2},labelconditions{4});

           if v1>0
               BB=BB{2};
           else
               BB=BB{1};
           end
    %         
    end 

if iscell(BB)==1
    BB=BB{1};
end
end