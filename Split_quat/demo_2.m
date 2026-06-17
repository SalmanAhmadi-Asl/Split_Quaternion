%% Test scalar multiplication with split quaternion matrices
disp('Testing scalar multiplication with SplitQuaternionMatrix...');

% Create a split quaternion matrix
A = [1 2; 3 4];
B = [0 1; 2 0];
C = [1 0; 0 1];
D = [0 0; 1 0];

SQM = SplitQuaternionMatrix(A, B, C, D);
disp('Original matrix:');
disp(SQM);

% Test scalar * matrix
scalar = 2.5;
result1 = scalar * SQM;
disp('2.5 * SQM:');
disp(result1);

% Test matrix * scalar
result2 = SQM * scalar;
disp('SQM * 2.5:');
disp(result2);

% Test both should be equal
disp('Difference between 2.5*SQM and SQM*2.5:');
diff = result1 - result2;
disp(diff);

% Test with split quaternion (not matrix)
sq = SplitQuaternion(1, 2, 3, 4);

% Test scalar * split quaternion
result3 = 3 * sq;
disp('3 * sq:');
disp(result3);

% Test split quaternion * scalar
result4 = sq * 3;
disp('sq * 3:');
disp(result4);

% Test they should be equal
disp('Difference between 3*sq and sq*3:');
diff_sq = result3 - result4;
disp(diff_sq);

% Test matrix multiplication still works
SQM2 = SplitQuaternionMatrix([2 1; 1 3], [1 0; 2 1], [0 1; 1 0], [1 1; 0 1]);
disp('Second matrix:');
disp(SQM2);

result5 = SQM * SQM2;
disp('SQM * SQM2:');
disp(result5);


%%

% Create a split quaternion matrix
Q = SplitQuaternionMatrix(rand(3,3), rand(3,3), rand(3,3), rand(3,3));

% Real matrix multiplication
M_real = rand(3,3);
R1 = M_real * Q;   % numeric Matrix * SplitQuaternionMatrix
R2 = Q * M_real;   % SplitQuaternionMatrix * numeric Matrix

% Complex matrix multiplication  
M_complex = rand(3,3) + 1i*rand(3,3);
R3 = M_complex * Q;  % complex Matrix * SplitQuaternionMatrix
R4 = Q * M_complex;  % SplitQuaternionMatrix * complex Matrix