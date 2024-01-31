function shadowed = InEarthsShadow(A, B)
    arguments
        A nodes.Located_Object
        B nodes.Located_Object
    end

    %% get the two XYZ positions of the two objects
    [X1, Y1, Z1] = GetXYZ(A);
    Pos_A = [X1, Y1, Z1];
    [X2, Y2, Z2] = GetXYZ(B);
    Pos_B = [X2, Y2, Z2];

    %% determine the minimum radius from earth's centre of the line between these two
    Dot_product = sum(Pos_A .* Pos_B, 2);
    Lambda_min = (utilities.Row2Norms(Pos_A).^2 - Dot_product) ...
        ./ (utilities.Row2Norms(Pos_A).^2 + utilities.Row2Norms(Pos_B).^2 - 2 .* Dot_product);

    Pos_min = Pos_A .* (1 - Lambda_min) + Pos_B .* Lambda_min;
    %check lambda for not being inside bounds
    %if Lambda_min is <0 this indicates the the first position
    %is the lowest radius
    %Pos_A may be an array or a vector
    if isvector(Pos_A)
        Pos_min(Lambda_min < 0, :) = ones(sum(Lambda_min < 0), 1) * Pos_A;
    else
        Pos_min(Lambda_min < 0, :) = Pos_A(Lambda_min < 0, :);
    end

    %if lambda_min>1 this indicates that the 2nd position 9is
    %the lowest radius
    if isvector(Pos_B)
        Pos_min(Lambda_min > 1, :) = ones(sum(Lambda_min > 1), 1) * Pos_B;
    else
        Pos_min(Lambda_min > 1, :) = Pos_B(Lambda_min > 1, :);
    end

    %produce a located_object at this minimum point by converting
    %to spherical coords and then geographic coords
    R_min = utilities.Row2Norms(Pos_min);

    shadowed = R_min < A.Earth_Radius;
end
