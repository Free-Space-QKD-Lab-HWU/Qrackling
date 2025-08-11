function dydx = finiteDifferenceGradient(x, y)
    % Computes the finite difference gradient of y with respect to x.
    %
    % Syntax:
    % dydx = finiteDifferenceGradient(x, y)
    %
    % Description:
    % Returns a vector of gradients using backward finite differences.
    % The final element remains zero unless post-processed.

    assert(utilities.haveEqualDimensions(x, y))

    dydx = zeros(size(x));

    for i = 2:numel(x)
        j = i - 1;
        dy = y(j) - y(i);
        dx = x(j) - x(i);
        dydx(j) = dy / dx;
    end
end