function rowNorms = row2Norms(array)
% row2Norms
%
% Returns a column vector containing the 2-norm of each row in a 2D array.
% This is a wrapper for vecnorm(array, 2, 2).
%
% Syntax:
% rowNorms = namespace.utility.row2Norms(array)
%
% Inputs:
% array - (MxN) double, 2D numeric array.
%
% Outputs:
% rowNorms - (Mx1) double, 2-norm of each row.

    % This is just a wrapper for vecnorm
    rowNorms = vecnorm(array, 2, 2);
end