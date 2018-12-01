function varargout = sri_game(varargin)
% SRI_GAME MATLAB code for sri_game.fig
%      SRI_GAME by itself, creates a new SRI_GAME or raises the
%      existing singleton*.
%
%      H = SRI_GAME returns the handle to a new SRI_GAME or the handle to
%      the existing singleton*.
%
%      SRI_GAME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SRI_GAME.M with the given input arguments.
%
%      SRI_GAME('Property','Value',...) creates a new SRI_GAME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sri_game_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sri_game_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sri_game


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sri_game_OpeningFcn, ...
                   'gui_OutputFcn',  @sri_game_OutputFcn, ...
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

% --- Executes just before sri_game is made visible.
function sri_game_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sri_game (see VARARGIN)

% Choose default command line output for sri_game
handles.output = 'Yes';
handles.qcounter = 1;
handles.score=0
handles.results= cell(4,1);
handles.results{1,1}=['Chris']
handles.results{2,1}= ['Stefanatos']
handles.results{3,1}= ['c.stefanatos@parityplatform.com']
handles.results{4,1}= [0];

handles.qnum = 3
handles.UANSWER = cell(1,3);
handles.ANSWER = cell(1,3)
handles.atext= cell(3,3)
handles.ANSWER{1,1} = char('option2')
handles.ANSWER{1,2} = char('option2')
handles.ANSWER{1,3} = char('option1')
handles.qtext= cell(1,3)
handles.qtext{1,1}= ['Socially responsible investing (SRI) is becoming more and more popular for both institutional and retail investors.  It involves :'];
handles.qtext{1,2}= ['When comparing returns of two European Stock indices : MSCI Europe(general stock index) and MSCI Europe SRI ( exposure to companies with outstanding Environmental, Social and Governance (ESG) ratings and excludes companies whose products have negative social or environmental impacts) whice of the following statements is correct ?'];   
handles.qtext{1,3}= ['will find out']
handles.atext{1,1}=['Donation based allocatios to non-profit organizations solving society,s issues.']
handles.atext{1,2}=['Profit seeking allocations in companies that excel in corporate governance and responsibility standards or to companies whose operations positively impact social or environmental issues.']
handles.atext{1,3}=['Allocations in companies that have donated amounts of their profits to charitable organizations.']
handles.atext{2,1}=['SRI index returns were lower than the general index. (Socially Responsible investing led to lower performance)']
handles.atext{2,2}=['SRI index returns were higher than the general index. (Socially Responsible investing led to higher performance)']
handles.atext{2,3}= [' SRI index returns were negative, since sri allocations are not profit seeking']
handles.gameover = 0;
% Update handles structure
guidata(hObject, handles);

% Insert custom Title and Text if specified by the user
% Hint: when choosing keywords, be sure they are not easily confused 
% with existing figure properties.  See the output of set(figure) for
% a list of figure properties.
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        switch lower(varargin{index})
         case 'title'
          set(hObject, 'Name', varargin{index+1});
         case 'string'
          set(handles.question, 'String', varargin{index+1});
        end
    end
end

% Determine the position of the dialog - centered on the callback figure
% if available, else, centered on the screen
FigPos=get(0,'DefaultFigurePosition');
OldUnits = get(hObject, 'Units');
set(hObject, 'Units', 'pixels');
OldPos = get(hObject,'Position');
FigWidth = OldPos(3);
FigHeight = OldPos(4);
if isempty(gcbf)
    ScreenUnits=get(0,'Units');
    set(0,'Units','pixels');
    ScreenSize=get(0,'ScreenSize');
    set(0,'Units',ScreenUnits);

    FigPos(1)=1/2*(ScreenSize(3)-FigWidth);
    FigPos(2)=2/3*(ScreenSize(4)-FigHeight);
else
    GCBFOldUnits = get(gcbf,'Units');
    set(gcbf,'Units','pixels');
    GCBFPos = get(gcbf,'Position');
    set(gcbf,'Units',GCBFOldUnits);
    FigPos(1:2) = [(GCBFPos(1) + GCBFPos(3) / 2) - FigWidth / 2, ...
                   (GCBFPos(2) + GCBFPos(4) / 2) - FigHeight / 2];
end
FigPos(3:4)=[FigWidth FigHeight];
set(hObject, 'Position', FigPos);
set(hObject, 'Units', OldUnits);

% Show a question icon from dialogicons.mat - variables questIconData
% and questIconMap
load dialogicons.mat

IconData=questIconData;
questIconMap(256,:) = get(handles.figure1, 'Color');
IconCMap=questIconMap;

