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
