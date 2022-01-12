function varargout = ParkingLot(varargin)
% PARKINGLOT MATLAB code for ParkingLot.fig
%      PARKINGLOT, by itself, creates a new PARKINGLOT or raises the existing
%      singleton*.
%
%      H = PARKINGLOT returns the handle to a new PARKINGLOT or the handle to
%      the existing singleton*.
%
%      PARKINGLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARKINGLOT.M with the given input arguments.
%
%      PARKINGLOT('Property','Value',...) creates a new PARKINGLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ParkingLot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ParkingLot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ParkingLot

% Last Modified by GUIDE v2.5 11-Jan-2022 21:04:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ParkingLot_OpeningFcn, ...
                   'gui_OutputFcn',  @ParkingLot_OutputFcn, ...
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


% --- Executes just before ParkingLot is made visible.
function ParkingLot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ParkingLot (see VARARGIN)

% Choose default command line output for ParkingLot
handles.output = hObject;

global N; % 停车位数量
global pArg; % 柏松分布参数
global eArg; % 指数分布参数
global Tmax; % 仿真时间(h)
global speed; % 仿真倍速
N = 8;
pArg = 1;
eArg = 20;
Tmax = 24;
speed = 1;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ParkingLot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ParkingLot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function PoissArg_Callback(hObject, eventdata, handles)
% hObject    handle to PoissArg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PoissArg as text
%        str2double(get(hObject,'String')) returns contents of PoissArg as a double
global pArg
pArg = str2double(get(handles.PoissArg, 'String'));


% --- Executes during object creation, after setting all properties.
function PoissArg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PoissArg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ExpArg_Callback(hObject, eventdata, handles)
% hObject    handle to ExpArg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ExpArg as text
%        str2double(get(hObject,'String')) returns contents of ExpArg as a double
global eArg;
eArg = str2double(get(handles.ExpArg,'String'));


% --- Executes during object creation, after setting all properties.
function ExpArg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ExpArg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function OccupRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OccupRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in ParkLotNum.
function ParkLotNum_Callback(hObject, eventdata, handles)
% hObject    handle to ParkLotNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ParkLotNum contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ParkLotNum
global N;
list = get(handles.ParkLotNum,'String');
val = get(handles.ParkLotNum,'Value');
N = str2num(list{val});
set(handles.Park2,'Visible','off');
set(handles.Park3,'Visible','off');
set(handles.Park4,'Visible','off');
set(handles.Park5,'Visible','off');
set(handles.Park6,'Visible','off');
set(handles.Park7,'Visible','off');
set(handles.Park8,'Visible','off');

if N>7
    set(handles.Park8,'Visible','on');
end
if N>6
    set(handles.Park7,'Visible','on');
end
if N>5
    set(handles.Park6,'Visible','on');
end
if N>4
    set(handles.Park5,'Visible','on');
end
if N>3
    set(handles.Park4,'Visible','on');
end
if N>2
    set(handles.Park3,'Visible','on');
end
if N>1
    set(handles.Park2,'Visible','on');
end


% --- Executes during object creation, after setting all properties.
function ParkLotNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ParkLotNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in speed.
function speed_Callback(hObject, eventdata, handles)
% hObject    handle to speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns speed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from speed
global speed;
speed=get(handles.speed,'Value');


% --- Executes during object creation, after setting all properties.
function speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
    % hObject    handle to Start (see GCBO)
    % eventdata  reserved - to be defined in a future version of MATLAB
    % handles    structure with handles and user data (see GUIDATA)
    % N          车位数
    % pArg       车辆到达时间服从的泊松分布的参数
    % eArg       车辆停车时间服从的负指数分布的参数
    % Tmax       仿真时长
    % speed      仿真速度
    global N;
    global Tmax;
if get(handles.Start,'String') == '退出'
    close;
