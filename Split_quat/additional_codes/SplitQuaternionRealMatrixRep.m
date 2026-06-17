classdef SplitQuaternionRealMatrixRep
    % SPLITQUATERNIONREALMATRIXREP Real 4x4 matrix representation of split quaternions
    %   This class represents split quaternions as real 4x4 matrices.
    %   A split quaternion q = a + bi + cj + dk is represented as:
    %   
    %   M(q) = a*I + b*M_i + c*M_j + d*M_k
    %   
    %   where:
    %   M_i = [0 -1  0  0;
    %          1  0  0  0;
    %          0  0  0  1;
    %          0  0 -1  0]
    %   
    %   M_j = [0  0  1  0;
    %          0  0  0  1;
    %          1  0  0  0;
    %          0 -1  0  0]
    %   
    %   M_k = [0  0  0  1;
    %          0  0  1  0;
    %          0 -1  0  0;
    %         -1  0  0  0]
    
    properties
        matrix double   % 4x4 real matrix
    end
    
    properties (Constant)
        % Basis matrices
        I = eye(4);
        
        Mi = [0 -1  0  0;
              1  0  0  0;
              0  0  0  1;
              0  0 -1  0];
        
        Mj = [0  0  1  0;
              0  0  0  1;
              1  0  0  0;
              0 1  0  0];
        
        Mk = [0  0  0  -1;
              0  0  1  0;
              0 1  0  0;
             -1  0  0  0];
    end
    
    methods
        %% Constructor from split quaternion components
        function obj = SplitQuaternionRealMatrixRep(a, b, c, d)
            if nargin == 1 && isa(a, 'SplitQuaternion')
                % Construct from SplitQuaternion object
                q = a;
                obj.matrix = q.a * obj.I + q.b * obj.Mi + q.c * obj.Mj + q.d * obj.Mk;
            elseif nargin == 1 && isequal(size(a), [4, 4])
                % Construct directly from 4x4 matrix
                obj.matrix = a;
            elseif nargin == 4
                % Construct from components
                obj.matrix = a * obj.I + b * obj.Mi + c * obj.Mj + d * obj.Mk;
            else
                error('Invalid input arguments');
            end
        end
        
        %% Get split quaternion components from matrix
        function [a, b, c, d] = getComponents(obj)
            a = 0.25 * trace(obj.matrix);
            b = 0.25 * trace(obj.matrix * obj.Mi');
            c = 0.25 * trace(obj.matrix * obj.Mj');
            d = 0.25 * trace(obj.matrix * obj.Mk');
        end
        
        %% Convert back to SplitQuaternion
        function q = toSplitQuaternion(obj)
            [a, b, c, d] = obj.getComponents();
            q = SplitQuaternion(a, b, c, d);
        end
        
        %% Display
        function disp(obj)
            fprintf('Real 4x4 Matrix Representation:\n');
            disp(obj.matrix);
            [a, b, c, d] = obj.getComponents();
            fprintf('Corresponding split quaternion: %g + %gi + %gj + %gk\n', a, b, c, d);
        end
        
        %% Matrix multiplication
        function R = mtimes(left, right)
            if isa(left, 'SplitQuaternionRealMatrixRep') && ...
               isa(right, 'SplitQuaternionRealMatrixRep')
                % Matrix multiplication
                R = SplitQuaternionRealMatrixRep(left.matrix * right.matrix);
            elseif isa(left, 'SplitQuaternionRealMatrixRep') && isnumeric(right)
                % Matrix * scalar or matrix multiplication
                if isscalar(right)
                    R = SplitQuaternionRealMatrixRep(left.matrix * right);
                else
                    R = left.matrix * right;
                end
            elseif isnumeric(left) && isa(right, 'SplitQuaternionRealMatrixRep')
                % Scalar * matrix
                R = SplitQuaternionRealMatrixRep(left * right.matrix);
            else
                error('Invalid multiplication');
            end
        end
        
        %% Addition
        function R = plus(left, right)
            if isa(left, 'SplitQuaternionRealMatrixRep') && ...
               isa(right, 'SplitQuaternionRealMatrixRep')
                R = SplitQuaternionRealMatrixRep(left.matrix + right.matrix);
            else
                error('Both operands must be SplitQuaternionRealMatrixRep');
            end
        end
        
        %% Subtraction
        function R = minus(left, right)
            if isa(left, 'SplitQuaternionRealMatrixRep') && ...
               isa(right, 'SplitQuaternionRealMatrixRep')
                R = SplitQuaternionRealMatrixRep(left.matrix - right.matrix);
            else
                error('Both operands must be SplitQuaternionRealMatrixRep');
            end
        end
        
        %% Conjugate
        function R = conj(obj)
            % For split quaternions, conjugate corresponds to:
            % M(q*) = M(q)^T with appropriate sign changes
            R = SplitQuaternionRealMatrixRep(obj.toSplitQuaternion().conj());
        end
        
        %% Norm (indefinite)
        function n = norm(obj)
            q = obj.toSplitQuaternion();
            n = q.norm();
        end
        
        %% Check if matrix representation is correct
        function isValid = verifyRepresentation(obj)
            q = obj.toSplitQuaternion();
            q_reconstructed = SplitQuaternionRealMatrixRep(q);
            isValid = norm(obj.matrix - q_reconstructed.matrix, 'fro') < 1e-10;
        end
    end
    
    methods (Static)
        %% Generate basis matrices
        function showBasisMatrices()
            fprintf('Basis matrices for real 4x4 representation:\n\n');
            fprintf('M_i (i basis):\n');
            disp(SplitQuaternionRealMatrixRep.Mi);
            fprintf('M_j (j basis):\n');
            disp(SplitQuaternionRealMatrixRep.Mj);
            fprintf('M_k (k basis):\n');
            disp(SplitQuaternionRealMatrixRep.Mk);
        end
        
        %% Test algebra isomorphism
        function testAlgebra()
            fprintf('Testing split quaternion algebra in real 4x4 representation:\n\n');
            
            % Test basis multiplication rules
            Mi = SplitQuaternionRealMatrixRep.Mi;
            Mj = SplitQuaternionRealMatrixRep.Mj;
            Mk = SplitQuaternionRealMatrixRep.Mk;
            
            fprintf('Mi^2 = -I:\n');
            disp(Mi^2 + eye(4));
            fprintf('Norm: %g\n\n', norm(Mi^2 + eye(4), 'fro'));
            
            fprintf('Mj^2 = I:\n');
            disp(Mj^2 - eye(4));
            fprintf('Norm: %g\n\n', norm(Mj^2 - eye(4), 'fro'));
            
            fprintf('Mk^2 = I:\n');
            disp(Mk^2 - eye(4));
            fprintf('Norm: %g\n\n', norm(Mk^2 - eye(4), 'fro'));
            
            fprintf('Mi*Mj = Mk:\n');
            disp(Mi*Mj - Mk);
            fprintf('Norm: %g\n\n', norm(Mi*Mj - Mk, 'fro'));
            
            fprintf('Mj*Mi = -Mk:\n');
            disp(Mj*Mi + Mk);
            fprintf('Norm: %g\n\n', norm(Mj*Mi + Mk, 'fro'));
        end
    end
end