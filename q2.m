%% Matlab R2021a
% Designed by YuTaoV5
% q2.m is designed for Upper bound Sliding Mode Control
% you can send issues in https://github.com/YuTaoV5/SMC_demo if you have any question
clc
clear
close all;
%% 调参
global J c epc
J = 5;
c = 1;
epc = 0.5;
%% 运行模型
sim('my_sim.mdl')
%% 可视化
subplot(3,1,1);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
legend('Ideal position signal','Position tracking');
xlabel('time(s)');ylabel('Angle response');
subplot(3,1,2);
plot(t,u(:,1),'k','linewidth',0.01);
xlabel('time(s)');ylabel('Control input');
subplot(3,1,3);
plot(e,de,'r','linewidth',2);
xlabel('e');ylabel('de');