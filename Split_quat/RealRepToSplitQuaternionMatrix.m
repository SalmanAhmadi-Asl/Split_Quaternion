function X = RealRepToSplitQuaternionMatrix(Q)
    % Simpler version assuming exact structure
    % Q: 4m x 4n real matrix in real representation
[m,n]=size(Q);
A1=Q(1:m/4,1:n/4);
A2=Q(m/4+1:m/2,1:n/4);
A3=Q(m/2+1:3*m/4,1:n/4);
A4=Q(3*m/4+1:m,1:n/4);  
X=SplitQuaternionMatrix(A1,A2,A3,A4);
end