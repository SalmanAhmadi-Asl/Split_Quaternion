classdef SplitQuaternionMatrix
    properties
        A double
        B double
        C double
        D double
    end

    methods
        %% Constructor
        function obj = SplitQuaternionMatrix(A,B,C,D)
            if nargin == 0
                obj.A = [];
                obj.B = [];
                obj.C = [];
                obj.D = [];
                return;
            end
            obj.A = A;
            obj.B = B;
            obj.C = C;
            obj.D = D;
        end

        %% Size
        function s = size(Q,varargin)
            s = size(Q.A,varargin{:});
        end

        %% Display
        function disp(Q)
            fprintf('Split Quaternion Matrix:\n');
            fprintf('Real part:\n');
            disp(Q.A);
            fprintf('Imaginary part:\n');
            disp(Q.B);
            disp(Q.C);
            disp(Q.D);
        end

        %% Addition
%         function R = plus(Q,P)
%             R = SplitQuaternionMatrix( ...
%                 Q.A+P.A, Q.B+P.B, Q.C+P.C, Q.D+P.D);
%         end
        function R = plus(Q,P)
            % Handle: SplitQuaternionMatrix + SplitQuaternionMatrix
            %         SplitQuaternionMatrix + scalar
            %         scalar + SplitQuaternionMatrix
            if isa(Q, 'SplitQuaternionMatrix') && isa(P, 'SplitQuaternionMatrix')
                R = SplitQuaternionMatrix( ...
                    Q.A+P.A, Q.B+P.B, Q.C+P.C, Q.D+P.D);
            elseif isa(Q, 'SplitQuaternionMatrix') && isnumeric(P) 
                % Add scalar to real part only
                R = SplitQuaternionMatrix(Q.A+P, Q.B, Q.C, Q.D);
            elseif  isscalar(Q) && isa(P, 'SplitQuaternionMatrix')
                R = SplitQuaternionMatrix(Q+P.A, P.B, P.C, P.D);
            else
                error('Invalid addition for SplitQuaternionMatrix');
            end
        end
        %% Unary minus
        function R = uminus(Q)
            R = SplitQuaternionMatrix(-Q.A, -Q.B, -Q.C, -Q.D);
        end
        
        %% Unary plus
        function R = uplus(Q)
            R = Q;
        end
        %% Subtraction
