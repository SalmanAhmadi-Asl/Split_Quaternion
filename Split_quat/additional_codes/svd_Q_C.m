function [U,S,V]=svd_Q_C(X)

[U1,S1,V1]=svd(SplitQuaternionMatrixComplexRep(X));
U=ComplexRepToSplitQuaternionMatrix(U1);
S=ComplexRepToSplitQuaternionMatrix(S1);
V=ComplexRepToSplitQuaternionMatrix(V1);

end