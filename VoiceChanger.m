function varargout = VoiceChanger(varargin)
% VOICECHANGER MATLAB code for VoiceChanger.fig
%      VOICECHANGER, by itself, creates a new VOICECHANGER or raises the existing
%      singleton*.
%
%      H = VOICECHANGER returns the handle to a new VOICECHANGER or the handle to
%      the existing singleton*.
%
%      VOICECHANGER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VOICECHANGER.M with the given input arguments.
%
%      VOICECHANGER('Property','Value',...) creates a new VOICECHANGER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VoiceChanger_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VoiceChanger_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VoiceChanger

% Last Modified by GUIDE v2.5 15-Jan-2023 01:11:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VoiceChanger_OpeningFcn, ...
                   'gui_OutputFcn',  @VoiceChanger_OutputFcn, ...
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


% --- Executes just before VoiceChanger is made visible.
function VoiceChanger_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VoiceChanger (see VARARGIN)

% Choose default command line output for VoiceChanger
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VoiceChanger wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VoiceChanger_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
recorder=audiorecorder(8000,16,1); %Had to change Fs to 8000 
% because it didn't work otherwise
filename='OriginalVoice.wav';
pause(2);
set(handles.prompt,'String','Started recording...');
recordblocking(recorder,5);
set(handles.prompt,'String','Stopped recording...');
myrec=getaudiodata(recorder);
audiowrite(filename, myrec,8000); %Writes our audio data in .wav file
clear y Fs;
[y,Fs] = audioread(filename);
f0=pitch(y,Fs); %Get the frequency array of the sound signal.
fa=mean(f0,'all'); %Take mean of all values in the frequency array
set(handles.edit1,'String',num2str(fa)); %Displaying original frequency values in a text box
if fa>165
   set(handles.text9,'String','This is a female voice');
else
   set(handles.text9,'String','This is a male voice');
end
sound(y,Fs); %Play the data
info=audioinfo(filename); %Provides us info about the .wav file

%Creates a vector of the same length
%as y, this represents the time elapsed
t = 0:seconds(1/Fs):seconds(info.Duration); 
t = t(1:end-1);

%Plot the signal
plot(t,y);
legend('Original Voice Graph');

handles.info=info; %Information necessary to plot a graph of our original sound signal
handles.y=y; %Audio data saved into GUI handles
handles.Fs=Fs; %Sample frequency saved into GUI handles.
handles.myrec=myrec; %Storing the audiorecorder object in GUI handles
handles.filename=filename; %Storing filename in GUI handles.
handles.fa=fa; %Storing mean frequency in GUI handles
handles.t=t; %Storing time in handles GUI
guidata(hObject,handles); %Changing the state of our GUI handles.

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename=uigetfile('*.wav'); %Filtering by .wav files
if isequal(filename,0)
  set(handles.prompt,'String','No file selected...');
else
    set(handles.prompt,'String','File selected.');
    [y,Fs] = audioread(filename); %Reading data from our selected .wav file
f0=pitch(y,Fs); %Get the frequency array of the sound signal.
fa=mean(f0,'all'); %Take mean of all values in the frequency array
set(handles.edit1,'String',num2str(fa)); %Displaying original frequency values in a text box
if fa>165
   set(handles.text9,'String','This is a female voice'); %Display if mean is greater than 165
else
   set(handles.text9,'String','This is a male voice');
end
sound(y,Fs); %Play the data
info=audioinfo(filename); %Provides us info about the .wav file

%Creates a vector of the same length
%as y, this represents the time elapsed
t = 0:seconds(1/Fs):seconds(info.Duration); 
t = t(1:end-1);

%Plot the signal
plot(t,y)
legend('Original Voice Graph');


handles.info=info; %Information necessary to plot a graph of our original sound signal
handles.y=y; %Audio data saved into GUI handles
handles.Fs=Fs; %Sample frequency saved into GUI handles.
handles.filename=filename;
handles.fa=fa; %Storing frequency in GUI handles.
guidata(hObject,handles); %Changing the state of our GUI handles.
end




function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
y=handles.y;
Fs=handles.Fs;
fa=handles.fa;
win = kbdwin(512); %Current window
overlapLength = 0.75*numel(win);
lockPhase=false;
S = stft(y, ...
    "Window",win, ...
    "OverlapLength",overlapLength, ...
    "Centered",false); %Short Time Fourier Transform is applied to Frequency Domain
%For male ranges
if (fa(1)>=85 && fa(1)<=100)
    semitones=10;
else if (fa>=100 && fa<=120)
    semitones=8;
else if (fa>=120 && fa<=140)
    semitones=7;
else if (fa>=140 && fa<=165)
     semitones=6;
%For female ranges     
else if (fa>=165 && fa<=200)
     semitones=-6;
else if (fa>=200 && fa<=220)
     semitones=-12;
else if (fa>=220 && fa<=255)
     semitones=-12;
end
end
end
end    
end
end
end
audioOut = shiftPitch(S,semitones, ...
                     "Window",win, ...
                     "OverlapLength",overlapLength, ...
                     "LockPhase",lockPhase);
f0_shifted=pitch(audioOut,Fs);
f0_shifted=mean(f0_shifted);
set(handles.edit2,'String',f0_shifted(1));
audiowrite("ShiftedVoice.wav",audioOut,Fs);

info2=audioinfo("ShiftedVoice.wav");
t = 0:seconds(1/Fs):seconds(info2.Duration); 
t = t(1:end-1);
plot(t,audioOut);
legend('Shifted Voice Graph');

%pause(5);
soundsc(audioOut,Fs)
handles.audioOut=audioOut;
guidata(hObject,handles);

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
audioOut=handles.audioOut;
y=handles.y;
val = get(hObject,'Value');
string_list = get(hObject,'String');
selected_string = string_list{val}; % convert from cell array to string
if (strcmp(selected_string,"Original Plot")==1)
    plot(y,t);
else if (strcmp(selected_string,"Shifted Plot")==1)
    plot(audioOut,t);
end
end

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
