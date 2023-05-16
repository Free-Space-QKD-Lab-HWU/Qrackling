classdef utils
    methods(Static)

        function result = sameSize(A, B)
            size_a = size(A);
            size_b = size(B);
            result = (size_a(1) == size_b(1)) && (size_a(2) == size_b(2));
        end

        function k = wavenumberFromWavelength(wvl)
            k = 2 .* pi ./ wvl;
        end

        function wvl = wavelengthFromWavenumber(k)
            wvl = 2 .* pi / k;
        end

    end
end
