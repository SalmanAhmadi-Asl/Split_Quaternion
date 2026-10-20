%% Demo: Matrix Representations of Split Quaternion Matrices

clear; clc;
import splitquat.*

fprintf('===================================================\n');
fprintf('MATRIX REPRESENTATIONS OF SPLIT QUATERNION MATRICES\n');
fprintf('===================================================\n\n');

%% 1. Create split quaternion matrices
fprintf('1. Creating Split Quaternion Matrices:\n');
fprintf('-------------------------------------\n');

% Create 2x2 split quaternion matrix
A = [1 2; 3 4];
B = [0.1 0.2; 0.3 0.4];
C = [0.5 0.6; 0.7 0.8];
D = [0.9 1.0; 1.1 1.2];

SQM = SplitQuaternionMatrix(A, B, C, D);
fprintf('2x2 Split Quaternion Matrix:\n');
disp(SQM);

%% 2. Real adjoint representation
fprintf('\n2. Real 4m×4n Adjoint Representation:\n');
fprintf('------------------------------------\n');

R_rep = SplitQuaternionMatrixRealRep(SQM);
disp(R_rep);


% Show block structure
% fprintf('\nBlock structure of real representation:\n');
% for i = 1:2
%     for j = 1:2
%         fprintf('\nBlock for element (%d,%d):\n', i, j);
%         block = R_rep.getElementBlock(i, j);
%         disp(block);
%     end
% end

%% 3. Complex adjoint representation
fprintf('\n3. Complex 2m×2n Adjoint Representation:\n');
fprintf('---------------------------------------\n');

C_rep = SplitQuaternionMatrixComplexRep(SQM);
disp(C_rep);

[Q_1]=ComplexRepToSplitQuaternionMatrix(C_rep);

norm(Q_1-SQM)

%% 4. Test isomorphism properties
fprintf('\n4. Testing Isomorphism Properties:\n');
fprintf('---------------------------------\n');



% SplitQuaternionMatrixRealRep.testIsomorphism();

%% 5. Compare representations
fprintf('\n5. Comparing Both Representations:\n');
fprintf('---------------------------------\n');

% SplitQuaternionMatrixComplexRep.compareRepresentations(SQM)