classdef PathElongation

    % properties(Static)
    %    earth_radius = 6378 % km
    % end

    methods(Static)

        function out = ApparentZenith(n0, zenith)
            arguments
                n0 {mustBeNumeric}
                zenith {mustBeNumeric}
            end

           out = asin((1/n0) .* sin(zenith));
        end

        function out = C(height)
            earth_radius = 6378; % km
            out = earth_radius ./ (earth_radius + height);
        end

        % should angles be in degrees or radians?

        function out = Beta(Zenith_Angles, Refractive_Index, Altitudes)
           c = PathElongation.C(Altitudes);
           out = acos((c ./ Refractive_Index) .* sin(Zenith_Angles));
        end

        function r = BendingAngle2(Zenith_Angles, Refractive_Index, Altitudes)
            Beta = PathElongation.Beta(Zenith_Angles, Refractive_Index, Altitudes);
            N = numel(Refractive_Index);
            r = zeros(1, N - 1);
            for i = 2:N
                j = i - 1;
                r(j) = (Refractive_Index(j) - Refractive_Index(i)) ...
                    / ( tan(Beta(i)) - tan(Beta(j)) );
            end

            r = interp1(Altitudes(1:end-1), r, 'spline');
            %r = ppval(r_interp, Altitudes);
        end

        function [n_1, dndh, kernel] = BendingAngle(Zenith_Angles, Refractive_Index, Altitudes)
            assert(utils.sameSize(Refractive_Index, Altitudes), ...
                'Inputs are not the same length');

            lim = sum(Altitudes < StandardAtmosphere().height(end)) - 1;

            Beta = PathElongation.Beta( ...
                Zenith_Angles, Refractive_Index, Altitudes);
            C = PathElongation.C(Altitudes);

            dndh = utils.FiniteDifferenceGradient(Refractive_Index, Altitudes);
            n_1 = 1 ./ Refractive_Index;

            % N = numel(Refractive_Index);
            N = lim;
            kernel = zeros(1, N);
            for i = 2:N
                j = i - 1;
                kernel(j) = PathElongation.kernel( ...
                    Beta(j), ...
                    Refractive_Index(i), Refractive_Index(j), ...
                    C(i), C(j));
            end

            size(n_1)
            size(dndh)
            size(kernel)
            size(Altitudes)

            kernel = n_1(1:lim) .* dndh(1:lim) .* kernel;

            r = kernel;
            % r_i = @(i) kernel(i);


            % r = trapz(Altitudes, kernel);
        end

        function k = kernel(b_1, n, n_1, c, c_1)
            k = cos(b_1) / sqrt( ((n * c_1) / (n_1 * c))^2  - cos(b_1)^2 );
        end

    end


end
