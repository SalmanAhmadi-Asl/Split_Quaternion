classdef SplitQuaternion
    properties
        a double = 0
        b double = 0
        c double = 0
        d double = 0
    end

    methods
        %% Constructor
        function obj = SplitQuaternion(a,b,c,d)
            if nargin == 0
                return;
            end
            obj.a = a;
            obj.b = b;
            obj.c = c;
            obj.d = d;
        end

        %% Display
        function disp(q)
            fprintf('(%g) + (%gi) + (%gj) + (%gk)\n',q.a,q.b,q.c,q.d);
        end

        %% Addition
%         function r = plus(p,q)
%             r = SplitQuaternion( ...
%                 p.a+q.a, p.b+q.b, p.c+q.c, p.d+q.d);
%         end
%% Addition
function r = plus(p,q)
    % Handle four cases:
    % 1. SplitQuaternion + SplitQuaternion
    % 2. SplitQuaternion + scalar
    % 3. scalar + SplitQuaternion
    % 4. scalar + scalar (handled by MATLAB default)
    
    if isa(p, 'SplitQuaternion') && isa(q, 'SplitQuaternion')
        % Case 1: SplitQuaternion + SplitQuaternion
        r = SplitQuaternion( ...
            p.a+q.a, p.b+q.b, p.c+q.c, p.d+q.d);
        
    elseif isa(p, 'SplitQuaternion') && isnumeric(q) && isscalar(q)
        % Case 2: SplitQuaternion + scalar
        % Add scalar to real part only
        r = SplitQuaternion( ...
            p.a+q, p.b, p.c, p.d);
        
    elseif isnumeric(p) && isscalar(p) && isa(q, 'SplitQuaternion')
        % Case 3: scalar + SplitQuaternion
        % Add scalar to real part only
        r = SplitQuaternion( ...
            p+q.a, q.b, q.c, q.d);
        
    else
        % Let MATLAB handle other cases or throw error
        try
            r = builtin('plus', p, q);
        catch
            error('Invalid addition for SplitQuaternion');
        end
    end
end

        %% Subtraction
%         function r = minus(p,q)
%             r = SplitQuaternion( ...
%                 p.a-q.a, p.b-q.b, p.c-q.c, p.d-q.d);
%         end
%% Subtraction
function r = minus(p,q)
    % Handle four cases:
    % 1. SplitQuaternion - SplitQuaternion
    % 2. SplitQuaternion - scalar
    % 3. scalar - SplitQuaternion
    % 4. scalar - scalar (handled by MATLAB default)
    
    if isa(p, 'SplitQuaternion') && isa(q, 'SplitQuaternion')
        % Case 1: SplitQuaternion - SplitQuaternion
        r = SplitQuaternion( ...
            p.a-q.a, p.b-q.b, p.c-q.c, p.d-q.d);
        
    elseif isa(p, 'SplitQuaternion') && isnumeric(q) && isscalar(q)
        % Case 2: SplitQuaternion - scalar
        % Subtract scalar from real part only
        r = SplitQuaternion( ...
            p.a-q, p.b, p.c, p.d);
        
    elseif isnumeric(p) && isscalar(p) && isa(q, 'SplitQuaternion')
        % Case 3: scalar - SplitQuaternion
        % Subtract each component from scalar
        r = SplitQuaternion( ...
            p-q.a, -q.b, -q.c, -q.d);
        
    else
        % Let MATLAB handle other cases or throw error
        try
            r = builtin('minus', p, q);
        catch
            error('Invalid subtraction for SplitQuaternion');
        end
    end
