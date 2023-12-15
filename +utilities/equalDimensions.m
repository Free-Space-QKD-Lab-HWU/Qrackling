function result = equalDimensions(A, B)
    arguments
        A
        B
    end

    size_a = size(A);
    size_b = size(B);

    result = isequal(size_a, size_b);

    if (true == result)
        return
    end

    msg = ['Inputs must have matching dimensions:', ...
        newline, char(9), ...
        '-> ', inputname(1), ' :: ', num2str(size_a), ...
        newline , char(9), ...
        '-> ', inputname(2), ' :: ', num2str(size_b) ...
    ];

    error(string(msg));

end
