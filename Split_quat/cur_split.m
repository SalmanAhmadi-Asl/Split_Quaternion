function [C, U, R] = cur_split(A,k)
% CUR_APPROXIMATION Compute CUR decomposition of matrix A using uniform sampling
%   Input:
%       A - m x n input matrix
%       k - target rank for approximation
%       c - number of columns to select (should be >= k)
%       r - number of rows to select (should be >= k)
%   Output:
%       C - m x c matrix of selected columns
%       U - c x r core matrix
%       R - r x n matrix of selected rows

    h=size(A);
    m=h(1);
    n=h(2);
    
    % Step 1: Uniformly sample columns
    col_indices = randsample(n, k);
    C = A(:, col_indices);
    
    % Step 2: Uniformly sample rows
    row_indices = randsample(m, k);
    R = A(row_indices, :);
    
    % Step 3: Compute the core matrix U
    % W = intersection of selected rows and columns
    W = A(row_indices, col_indices);
    
    % Compute pseudo-inverse and form U
    % Using the formula: U = C_pinv * A * R_pinv (more stable)
    % Or simpler: U = pinv(W) (if W is well-conditioned)
    
    % Method 1: Using W pseudoinverse (standard CUR)
%     U = pseudoinverse_ben_israel(W, 200, 1E-7);
CP = mp_split_quat(C);
RP = mp_split_quat(R);
    U=CP*A*RP;

end
