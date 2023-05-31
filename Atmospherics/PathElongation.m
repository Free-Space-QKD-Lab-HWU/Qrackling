function Details = PathElongation(Zenith_Angle, Altitudes, ...
        Satellite_Altitude, Refractive_Index, options)

    arguments
        Zenith_Angle
        Altitudes
        Satellite_Altitude
        Refractive_Index
        options.Sea_Level_Refractive_Index double = 1.00027
    end

    n_0 = options.Sea_Level_Refractive_Index;
    Z_a = ApparentZenith(n_0, Zenith_Angle);

    C_H = C(Satellite_Altitude); % C at sateliite altitude
    C_i = C(Altitudes); % C for each atmospheric layer
    disp(size(C_i))

    B_N = Beta(Zenith_Angle, 1, C_H); % B at last atmospheric layer
    B_i = Beta(Zenith_Angle, Refractive_Index, C_i);
    B_i = cat(2, B_i, B_N);

    A_i = ...
        Refractive_Index(2:end) ...
        ./ Refractive_Index(1:end-1) ...
        .* cos(B_i(1:end-2));

    r_i = 2 ...
        .* ((Refractive_Index(1:end-1) - Refractive_Index(2:end)) ...
        ./ (tan(B_i(2:end-1)) + tan(B_i(1:end-2))));

    Chi_i = r_i - (A_i - B_i(1:end-2));

    a_0i = zeros(1, numel(C_i)-1);
    a_0i(1) = (pi / 2) - Z_a;

    Delta = zeros(1, numel(C_i)-1);
    Delta(1) = Delta_i(A_i(1), Chi_i(1), C_i(1), 1, a_0i(1));

    Psi = zeros(1, numel(C_i)-1);
    Psi(1) = pi - Z_a - Delta(1) - A_i(1) + a_0i(1) - Chi_i(1);

    for i = 2 : numel(C_i) - 1
        i_1 = i - 1;

        Psi(i) = Psi_i(C_i(i), C_i(i_1), Z_a, B_i(i_1), a_0i(i_1));
        a_0i(i) = A_i(i) - a_0i(i_1) + B_i(i) + Chi_i(i) + Psi(i);
        Delta(i) = Delta_i(A_i(i), Chi_i(i), C_i(i), i, a_0i(i));
    end

    Delta_N = Delta_i(A_i(end), Chi_i(end), C_H, C_i(end), a_0i(end));
    Psi_S = Psi_i(C_i(end), C_H, r_i(end), Delta(end), Psi(end));

    Length = PathLength(Altitudes, A_i, a_0i, Chi_i);
    Length_N = PathLengthVacuum(Satellite_Altitude, Altitudes(end), r_i(end), Delta_N, Psi(end), Psi_S);

    Details = struct();
    Details.Z_a = Z_a;
    Details.Alpha_0i = cat(2, NaN, a_0i);
    Details.Alpha = cat(2, NaN, A_i);
    Details.Beta = B_i(1:end);
    Details.Beta_N = B_N;
    Details.C = C_i;
    Details.Delta = cat(2, NaN, Delta);
    Details.Delta_N = Delta_N;
    Details.Chi = cat(2, NaN, Chi_i);
    Details.Psi = cat(2, NaN, Psi);
    Details.r = cat(2, NaN, r_i);
    Details.Length = Length;
    Details.Length_N = Length_N;
    Details.SlantRange = SlantRange(Satellite_Altitude, Zenith_Angle);

end

function out = ApparentZenith(n_0, Zenith_Angle)
    arguments
        n_0 {mustBeNumeric}
        Zenith_Angle {mustBeNumeric}
    end

   out = asin((1/n_0) .* sin(Zenith_Angle));
end

function out = C(height)
    earth_radius = 6378; % km
    out = earth_radius ./ (earth_radius + height);
end

function out = Beta(Zenith_Angle, Refractive_Index, C)
   out = acos((C ./ Refractive_Index) .* sin(Zenith_Angle));
end

function delta = Delta_i(Alpha_i, Chi_i, C_i, C_i_1, Alpha_0i)
    AC = Alpha_i + Chi_i;
    delta = atan( ...
        (cos(Alpha_i) - cos(AC)) / ...
        (sin(AC) - (C_i / C_i_1) * sin(Alpha_0i)) ...
        );
end

function alpha_0i = Alpha_0i(Alpha_i, Alpha_0i_1, Beta_i, Chi_i, Psi_i, Z_a)
    alpha_0i = Alpha_i - Alpha_0i_1 + Beta_i + Chi_i + Psi_i - Z_a;
end

function psi_i = Psi_i(C_i, C_i_1, Z_a, B_i_1, Alpha_0i_1)
    psi_i = asin((C_i / C_i_1) * sin(Z_a - B_i_1 + Alpha_0i_1));
end

function l = PathLength(Altitudes, Alpha_i, Alpha_0i, Chi_i)
    earth_radius = 6378; % km

    Phi = Alpha_i - Alpha_0i + Chi_i;
    left = earth_radius + Altitudes(1:end-1);
    right = earth_radius + Altitudes(2:end);
    l = sqrt(left.^2 + right.^2 + left.*right.*cos(Phi))
end

function l = PathLengthVacuum(Satellite_Altitude, Altitudes, BendingAngle, Delta, Psi, Psi_S)
    earth_radius = 6378; % km

    Theta = BendingAngle - Delta + Psi - Psi_S;
    left = earth_radius + Altitudes(end);
    right = earth_radius + Satellite_Altitude;
    l = sqrt(left.^2 + right.^2 + left.*right.*cos(Theta))
end

function l = SlantRange(Satellite_Altitude, Zenith_Angle)
    earth_radius = 6378; % km

    rCosZ = earth_radius * cos(Zenith_Angle);

    l = sqrt((Satellite_Altitude ^ 2) ...
        + (2 * Satellite_Altitude * earth_radius) ...
        + rCosZ ^ 2) - rCosZ;
end