else
    set(handles.Start,'String','退出');

    %{
        车辆信息     struct[]
        arrTime   - 车辆到达时间
        parkTime  - 停车时长
        queTime   - 排队时长
        parkNum   - 停车位号
        leaTime   - 离开时间
        startTime - 开始停车时间(=车辆到达时间+排队时长)
    %}
    Cars = [struct('arrTime', 0, 'parkTime', 0, 'queTime', 0, 'parkNum', 0, 'leaTime', 0, 'startTime', 0)];

    % 第1行: 状态改变的时刻
    % 第2行: 车辆号
    % 第3行: 改变后的状态(0离开, 1到达, 2开始停车)
    %{
        状态改变信息    3*状态改变次数
        第1行        - 状态改变的时刻
        第2行        - 车辆号
        第3行        - 改变后的状态(0离开, 1到达, 2开始停车)
    %}
    changes = [struct('changeTime', 0, 'carNum', 0, 'state', 0)];

    % [] 根据离开时间先后排序
    leave = 0;

    % 1*N 每个停车位的状态改变次数
    parkChangeTimes = zeros(1,N);

    %{
        停车位信息    N*(1+parkChangeTimes)
        行         - 停车位号
        第1列      - 状态(0为空闲，1为占用) 
        第2列及以后 - 每次状态改变发生的时间
    %}
    S = zeros(N,1);

    % OcpRate 总的车位占有率
    OcpRate = 0;

    %{
        队伍信息    2*队伍改变次数
        第1行      - 状态改变时间
        第2行      - 相应的队伍长度
    %}
    L = [0;0];
    

    % 初始化, 获得
    [Cars, K] = initialization(Cars);

    % 补全完整的车辆信息
    Cars = carInfo(Cars, K);

    % 离开排序
    leave = sortLeave(Cars, K, leave);

    % 仿真时刻排序
    [changes, m] = sortSimu(changes, Cars, K, leave);

    % 开始仿真
    k = 1; % 第k次状态改变
    km = 0; % 演示的状态改变次数
    OccupTime = 0; % 停车位占用总时长
    car = 0; % 车辆图片(1*K)

    % 动画演示到最后一个离开就结束
    while k<=m && changes(k).changeTime<=Tmax
        km = km + 1;
        k = k + 1;
    end

    % 从第1个状态改变开始仿真
    k = 1;
    while k <= km
        i = 0;
        set(handles.timeout,'String',num2str(changes(k).changeTime)); % 更新时间显示
        while k <= km-i-1 && changes(k).changeTime == changes(k+i+1).changeTime && changes(k).state == changes(k+i+1).state
            i = i+1; % 同时改变状态车辆数
        end

        if changes(k).state == 0 % 离开 % elseif到达(line 373) else开始停车(line 450)
            y=1;
            while y <= N               
                OccupTime = OccupTime + ...
                            (changes(k).changeTime - changes(k-1).changeTime) * S(y,1); % 只有被占的停车位才会被计进去，占有时间 = 离开时间 - 开始停车时间
                y=y+1;
            end
            OcpRate = OccupTime / (N*changes(k).changeTime) * 100;
            % 更新停车位占有率显示
            set(handles.OccupRate,'String',num2str(OcpRate));

            % 输出离开车辆信息
            y = 0;
            while y < i+1
                disp(['      ',num2str(changes(k+y).changeTime),'h: ',num2str(changes(k+y).carNum),'号车辆从',num2str(Cars(changes(k+y).carNum).parkNum),'号停车位离开']);
                y = y+1;
            end

            % 离开的停车位状态改变信息更新、队伍信息更新
            y=0;
            while y<i+1
                x = Cars(changes(k).carNum).parkNum;
                S(x,1) = 0; % 0空闲
                parkChangeTimes(1,x) = parkChangeTimes(1,x) + 1; % 次数
                S(x, parkChangeTimes(1,x)+1) = changes(k).changeTime; % 时间
                L(1,k) = changes(k).changeTime; % 第1行：状态改变时间
                L(2,k) = L(2,k-1); % 第2行：队伍长度
                y = y+1;
                k = k+1;
            end
            k = k-i-1;

            % 离开动画
            j = 0;
            % 先往上走到出口那行
            while j < i+1
                toY(car(1,changes(k+j).carNum), 0.788);
                j = j+1;
            end
            % 再往左走出画面
            j = 0;
            while j < i+1
                toX(car(changes(k+j).carNum), 0.003);
                set(car(changes(k+j).carNum),'Visible','off');
                j = j+1;
            end
            
        elseif  changes(k).state == 1  % 到达
            y = 1;
            while y <= N
                if k > 1                
                    OccupTime = OccupTime + (changes(k).changeTime - changes(k-1).changeTime) * S(y,1);
                else
                    OccupTime = OccupTime + changes(k).changeTime * S(y,1); % 防止k-1出现负数
                end
                y = y+1;
            end
            if changes(k).changeTime == 0
                OcpRate = 0;
            else
                OcpRate = OccupTime / (N * changes(k).changeTime) * 100;
            end
            % 更新停车位占有率显示
            set(handles.OccupRate,'String',num2str(OcpRate));
            % 更新队伍信息
            L(1,k) = changes(k).changeTime;  
            if k>1
                L(2,k) = L(2,k-1) + i + 1;
            else
                L(2,k) = i + 1;
            end

            y = 0;
            while y < i
                L(1,k+1) = changes(k+1).changeTime;
                L(2,k+1) = L(2,k);
                y = y+1;
                k = k+1;
            end
            k = k-i;

            % x=1;
            % while x<K&&Cars(x).arrTime<changes(k).changeTime
            %     x=x+1;
            % end

            % 输出到达信息显示
            y = 0;
            while y < i+1
                disp([num2str(changes(k+y).changeTime),'h: ',num2str(changes(k+y).carNum),'号车辆到达停车场']);
                y = y+1;
            end


            % 到达动画
            queNum = 0; % 在现在的队伍中的第几个
            j = 0;
            while j < i+1
                pic = imread('car.PNG');
                car(1,changes(k+j).carNum) = ...
                    uicontrol('Style','push','Units','normalized','String','','FontUnits','normalized','ForegroundColor','blue','FontSize',0.2,'CData',pic,'Position',[0.147+0.184*j 0.086 0.076 0.072]);
                set(car(changes(k+j).carNum),'String',num2str(changes(k+j).carNum)); % 在图上显示车辆号
                j = j+1;
                if k == 1
                    queNum(1, j) = j;
                else
                    queNum(1, j) = L(2, k-1) + j; 
                end
            end

            j = 0;
            while j < i+1
                if mod(queNum(1, j+1),4) == 0
                    tx = 0.147 + 0.184 * 3;
                else
                    tx = 0.147 + 0.184 * (mod(queNum(1, j+1),4) - 1);
                end
                carCurrent = car(changes(1, k+j).carNum);
                toX(carCurrent, tx);
                ty = 0.349 - 0.085 * floor((queNum(1, j+1) - 1) / 4);
                toY(carCurrent, ty);
                j = j + 1;
            end
            
        else % 开始停车
            y = 1;
            while y <= N               
                OccupTime = OccupTime + (changes(k).changeTime - changes(k-1).changeTime) * S(y,1);
                y = y + 1;
            end
            if changes(k).changeTime==0
                OcpRate = 0;
            else
                OcpRate = OccupTime / (N*changes(k).changeTime) * 100;
            end
            % 更新停车位占有率显示
            set(handles.OccupRate,'String',num2str(OcpRate));
            L(1,k) = changes(k).changeTime;  
            L(2,k) = L(2,k-1) - i - 1;
            
            y = 0;
            while y<i
                L(1,k+1) = changes(k+1).changeTime;
                L(2,k+1) = L(2,k);
                y = y + 1;
                k = k + 1;
            end
            k = k-i;

            y=0;
            while y<i+1
                disp(['   ',num2str(changes(k+y).changeTime),'h: ',num2str(changes(k+y).carNum),'号车辆到',num2str(Cars(changes(k+y).carNum).parkNum),'号停车位开始停车']);
                y =y + 1;
            end

            y = 0;
            while y < i+1
                x = Cars(changes(k+y).carNum).parkNum; % 停车位号
                S(x,1) = 1; % 停车位状态变成1:工作
                parkChangeTimes(1,x) = parkChangeTimes(1,x) + 1; % 停车位状态改变次数+1
                S(x, parkChangeTimes(1,x) + 1) = changes(k+y).changeTime; % 改变状态的时间
                y = y + 1;
            end

            % 开始停车动画
            j = 0;
            while j < i+1
                carCurrent = car(1, changes(k+j).carNum);
                parkNum = Cars(changes(k+j).carNum).parkNum;
                if mod(parkNum, 4) == 0
                    tx = 0.147 + 0.184 * 3;
                else
                    tx = 0.147 + 0.184 * (mod(parkNum, 4) - 1);
                end
                toX(carCurrent, tx);
                ty = 0.631 - 0.158 * floor(parkNum/5);
                toY(carCurrent, ty);
                j=j+1;
            end

            j=0;
            rows = floor((L(2,k-1)-i-1-1) / 4);
            for row = 0:rows
                if row < rows
                    n = 4;
                else
                    n = L(2,k-1) - i -1 - rows*4;
                end
                for index = 1:n
                    tx = 0.147 + 0.184 * (index -1);
                    ty = 0.349 - 0.085 * row;
                    carCurrent = car(changes(k+i).carNum + row*4 + index);
                    toX(carCurrent, tx);
                    toY(carCurrent, ty);
                end
            end
        end
        k = k + i + 1;
    end
    set(handles.timeout,'String',Tmax); % 仿真结束
