# Split Quaternion and Split Quaternion Matrix Toolbox

A MATLAB toolbox for working with split quaternions and split quaternion matrices, including basic algebraic operations, matrix manipulations, and utility functions.

## Overview

This repository provides two core classes for split quaternion arithmetic in MATLAB:

- **SplitQuaternion**: Represents individual split quaternions with components $a + bi + cj + dk$ where $i^2 = -1$, $j^2 = k^2 = 1$, and $ijk = 1$.
- **SplitQuaternionMatrix**: Represents matrices whose entries are split quaternions, with support for matrix operations and element-wise manipulations.

Split quaternions (also known as coquaternions) are a 4-dimensional algebra over the reals with applications in:
- Relativistic physics and Lorentz transformations
- Computer graphics and geometric algebra
- Signal processing and control theory

## Features

### SplitQuaternion Class
- **Basic operations**: Addition, subtraction, multiplication (both quaternion and scalar)
- **Algebraic operations**: Conjugate, inverse, norm (indefinite), magnitude
- **Advanced functions**: Exponential, logarithm, power, normalization
- **Utility methods**: Convert to/from vectors, extract components, check properties (pure, unit)
- **Static constructors**: `zeros()`, `ones()`, `eye()`, `i()`, `j()`, `k()`, `random()`, `fromVector()`, `fromAngleAxis()`

### SplitQuaternionMatrix Class
- **Matrix operations**: Addition, subtraction, multiplication (matrix-matrix, matrix-scalar, numeric matrix-quaternion matrix)
- **Element-wise operations**: Element-wise multiplication, power, scalar division
- **Matrix utilities**: Size, reshape, concatenation, indexing (`()` and `.`), trace, sum, mean
- **Algebraic operations**: Conjugate, transpose, conjugate transpose (Hermitian)
- **Conversion utilities**: Convert to full 2x2 block matrix, real matrix, cell array
- **Component access**: Extract real/imaginary parts, specific components, all components
- **Norms**: Split Frobenius norm (using indefinite quaternion norm)
- **Static constructors**: `zeros()`, `ones()`, `eye()`, `rand()`, `fromReal()`, `fromComplex()`

## Repository Structure
SplitQuaternion/
├── SplitQuaternion.m # Core SplitQuaternion class
├── SplitQuaternionMatrix.m # Core SplitQuaternionMatrix class
├── examples/ # Example scripts demonstrating usage
│ ├── basic_operations.m
│ ├── matrix_operations.m
│ └── advanced_features.m
├── tests/ # Unit tests and validation scripts
│ ├── test_splitquaternion.m
│ └── test_matrix_operations.m
└── README.md # This file

text

## Quick Start (MATLAB)

Add the repository to your MATLAB path:

```matlab
addpath('path/to/SplitQuaternion');
Basic Split Quaternion Operations
matlab
% Create split quaternions
q1 = SplitQuaternion(1, 2, 3, 4);
q2 = SplitQuaternion(5, 6, 7, 8);

% Basic arithmetic
q_sum = q1 + q2;                    % Addition
q_diff = q1 - q2;                   % Subtraction
q_prod = q1 * q2;                   % Quaternion multiplication

% Algebraic properties
q_conj = conj(q1);                  % Conjugate
q_inv = inv(q1);                    % Inverse (if norm != 0)
q_norm = norm(q1);                  % Indefinite norm (a²+b²-c²-d²)
q_mag = magnitude(q1);              % Absolute value of norm

% Check properties
is_pure = isPure(q1);               % Check if real part is zero
is_unit = isUnit(q1);               % Check if |norm| = 1

% Exponential and logarithm
q_exp = exp(q1);                    % Exponential
q_log = log(q1);                    % Logarithm (if norm > 0)

% Static constructors
zero = SplitQuaternion.zeros();
identity = SplitQuaternion.eye();
basis_i = SplitQuaternion.i();
random = SplitQuaternion.random();
Matrix Operations with Split Quaternions
matlab
% Create matrices
A = SplitQuaternionMatrix.rand(3, 4);
B = SplitQuaternionMatrix.rand(4, 5);

% Matrix operations
C = A * B;                          % Matrix multiplication
D = A + B;                          % Element-wise addition
E = A - B;                          % Element-wise subtraction

% Scalar operations
F = 2 * A;                          % Scalar multiplication
G = A / 3;                          % Scalar division

% Element-wise operations
H = A .* B;                         % Element-wise multiplication
I = A .^ 2;                         % Element-wise power

% Algebraic properties
A_conj = conj(A);                   % Conjugate
A_trans = A.';                      % Transpose
A_herm = A';                        % Hermitian transpose

% Component extraction
[real_part, imag_parts] = real(A), imag(A);
[A_comp, B_comp, C_comp, D_comp] = parts(A);

% Matrix utilities
size_A = size(A);                   % Get dimensions
A_trace = trace(A);                 % Trace
A_sum = sum(A);                     % Sum all elements
A_mean = mean(A, 2);                % Mean along dimension

% Conversion to numeric representations
full_mat = full(A);                 % 2x2 block matrix representation
real_mat = realMatrix(A);           % [A B; C D] representation
Indexing and Assignment
matlab
% Create a matrix
Q = SplitQuaternionMatrix.rand(4, 4);

% Access specific entries (returns SplitQuaternion)
q = Q(2, 3);

% Modify specific entries
Q(2, 3) = SplitQuaternion(1, 2, 3, 4);
Q(2, 3) = 5;                        % Assigns scalar to real part

% Access submatrices
Q_sub = Q(2:3, 1:2);
Advanced Examples
Working with Rotations
matlab
% Create a rotor for Lorentz boost
angle = pi/4;
axis = SplitQuaternion(0, 1, 0, 0);  % Pure split quaternion along i-axis
rotor = SplitQuaternion.rotor(angle, axis);

% Apply rotation (not shown - requires conjugation)
% p_rotated = rotor * p * conj(rotor);
Matrix Norms
matlab
Q = SplitQuaternionMatrix.rand(5, 5);
frobenius_norm = norm(Q);            % Split Frobenius norm
Testing
The repository includes test scripts to verify correct implementation of all operations:

matlab
% Run unit tests
run tests/test_splitquaternion.m
run tests/test_matrix_operations.m
Requirements
MATLAB R2018b or later (for class syntax and method declarations)

No additional toolboxes required

License
This project is licensed under the MIT License - see the LICENSE file for details.

Contributing
Contributions are welcome! Please submit issues and pull requests through GitHub.

References
Wikipedia: Split-quaternion

Split Quaternions and Lorentz Transformations

Quaternion Algebra and Its Applications

Citation
If you use this toolbox in your research, please cite:

bibtex
@misc{splitquaternion2025,
  title={Split Quaternion Toolbox for MATLAB},
  author={Your Name},
  year={2025},
  url={https://github.com/yourusername/SplitQuaternion}
}
