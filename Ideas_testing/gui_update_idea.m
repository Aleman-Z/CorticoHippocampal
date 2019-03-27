%function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% contents = cellstr(get(hObject,'String')) % returns listbox3 contents as cell array
% contents{get(hObject,'Value')} %returns selected item from listbox3
win_ten=1;
contents=get(hObject,'Value')
if contents==2
    win_comp=1; %Prefer using strings.
else
    win_comp=0;
end
assignin('base', 'win_comp', win_comp)
assignin('base', 'win_ten', win_ten)
