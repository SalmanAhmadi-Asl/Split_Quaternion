function [l,u]=lu_Q(X)

[l_1,u_1]=lu(SplitQuaternionMatrixRealRep(X));

l=RealRepToSplitQuaternionMatrix(l_1);
u=RealRepToSplitQuaternionMatrix(u_1);
end