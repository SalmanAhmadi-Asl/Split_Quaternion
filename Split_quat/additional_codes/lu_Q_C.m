function [l,u]=lu_Q_C(X)

[l_1,u_1]=lu(SplitQuaternionMatrixComplexRep(X));

l=ComplexRepToSplitQuaternionMatrix(l_1);
u=ComplexRepToSplitQuaternionMatrix(u_1);
end