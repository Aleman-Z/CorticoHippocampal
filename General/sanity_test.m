%function [Base,FolderRip,Method]=sanity_test(Rat,rat26session3,rat27session3)
%Get number of ripples
    FolderRip=[{'all_ripples'} {'500'} {'1000'}];
                Method=[{'Method2' 'Method3' 'Method4'}];
    if Rat==26
    Base=[{'Baseline1'} {'Baseline2'} {'Baseline3'}];
    end
    %             else
    %             Base=[{'Baseline2'} {'Baseline1'} {'Baseline3'}];    
    %             end
    if Rat==26 && rat26session3==1
    Base=[{'Baseline3'} {'Baseline2'}];
    end

    if Rat==27 
    Base=[{'Baseline2'} {'Baseline1'}];% We run Baseline 2 first, cause it is the one we prefer.
    end

    if Rat==27 && rat27session3==1
    Base=[{'Baseline2'} {'Baseline3'}];% We run Baseline 2 first, cause it is the one we prefer.    
    end

                folder=strcat(Base{base},'_',FolderRip{FiveHun+1},'_',Method{meth-1});
    %xo
    cd(folder)
    %look for randrip.
    b=struct2cell(dir)

    if ~any(ismember(b(1,:),'randrip.mat'))

    load('NumberRipples.mat')
    vr=getfield(s,Base{base});
    vr=min(vr(:,1));

    randrip=randi(1000,[1,vr]);
    save('randrip.mat','randrip');

    %xo
    else
     load('randrip.mat')   
    end
    cd('..')
    


