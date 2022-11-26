function [sys,x0,str,ts] = ctrl(t, x, u, flag)

switch flag,
  case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;  % 调用初始化子函数
  case 1,
    sys=[];
  case 2,
    sys=[];
  case 3,
    sys=mdlOutputs(t,x,u);    %计算输出子函数
  case 4,
    sys=[];    %计算下一仿真时刻子函数
  case 9,
    sys=[];    %终止仿真子函数
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
 
end
 
function [sys,x0,str,ts,simStateCompliance]=mdlInitializeSizes   %初始化子函数
 
sizes = simsizes;
 
sizes.NumContStates  = 0;  %连续状态变量个数
sizes.NumDiscStates  = 0;  %离散状态变量个数
sizes.NumOutputs     = 4;  %输出变量个数
sizes.NumInputs      = 4;   %输入变量个数
sizes.DirFeedthrough = 1;   %输入信号是否在输出端出现
sizes.NumSampleTimes = 0;   % at least one sample time is needed
 
sys = simsizes(sizes);
x0  = [];   %初始值
str = [];   
ts  = [];   %[0 0]用于连续系统，[-1 0]表示继承其前的采样时间设置
simStateCompliance = 'UnknownSimState';
 
function sys=mdlOutputs(t,x,u)   %计算输出子函数
global J c epc d_flag s_flag
%dt = sin(t)/2;%扰动

x1 = u(2);  %x1 theta
x2 = u(3); %x2 dtheta
dt = u(4);
if s_flag==true
    thd = u(1); %输入
    dthd = 0;
    ddthd = 0;
else
    thd = sin(t); %输入
    dthd = cos(t);
    ddthd = -sin(t);
end

e = x1 - thd;
de = x2 - dthd;   %因为输入信号在阶跃后保持1,导数为0
s = c*e + de;

 
ut = -c*J*de - J*epc*sign(s) + J*ddthd -0.5 
sys(1) = ut;
sys(2) = e;
sys(3) = de;
sys(4) = dt;