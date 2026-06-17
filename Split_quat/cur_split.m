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
%       error - Frobenius norm error ||A - C*U*R||_F

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
    % Alternative method: More stable for ill-conditioned matrices
    % [U_W, S_W, V_W] = svd(W, 'econ');
    % S_W_inv = diag(1 ./ diag(S_W(1:k, 1:k)));
    % U = V_W(:, 1:k) * S_W_inv * U_W(:, 1:k)';
    
    % Step 4: Compute approximation and error
    %approx = C * U * R;
%    error = norm(A - approx, 'fro')
    
    % Display results
%     fprintf('CUR Decomposition Results:\n');
%     fprintf('Original matrix size: %d x %d\n', m, n);
%     fprintf('Selected columns: %d, Selected rows: %d\n', c, r);
%     fprintf('Target rank: %d\n', k);
%     fprintf('Approximation error (Frobenius norm): %.4f\n', error);
%     fprintf('Relative error: %.4f\n', error / norm(A, 'fro'));
end