clc;clear all

m=20;
n=30;

A1=randn(m,n);A2=randn(m,n);A3=rand(m,n);A4=rand(m,n);
A=SplitQuaternionMatrix(A1,A2,A3,A4);
% X=pseudoinverse_gradient(A,200,1e-7);



%%

X = pseudoinverse_ben_israel(A, 50, 1e-7);

% X=mp_split_quat(A);

E_1=X*A*X-X;
norm(real(E_1),'fro')
% norm(E.s,'fro')+norm(E.d,'fro')

E_2=A*X*A-A;
norm(real(E_2),'fro')
% norm(E.s,'fro')+norm(E.d,'fro')


%E_3=conj_i(X*A)-(X*A);
E_3=(X*A)'-(X*A);
norm(real(E_3),'fro')
% norm(E.s,'fro')+norm(E.d,'fro')

E_4=conj_i(X*A)-X*A;
%E_4=(X*A)'-X*A;
norm(real(E_4),'fro')
% norm(E.s,'fro')+norm(E.d,'fro')