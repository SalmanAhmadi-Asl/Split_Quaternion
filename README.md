# Split Quaternion Toolbox

A MATLAB implementation of split quaternions and split quaternion matrices with comprehensive algebraic operations and matrix functionalities.

## Overview

This toolbox provides two core classes for working with split quaternions in MATLAB:
- **SplitQuaternion**: Represents individual split quaternions with full algebraic support
- **SplitQuaternionMatrix**: Extends split quaternion operations to matrices with element-wise and matrix-level operations

Split quaternions (also known as coquaternions) are a 4-dimensional algebra over the real numbers with basis `{1, i, j, k}` satisfying:
- `i² = -1`
- `j² = k² = 1`
- `ij = -ji = k`
- `jk = -kj = -i`
- `ki = -ik = j`

Unlike standard quaternions, split quaternions have an indefinite norm: `N(q) = a² + b² - c² - d²`.

## Features

### SplitQuaternion Class
- **Basic Operations**: Addition, subtraction, multiplication (both matrix and element-wise)
- **Scalar Operations**: Division by scalars, scalar multiplication
- **Algebraic Properties**: Conjugate, norm, magnitude, inverse, power
- **Advanced Functions**: Exponential, logarithm, rotation rotors
- **Utility Methods**: Vector conversion, part extraction, unit checks, normalization
- **Static Constructors**: Zero, identity, basis elements, random, from vector/angle-axis

### SplitQuaternionMatrix Class
- **Matrix Operations**: Addition, subtraction, multiplication (matrix and element-wise)
- **Scalar Operations**: Scalar multiplication and division
- **Matrix Operations**: Transpose, conjugate transpose, trace, sum, mean, diag
- **Subscripting**: Full support for matrix indexing and assignment
- **Concatenation**: Horizontal and vertical concatenation
- **Conversion**: Full numeric representation, real matrix conversion, cell array conversion
- **Utility**: Size, length, empty check, pure/real checks

## Installation

1. Clone this repository:
```bash   
git clone https://github.com/yourusername/split-quaternion-toolbox.git
```

2. Add the toolbox to your MATLAB path:

```bash
addpath(genpath('path/to/split-quaternion-toolbox'));
```

## Quick Start
## Creating Split Quaternions

```bash
% Create a split quaternion
q = SplitQuaternion(1, 2, 3, 4);

% Using static constructors
zero = SplitQuaternion.zeros();        % 0 + 0i + 0j + 0k
identity = SplitQuaternion.eye();       % 1 + 0i + 0j + 0k
i_basis = SplitQuaternion.i();          % 0 + 1i + 0j + 0k
j_basis = SplitQuaternion.j();          % 0 + 0i + 1j + 0k
k_basis = SplitQuaternion.k();          % 0 + 0i + 0j + 1k
random = SplitQuaternion.random();      % Random components in [0,1]

% From vector
q = SplitQuaternion.fromVector([1, 2, 3, 4]);
```

## Basic Operations
```bash
p = SplitQuaternion(1, 2, 3, 4);
q = SplitQuaternion(5, 6, 7, 8);

% Addition and subtraction
r = p + q;
r = p - q;

% Multiplication (split quaternion multiplication)
r = p * q;                    % Matrix multiplication
r = p .* q;                   % Element-wise multiplication

% Scalar operations
r = p + 5;                    % Add scalar to real part
r = 5 * p;                    % Scalar multiplication
r = p / 2;                    % Scalar division

% Algebraic properties
conj_q = conj(q);              % Conjugate: a - bi - cj - dk
n = norm(q);                   % Indefinite norm: a² + b² - c² - d²
mag = magnitude(q);            % sqrt(|norm(q)|)
inv_q = inv(q);                % Multiplicative inverse
q_power = q^3;                 % Integer power
```

## Basic Operations
```bash
q = SplitQuaternion(1, 2, 3, 4);

% Exponential and logarithm
exp_q = exp(q);
log_q = log(q);

% Component extraction
[a, b, c, d] = q.parts();
vec = q.vector();              % Returns [b, c, d]
full_vec = q.toVector();       % Returns [a, b, c, d]

% Checks
is_pure = q.isPure();          % Check if pure (a = 0)
is_unit = q.isUnit();          % Check if unit (|norm| = 1)

% Normalization
q_norm = q.normalize();

% Dot product
d = dot(p, q);                 % a1*a2 + b1*b2 - c1*c2 - d1*d2
```

