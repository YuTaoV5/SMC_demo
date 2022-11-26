function yddt = fun(t,y) %记得将“fun”作为文件名，接下来求解时，就用它代表整个微分方程组
    c1 = 15;            %参数设置
    c2 = 15;
    epc = 0.5;
    yddt = zeros(2,1);   %创建数组存储数据
    yddt(1) = y(2)
    yddt(2) = -25*y(2) - (epc*sign(c1*y(1) + c2*y(2)) +y(2)*(c1 - 25*c2))/c2;

 
end
