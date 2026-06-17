function X = ComplexRepToSplitQuaternionMatrix(Q)
    
[m,n]=size(Q);
T=Q(1:m/2,1:n/2);
H=Q(m/2+1:m,1:n/2);
A1=0.5*(T+conj(T));
A2=-0.5i*(T-conj(T));
A3=0.5*(H+conj(H));
A4=0.5i*(H-conj(H));

X=SplitQuaternionMatrix(A1,A2,A3,A4);

end