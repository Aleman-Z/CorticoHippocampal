function varargout = gui_spectral(varargin)
% GUI_SPECTRAL MATLAB code for gui_spectral.fig
%      GUI_SPECTRAL, by itself, creates a new GUI_SPECTRAL or raises the existing
%      singleton*.
%
%      H = GUI_SPECTRAL returns the handle to a new GUI_SPECTRAL or the handle to
%      the existing singleton*.
%
%      GUI_SPECTRAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SPECTRAL.M with the given input arguments.
%
%      GUI_SPECTRAL('Property','Value',...) creates a new GUI_SPECTRAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_spectral_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_spectral_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui_spectral

% Last Modified by GUIDE v2.5 18-Jun-2019 03:27:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_spectral_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_spectral_OutputFcn, ...
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


% --- Executes just before gui_spectral is made visible.
function gui_spectral_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_spectral (see VARARGIN)

% Choose default command line output for gui_spectral
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui_spectral wait for user response (see UIRESUME)
% uiwait(handles.figure1);
axes(handles.axes2)
imshow('memdyn.png')

axes(handles.axes1)
imshow('trace.png')


% --- Outputs from this function are returned to the command line.
function varargout = gui_spectral_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% FILE

% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Load_data_Callback(hObject, eventdata, handles)
% hObject    handle to Load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Export_data_Callback(hObject, eventdata, handles)
% hObject    handle to Export_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function save_figure_Callback(hObject, eventdata, handles)
% hObject    handle to save_figure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function exit_gui_Callback(hObject, eventdata, handles)
% hObject    handle to exit_gui (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all


%PREPROCESSING

% --------------------------------------------------------------------
function Preprocessing_Callback(hObject, eventdata, handles)
% hObject    handle to Preprocessing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Downsample_data_Callback(hObject, eventdata, handles)
% hObject    handle to Downsample_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Extract_stages_Callback(hObject, eventdata, handles)
% hObject    handle to Extract_stages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Filter_data_Callback(hObject, eventdata, handles)
% hObject    handle to Filter_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function SWR_detection_Callback(hObject, eventdata, handles)
% hObject    handle to SWR_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function Run_SWR_Callback(hObject, eventdata, handles)
% hObject    handle to Run_SWR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Data_description_Callback(hObject, eventdata, handles)
% hObject    handle to Data_description (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function Spectral_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to Spectral_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Periodogram_Callback(hObject, eventdata, handles)
% hObject    handle to Periodogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Spectrogram_Callback(hObject, eventdata, handles)
% hObject    handle to Spectrogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Granger_causality_Callback(hObject, eventdata, handles)
% hObject    handle to Granger_causality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Sleep_amount_Callback(hObject, eventdata, handles)
% hObject    handle to Sleep_amount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Threshold_plots_Callback(hObject, eventdata, handles)
% hObject    handle to Threshold_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function New_experiment_Callback(hObject, eventdata, handles)
% hObject    handle to New_experiment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Ripples_amount_Callback(hObject, eventdata, handles)
% hObject    handle to Ripples_amount (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Ripple_Selection_Callback(hObject, eventdata, handles)
% hObject    handle to Ripple_Selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Load_experiment_Callback(hObject, eventdata, handles)
% hObject    handle to Load_experiment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Help_Callback(hObject, eventdata, handles)
% hObject    handle to Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Github_Callback(hObject, eventdata, handles)
% hObject    handle to Github (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
