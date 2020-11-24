%MULTIPLETS DETECTION (Consecutive ripples)

function [M_multiplets, Mx_multiplets]=findmultiplets(Mx)
% We take the timestamps of the ripple peaks and compute their difference.
% If the ripples are closer to 300ms we consider the ripples to be multiplets.
% We count how many events are consecutive. 
% Two ripples= doublet
% Three ripples= triplet
% And so on.
multiplets=[{'singlets'} {'doublets'} {'triplets'} {'quatruplets'} {'pentuplets'} {'sextuplets'} {'septuplets'} {'octuplets'} {'nonuplets'}];

% Convert to cell array. Only need this if your input is not a cell array already.
if ~iscell(Mx)
Mx={Mx};
end
    
%% Multiplets detection
%M_multiplets contains the timestamps of the ripple peak for all the detected multiplets.
%Mx_multiplets contains the same timestamps but grouped in groups.
%For example, ripple 1 of a triplet is in Mx_multiplets.triplets.m_1
% ripple 2 of a triplet is in Mx_multiplets.triplets.m_2
% and ripple 3 of a triplet is in Mx_multiplets.triplets.m_3

    for l=1:length(Mx)
         hfo_sequence=ConsecutiveOnes(diff(Mx{l})<=0.300);

         for ll=1:length(multiplets)
             eval([multiplets{ll} '=(hfo_sequence=='  num2str(ll-1) ');'])
             cont=1;
             M_multiplets.(multiplets{ll}){l}=[];
             while cont<=ll
                 %eval(['Sx_' multiplets{ll} '_' num2str(cont) '{l}=Sx{l}(find(' multiplets{ll} ')+(cont-1));'])
                 eval(['Mx_' multiplets{ll} '_' num2str(cont) '{l}=Mx{l}(find(' multiplets{ll} ')+(cont-1));'])
                 %eval(['Ex_' multiplets{ll} '_' num2str(cont) '{l}=Ex{l}(find(' multiplets{ll} ')+(cont-1));'])
                 Mx_multiplets.(multiplets{ll}).(strcat('m_',num2str(cont))){l}=eval(['Mx_' multiplets{ll} '_' num2str(cont) '{l}']);
                 M_multiplets.(multiplets{ll}){l}=eval(['sort([M_multiplets.(multiplets{ll}){l} ' ' Mx_' multiplets{ll} '_' num2str(cont) '{l}])']); % Combined consecutive multiplets    
%                   eval([  'clear' ' ' 'Mx_' multiplets{ll} '_' num2str(cont)])
                 cont=cont+1;
             end
         end
    end

    
end