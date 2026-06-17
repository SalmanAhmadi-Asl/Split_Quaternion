function Y=ANTIREALMAP(X)
[m,n]=size(X);
X11=X(1:m/2,1:n/2);
X12=X(1:m/2,n/2+1:n);
X21=X(m/2+1:m,1:n/2);
X22=X(m/2+1:m,n/2+1:n);

Y=SplitQuaternionMatrix(0.5*(X11+X22),0.5*(X21-X12),0.5*(X11-X22),0.5*(X21+X12));


end