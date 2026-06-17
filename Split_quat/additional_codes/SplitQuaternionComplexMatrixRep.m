classdef SplitQuaternionComplexMatrixRep
    % SPLITQUATERNIONCOMPLEXMATRIXREP Complex 2x2 matrix representation of split quaternions
    %   This class represents split quaternions as complex 2x2 matrices.
    %   A split quaternion q = a + bi + cj + dk is represented as:
    %   
    %   M(q) = [a + bi, c + di;
    %           c - di, a - bi]
    %   
    %   This is equivalent to:
    %   M(q) = a*I + b*i*σ_z + c*σ_x + d*i*σ_y
    %   where σ_x, σ_y, σ_z are Pauli matrices.
    
    properties
        matrix double   % 2x2 complex matrix
    end
    
    methods
        %% Constructor from split quaternion components
        function obj = SplitQuaternionComplexMatrixRep(a, b, c, d)
            if nargin == 1 && isa(a, 'SplitQuaternion')
                % Construct from SplitQuaternion object
                q = a;
                obj.matrix = [q.a + 1i*q.b, q.c + 1i*q.d;
                             q.c - 1i*q.d, q.a - 1i*q.b];
            elseif nargin == 1 && isequal(size(a), [2, 2])
                % Construct directly from 2x2 complex matrix
                obj.matrix = a;
            elseif nargin == 4
                % Construct from components
                obj.matrix = [a + 1i*b, c + 1i*d;
                             c - 1i*d, a - 1i*b];
            else
                error('Invalid input arguments');
            end
        end
        
        %% Get split quaternion components from matrix
        function [a, b, c, d] = getComponents(obj)
            a = 0.5 * real(obj.matrix(1,1) + obj.matrix(2,2));
            b = 0.5 * imag(obj.matrix(1,1) - obj.matrix(2,2));
            c = 0.5 * real(obj.matrix(1,2) + obj.matrix(2,1));
            d = 0.5 * imag(obj.matrix(1,2) - obj.matrix(2,1));
        end
        
        %% Convert back to SplitQuaternion
        function q = toSplitQuaternion(obj)
            [a, b, c, d] = obj.getComponents();
            q = SplitQuaternion(a, b, c, d);
        end
        
        %% Display
        function disp(obj)
            fprintf('Complex 2x2 Matrix Representation:\n');
            disp(obj.matrix);
            [a, b, c, d] = obj.getComponents();
            fprintf('Corresponding split quaternion: %g + %gi + %gj + %gk\n', a, b, c, d);
        end
        
        %% Matrix multiplication
        function R = mtimes(left, right)
            if isa(left, 'SplitQuaternionComplexMatrixRep') && ...
               isa(right, 'SplitQuaternionComplexMatrixRep')
                % Matrix multiplication
                R = SplitQuaternionComplexMatrixRep(left.matrix * right.matrix);
            elseif isa(left, 'SplitQuaternionComplexMatrixRep') && isnumeric(right)
                % Matrix * scalar or matrix multiplication
                if isscalar(right)
                    R = SplitQuaternionComplexMatrixRep(left.matrix * right);
                else
                    R = left.matrix * right;
                end
            elseif isnumeric(left) && isa(right, 'SplitQuaternionComplexMatrixRep')
                % Scalar * matrix
                R = SplitQuaternionComplexMatrixRep(left * right.matrix);
            else
                error('Invalid multiplication');
            end
        end
        
        %% Addition
        function R = plus(left, right)
            if isa(left, 'SplitQuaternionComplexMatrixRep') && ...
               isa(right, 'SplitQuaternionComplexMatrixRep')
                R = SplitQuaternionComplexMatrixRep(left.matrix + right.matrix);
            else
                error('Both operands must be SplitQuaternionComplexMatrixRep');
            end
        end
        
        %% Subtraction
        function R = minus(left, right)
            if isa(left, 'SplitQuaternionComplexMatrixRep') && ...
               isa(right, 'SplitQuaternionComplexMatrixRep')
                R = SplitQuaternionComplexMatrixRep(left.matrix - right.matrix);
            else
                error('Both operands must be SplitQuaternionComplexMatrixRep');
            end
        end
        
        %% Conjugate
        function R = conj(obj)
            % In complex representation, conjugate is Hermitian transpose
            q = obj.toSplitQuaternion();
            q_conj = q.conj();
            R = SplitQuaternionComplexMatrixRep(q_conj);
        end
        
        %% Norm (indefinite)
        function n = norm(obj)
            q = obj.toSplitQuaternion();
            n = q.norm();
        end
        
        %% Determinant (should equal the norm)
        function detVal = det(obj)
            detVal = det(obj.matrix);
        end
        
        %% Check if matrix representation is correct
        function isValid = verifyRepresentation(obj)
            q = obj.toSplitQuaternion();
            q_reconstructed = SplitQuaternionComplexMatrixRep(q);
            isValid = norm(obj.matrix - q_reconstructed.matrix, 'fro') < 1e-10;
        end
    end
    
    methods (Static)
        %% Generate Pauli matrices with split quaternion structure
        function showPauliRepresentation()
            fprintf('Pauli matrix representation for split quaternions:\n\n');
            
            % Pauli matrices
            sigma_x = [0 1; 1 0];
            sigma_y = [0 -1i; 1i 0];
            sigma_z = [1 0; 0 -1];
            
            fprintf('i basis (i*σ_z):\n');
            disp(1i * sigma_z);
            
            fprintf('j basis (σ_x):\n');
            disp(sigma_x);
            
            fprintf('k basis (i*σ_y):\n');
            disp(1i * sigma_y);
        end
        
        %% Test algebra isomorphism
        function testAlgebra()
            fprintf('Testing split quaternion algebra in complex 2x2 representation:\n\n');
            
            % Create basis elements
            i_rep = SplitQuaternionComplexMatrixRep(0, 1, 0, 0);
            j_rep = SplitQuaternionComplexMatrixRep(0, 0, 1, 0);
            k_rep = SplitQuaternionComplexMatrixRep(0, 0, 0, 1);
            
            fprintf('i^2 = -1:\n');
            i_sq = i_rep * i_rep;
            [a, b, c, d] = i_sq.getComponents();
            fprintf('Result: %g + %gi + %gj + %gk (Expected: -1 + 0i + 0j + 0k)\n\n', a, b, c, d);
            
            fprintf('j^2 = 1:\n');
            j_sq = j_rep * j_rep;
            [a, b, c, d] = j_sq.getComponents();
            fprintf('Result: %g + %gi + %gj + %gk (Expected: 1 + 0i + 0j + 0k)\n\n', a, b, c, d);
            
            fprintf('k^2 = 1:\n');
            k_sq = k_rep * k_rep;
            [a, b, c, d] = k_sq.getComponents();
            fprintf('Result: %g + %gi + %gj + %gk (Expected: 1 + 0i + 0j + 0k)\n\n', a, b, c, d);
            
            fprintf('i*j = k:\n');
            ij = i_rep * j_rep;
            [a, b, c, d] = ij.getComponents();
            fprintf('Result: %g + %gi + %gj + %gk (Expected: 0 + 0i + 0j + 1k)\n\n', a, b, c, d);
            
            fprintf('j*i = -k:\n');
            ji = j_rep * i_rep;
            [a, b, c, d] = ji.getComponents();
            fprintf('Result: %g + %gi + %gj + %gk (Expected: 0 + 0i + 0j - 1k)\n\n', a, b, c, d);
        end
    end
end