%         function R = minus(Q,P)
%             R = SplitQuaternionMatrix( ...
%                 Q.A-P.A, Q.B-P.B, Q.C-P.C, Q.D-P.D);
%         end
        function R = minus(Q,P)
            % Handle: SplitQuaternionMatrix - SplitQuaternionMatrix
            %         SplitQuaternionMatrix - scalar
            %         scalar - SplitQuaternionMatrix
            if isa(Q, 'SplitQuaternionMatrix') && isa(P, 'SplitQuaternionMatrix')
                R = SplitQuaternionMatrix( ...
                    Q.A-P.A, Q.B-P.B, Q.C-P.C, Q.D-P.D);
            elseif isa(Q, 'SplitQuaternionMatrix') && isnumeric(P) 
                % Subtract scalar from real part only
                R = SplitQuaternionMatrix(Q.A-P, Q.B, Q.C, Q.D);
            elseif isnumeric(Q) &&  isa(P, 'SplitQuaternionMatrix')
                % scalar - SplitQuaternionMatrix
                R = SplitQuaternionMatrix(Q-P.A, -P.B, -P.C, -P.D);
            else
                error('Invalid subtraction for SplitQuaternionMatrix');
            end
        end
        %% Conjugate
        function r = conj(Q)
            r = SplitQuaternionMatrix(Q.A.', -Q.B.', -Q.C.', -Q.D.');
        end
                %% ConjugateI
        function r = conj_i(Q)
            r = SplitQuaternionMatrix(Q.A.', -Q.B.', Q.C.', Q.D.');
        end
                        %% Conjugatej
        function r = conj_j(Q)
            r = SplitQuaternionMatrix(Q.A.', Q.B.', -Q.C.', Q.D.');
        end
                        %% Conjugatek
        function r = conj_k(Q)
            r = SplitQuaternionMatrix(Q.A.', Q.B.', Q.C.', -Q.D.');
        end
        %% Transpose
        function R = transpose(Q)
            R = SplitQuaternionMatrix( ...
                Q.A.', Q.B.', Q.C.', Q.D.');
        end

        %% Conjugate transpose
        function R = ctranspose(Q)
            R = SplitQuaternionMatrix( ...
                Q.A.', -Q.B.', -Q.C.', -Q.D.');
        end

        %% Check if empty
        function tf = isempty(Q)
            tf = isempty(Q.A);
        end
        
        %% Check dimensions equality
        function tf = eq(Q, P)
            % Check if two split quaternion matrices have equal components
            if isa(Q, 'SplitQuaternionMatrix') && isa(P, 'SplitQuaternionMatrix')
                tf = isequal(Q.A, P.A) && isequal(Q.B, P.B) && ...
                     isequal(Q.C, P.C) && isequal(Q.D, P.D);
            else
                tf = false;
            end
        end
        
        %% Check dimensions not equal
        function tf = ne(Q, P)
            tf = ~eq(Q, P);
        end

              %% Check if pure (zero real part)
        function tf = isPure(Q)
            tf = all(Q.A(:) == 0);
        end
        
        %% Check if real (zero imaginary parts)
        function tf = isReal(Q)
            tf = all(Q.B(:) == 0) && all(Q.C(:) == 0) && all(Q.D(:) == 0);
        end
                %% Number of elements
        function n = numel(Q)
            n = numel(Q.A);
        end
        
        %% Length (largest dimension)
        function l = length(Q)
            l = max(size(Q));
        end
                %% End indexing
        function e = end(Q, k, n)
            % Support for end indexing in arrays
            s = size(Q);
            if k < n
                e = s(k);
            else
                e = prod(s(k:end));
            end
        end
        
        %% Subscripted reference (get elements)
        function varargout = subsref(Q, S)
            % Enable indexing like Q(i,j)
            switch S(1).type
                case '()'
                    % Matrix indexing
                    indices = S(1).subs;
                    A = Q.A(indices{:});
                    B = Q.B(indices{:});
                    C = Q.C(indices{:});
                    D = Q.D(indices{:});
                    
                    % If result is scalar, return SplitQuaternion
                    if isscalar(A)
                        varargout{1} = SplitQuaternion(A, B, C, D);
                    else
                        varargout{1} = SplitQuaternionMatrix(A, B, C, D);
                    end
                    
                case '.'
                    % Property access
                    [varargout{1:nargout}] = builtin('subsref', Q, S);
                    
                case '{}'
                    error('Cell indexing not supported for SplitQuaternionMatrix');
            end
        end
        
        %% Subscripted assignment (set elements)
        function Q = subsasgn(Q, S, val)
            % Enable assignment like Q(i,j) = val
            switch S(1).type
                case '()'
                    indices = S(1).subs;
                    
                    if isa(val, 'SplitQuaternionMatrix')
                        Q.A(indices{:}) = val.A;
                        Q.B(indices{:}) = val.B;
                        Q.C(indices{:}) = val.C;
                        Q.D(indices{:}) = val.D;
                    elseif isa(val, 'SplitQuaternion')
                        Q.A(indices{:}) = val.a;
                        Q.B(indices{:}) = val.b;
                        Q.C(indices{:}) = val.c;
                        Q.D(indices{:}) = val.d;
                    elseif isnumeric(val) && isscalar(val)
                        Q.A(indices{:}) = val;
                        Q.B(indices{:}) = 0;
                        Q.C(indices{:}) = 0;
                        Q.D(indices{:}) = 0;
                    else
                        error('Invalid assignment to SplitQuaternionMatrix');
                    end
                    
                case '.'
                    Q = builtin('subsasgn', Q, S, val);
                    
                case '{}'
                    error('Cell indexing not supported for SplitQuaternionMatrix');
            end
        end

        %% Reshape
        function R = reshape(Q, varargin)
            R = SplitQuaternionMatrix(reshape(Q.A, varargin{:}), ...
                                     reshape(Q.B, varargin{:}), ...
                                     reshape(Q.C, varargin{:}), ...
                                     reshape(Q.D, varargin{:}));
        end
        %% Horizontal concatenation
        function R = horzcat(varargin)
            A_cat = []; B_cat = []; C_cat = []; D_cat = [];
            for i = 1:nargin
                if isa(varargin{i}, 'SplitQuaternionMatrix')
                    A_cat = [A_cat, varargin{i}.A];
                    B_cat = [B_cat, varargin{i}.B];
                    C_cat = [C_cat, varargin{i}.C];
                    D_cat = [D_cat, varargin{i}.D];
                else
                    error('All inputs must be SplitQuaternionMatrix');
                end
            end
            R = SplitQuaternionMatrix(A_cat, B_cat, C_cat, D_cat);
        end      
        %% Vertical concatenation
        function R = vertcat(varargin)
            A_cat = []; B_cat = []; C_cat = []; D_cat = [];
            for i = 1:nargin
                if isa(varargin{i}, 'SplitQuaternionMatrix')
                    A_cat = [A_cat; varargin{i}.A];
                    B_cat = [B_cat; varargin{i}.B];
                    C_cat = [C_cat; varargin{i}.C];
                    D_cat = [D_cat; varargin{i}.D];
                else
                    error('All inputs must be SplitQuaternionMatrix');
                end
            end
            R = SplitQuaternionMatrix(A_cat, B_cat, C_cat, D_cat);
        end
        
