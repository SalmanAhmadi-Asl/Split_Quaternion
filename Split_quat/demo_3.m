%% Demo: Split Quaternion Matrix Representations

% Clear and setup
clear; clc;
import splitquat.*

fprintf('========================================\n');
fprintf('SPLIT QUATERNION MATRIX REPRESENTATIONS\n');
fprintf('========================================\n\n');

%% 1. Create split quaternions
fprintf('1. Creating split quaternions:\n');
q1 = SplitQuaternion(1, 2, 3, 4);
q2 = SplitQuaternion(2, -1, 4, 3);

fprintf('q1 = '); disp(q1);
fprintf('q2 = '); disp(q2);

%% 2. Test real 4x4 representation
fprintf('\n2. Real 4x4 Matrix Representation:\n');
fprintf('---------------------------------\n');

M1_real = SplitQuaternion.SplitQuaternionRealRep(q1);
M2_real = SplitQuaternion.SplitQuaternionRealRep(q2);

fprintf('M(q1):\n');
disp(M1_real);

fprintf('M(q2):\n');
disp(M2_real);

% Test multiplication
fprintf('M(q1) * M(q2):\n');
M_product_real = M1_real * M2_real;
disp(M_product_real);

% Convert back
q_product_real = SplitQuaternion.RealRepToSplitQuaternion(M_product_real);
fprintf('Product from matrix multiplication:\n');
disp(q_product_real);

% Direct product for comparison
q_product_direct = q1 * q2;
fprintf('Direct product q1 * q2:\n');
disp(q_product_direct);

%% 3. Test complex 2x2 representation
fprintf('\n3. Complex 2x2 Matrix Representation:\n');
fprintf('-----------------------------------\n');

M1_complex = SplitQuaternion.SplitQuaternionComplexRep(q1);
M2_complex = SplitQuaternion.SplitQuaternionComplexRep(q2);

fprintf('M(q1):\n');
disp(M1_complex);

fprintf('M(q2):\n');
disp(M2_complex);

% Test multiplication
fprintf('M(q1) * M(q2):\n');
M_product_complex = M1_complex * M2_complex;
disp(M_product_complex);

% Convert back
q_product_complex = SplitQuaternion.ComplexRepToSplitQuaternion(M_product_complex);
fprintf('Product from matrix multiplication:\n');
disp(q_product_complex);

%% 7. Special cases
fprintf('\n7. Special Cases:\n');
fprintf('----------------\n');

% Pure imaginary split quaternions
fprintf('Pure imaginary split quaternions:\n');
i_q = SplitQuaternion(0, 1, 0, 0);
j_q = SplitQuaternion(0, 0, 1, 0);
k_q = SplitQuaternion(0, 0, 0, 1);

fprintf('i = '); disp(i_q);
fprintf('j = '); disp(j_q);
fprintf('k = '); disp(k_q);

M_i_real = SplitQuaternion.SplitQuaternionRealRep(i_q);
M_j_real = SplitQuaternion.SplitQuaternionRealRep(j_q);
M_k_real = SplitQuaternion.SplitQuaternionRealRep(k_q);

fprintf('\nReal matrix for i:\n');
disp(M_i_real);

fprintf('Real matrix for j:\n');
disp(M_j_real);

fprintf('Real matrix for k:\n');
disp(M_k_real);
