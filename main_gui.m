function varargout = main_gui(varargin)
% MAIN_GUI MATLAB code for main_gui.fig
%      MAIN_GUI, by itself, creates a new MAIN_GUI or raises the existing
%      singleton*.
%
%      H = MAIN_GUI returns the handle to a new MAIN_GUI or the handle to
%      the existing singleton*.
%
%      MAIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUI.M with the given input arguments.
%
%      MAIN_GUI('Property','Value',...) creates a new MAIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_gui

% Last Modified by GUIDE v2.5 05-May-2015 09:53:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @main_gui_OutputFcn, ...
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


% --- Executes just before main_gui is made visible.
function main_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_gui (see VARARGIN)

% Choose default command line output for main_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_gui_OutputFcn(hObject, eventdata, handles) 
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

global I
[fn fp] = uigetfile('*.bmp;*.jpg;*.png;*.tif;*.jpeg','Please select input image');

% Concatinate to create whole image path
impath = [fp fn];

% Read image
I = imread(impath);

% Make image to standard resolution
I = imresize(I,[30 40]);


% Show image
axes(handles.axes1)
imshow(I);

set(handles.uitable1,'Data',I(:,:,1))

str = [num2str(size(I,1)) ' x ' num2str(size(I,2)) ' x ' num2str(size(I,3))];  
set(handles.text2,'String',str);
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global I R G B

% Separate R G and B
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

% Concatinate to see as a single image
Irgb = [R G B];


% Merge all the values
I1 = Irgb;

I1(:,1:3:end) = R;
I1(:,2:3:end) = G;
I1(:,3:3:end) = B;


axes(handles.axes1)
imshow(Irgb);

set(handles.uitable1,'Data',I1)
str = [num2str(size(I1,1)) ' x ' num2str(size(I1,2))];  
set(handles.text2,'String',str);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global I R G B pattern


% Get the size
[nr nc k] = size(I);

%% Take one by one matrix and covert to binary
% REd matrix
% Intiliase empty matrix
Rbin = zeros(nr,nc*8);

for ii = 1:nc
    
    % Get iith column
    c = R(:,ii);
    
    % Convert to binary
    bin1 = de2bi(c,8,'left-msb');
    
    % Save it
    Rbin(:,(ii-1)*8+1:ii*8) = bin1;
end

% Green matrix
% Intiliase empty matrix
Gbin = zeros(nr,nc*8);

for ii = 1:nc
    
    % Get iith column
    c = G(:,ii);
    
    % Convert to binary
    bin1 = de2bi(c,8,'left-msb');
    
    % Save it
    Gbin(:,(ii-1)*8+1:ii*8) = bin1;
end

% Blue matrix
% Intiliase empty matrix
Bbin = zeros(nr,nc*8);

for ii = 1:nc
    
    % Get iith column
    c = B(:,ii);
    
    % Convert to binary
    bin1 = de2bi(c,8,'left-msb');
    
    % Save it
    Bbin(:,(ii-1)*8+1:ii*8) = bin1;
end

% Concatinate all the matrix
pattern = [Rbin Gbin Bbin];

set(handles.uitable1,'Data',pattern)

str = [num2str(size(pattern,1)) ' x ' num2str(size(pattern,2))];  
set(handles.text2,'String',str);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pattern
%% Convert to bipolar
% Get the size of the pattern
[nrp ncp] =size(pattern);

% For all rows and column check the value and replace it
for ii= 1:nrp
    for jj = 1:ncp
        
        % Get the bit
        bit1 = pattern(ii,jj);
        
        % Check the bit.
        if bit1==0
            %Make it bipolar
            bit1 = -1;
        end
        
        % Store the value back
        pattern(ii,jj) = bit1;
    end
end

set(handles.uitable1,'Data',pattern)

str = [num2str(size(pattern,1)) ' x ' num2str(size(pattern,2))];  
set(handles.text2,'String',str);


% Convert full image into single column vector
pattern = pattern(:);
%% Check image
% Call recognition function
op = authorise_user(pattern);

if ~isempty(op)

    errordlg('Image is already used .. please use other image');
    
    return;
end

% Load database
load DB

% Append current pattern with all the database
A = [A pattern];

tic
% Train hpnn with a new matrix
W = train_hpnn(A);
t2 = toc;

fprintf('Training time = %f sec\n',t2);


save DBtemp A  W



% save DB A PW UI W idx

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get userID and password
load DB
load DBtemp

uitemp = get(handles.edit1,'String');

% password
pwtemp = get(handles.edit2,'String');

if isempty(uitemp);
    warndlg('Please mention user Id');
    return;
end

flag1 = 0;
for ii = 1:idx
    if strcmpi(uitemp,UI{1,ii})
        flag1 = 1;
        break;
    end
end

if flag1 ==1
    warndlg('The USERID is not available');
    return
end

if isempty(pwtemp)
    warndlg('Please mention password')
    return;
end
idx= idx+1;
PW{1,idx} = pwtemp;
UI{1,idx} = uitemp;


save DB A PW UI W idx


msgbox('The database is updated');

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
