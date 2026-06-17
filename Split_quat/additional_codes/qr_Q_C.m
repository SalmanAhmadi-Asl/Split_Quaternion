function [q,r]=qr_Q_C(X)

[q_1,r_1]=lu(SplitQuaternionMatrixComplexRep(X));

q=ComplexRepToSplitQuaternionMatrix(q_1);
r=ComplexRepToSplitQuaternionMatrix(r_1);
end