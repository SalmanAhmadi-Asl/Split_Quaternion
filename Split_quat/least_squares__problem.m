clc;clear

m=5;n=4;r=2;
A1=randn(m,r);A2=randn(r,n);
A1=A1*A2;
%A1=zeros(m,n);

B1=randn(m,r);B2=randn(r,n);
A2=B1*B2;
%  A2=zeros(m,n);

C1=randn(m,r);C2=randn(r,n);
A3=C1*C2;
% A3=zeros(m,n);

D1=randn(m,r);D2=randn(r,n);
A4=D1*D2;
%A4=zeros(m,n);

A=SplitQuaternionMatrix(A1,A2,A3,A4);

x=SplitQuaternionMatrix(randn(4,5),randn(4,5),randn(4,5),randn(4,5));

b=A*x;


y = mp_split_quat(A)*b;

A*y-b