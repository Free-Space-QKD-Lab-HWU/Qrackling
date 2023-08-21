classdef utils
    methods(Static)

        function msg = sameSizeMessage(arg_name_a, arg_name_b)
            msg = ['Argument: ', arg_name_a, ', and Argument : ', ...
                arg_name_b, ', are of different sizes'];
        end

        function result = sameSize(A, B)
            size_a = size(A);
            size_b = size(B);
            result = (size_a(1) == size_b(1)) && (size_a(2) == size_b(2));
        end

        function k = wavenumberFromWavelength(wvl)
            k = 2 .* pi ./ wvl;
        end

        function wvl = wavelengthFromWavenumber(k)
            wvl = 2 .* pi ./ k;
        end

        function dydx = FiniteDifferenceGradient(x, y)
            assert(utils.sameSize(WindShear, LapseRate), ...
                utils.sameSizeMessage(inputname(1), inputname(2)));

            dydx = zeros(size(x));

            for i = 2:numel(x)
                j = i - 1;
                dy = y(j) - y(i);
                dx = x(j) - x(i);
                dydx(j) = dy / dx;
            end

        end

    end
end