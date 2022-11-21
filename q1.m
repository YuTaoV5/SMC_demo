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
syms x1 x2 c1 c2 epc k a
x=[x1;x2];
c=[c1 c2];
s=c*x;
u1=-inv(c*B)*((c*A*x)+epc*sign(s))
u2=-inv(c*B)*((c*A*x)+epc*sign(s)+k*s)
u3=-inv(c*B)*((c*A*x)+k*abs(s)^a*sign(s))

%% 绘制相轨迹
% 使用附加包, 地址如下:
% https://github.com/MathWorks-Teaching-Resources/Phase-Plane-and-Slope-Field
% x' = y
% y' = -25*y -(epc*sign(c1*x + c2*y) +y*(c1 - 25*c2))/c2
% y' = -25*y -(epc*sign(c1*x + c2*y) + y*(c1 - 25*c2) + k*(c1*x1 + c2*y))/c2
% y' = -25*y -(y*(c1 - 25*c2) + k*abs(c1*x + c2*y)^a*sign(c1*x + c2*y))/c2