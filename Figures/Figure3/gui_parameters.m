function varargout = gui_parameters(varargin)
% GUI_PARAMETERS MATLAB code for gui_parameters.fig
%      GUI_PARAMETERS, by itself, creates a new GUI_PARAMETERS or raises the existing
%      singleton*.
%
%      H = GUI_PARAMETERS returns the handle to a new GUI_PARAMETERS or the handle to
%      the existing singleton*.
%
%      GUI_PARAMETERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PARAMETERS.M with the given input arguments.
%
%      GUI_PARAMETERS('Property','Value',...) creates a new GUI_PARAMETERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_parameters_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_parameters_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_parameters

% Last Modified by GUIDE v2.5 22-Jul-2019 05:27:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_parameters_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_parameters_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before gui_parameters is made visible.
function gui_parameters_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_parameters (see VARARGIN)

% Choose default command line output for gui_parameters
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%Default parameters
RAT=1;
mergebaseline=0; %Make sure baselines's while loop condition is never equal to 2.
%Maximum number of ripples. 
FiveHun=2; % Options: 0 all, 1 current (500), 2 1000?
%Swaps baseline sessions for testing purposes:
rat26session3=0; %Swaps session 1 for session 3 on Rat 26.
rat27session3=0; %Swaps session 1 for session 3 on Rat 26.
%Controls for Spectrograms: 0:NO, 1:YES. 
rippletable=0; %Generate table with ripple information. 
sanity=0; %Sanity check. 
quinientos=0;
outlie=0; %More aggressive outlier detection. 
acer=1;
win_ten=0;
equal_num=0;

win_stats=0;

rip_hist=0;
%     sanity=1: This control test consists on selecting the same n random number of ripples among conditions. Since Plusmaze generates less ripples, this condition defines the value of n.
% 
%     quinientos=1: Similar to control above but this one makes sure to take the top 500 ripples instead of their random version. Could be more vulnerable to outliers.
% 
%     outlie=1: The use of this control activates a more agressive detection of outliers.


%For testing purposes only.
rat26session3=0; %Swaps session 1 for session 3 on Rat 26.
rat27session3=0; %Swaps session 1 for session 3 on Rat 26.

assignin('base', 'acer', acer)
assignin('base', 'RAT', RAT)
assignin('base', 'mergebaseline', mergebaseline)
assignin('base', 'FiveHun', FiveHun)
assignin('base', 'rat26session3', rat26session3)
assignin('base', 'rat27session3', rat27session3)
assignin('base', 'rippletable', rippletable)
assignin('base', 'sanity', sanity)
assignin('base', 'quinientos', quinientos)
assignin('base', 'outlie', outlie)
assignin('base', 'win_ten', win_ten)
assignin('base', 'equal_num', equal_num)
assignin('base', 'rat26session3', rat26session3)
assignin('base', 'rat27session3', rat27session3)
assignin('base', 'win_stats', win_stats)
assignin('base', 'rip_hist', rip_hist)





% UIWAIT makes gui_parameters wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_parameters_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
% push_but=(handles.pushbutton1.Value)
% while ~push_but
% pause(10)
uiwait
% end
varargout{1} = handles.output;
% pause(8) %Wait for 8 seconds. 
%close all
%varargout{1} = getappdata(hObject,'result');


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Val=get(hObject,'String');
val=get(hObject,'Value');

if strcmp(Val{val},'No')
acer=0;
else
acer=1;    
end
assignin('base', 'acer', acer)



% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Val=get(hObject,'String');
val=get(hObject,'Value');

if strcmp(Val{val},'1000')
FiveHun=2;
end

if strcmp(Val{val},'All')
FiveHun=0;
end

if strcmp(Val{val},'500')
FiveHun=1;
end

assignin('base', 'FiveHun', FiveHun)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
Val=get(hObject,'String');
val=get(hObject,'Value');

if strcmp(Val{val},'No')
mergebaseline=0;
else
mergebaseline=1;    
end
assignin('base', 'mergebaseline', mergebaseline)


% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Val=get(hObject,'String');
val=get(hObject,'Value');

if strcmp(Val{val},'No')
sanity=0;
else
sanity=1;    
end
assignin('base', 'sanity', sanity)



% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Val=get(hObject,'String');
val=get(hObject,'Value');

if strcmp(Val{val},'No')
quinientos=0;
else
quinientos=1;    
end
assignin('base', 'quinientos', quinientos)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Val=get(hObject,'String');
val=get(hObject,'Value');

if strcmp(Val{val},'No')
outlie=0;
else
outlie=1;    
end
assignin('base', 'outlie', outlie)


% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
cl_button=get(hObject,'Value');
if cl_button==1
    close all
end
% close all
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
RAT=get(hObject,'Value');
assignin('base', 'RAT', RAT)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
win_ten=hObject.Value;
win_comp=0;
assignin('base', 'win_ten', win_ten)
assignin('base', 'win_comp', win_comp)

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2


% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
win_ten=hObject.Value;
win_comp=1;
assignin('base', 'win_ten', win_ten)
assignin('base', 'win_comp', win_comp)

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
equal_num=hObject.Value;
assignin('base', 'equal_num', equal_num)



% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rippletable=hObject.Value;
assignin('base', 'rippletable', rippletable)


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
win_stats=hObject.Value;
assignin('base', 'win_stats', win_stats)


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rip_hist=hObject.Value;
assignin('base', 'rip_hist', rip_hist)
% Hint: get(hObject,'Value') returns toggle state of checkbox6