end
         %% Equality
        function tf = eq(p,q)
            tf = (p.a == q.a) && (p.b == q.b) && (p.c == q.c) && (p.d == q.d);
        end
        
        %% Inequality
        function tf = ne(p,q)
            tf = ~eq(p,q);
        end
            %% Scalar division
        function R = mrdivide(q, s)
            % SplitQuaternion / scalar
            if isnumeric(s) && isscalar(s)
                R = SplitQuaternion(q.a/s, q.b/s, q.c/s, q.d/s);
            else
                error('Invalid division for SplitQuaternion');
            end
        end
        
        %% Scalar division from left
        function R = mldivide(s, q)
            % scalar \ SplitQuaternion
            if isnumeric(s) && isscalar(s)
                R = SplitQuaternion(q.a/s, q.b/s, q.c/s, q.d/s);
            else
                error('Invalid division for SplitQuaternion');
            end
        end

        %% Convert to vector
        function v = vector(q)
            % Returns the vector part [b, c, d] as a row vector
            v = [q.b, q.c, q.d];
        end
        
        %% Convert to 4D vector
        function v = toVector(q)
            % Returns the complete quaternion as a 4D vector [a, b, c, d]
            v = [q.a, q.b, q.c, q.d];
        end
        
        %% Get all parts as separate outputs
        function [a, b, c, d] = parts(q)
            % Returns all four components as separate outputs
            a = q.a;
            b = q.b;
            c = q.c;
            d = q.d;
        end
                %% Inverse
        function r = inv(q)
            % Returns the multiplicative inverse: q⁻¹ = q̅ / N(q)
            % where N(q) = a² + b² - c² - d² is the norm (indefinite)
            n = norm(q);
            if abs(n) < eps
                error('SplitQuaternion is singular (norm is zero)');
            end
            r = conj(q) / n;
        end

                %% Power
        function r = power(q, n)
            % q^n for integer n
            if ~isnumeric(n) || ~isscalar(n) || n ~= floor(n)
                error('Power must be an integer scalar');
            end
            
            if n == 0
                r = SplitQuaternion(1, 0, 0, 0); % Identity
            elseif n > 0
                r = q;
                for i = 2:n
                    r = r * q;
                end
            else % n < 0
                r = inv(q);
                q_inv = r;
                for i = 2:abs(n)
                    r = r * q_inv;
                end
            end
        end
                %% Check if pure split quaternion (zero real part)
        function tf = isPure(q)
            tf = (q.a == 0);
        end 
        %% Check if unit split quaternion (|norm| = 1)
        function tf = isUnit(q)
            tf = (abs(norm(q) - 1) < eps);
        end 
        %% Normalize to unit split quaternion
        function r = normalize(q)
            n = norm(q);
            if abs(n) < eps
                error('Cannot normalize split quaternion with zero norm');
            end
            r = q / sqrt(abs(n));
        end

                %% Dot product
        function d = dot(p, q)
            % Dot product of two split quaternions (indefinite)
            d = p.a*q.a + p.b*q.b - p.c*q.c - p.d*q.d;
        end
%%
        %% Matrix Multiplication (fixed)
        function R = mtimes(left, right)
            % Handle three cases:
            % 1. SplitQuaternionMatrix * SplitQuaternionMatrix
            % 2. scalar * SplitQuaternionMatrix
            % 3. SplitQuaternionMatrix * scalar
            
            if isa(left, 'SplitQuaternion') && isa(right, 'SplitQuaternion')
                % Case 1: SplitQuaternionMatrix * SplitQuaternionMatrix
                a = left.a * right.a - left.b * right.b + left.c * right.c + left.d * right.d;
                b = left.a * right.b + left.b * right.a - left.c * right.d + left.d * right.c;
                c = left.a * right.c + left.c * right.a - left.b * right.d + left.d * right.b;
                d = left.a * right.d + left.d * right.a + left.b * right.c - left.c * right.b;
                R = SplitQuaternion(a, b, c, d);
                
            elseif isnumeric(left) && isscalar(left) && isa(right, 'SplitQuaternion')
                % Case 2: scalar * SplitQuaternionMatrix
                R = SplitQuaternion(left * right.a, left * right.b, ...
                                          left * right.c, left * right.d);
                
            elseif isa(left, 'SplitQuaternion') && isnumeric(right) && isscalar(right)
                % Case 3: SplitQuaternionMatrix * scalar
                R = SplitQuaternion(left.a * right, left.b * right, ...
                                          left.c * right, left.d * right);
            else
                error('Invalid multiplication for SplitQuaternion');
            end
        end
        
        %% Element-wise multiplication (also needs fixing)
        function R = times(left, right)
            % Handle element-wise multiplication
            
            if isa(left, 'SplitQuaternion') && isa(right, 'SplitQuaternion')
                % Element-wise split quaternion multiplication
                a = left.a .* right.a - left.b .* right.b + left.c .* right.c + left.d .* right.d;
                b = left.a .* right.b + left.b .* right.a - left.c .* right.d + left.d .* right.c;
                c = left.a .* right.c + left.c .* right.a - left.b .* right.d + left.d .* right.b;
                d = left.a .* right.d + left.d .* right.a + left.b .* right.c - left.c .* right.b;
                R = SplitQuaternion(a, b, c, d);
                
            elseif isnumeric(left) && isscalar(left) && isa(right, 'SplitQuaternion')
                % scalar .* SplitQuaternionMatrix
                R = SplitQuaternion(left .* right.a, left .* right.b, ...
                                          left .* right.c, left .* right.d);
                
            elseif isa(left, 'SplitQuaternion') && isnumeric(right) && isscalar(right)
                % SplitQuaternionMatrix .* scalar
                R = SplitQuaternion(left.a .* right, left.b .* right, ...
                                          left.c .* right, left.d .* right);
            else
                error('Invalid element-wise multiplication for SplitQuaternion');
            end
        end
        
        %% Conjugate
        function r = conj(q)
            r = SplitQuaternion(q.a.',-q.b.',-q.c.',-q.d.');
        end
                %% Get real part (scalar part)
        function realPart = real(q)
            % Returns the real part (A component) as a numeric matrix
            realPart = q.a;
        end
        
        %% Get imaginary parts
        function imagPart = imag(q)
            % Returns the imaginary parts as a cell array
            % {B, C, D} or optionally combine them if desired
            imagPart = SplitQuaternion(0,q.b,q.c,q.d);
        end
                        %% Get specific imaginary parts
        function part = imagi(q, i)
            % Get specific imaginary part: i=1 for B, i=2 for C, i=3 for D
            switch i
                case 1
                    part = q.b;
                case 2
                    part = q.c;
                case 3
                    part = q.d;
                otherwise
                    error('Invalid imaginary part index. Use 1, 2, or 3.');
            end
        end
