clc;clear

m=9;n=7;r=2;
% A1=randn(m,r);A2=randn(r,n);
% A1=A1*A2;
% A1=zeros(m,n);
% 
% B1=randn(m,r);B2=randn(r,n);
% A2=B1*B2;
% %  A2=zeros(m,n);
% 
% C1=randn(m,r);C2=randn(r,n);
% A3=C1*C2;
%  %A3=zeros(m,n);
% 
% D1=randn(m,r);D2=randn(r,n);
% A4=D1*D2;
% %A4=zeros(m,n);

% A=SplitQuaternionMatrix(A1,A2,A3,A4);

A1=SplitQuaternionMatrix(randn(m,r),randn(m,r),randn(m,r),randn(m,r));
A2=SplitQuaternionMatrix(randn(r,n),randn(r,n),randn(r,n),randn(r,n));
A=A1*A2;

k=2;
% [C, U, R] = cur_split(A,5);

% Step 1: Uniformly sample columns
    col_indices = randsample(n, k);
    C = A(:, col_indices);
    
    % Step 2: Uniformly sample rows
    row_indices = randsample(m, k);
    R = A(row_indices, :);
    
    % Step 3: Compute the core matrix U
    % W = intersection of selected rows and columns
    W = A(row_indices, col_indices);

    WP = mp_split_quat(W);
    
    % Compute pseudo-inverse and form U
    % Using the formula: U = C_pinv * A * R_pinv (more stable)
    % Or simpler: U = pinv(W) (if W is well-conditioned)
    
    % Method 1: Using W pseudoinverse (standard CUR)
%     U = pseudoinverse_ben_israel(W, 200, 1E-7);
CP = mp_split_quat(C);

E=CP*C*CP-CP;
norm(real(E),'fro')
% norm(E.s,'fro')+norm(E.d,'fro')

E=C*CP*C-C;
norm(real(E),'fro')
% norm(E.s,'fro')+norm(E.d,'fro')


E=(CP*C)'-(CP*C);
norm(real(E),'fro')
% norm(E.s,'fro')+norm(E.d,'fro')

E=(C*CP)'-C*CP;
norm(real(E),'fro')

%%
clc
RP = mp_split_quat(R);

E=RP*R*RP-RP;
norm(real(E),'fro')
% norm(E.s,'fro')+norm(E.d,'fro')

E=R*RP*R-R;
norm(real(E),'fro')
% norm(E.s,'fro')+norm(E.d,'fro')


E=(RP*R)'-(RP*R);
norm(real(E),'fro')
% norm(E.s,'fro')+norm(E.d,'fro')

E=(R*RP)'-R*RP;
norm(real(E),'fro')
%%
clc
%U=CP*A*RP;

 approx=C * CP*A*RP*R;

norm(real(A-approx),'fro')