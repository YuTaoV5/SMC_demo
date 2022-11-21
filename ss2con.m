function [D,E,F,T] = ss2con(A,B,C,n)
%能控标准型转换
T=zeros(n,n);
T(:,1)=B;
%求其特征多项式
a=poly(A);
 
for i=2:n
    T(:,i)=A*T(:,i-1)+a(1,i)*T(:,1);
end
T=fliplr(T);
%得到新的A矩阵
D=inv(T)*A*T;
%得到新的B矩阵
E=inv(T)*B;
%得到新的C矩阵
F=C*T;
end
 
 