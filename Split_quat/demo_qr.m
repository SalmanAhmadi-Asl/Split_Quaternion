clc;clear all

m=5;
n=5;

A1=randn(m,n);A2=randn(m,n);A3=rand(m,n);A4=rand(m,n);
A=SplitQuaternionMatrix(A1,A2,A3,A4);
% X=pseudoinverse_gradient(A,200,1e-7);

[Q,R]=qr_split(A);
Q*R-A

%%

% [u,s,v]=svd_split(A);
H=size(A);
m=H(1);
n=H(2);
n=min(m,n);

Y=REALMAP(A);
[u,s,v]=svd(Y);
u=ANTIREALMAP(u);
% s=ANTIREALMAP(s);

% ss=s(:);
% nz=nnz(ss);


% for i=1:nz
% s_(i)=SplitQuaternionMatrix(0.5*(ss(i)+ss(i+n)),0,0.5*(ss(i)-ss(i+n)),0);
% end

% s=SplitQuaternionMatrix.zeros(m,n);
% 
% for i=1:nz
% 
%     s(i,i)=SplitQuaternionMatrix(0.5*(ss(i)+ss(i+n)),0,0.5*(ss(i)-ss(i+n)),0);
% 
% end

v=ANTIREALMAP(v);
s=u'*A*v