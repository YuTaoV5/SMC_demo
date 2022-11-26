%% Matlab R2021a
% Designed by YuTaoV5
% q1.m is designed for Sliding mode control based on approach law
% you can send issues in https://github.com/YuTaoV5/SMC_demo if you have any question
clc
clear
%% 转化状态空间方程
num = [0 0 133]
den = [1 25 0]
[A B C] = tf2ss(num, den)
[A B C D] = ss2con(A,B,C,2)

%% 设计控制器u
syms x1 x2 c1 c2 epc k a c
x=[x1;x2];
c=[c1 c2];
s=c*x;
u1=-inv(c*B)*((c*A*x)+epc*sign(s))
u2=-inv(c*B)*((c*A*x)+epc*sign(s)+k*s)
u3=-inv(c*B)*((c*A*x)+k*abs(s)^a*sign(s))

%% 绘制相轨迹
c=15
y0(1) = 1;              %x的初始条件
y0(2) = -1;              %y的初始条件
tspan = [0 10];        %求解的时间范围
[t,y] = ode45('fun',tspan,[y0(1),y0(2)]); %调用ode45求解，要求解的函数就是前面创建的“eqx”文件
subplot(3,1,1)
plot(t,y(:,1),t,y(:,2))  %绘制x，y随时间t的变化图像
subplot(3,1,2)
plot(y(:,1),y(:,2),'r')      %绘制相图
subplot(3,1,3)
plot(y(:,1),y(:,2),'r',y(:,1),-c'.*y(:,1),'k')      %绘制相图
% 使用附加包, 地址如下:
% https://github.com/MathWorks-Teaching-Resources/Phase-Plane-and-Slope-Field
% x' = y
% y' = -25*y - (epc*sign(c1*x + c2*y) +y*(c1 - 25*c2))/c2
% y' = -25*y - (epc*sign(c1*x + c2*y) + y*(c1 - 25*c2) + k*(c1*x + c2*y))/c2
% y' = -25*y - (y*(c1 - 25*c2) + k*abs(c1*x + c2*y)^a*sign(c1*x + c2*y))/c2