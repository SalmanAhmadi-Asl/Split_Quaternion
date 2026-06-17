function [U,S,V]=svd_Q(X)

[U1,S1,V1]=svd(SplitQuaternionMatrixRealRep(X));
U=RealRepToSplitQuaternionMatrix(U1);
S=RealRepToSplitQuaternionMatrix(S1);
V=RealRepToSplitQuaternionMatrix(V1);

end