classdef SplitQuaternionMatrixRep
    % SPLITQUATERNIONMATRIXREP Unified interface for matrix representations
    %   This class provides a unified interface for both real and complex
    %   matrix representations of split quaternions.
    
    methods (Static)
        %% Convert SplitQuaternion to real 4x4 matrix
        function M_real = toRealMatrix(q)
            if isa(q, 'SplitQuaternion')
                M_real = SplitQuaternionRealMatrixRep(q);
            else
                error('Input must be a SplitQuaternion');
            end
        end
        
        %% Convert SplitQuaternion to complex 2x2 matrix
        function M_complex = toComplexMatrix(q)
            if isa(q, 'SplitQuaternion')
                M_complex = SplitQuaternionComplexMatrixRep(q);
            else
                error('Input must be a SplitQuaternion');
            end
        end
        
        %% Convert real 4x4 matrix back to SplitQuaternion
        function q = fromRealMatrix(M)
            if isa(M, 'SplitQuaternionRealMatrixRep')
                q = M.toSplitQuaternion();
            elseif isnumeric(M) && isequal(size(M), [4, 4])
                temp = SplitQuaternionRealMatrixRep(M);
                q = temp.toSplitQuaternion();
            else
                error('Input must be a 4x4 real matrix or SplitQuaternionRealMatrixRep');
            end
        end
        
        %% Convert complex 2x2 matrix back to SplitQuaternion
        function q = fromComplexMatrix(M)
            if isa(M, 'SplitQuaternionComplexMatrixRep')
                q = M.toSplitQuaternion();
            elseif isnumeric(M) && isequal(size(M), [2, 2])
                temp = SplitQuaternionComplexMatrixRep(M);
                q = temp.toSplitQuaternion();
            else
                error('Input must be a 2x2 complex matrix or SplitQuaternionComplexMatrixRep');
            end
        end
        
        %% Verify isomorphism between representations
        function verifyIsomorphism(q)
            fprintf('Verifying isomorphism for split quaternion:\n');
            disp(q);
            
            % Convert to both representations
            M_real = SplitQuaternionMatrixRep.toRealMatrix(q);
            M_complex = SplitQuaternionMatrixRep.toComplexMatrix(q);
            
            fprintf('\nReal 4x4 representation:\n');
            disp(M_real.matrix);
            
            fprintf('\nComplex 2x2 representation:\n');
            disp(M_complex.matrix);
            
            % Convert back
            q_from_real = M_real.toSplitQuaternion();
            q_from_complex = M_complex.toSplitQuaternion();
            
            fprintf('\nReconstructed from real matrix: ');
            fprintf('%g + %gi + %gj + %gk\n', q_from_real.a, q_from_real.b, ...
                    q_from_real.c, q_from_real.d);
            
            fprintf('Reconstructed from complex matrix: ');
            fprintf('%g + %gi + %gj + %gk\n', q_from_complex.a, q_from_complex.b, ...
                    q_from_complex.c, q_from_complex.d);
            
            % Check if they match
            error_real = norm([q.a - q_from_real.a, q.b - q_from_real.b, ...
                               q.c - q_from_real.c, q.d - q_from_real.d]);
            error_complex = norm([q.a - q_from_complex.a, q.b - q_from_complex.b, ...
                                  q.c - q_from_complex.c, q.d - q_from_complex.d]);
            
            fprintf('\nReconstruction errors:\n');
            fprintf('  From real matrix: %g\n', error_real);
            fprintf('  From complex matrix: %g\n', error_complex);
            
            if error_real < 1e-10 && error_complex < 1e-10
                fprintf('\n✓ Isomorphism verified successfully!\n');
            else
                fprintf('\n✗ Isomorphism verification failed!\n');
            end
        end
        
        %% Test multiplication preservation
        function testMultiplicationPreservation(q1, q2)
            fprintf('Testing multiplication preservation:\n');
            fprintf('q1 = '); fprintf('%g + %gi + %gj + %gk\n', q1.a, q1.b, q1.c, q1.d);
            fprintf('q2 = '); fprintf('%g + %gi + %gj + %gk\n', q2.a, q2.b, q2.c, q2.d);
            
            % Direct multiplication
            q_product_direct = q1 * q2;
            fprintf('\nDirect product: ');
            fprintf('%g + %gi + %gj + %gk\n', q_product_direct.a, q_product_direct.b, ...
                    q_product_direct.c, q_product_direct.d);
            
            % Multiplication via real matrix representation
            M1_real = SplitQuaternionMatrixRep.toRealMatrix(q1);
            M2_real = SplitQuaternionMatrixRep.toRealMatrix(q2);
            M_product_real = M1_real * M2_real;
            q_from_real = M_product_real.toSplitQuaternion();
            fprintf('Via real matrix: ');
            fprintf('%g + %gi + %gj + %gk\n', q_from_real.a, q_from_real.b, ...
                    q_from_real.c, q_from_real.d);
            
            % Multiplication via complex matrix representation
            M1_complex = SplitQuaternionMatrixRep.toComplexMatrix(q1);
            M2_complex = SplitQuaternionMatrixRep.toComplexMatrix(q2);
            M_product_complex = M1_complex * M2_complex;
            q_from_complex = M_product_complex.toSplitQuaternion();
            fprintf('Via complex matrix: ');
            fprintf('%g + %gi + %gj + %gk\n', q_from_complex.a, q_from_complex.b, ...
                    q_from_complex.c, q_from_complex.d);
            
            % Check errors
            error_real = norm([q_product_direct.a - q_from_real.a, ...
                               q_product_direct.b - q_from_real.b, ...
                               q_product_direct.c - q_from_real.c, ...
                               q_product_direct.d - q_from_real.d]);
            error_complex = norm([q_product_direct.a - q_from_complex.a, ...
                                  q_product_direct.b - q_from_complex.b, ...
                                  q_product_direct.c - q_from_complex.c, ...
                                  q_product_direct.d - q_from_complex.d]);
            
            fprintf('\nMultiplication errors:\n');
            fprintf('  Real matrix representation: %g\n', error_real);
            fprintf('  Complex matrix representation: %g\n', error_complex);
            
            if error_real < 1e-10 && error_complex < 1e-10
                fprintf('\n✓ Multiplication preserved in both representations!\n');
            else
                fprintf('\n✗ Multiplication preservation failed!\n');
            end
        end
    end
end