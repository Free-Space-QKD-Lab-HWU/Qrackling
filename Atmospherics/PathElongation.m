classdef PathElongation

    properties(Static)
       earth_radius = 6378 % km
    end

    methods(Static)

        function out = ApparentZenith(n0, zenith, options)
            arguments
                n0 {mustBeNumeric}
                zenith {mustBeNumeric}
            end

           out = asin((1/n0) .* sin(zenith))
        end

        function out = C(height)
           out = PathElongation.earth_radius ...
               ./ (PathElongation.earth_radius + height);
        end

        function out = Beta(height, zenith, refractive_index)
           c = PathElongation.C(height);
           out = acos((c / refractive_index) .* sin(zenith));
        end

        function out = kernel( ...
                height_i, height_i_1 ...
                zenith_i, zenith_i_1, ...
                n_i, n_i_1, n_grad_i, ...
                )

            beta_i_1 = PathElongation.Beta(height_i_1, zenith_i_1, n_i_1);
            c_i = PathElongation.C(height_i);
            c_i_1 = PathElongation.C(height_i_1);




        end

    end

end