function R = mtimes(left, right)
    % Handle five cases:
    % 1. SplitQuaternionMatrix * SplitQuaternionMatrix
    % 2. scalar * SplitQuaternionMatrix
    % 3. SplitQuaternionMatrix * scalar
    % 4. numeric Matrix (real/complex) * SplitQuaternionMatrix
    % 5. SplitQuaternionMatrix * numeric Matrix (real/complex)
    
    if isa(left, 'SplitQuaternionMatrix') && isa(right, 'SplitQuaternionMatrix')
        % Case 1: SplitQuaternionMatrix * SplitQuaternionMatrix
        A = left.A * right.A - left.B * right.B + left.C * right.C + left.D * right.D;
        B = left.A * right.B + left.B * right.A - left.C * right.D + left.D * right.C;
        C = left.A * right.C + left.C * right.A - left.B * right.D + left.D * right.B;
        D = left.A * right.D + left.D * right.A + left.B * right.C - left.C * right.B;
        R = SplitQuaternionMatrix(A, B, C, D);
        
    elseif isnumeric(left) && isscalar(left) && isa(right, 'SplitQuaternionMatrix')
        % Case 2: scalar * SplitQuaternionMatrix
        R = SplitQuaternionMatrix(left * right.A, left * right.B, ...
                                  left * right.C, left * right.D);
        
    elseif isa(left, 'SplitQuaternionMatrix') && isnumeric(right) && isscalar(right)
        % Case 3: SplitQuaternionMatrix * scalar
        R = SplitQuaternionMatrix(left.A * right, left.B * right, ...
                                  left.C * right, left.D * right);
        
    elseif isnumeric(left) && ismatrix(left) && isa(right, 'SplitQuaternionMatrix')
        % Case 4: numeric Matrix * SplitQuaternionMatrix
        % left is real/complex matrix, right is SplitQuaternionMatrix
        % Multiply each component matrix separately
        A = left * right.A;
        B = left * right.B;
        C = left * right.C;
        D = left * right.D;
        R = SplitQuaternionMatrix(A, B, C, D);
        
    elseif isa(left, 'SplitQuaternionMatrix') && isnumeric(right) && ismatrix(right)
        % Case 5: SplitQuaternionMatrix * numeric Matrix
        % left is SplitQuaternionMatrix, right is real/complex matrix
        % Multiply each component matrix separately
        A = left.A * right;
        B = left.B * right;
        C = left.C * right;
        D = left.D * right;
        R = SplitQuaternionMatrix(A, B, C, D);
        
    else
        error('Invalid multiplication for SplitQuaternionMatrix');
    end
