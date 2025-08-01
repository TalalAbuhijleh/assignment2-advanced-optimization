function f = rastrigin(x, y)
%RASTRIGIN  Two–dimensional Rastrigin test function.
%
%   f = RASTRIGIN(x, y) returns the value of the function
%
%       f(x,y) = 20 + x^2 + y^2 − 10 [cos(2πx) + cos(2πy)]
%
%   x and y can be scalars, vectors, or matrices of the same size.

f = 20 + x.^2 + y.^2 - 10 .* (cos(2*pi*x) + cos(2*pi*y));
end
