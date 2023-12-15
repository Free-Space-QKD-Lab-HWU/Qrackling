function dydx = FiniteDifferenceGradient(x, y)
    assert(utilities.sameSize(WindShear, LapseRate), ...
        utilities.sameSizeMessage(inputname(1), inputname(2)));

    dydx = zeros(size(x));

    for i = 2:numel(x)
        j = i - 1;
        dy = y(j) - y(i);
        dx = x(j) - x(i);
        dydx(j) = dy / dx;
    end
end
