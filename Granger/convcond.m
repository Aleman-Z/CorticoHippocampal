function [MA]=convcond(grangercon)
    clear MA
     Aver=grangercon.grangerspctrm;
%    Aver=grangercon;

%     Aver=granger22.grangerspctrm;

    for i=1:size(Aver,2)
    aver=Aver(:,i);
    %Matav=[0 aver(2) aver(4); aver(1) 0 aver(6); aver(3) aver(5) 0];
%    Matav=[0 aver(1) aver(2); aver(3) 0 aver(4); aver(5) aver(6) 0];


Matav=[0 aver(2) aver(4);
           aver(1) 0 aver(6);
          aver(3) aver(5) 0];

%     Matav=[0 aver(4) aver(2);
%            aver(3) 0 aver(5);
%           aver(1) aver(6) 0];

      
      
    MA(:,:,i)=Matav;
    end
end

% %%
% plot_spw2(gran.grangerspctrm)
% %%
% figure()
% plot_spw2(MA)
