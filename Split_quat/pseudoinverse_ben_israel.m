function X = pseudoinverse_ben_israel(A, max_iter, tol)
    % Ben-Israel iterative algorithm for Moore-Penrose pseudoinverse
    % Based on: X_{k+1} = X_k * (2I - A*X_k)
    % A: Input matrix (m x n)
    % max_iter: Maximum number of iterations (default: 100)
    % tol: Tolerance for convergence (default: 1e-10)
    % X: Pseudoinverse of A
    
    if nargin < 2
        max_iter = 100;
    end
    if nargin < 3
        tol = 1e-10;
    end
    
   % [m, n] = size(A);
    
    % Initialize with X0 = A'
    X =0.0001*conj_i(A);
    
    % Compute scaling factor
    %normA = norm(A, 2);
    
    for iter = 1:max_iter
        X_old = X;
        
        % Ben-Israel iteration
        AX = A * X;
        I = eye(size(AX));
        X = X * (2*I - AX);
        
    end
    
    if iter == max_iter
        fprintf('Warning: Maximum iterations (%d) reached\n', max_iter);
    end
end
