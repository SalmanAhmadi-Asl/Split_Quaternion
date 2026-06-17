function [Q]=SplitQuaternionMatrixComplexRep(X)
A1=X.A;
A2=X.B;
A3=X.C;
A4=X.D;
Q=[A1+i*A2,A3+i*A4;
   A3-i*A4,A1-i*A2];
end