function [q,r]=qr_Q(X)

[q_1,r_1]=qr(SplitQuaternionMatrixRealRep(X));

q=RealRepToSplitQuaternionMatrix(q_1);
r=RealRepToSplitQuaternionMatrix(r_1);
end