%%demo to test qr, svd and lu decompositions for split quaternion matrices


clc;clear all

% Create 2x2 split quaternion matrix
A = [1 2; 1 4];
B = [0.1 0.2; 0.3 0.4];
C = [0.5 0.6; 0.7 0.8];
D = [0.9 1.0; 1.1 1.2];

SQM = SplitQuaternionMatrix(A, B, C, D);
fprintf('2x2 Split Quaternion Matrix:\n');
disp(SQM);

[l,u]=lu_Q(SQM);

norm(SQM-l*u)

[q,r]=qr_Q(SQM);

norm(SQM-q*r)

[U,S,V]=svd_Q(SQM);

norm(SQM-U*S*ctranspose(V))

%%
[l,u]=lu_Q_C(SQM);

norm(SQM-l*u)

[q,r]=qr_Q_C(SQM);

norm(SQM-q*r)

[U,S,V]=svd_Q_C(SQM);

norm(SQM-U*S*ctranspose(V))

%%
% Test QR Householder for complex matrix

[Q,R] = qr_householder_sq(A);

fprintf('A - QR = %.2e\n', norm(A - Q*R))
fprintf('Q^*Q - I = %.2e\n', norm(Q'*Q - eye(m)))
fprintf('Lower-triangular part of R = %.2e\n', ...
        norm(tril(R,-1)))