end


function Tmax_Callback(hObject, eventdata, handles)
% hObject    handle to Tmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tmax as text
%        str2double(get(hObject,'String')) returns contents of Tmax as a double
global Tmax;
Tmax = str2num(get(handles.Tmax,'String'));

% --- Executes during object creation, after setting all properties.
function Tmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function timeout_Callback(hObject, eventdata, handles)
% hObject    handle to timeout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of timeout as text
%        str2double(get(hObject,'String')) returns contents of timeout as a double


% --- Executes during object creation, after setting all properties.
function timeout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to timeout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function [Cars, K] = initialization(Cars)
%Finitialization - Description
%
% Syntax: Cars = initialization(input)
%
% Long description
    global pArg;
    global eArg;
    global Tmax;
    k=1;
    while Cars(k).arrTime <= Tmax
        deltaT = poissrnd(pArg);
        Cars(k+1).arrTime = Cars(k).arrTime + deltaT; % 到达时间
        k = k + 1;
    end

    K = k - 1;
    
    parkTimes = exprnd(eArg,1,K);
    while k>1
        k = k - 1;
        Cars(k).parkTime = parkTimes(k); % 停车时间
    end


function Cars = carInfo(Cars, K)
%carInfo - Description
%
% Syntax: Cars = carInfo(Cars)
%
% Long description
    global N;
    i = 0;
    k = 1;
    n = 1;
    p = 1;
    sk = linspace(0,0,N); % N个0
    while k <= K
        if Cars(k).arrTime >= sk(1,p) % 到达时间 晚于 第n个停车的结束时间
            sk(1,1) = Cars(k).arrTime + Cars(k).parkTime;
            Cars(k).queTime = 0;
            Cars(k).parkNum = 1; % 停车位号 = 1
            Cars(k).leaTime = sk(1,1);
        elseif Cars(k).arrTime < sk(1,n) % 早于
            Cars(k).queTime = sk(1,n)-Cars(k).arrTime; % 排队时间 = 停车的结束时间 - 到达时间
            sk(1,n) = sk(1,n) + Cars(k).parkTime; % 更新停车结束时间(加上k的服务时长)
            Cars(k).parkNum = n; % 停车位号 = n
            Cars(k).leaTime = sk(1,n);
        else 
            i = 1;
            while sk(1,i) > Cars(k).arrTime
                i = i+1; % 从第1个开始找，直到停车位的结束时间比到达时间早
            end
            sk(1,i) = Cars(k).arrTime + Cars(k).parkTime; % 更新离开时间：到达+停车
            Cars(k).queTime = 0; % 不用排队
            Cars(k).parkNum = i;
            Cars(k).leaTime = sk(1,i);
        end
        i = 2;
        n = 1;
        p = 1;
        while i <= N
            if sk(1,i) > sk(1,p)
                p = i;
            end
            if sk(1,i) < sk(1,n)
                n = i;
            end
            i = i + 1;
        end
        Cars(k).startTime = Cars(k).arrTime + Cars(k).queTime; % 开始停车时间 = 到达时间 + 排队时长
        k=k+1;
    end
    
