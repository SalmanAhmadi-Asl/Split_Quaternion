% Create a split quaternion matrix
clc;clear all
% A = [1 2; 3 4];
% B = [0 1; 2 0];
% C = [1 0; 0 1];
% D = [0 0; 1 0];

A = randn(2,2);
B = randn(2,2);
C = randn(2,2);
D = randn(2,2);

A_ = randn(2,2);
B_ = randn(2,2);
C_ = randn(2,2);
D_ = randn(2,2);

S = SplitQuaternionMatrix(A, B, C, D);

S_ = SplitQuaternionMatrix(A_, B_, C_, D_);

ComplexRepToSplitQuaternionMatrix(SplitQuaternionMatrixComplexRep(S))-S;


ComplexRepToSplitQuaternionMatrix(SplitQuaternionMatrixComplexRep(S)*SplitQuaternionMatrixComplexRep(S_))-S*S_

RealRepToSplitQuaternionMatrix(SplitQuaternionMatrixRealRep(S)*SplitQuaternionMatrixRealRep(S_))-S*S_

RealRepToSplitQuaternionMatrix(SplitQuaternionMatrixRealRep(S))-S;