## Basic Operations
```bash
% Create from component matrices
A = randn(3, 3);
B = randn(3, 3);
C = randn(3, 3);
D = randn(3, 3);
Q = SplitQuaternionMatrix(A, B, C, D);

% Using static constructors
Z = SplitQuaternionMatrix.zeros(3, 3);    % Zero matrix
I = SplitQuaternionMatrix.eye(3);         % Identity matrix
R = SplitQuaternionMatrix.rand(3, 3);     % Random matrix

% From real or complex matrices
Q_real = SplitQuaternionMatrix.fromReal(A);     % Imaginary parts zero
Q_complex = SplitQuaternionMatrix.fromComplex(z); % Complex to split quaternion
```

## Matrix Operations
```bash
Q = SplitQuaternionMatrix.rand(3, 3);
P = SplitQuaternionMatrix.rand(3, 3);

% Basic matrix operations
R = Q + P;                     % Addition
R = Q - P;                     % Subtraction
R = Q * P;                     % Matrix multiplication
R = Q .* P;                    % Element-wise multiplication
R = Q / 2;                     % Scalar division

% Matrix properties
t = trace(Q);                  % Trace
s = sum(Q);                    % Sum of elements
m = mean(Q);                   % Mean of elements
d = diag(Q);                   % Extract diagonal

% Conjugations
conj_Q = conj(Q);              % Full conjugate
conj_i = Q.conj_i();           % Conjugate with respect to i
conj_j = Q.conj_j();           % Conjugate with respect to j
conj_k = Q.conj_k();           % Conjugate with respect to k

% Conversions
mat = Q.full();                % 2x2 block matrix representation
mat = Q.realMatrix();          % Real 4x4 matrix representation
cell_mat = Q.toCell();         % Cell array of components
[A, B, C, D] = Q.parts();      % Extract components
```

## Matrix Indexing
```bash
Q = SplitQuaternionMatrix.rand(5, 5);

% Accessing elements
q_ij = Q(2, 3);                % Returns a SplitQuaternion
submatrix = Q(1:3, 2:4);       % Returns a SplitQuaternionMatrix

% Assignment
Q(2, 3) = SplitQuaternion(1, 2, 3, 4);
Q(1:2, 1:2) = SplitQuaternionMatrix.eye(2);
```

## Rotation Rotors
```bash
% Create a rotation rotor
axis = SplitQuaternion(0, 1, 0, 0);  % Pure split quaternion (i direction)
angle = pi/4;
rotor = SplitQuaternion.rotor(angle, axis);

% Apply rotation to a split quaternion
q = SplitQuaternion(0, 1, 0, 0);  % Vector to rotate
q_rotated = rotor * q * conj(rotor);
```
#### Mathematical Notes
## Split Quaternion Multiplication
For split quaternions `p = a + bi + cj + dk` and `q = e + fi + gj + hk`:
```bash
p * q = (ae - bf + cg + dh) +
        (af + be - ch + dg)i +
        (ag + ce - bf + dh)j +
        (ah + de + bg - cf)k
```

## Indefinite Norm
The norm of a split quaternion is:
```bash
N(q) = a² + b² - c² - d²
```
This can be positive, negative, or zero, unlike the definite norm of standard quaternions.

## Lightlike Elements
Split quaternions with zero norm are called lightlike or null elements. Special care must be taken when computing inverses or logarithms for such elements.

## Testing
The toolbox includes comprehensive tests for both classes. To run the tests:
```bash
% Run all tests
run_tests();

% Test specific class
test_split_quaternion();
test_split_quaternion_matrix();
```

## Performance Considerations

1. The `mtimes` and `times` methods for `SplitQuaternionMatrix` support multiplication with numeric matrices (real or complex) as well as scalar values

1. Matrix operations leverage MATLAB's optimized matrix multiplication for component-wise operations

2. For large matrices, consider using the `full()` or `realMatrix()` conversions if you need to use standard MATLAB matrix functions

## Limitations

1. The logarithm function is only defined for split quaternions with positive norm

2. The exponential function handles different norm cases but may have numerical issues near lightlike elements

3. Matrix multiplication with numeric matrices assumes the numeric matrix is of compatible dimensions

## Citation
If you use this toolbox in your research, please cite:

```bash
@misc{yourname2026splitquaternion,
  title={Split Quaternion Toolbox: A MATLAB Implementation},
  author={Your Name},
  year={2026},
  howpublished={\url{https://github.com/yourusername/split-quaternion-toolbox}}
}
```
