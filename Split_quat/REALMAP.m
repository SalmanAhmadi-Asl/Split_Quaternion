function Y=REALMAP(X)
A1=X.A;
A2=X.B;
A3=X.C;
A4=X.D;


Y=[A1+A3  -A2+A4;
    A2+A4   A1-A3];


end