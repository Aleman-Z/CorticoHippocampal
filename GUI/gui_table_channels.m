function [channels]=gui_table_channels(z,rats,label1)
f = figure(1);
% f=uifigure;
dat = z;
% cnames = {'X-Data','Y-Data','Z-Data'};  % These are your column names
% rnames = {'First','Second','Third'};    % These are your row names
cnames=num2str(rats.');
cnames=strcat('Rat',cnames);
rnames=label1;

c = uicontrol('Style','text','Position',[1 380 300 20]);
c.String = {'Fill the table with the correct channels'};
c.FontSize=10;
c.FontAngle='italic';
%%
% label = uilabel(f,...
%     'Position',[100 164 100 15],...
%     'Text','Enter Comments:');

t = uitable('Parent',f,'Data',dat,'ColumnName',cnames,... 
            'RowName',rnames,'Position',[20 280 450 100]);
set(t,'ColumnEditable',true(1,length(rats)))        


% pb = uicontrol(f,'Style','pushbutton','String','Button 1',...
%                 'Position',[50 20 60 40]);

% tb = uicontrol(f,'Style','togglebutton',...
%                 'String','Confirm',...
%                 'Value',0,'Position',[30 20 100 30]);
%             if tb.Value == 1
%                 close (f)
%             end
h = uicontrol('Position',[220 20 100 40],'String','Confirm',...
              'Callback','uiresume(gcbf)');
h.FontSize=10;
uiwait(gcf); 
aver= get(t,'Data');
aver(aver==0) = NaN;
close(f);


for i=1:size(cnames,1)
    cenames=cnames(i,:);
    cenames(isspace(cenames)) = [];
    Cnames{i,:}=cenames;
    
    channels(1).(Cnames{i})= aver(:,i).';
end
clear cenames

% channels = struct(Cnames{1},aver(:,1).');
% 
% for i=1:length(cnames)
%     
% %  eval([strcat('channels(:).',Cnames{i,:})]) = aver(:,i).';
% %  eval(strcat('channels(1).(',Cnames(i),')')) = aver(:,i).';
%  channels(1).(Cnames{i})= aver(:,i).';
% 
% end
%  channels = struct(Cnames{i},aver(:,i).');
%     [channels(:).data] = deal(randn(3,1));
end