%%
        function r = ctranspose(q)
            r = SplitQuaternion( ...
                q.a.', -q.b.', -q.c.', -q.d.');
        end
        %% Norm (indefinite)
        function n = norm(q)
            n = q.a^2 + q.b^2 - q.c^2 - q.d^2;
        end
                %% Magnitude (absolute value of norm)
        function m = magnitude(q)
            m = sqrt(abs(norm(q)));
        end
               %% Exponential
        function r = exp(q)
            % Exponential of a split quaternion
            % For split quaternions, exponential can be computed
            % but careful with lightlike vectors (norm = 0)
            v_norm_sq = q.b^2 - q.c^2 - q.d^2;  % Note: negative sign for c,d in split quaternions
            
            if v_norm_sq > 0
                % Spacelike vector
                v_norm = sqrt(v_norm_sq);
                r = exp(q.a) * (cosh(v_norm) + (q.b*q.i + q.c*q.j + q.d*q.k)/v_norm * sinh(v_norm));
            elseif v_norm_sq < 0
                % Timelike vector
                v_norm = sqrt(-v_norm_sq);
                r = exp(q.a) * (cos(v_norm) + (q.b*q.i + q.c*q.j + q.d*q.k)/v_norm * sin(v_norm));
            else
                % Lightlike vector (norm = 0)
                r = exp(q.a) * (1 + q.b*q.i + q.c*q.j + q.d*q.k);
            end
        end
        
        %% Logarithm
        function r = log(q)
            % Principal logarithm of a split quaternion
            % Implementation depends on the norm type
            n = norm(q);
            if n <= 0
                error('Logarithm not defined for non-positive norm split quaternions');
            end
            
            v = [q.b, q.c, q.d];
            v_norm = sqrt(abs(q.b^2 - q.c^2 - q.d^2));
            
            if v_norm > eps
                r = SplitQuaternion(log(sqrt(abs(n))), ...
                    (q.b/v_norm) * acosh(q.a/sqrt(abs(n))), ...
                    (q.c/v_norm) * acosh(q.a/sqrt(abs(n))), ...
                    (q.d/v_norm) * acosh(q.a/sqrt(abs(n))));
            else
                r = SplitQuaternion(log(abs(q.a)), 0, 0, 0);
            end
        end
                %% Rotor (for rotations in split-quaternion space)
        function r = rotor(angle, axis)
            % Create a rotation rotor: exp(angle/2 * axis)
            % axis should be a pure split quaternion with norm ±1
            if ~isa(axis, 'SplitQuaternion') || ~isPure(axis)
                error('Axis must be a pure split quaternion');
            end
            
            axis_norm = norm(axis);
            if abs(abs(axis_norm) - 1) > eps
                axis = axis / sqrt(abs(axis_norm));
            end
            
            r = SplitQuaternion(cos(angle/2), ...
                axis.b * sin(angle/2), ...
                axis.c * sin(angle/2), ...
                axis.d * sin(angle/2));
        end
    end


        %% Static methods
    methods (Static)
        function q = zeros()
            % Create zero split quaternion
            q = SplitQuaternion(0, 0, 0, 0);
        end
        
        function q = ones()
            % Create unit real split quaternion
            q = SplitQuaternion(1, 0, 0, 0);
        end
        
        function q = eye()
            % Identity split quaternion
            q = SplitQuaternion(1, 0, 0, 0);
        end
        
        function q = i()
            % Basis element i
            q = SplitQuaternion(0, 1, 0, 0);
        end
        
        function q = j()
            % Basis element j
            q = SplitQuaternion(0, 0, 1, 0);
        end
        
        function q = k()
            % Basis element k
            q = SplitQuaternion(0, 0, 0, 1);
        end
        
        function q = random()
            % Random split quaternion with components in [0,1]
            q = SplitQuaternion(rand, rand, rand, rand);
        end
        
        function q = fromVector(v)
            % Create split quaternion from 4-element vector
            if length(v) ~= 4
                error('Input must be a 4-element vector');
            end
            q = SplitQuaternion(v(1), v(2), v(3), v(4));
        end
        
        function q = fromAngleAxis(angle, axis)
            % Create split quaternion from rotation angle and axis
            % axis should be a 3-element vector [x, y, z]
            if length(axis) ~= 3
                error('Axis must be a 3-element vector');
            end
            q = SplitQuaternion(cos(angle/2), ...
                axis(1)*sin(angle/2), ...
                axis(2)*sin(angle/2), ...
                axis(3)*sin(angle/2));
        end
    end

end