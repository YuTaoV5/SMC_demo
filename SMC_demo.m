%% Matlab R2021a
% Designed by YuTaoV5
% q2.m is designed for Upper bound Sliding Mode Control
% you can send issues in https://github.com/YuTaoV5/SMC_demo if you have any question
function [ut] = SMC_demo(J1,c1,epc1,d_flag1,s_flag1)
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
ut = u(:,1);


%% 调参
global J c epc d_flag s_flag
J = J1;%转动惯量
c = c1;%滑膜的Kp
epc = epc1;%固定切换倍率，取决于执行器切换能力，电机速度控制的话epc可以给高；位置控制的话建议给低
d_flag = d_flag1;% 1是随机噪声 0是正弦函数噪声
s_flag = s_flag1;% 1是阶跃输入 0是正弦输入
%% 运行模型
sim('my_sim.mdl')
%% 可视化
subplot(3,1,1);
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
hold on
plot(t,y(:,4),'color',[0.5 0.5 0.5],'linewidth',0.05);
legend('Ideal position signal','Position tracking','add noise');
xlabel('time(s)');ylabel('Angle response');
subplot(3,1,2);
plot(t,u(:,1),'k','linewidth',0.01);
xlabel('time(s)');ylabel('Control input');
subplot(3,1,3);
plot(e,de,'r','linewidth',2);
xlabel('e');ylabel('de');

end