end
        %% Element-wise multiplication (also needs fixing)
        function R = times(left, right)
            % Handle element-wise multiplication
            
            if isa(left, 'SplitQuaternionMatrix') && isa(right, 'SplitQuaternionMatrix')
                % Element-wise split quaternion multiplication
                A = left.A .* right.A - left.B .* right.B + left.C .* right.C + left.D .* right.D;
                B = left.A .* right.B + left.B .* right.A - left.C .* right.D + left.D .* right.C;
                C = left.A .* right.C + left.C .* right.A - left.B .* right.D + left.D .* right.B;
                D = left.A .* right.D + left.D .* right.A + left.B .* right.C - left.C .* right.B;
                R = SplitQuaternionMatrix(A, B, C, D);
                
            elseif isnumeric(left) && isscalar(left) && isa(right, 'SplitQuaternionMatrix')
                % scalar .* SplitQuaternionMatrix
                R = SplitQuaternionMatrix(left .* right.A, left .* right.B, ...
                                          left .* right.C, left .* right.D);
                
            elseif isa(left, 'SplitQuaternionMatrix') && isnumeric(right) && isscalar(right)
                % SplitQuaternionMatrix .* scalar
                R = SplitQuaternionMatrix(left.A .* right, left.B .* right, ...
                                          left.C .* right, left.D .* right);
            else
                error('Invalid element-wise multiplication for SplitQuaternionMatrix');
            end
        end

                %% Scalar division (right divide)
        function R = mrdivide(Q, s)
            % SplitQuaternionMatrix / scalar
            if isnumeric(s) && isscalar(s)
                R = SplitQuaternionMatrix(Q.A/s, Q.B/s, Q.C/s, Q.D/s);
            else
                error('Invalid division for SplitQuaternionMatrix');
            end
        end
        
        %% Scalar division (left divide)
        function R = mldivide(s, Q)
            % scalar \ SplitQuaternionMatrix
            if isnumeric(s) && isscalar(s)
                R = SplitQuaternionMatrix(Q.A/s, Q.B/s, Q.C/s, Q.D/s);
            else
                error('Invalid division for SplitQuaternionMatrix');
            end
        end
         %% Element-wise power
        function R = power(Q, p)
            % SplitQuaternionMatrix .^ scalar (element-wise)
            if isnumeric(p) && isscalar(p)
                % For integer powers, multiply repeatedly
                if p == 0
                    % Identity element
                    R = SplitQuaternionMatrix(ones(size(Q.A)), ...
                                             zeros(size(Q.B)), ...
                                             zeros(size(Q.C)), ...
                                             zeros(size(Q.D)));
                elseif p == 1
                    R = Q;
                elseif p > 1 && p == floor(p)
                    % Positive integer power
                    R = Q;
                    for i = 2:p
                        R = R .* Q;
                    end
                else
                    % For non-integer powers, use component-wise power
                    R = SplitQuaternionMatrix(Q.A.^p, Q.B.^p, Q.C.^p, Q.D.^p);
                end
            else
                error('Power must be a scalar');
            end
        end
         %% Trace
        function t = trace(Q)
            % Trace of split quaternion matrix
            t = SplitQuaternion(trace(Q.A), trace(Q.B), trace(Q.C), trace(Q.D));
        end
        
        %% Sum of elements
        function s = sum(Q, dim)
            % Sum along dimension dim (default: all elements)
            if nargin < 2
                % Sum all elements
                s = SplitQuaternion(sum(Q.A(:)), sum(Q.B(:)), sum(Q.C(:)), sum(Q.D(:)));
            else
                % Sum along specified dimension
                s = SplitQuaternionMatrix(sum(Q.A, dim), sum(Q.B, dim), ...
                                         sum(Q.C, dim), sum(Q.D, dim));
            end
        end
        
        %% Mean of elements
        function m = mean(Q, dim)
            % Mean along dimension dim (default: all elements)
            if nargin < 2
                n = numel(Q);
                m = SplitQuaternion(sum(Q.A(:))/n, sum(Q.B(:))/n, ...
                                   sum(Q.C(:))/n, sum(Q.D(:))/n);
            else
                n = size(Q, dim);
                m = SplitQuaternionMatrix(mean(Q.A, dim), mean(Q.B, dim), ...
                                         mean(Q.C, dim), mean(Q.D, dim));
            end
        end
                %% Alternative: Split Quaternion Indefinite Norm (matrix Frobenius style)
         function n = norm(Q)
            % SPLITFROBENIUSNORM Returns the Frobenius-style norm using split quaternion conjugate
            %   n = sqrt(|sum over all elements: (A^2 + B^2 - C^2 - D^2)|)
            
            indefinite_norms = Q.A(:).^2 + Q.B(:).^2 - Q.C(:).^2 - Q.D(:).^2;
            n = sqrt(abs(sum(indefinite_norms)));
         end

                 %% Get real part (scalar part)
        function realPart = real(Q)
            % Returns the real part (A component) as a numeric matrix
            realPart = Q.A;
        end
        
        %% Get imaginary parts
        function imagPart = imag(Q)
            % Returns the imaginary parts as a cell array
            % {B, C, D} or optionally combine them if desired
            imagPart = {Q.B, Q.C, Q.D};
        end

                        %% Get specific imaginary parts
        function part = imagi(Q, i)
            % Get specific imaginary part: i=1 for B, i=2 for C, i=3 for D
            switch i
                case 1
                    part = Q.B;
                case 2
                    part = Q.C;
                case 3
                    part = Q.D;
                otherwise
                    error('Invalid imaginary part index. Use 1, 2, or 3.');
            end
        end

                %% Get all components as separate outputs
        function [A, B, C, D] = parts(Q)
            % Returns all four components as separate outputs
            A = Q.A;
            B = Q.B;
            C = Q.C;
            D = Q.D;
        end
        
        %% Get all components in a structure
        function comp = components(Q)
            % Returns all components in a structure
            comp.A = Q.A;
            comp.B = Q.B;
            comp.C = Q.C;
            comp.D = Q.D;
        end
        %% Convert to full numeric matrix (2x2 block representation)
        function mat = full(Q)
            [m, n] = size(Q);
            mat = zeros(2*m, 2*n);
            mat(1:m, 1:n) = Q.A;
            mat(1:m, n+1:2*n) = Q.B;
            mat(m+1:2*m, 1:n) = Q.C;
            mat(m+1:2*m, n+1:2*n) = Q.D;
        end
        
        %% Convert to real matrix representation
        function mat = realMatrix(Q)
            mat = [Q.A, Q.B; Q.C, Q.D];
        end
                %% Convert to real matrix representation
        function mat = full_(Q)
            mat = [Q.A, Q.B; Q.C, Q.D];
        end
        
        %% Convert to cell array
        function C = toCell(Q)
            C = {Q.A, Q.B, Q.C, Q.D};
        end
        
        %% Extract diagonal
        function d = diag(Q)
            % Extract diagonal as a split quaternion matrix
            d = SplitQuaternionMatrix(diag(Q.A), diag(Q.B), diag(Q.C), diag(Q.D));
        end
    end

    %% Static methods
    methods (Static)
        function Q = zeros(m, n)
            % Create zero split quaternion matrix
            if nargin < 1
                m = 1; n = 1;
            elseif nargin == 1
                n = m;
            end
            Q = SplitQuaternionMatrix(zeros(m,n), zeros(m,n), zeros(m,n), zeros(m,n));
        end
        
        function Q = ones(m, n)
            % Create split quaternion matrix with ones in real part
            if nargin < 1
                m = 1; n = 1;
            elseif nargin == 1
                n = m;
            end
            Q = SplitQuaternionMatrix(ones(m,n), zeros(m,n), zeros(m,n), zeros(m,n));
        end
        
        function Q = eye(n)
            % Identity split quaternion matrix
            Q = SplitQuaternionMatrix(eye(n), zeros(n), zeros(n), zeros(n));
        end
        
        function Q = rand(m, n)
            % Random split quaternion matrix
            if nargin < 1
                m = 1; n = 1;
            elseif nargin == 1
                n = m;
            end
            Q = SplitQuaternionMatrix(rand(m,n), rand(m,n), rand(m,n), rand(m,n));
        end
        
        function Q = fromReal(A)
            % Create from real matrix (imaginary parts zero)
            Q = SplitQuaternionMatrix(A, zeros(size(A)), zeros(size(A)), zeros(size(A)));
        end
        
        function Q = fromComplex(z)
            % Create from complex matrix (z = A + iB, C=D=0)
            Q = SplitQuaternionMatrix(real(z), imag(z), zeros(size(z)), zeros(size(z)));
        end
    end
    
end
