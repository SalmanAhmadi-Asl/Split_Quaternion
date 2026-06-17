import splitquat.*
clc;clear all
% Scalars
q1 = SplitQuaternion(1,2,3,4);
q2 = SplitQuaternion(0,1,-1,2);

q3 = q1*q2;
disp(q3)

% Matrices
A = SplitQuaternionMatrix(rand(2),zeros(2),zeros(2),zeros(2));
B = SplitQuaternionMatrix(rand(2),rand(2),zeros(2),zeros(2));

C = A*B;
D = A + B;
E = B';