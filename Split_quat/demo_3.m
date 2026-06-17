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

M1_real = SplitQuaternionRealMatrixRep(q1);
M2_real = SplitQuaternionRealMatrixRep(q2);

fprintf('M(q1):\n');
disp(M1_real);

fprintf('M(q2):\n');
disp(M2_real);

% Test multiplication
fprintf('M(q1) * M(q2):\n');
M_product_real = M1_real * M2_real;
disp(M_product_real);

% Convert back
q_product_real = M_product_real.toSplitQuaternion();
fprintf('Product from matrix multiplication:\n');
disp(q_product_real);

% Direct product for comparison
q_product_direct = q1 * q2;
fprintf('Direct product q1 * q2:\n');
disp(q_product_direct);

%% 3. Test complex 2x2 representation
fprintf('\n3. Complex 2x2 Matrix Representation:\n');
fprintf('-----------------------------------\n');

M1_complex = SplitQuaternionComplexMatrixRep(q1);
M2_complex = SplitQuaternionComplexMatrixRep(q2);

fprintf('M(q1):\n');
disp(M1_complex);

fprintf('M(q2):\n');
disp(M2_complex);

% Test multiplication
fprintf('M(q1) * M(q2):\n');
M_product_complex = M1_complex * M2_complex;
disp(M_product_complex);

% Convert back
q_product_complex = M_product_complex.toSplitQuaternion();
fprintf('Product from matrix multiplication:\n');
disp(q_product_complex);

%% 4. Verify isomorphism
fprintf('\n4. Verifying Isomorphism:\n');
fprintf('------------------------\n');

SplitQuaternionMatrixRep.verifyIsomorphism(q1);

%% 5. Test multiplication preservation
fprintf('\n5. Testing Multiplication Preservation:\n');
fprintf('-------------------------------------\n');

SplitQuaternionMatrixRep.testMultiplicationPreservation(q1, q2);

%% 6. Test algebra in both representations
fprintf('\n6. Testing Algebra in Matrix Representations:\n');
fprintf('--------------------------------------------\n');

fprintf('Testing real 4x4 representation algebra:\n');
SplitQuaternionRealMatrixRep.testAlgebra();

fprintf('\nTesting complex 2x2 representation algebra:\n');
SplitQuaternionComplexMatrixRep.testAlgebra();

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

M_i_real = SplitQuaternionRealMatrixRep(i_q);
M_j_real = SplitQuaternionRealMatrixRep(j_q);
M_k_real = SplitQuaternionRealMatrixRep(k_q);

fprintf('\nReal matrix for i:\n');
disp(M_i_real.matrix);

fprintf('Real matrix for j:\n');
disp(M_j_real.matrix);

fprintf('Real matrix for k:\n');
disp(M_k_real.matrix);

%% 8. Norm preservation
fprintf('\n8. Norm Preservation:\n');
fprintf('-------------------\n');

fprintf('q1 norm (direct): %g\n', q1.norm());
fprintf('q1 norm from real matrix: %g\n', M1_real.norm());
fprintf('q1 norm from complex matrix: %g\n', M1_complex.norm());

% Check determinant in complex representation
fprintf('\nDeterminant of complex matrix M(q1): %g\n', det(M1_complex.matrix));
fprintf('Square of split quaternion norm: %g\n', q1.norm()^2);

%% 9. Test with random split quaternions
fprintf('\n9. Random Split Quaternion Test:\n');
fprintf('------------------------------\n');

for i = 1:3
    q_rand = SplitQuaternion(randn, randn, randn, randn);
    fprintf('\nTest %d:\n', i);
    SplitQuaternionMatrixRep.verifyIsomorphism(q_rand);
end

fprintf('\n========================================\n');
fprintf('DEMO COMPLETE\n');
fprintf('========================================\n');