function leave = sortLeave(Cars, K, leave)
%myFun - Description
%
% Syntax: output = myFun(input)
%
% Long description
    x=1;
    i=1;
    leave=linspace(1,K,K); % 从1到K
    while i<K
        j=i+1;
        while j<=K
            if Cars(leave(1,j)).leaTime<Cars(leave(1,i)).leaTime
                x=leave(1,i); % 交换第i个和第j个（值是车号）
                leave(1,i)=leave(1,j);
                leave(1,j)=x;
            end
            j=j+1;
        end
        i=i+1;
    end

function [changes, m] = sortSimu(changes, Cars, K, leave)
%sortSimu - Description
%
% Syntax: changes = sortSimu(changes, Cars, K, leave)
%
% Long description
    m = 0;
    k = 1; % k表示车辆到达号
    n = 1; % n表示车辆离开号
    i = 1; % i表示车辆开始停车号
    car = 0;
    % 3*K-1: 每个车辆有3次状态的改变
    while m<=3*K-1 && n<=K && i<=K
        m = m+1;
        if (k==K+1&&i == K+1) || ...
            (Cars(k).arrTime >= Cars(leave(1,n)).leaTime && ...
            Cars(i).startTime >= Cars(leave(1,n)).leaTime) % 第k个到达时间比第n个离开时间晚，第i个进入服务时间比第n个离开时间晚
            changes(m).changeTime = Cars(leave(1,n)).leaTime;
            changes(m).carNum = leave(1,n);
            changes(m).state = 0; % 状态：离开
            n = n + 1;
        elseif k == K+1 || ...
            Cars(k).arrTime > Cars(i).startTime % 第k个到达比第i个进入晚
            changes(m).changeTime = Cars(i).startTime;
            changes(m).carNum = i;
            changes(m).state = 2; % 状态：开始停车
            i = i + 1;
        else
            changes(m).changeTime = Cars(k).arrTime;
            changes(m).carNum = k;
            changes(m).state = 1; % 状态：到达
            k = k + 1;
        end
    end

function toY(car, ty)
%myFun - Description
%
% Syntax: output = myFun(input)
%
% Long description
    global speed;

    pos = get(car, 'Position'); % 获取车的位置信息
    py = pos(1,2);
    if py < ty
        while py < ty
            py = py + 0.01;
            pause(0.1/speed);
            pos(1,2) = py; % 更新y坐标
            set(car,'Position',pos);
        end
    elseif py > ty
        while py > ty
            py = py - 0.01;
            pause(0.1/speed);
            pos(1,2) = py;
            set(car,'Position',pos);
        end
    end

function toX(car, tx)
%myFun - Description
%
% Syntax: output = myFun(input)
%
% Long description
    global speed;

    pos = get(car,'Position');
    px = pos(1,1);
    if px < tx
        while px < tx
            px = px + 0.01;
            pause(0.05/speed); % 0.05比0.1快一点儿
            pos(1,1)=px;
            set(car,'Position',pos);
        end
    elseif px > tx
        while px > tx
            px = px - 0.01;
            pause(0.03/speed);
            pos(1,1) = px;
            set(car,'Position',pos);
        end
    end