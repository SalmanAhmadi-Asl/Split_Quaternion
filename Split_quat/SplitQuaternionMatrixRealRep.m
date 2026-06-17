function [Q]=SplitQuaternionMatrixRealRep(X)
A1=X.A;
A2=X.B;
A3=X.C;
A4=X.D;
Q=[A1,-A2,A3,A4;A2,A1,A4,-A3;A3,A4,A1,-A2;A4,-A3,A2,A1];
end