% Path Elongation according to appendix:C of Vasylyev, D., Vogel, W., et al. 
% (2019), Satellite-Mediated Quantum Atmospheric Links, 10.1103/PhysRevA.99.053830.

classdef PathElongation
    properties(Constant, Hidden, Access=private)
        Earth_Radius = 6371; % km
        Sea_Level_Refractive_Index double = 1.00027
    end

    methods(Static)

        function factors = ElongationFactor(Zenith_Angles, Altitudes, ...
                Satellite_Altitude, Refractive_Index, options)

            arguments
                Zenith_Angles double
                Altitudes double
                Satellite_Altitude double
                Refractive_Index double
                options.Sea_Level_Refractive_Index double = ...
                    PathElongation.Sea_Level_Refractive_Index
                options.UseApparentZenith = true;
            end

            n_0 = options.Sea_Level_Refractive_Index;

            factors = zeros(size(Zenith_Angles));
            for i = 1:numel(factors)
                details = PathElongation.Factor( ...
                    Zenith_Angles(i), Altitudes, Satellite_Altitude, ...
                    Refractive_Index, Sea_Level_Refractive_Index = n_0, ...
                    UseApparentZenith = options.UseApparentZenith);
                factors(i) = sum(details.Length) / details.SlantRange;
            end

            factors(factors < 1) = 1;
        end

    end

    methods(Static, Access=private)

        function Details = Factor(Zenith_Angle, Altitudes, ...
                Satellite_Altitude, Refractive_Index, options)

            arguments
                Zenith_Angle
                Altitudes
                Satellite_Altitude
                Refractive_Index
                options.Sea_Level_Refractive_Index double = ...
                    PathElongation.Sea_Level_Refractive_Index
                options.UseApparentZenith = true;
            end

            n_0 = options.Sea_Level_Refractive_Index;

            if (Altitudes(1) ~= 0)
                Altitudes = cat(2, 0, Altitudes);
                Refractive_Index = cat(2, n_0, Refractive_Index);
            end

            Z_a = Zenith_Angle;
            if options.UseApparentZenith
                Z_a = PathElongation.ApparentZenith(n_0, Zenith_Angle);
            end

            C_H = PathElongation.C(Satellite_Altitude); % C at sateliite altitude
            C = PathElongation.C(Altitudes); % C for each atmospheric layer

            % B_N = PathElongation.Beta(Zenith_Angle, 1, C_H); % B at last atmospheric layer
            B_N = acos(n_0 .* C_H .* sin(Z_a));
            B = PathElongation.Beta(Zenith_Angle, Refractive_Index, C);

            % Equation C6
            % -> \alpha_i = arccos \left( \frac{n_i}{n_{i-1}} cos \beta_{i} \right)
            % due to the "i-1" subscript the valid values from \beta are B_i(2:end)
            % only valid from first layer > 0 Km
            A = PathElongation.Alpha( ...
                Refractive_Index(2:end), ...
                Refractive_Index(1:end-1), ...
                B(2:end));

            % r = PathElongation.BendingAngle(Refractive_Index, B);
            r = ...
                (Refractive_Index(1:end-1) - Refractive_Index(2:end)) ...
                ./ (tan(B(2:end)) + tan(B(1:end-1)));

            Chi = r - (A - B(2:end)); % valid from frist layer > 0 Km

            N = numel(C) - 1;
            a_0i = zeros(1, N);
            Delta = zeros(1, N);
            Psi = zeros(1, N);

            a_0i(1) = (pi / 2) - Z_a;

            Delta(1) = atan( ...
                (cos(A(1)) - cos(A(1) + Chi(1))) ...
                / (sin(A(1) + Chi(1)) - sin(a_0i(1))) ...
                );

            Psi(1) = pi - Z_a - Delta(1) - A(1) + a_0i(1) - Chi(1);

            Length = zeros(1, N);

            for i = 2 : N
                i_1 = i - 1;

                [Psi_i, Alpha_0i, Delta_i] = PathElongation.nextStep( ...
                    Z_a, C(i), C(i_1), B(i), B(i_1), a_0i(i_1), A(i_1), Chi(i));

                Psi(i) = Psi_i;
                a_0i(i) = Alpha_0i;
                Delta(i) = Delta_i;
                Length(i) = PathElongation.PathLength( ...
                    Altitudes(i), Altitudes(i_1), A(i), a_0i(i), Chi(i));
            end

            Delta_N = PathElongation.Delta_i( ...
                A(end), Chi(end), C_H, C(end), a_0i(end));

            Psi_S = asin((C_H ./ C(end)) .* sin(r(end) - Delta_N + Psi(end)));

            %Length = PathElongation.PathLength(Altitudes, A, a_0i, Chi);

            Length_N = PathElongation.PathLengthVacuum( ...
                Satellite_Altitude, Altitudes(end), r(end), Delta_N, Psi(end), Psi_S);

            % Range = PathElongation.SlantRange(Satellite_Altitude, Zenith_Angle);
            Range = slant_range( ...
                Satellite_Altitude, ...
                Zenith_Angle, ...
                earth_radius=PathElongation.Earth_Radius);

            Details = struct();
            Details.Z_a = Z_a;
            Details.Alpha_0i = cat(2, NaN, a_0i);
            Details.Alpha = cat(2, NaN, A);
            Details.Beta = B(1:end);
            Details.Beta_N = B_N;
            Details.C = C;
            Details.Delta = cat(2, NaN, Delta);
            Details.Delta_N = Delta_N;
            Details.Chi = cat(2, NaN, Chi);
            Details.Psi = cat(2, NaN, Psi);
            Details.r = cat(2, NaN, r);
            Details.Length = cat(2, Length, Length_N);
            Details.SlantRange = Range;
        end

        function out = ApparentZenith(n_0, Zenith_Angle)
            arguments
                n_0 {mustBeNumeric}
                Zenith_Angle {mustBeNumeric}
            end
           out = asin((1/n_0) .* sin(Zenith_Angle));
        end

        function bend = BendingAngle(Refractive_Index, Beta)
            assert(utilities.sameSize(Refractive_Index, Beta), ...
                [inputname(1), 'and ', inputname(2), ...
                ' must have the same shape']);
            bend = 2 ...
                .* (Refractive_Index(1:end-1) - Refractive_Index(2:end)) ...
                ./ (tan(Beta(2:end)) + tan(Beta(1:end-1)));
        end

        function l = PathLength(Altitude_i, Altitude_i_1, Alpha_i, Alpha_0i, Chi_i)
            arguments
                Altitude_i
                Altitude_i_1
                Alpha_i
                Alpha_0i
                Chi_i
            end

            Phi = Alpha_i - Alpha_0i + Chi_i;
            left = PathElongation.Earth_Radius + Altitude_i;
            right = PathElongation.Earth_Radius + Altitude_i_1;

            l = sqrt((left.^2) + (right.^2) - (2.*left.*right.*cos(Phi)));
        end

        function l = PathLengthVacuum(Satellite_Altitude, Altitudes, ...
                BendingAngle, Delta, Psi_N, Psi)
            arguments
                Satellite_Altitude double
                Altitudes double
                BendingAngle double
                Delta double
                Psi_N double
                Psi double
            end

            earth_rad = PathElongation.Earth_Radius;

            Theta = BendingAngle - Delta + Psi_N - Psi;
            cosTheta = cos(Theta);
            left = earth_rad + Altitudes(end);
            right = earth_rad + Satellite_Altitude;
            lr = (left .^ 2) + (right .^ 2);
            difference = 2 .* left .* right .* cosTheta;
            total = lr - difference;
            l = sqrt(total);
        end

        function l = SlantRange(Satellite_Altitude, Zenith_Angle)
            arguments
                Satellite_Altitude double
                Zenith_Angle double
            end

            earth_rad = PathElongation.Earth_Radius;

            rCosZ = earth_rad .* cos(Zenith_Angle);
            l = sqrt((Satellite_Altitude .^ 2) ...
                + (2 .* Satellite_Altitude .* earth_rad) ...
                + (earth_rad^2) .* cos(Zenith_Angle).^2) - rCosZ;
        end

        function out = C(height)
            earth_rad = PathElongation.Earth_Radius;
            out = earth_rad ./ (earth_rad + height);
        end

        function out = Beta(Zenith_Angle, Refractive_Index, C)
           out = acos((C ./ Refractive_Index) .* sin(Zenith_Angle));
        end

        function delta = Delta_i(Alpha_i, Chi_i, C_i, C_i_1, Alpha_0i)
            AC = Alpha_i + Chi_i;
            delta = atan( ...
                (cos(Alpha_i) - cos(AC)) ./ ...
                (sin(AC) - (C_i ./ C_i_1) .* sin(Alpha_0i)) ...
                );
        end

        function A = Alpha(n, n_1, beta_i)
            A = acos((n ./ n_1) .* cos(beta_i));
        end

        function alpha_0i = Alpha_0i(Alpha_i, Alpha_0i_1, Beta_i, Chi_i, Psi_i, Z_a)
            alpha_0i = Alpha_i - Alpha_0i_1 + Beta_i + Chi_i + Psi_i - Z_a;
        end

        function psi_i = Psi_i(C_i, C_i_1, Z_a, B_i_1, Alpha_0i_1)
            psi_i = asin((C_i ./ C_i_1) .* sin(Z_a - B_i_1 + Alpha_0i_1));
        end

        function [Psi_i, Alpha_0i, Delta_i] = nextStep( ...
                Za, C_i, C_i_1, Beta_i, Beta_i_1, Alpha_0i_1, Alpha_i, Chi_i)

            Psi_i = PathElongation.Psi_i( ...
                C_i, C_i_1, Za, Beta_i_1, Alpha_0i_1);

            Alpha_0i = PathElongation.Alpha_0i( ...
                Alpha_i, Alpha_0i_1, Beta_i, Chi_i, Psi_i, Za);

            Delta_i = PathElongation.Delta_i( ...
                Alpha_i, Chi_i, C_i, C_i_1, Alpha_0i);
        end

    end

end