Img=image(IconData, 'Parent', handles.axes1);
set(handles.figure1, 'Colormap', IconCMap);

set(handles.axes1, ...
    'Visible', 'off', ...
    'YDir'   , 'reverse'       , ...
    'XLim'   , get(Img,'XData'), ...
    'YLim'   , get(Img,'YData')  ...
    );

% Make the GUI modal
set(handles.figure1,'WindowStyle','modal')

% UIWAIT makes sri_game wait for user response (see UIRESUME)
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = sri_game_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The figure can be deleted now
delete(handles.figure1);

% --- Executes on button press in option1.
function option1_Callback(hObject, eventdata, handles)
% hObject    handle to option1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.output = get(hObject,'String');
temp = get(hObject,'Tag');
handles.UANSWER{1,handles.qcounter} = temp;
if temp == handles.ANSWER{1, handles.qcounter}
    %correct answer
    handles.score= handles.score + 1
end
  
handles.qcounter = handles.qcounter + 1
if handles.qcounter < handles.qnum
    % move to next question
set(handles.question,'String',[(handles.qtext{1,handles.qcounter})]);
 set(handles.option1, 'String',[(handles.atext{handles.qcounter,1})]);
 set(handles.option2, 'String',[(handles.atext{handles.qcounter,2})]);
 set(handles.option3, 'String',[(handles.atext{handles.qcounter,3})]);
else
    %gameover
    set(handles.question,'String',[(handles.qtext{1,handles.qnum})]);
    fileID = fopen('Parity.txt','w');
    for i=1:4
    fprintf(fileID,'%s %12s\n',[handles.results{i,1}]);
    end
    fclose(fileID)
    handles.gameover=1
end

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);

% --- Executes on button press in option2.
function option2_Callback(hObject, eventdata, handles)
% hObject    handle to option2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = get(hObject,'Tag');
handles.UANSWER{1,handles.qcounter} = temp;
if temp == handles.ANSWER{1, handles.qcounter}
    %correct answer
    handles.score= handles.score + 1
end
handles.results{:,1}  
handles.qcounter = handles.qcounter + 1
if handles.qcounter < handles.qnum
    % move to next question
set(handles.question,'String',[(handles.qtext{1,handles.qcounter})])
 set(handles.option1, 'String',[(handles.atext{handles.qcounter,1})])
 set(handles.option2, 'String',[(handles.atext{handles.qcounter,2})])
 set(handles.option3, 'String',[(handles.atext{handles.qcounter,3})])
else
    %gameover
    set(handles.question,'String',[(handles.qtext{1,handles.qnum})])
    fileID = fopen('Parity.txt','w');
    for i=1:4
    fprintf(fileID,'%s %12s\n',[handles.results{i,1}]);
    end
    fclose(fileID)
    handles.gameover=1
end

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in option3.
function option3_Callback(hObject, eventdata, handles)
% hObject    handle to option3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

temp = get(hObject,'Tag');
handles.UANSWER{1,handles.qcounter} = temp;
if temp == handles.ANSWER{1, handles.qcounter}
    %correct answer
    handles.score = handles.score + 1
end
  
handles.qcounter = handles.qcounter + 1
if handles.qcounter < handles.qnum
    % move to next question
set(handles.question,'String',[(handles.qtext{1,handles.qcounter})])
 set(handles.option1, 'String',[(handles.atext{handles.qcounter,1})])
 set(handles.option2, 'String',[(handles.atext{handles.qcounter,2})])
 set(handles.option3, 'String',[(handles.atext{handles.qcounter,3})])
else
    %gameover
 set(handles.question,'String',[(handles.qtext{1,handles.qnum})]);
 set(handles.option1, 'String',[(handles.atext{handles.qnum,1})]);
 set(handles.option2, 'String',[(handles.atext{handles.qnum,2})]);
 set(handles.option3, 'String',[(handles.atext{handles.qnum,3})]);
    fileID = fopen('Parity.txt','w');
    for i=1:4
    fprintf(fileID,'%s %12s\n',[handles.results{i,1}]);
    end
    fclose(fileID);
    handles.gameover=1;
end

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
%uiresume(handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end


% --- Executes on key press over figure1 with no controls selected.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check for "enter" or "escape"
if isequal(get(hObject,'CurrentKey'),'escape')
    % User said no by hitting escape
    handles.output = 'No';
    
    % Update handles structure
    guidata(hObject, handles);
    
    uiresume(handles.figure1);
end    
    
if isequal(get(hObject,'CurrentKey'),'return')
    uiresume(handles.figure1);
end    
