%% Matlab R2021a
% Designed by YuTaoV5
% q2.m is designed for Upper bound Sliding Mode Control
% you can send issues in https://github.com/YuTaoV5/SMC_demo if you have any question
clc
clear
close all;
%% 调参
global J c epc d_flag s_flag
J = 1.5;%转动惯量
c = 0.4;%滑膜的Kp
epc = 1.2;%固定切换倍率，取决于执行器切换能力，电机速度控制的话epc可以给高；位置控制的话建议给低
d_flag = true;% 1是随机噪声 0是正弦函数噪声
s_flag = true;% 1是阶跃输入 0是正弦输入
%% 修改模型参数
load_system('smc_demo.mdl');
            
if d_flag==1
    set_param('smc_demo/Constant','value','1');
else
    set_param('smc_demo/Constant','value','0');
end
if s_flag==1
    set_param('smc_demo/Constant1','value','1');
else
    set_param('smc_demo/Constant1','value','0');
end
%% 运行模型
sim('smc_demo.mdl',20)
%% 可视化
subplot(3,1,1);
plot(t,y(:,4),'color',[0.5 0.5 0.5],'linewidth',0.05);

hold on
plot(t,y(:,1),'k',t,y(:,2),'r:','linewidth',2);
legend('Ideal position signal','Position tracking','add noise');
xlabel('time(s)');ylabel('Angle response');
subplot(3,1,2);
plot(t,u(:,1),'k','linewidth',0.01);
xlabel('time(s)');ylabel('Control input');
subplot(3,1,3);
plot(e,de,'r',e,-c'.*e,'k','linewidth',2);
xlabel('e');ylabel('de');