classdef aerosol_king_byrne
    properties (Access = protected)
        alpha_0 {mustBeNumeric}
        alpha_1 {mustBeNumeric}
        alpha_2 {mustBeNumeric}
    end

    methods
        function king_byrne = aerosol_king_byrne(alpha_0, alpha_1, alpha_2)
            arguments
                alpha_0 {mustBeNumeric}
                alpha_1 {mustBeNumeric}
                alpha_2 {mustBeNumeric}
            end

            king_byrne.alpha_0 = alpha_0;
            king_byrne.alpha_1 = alpha_1;
            king_byrne.alpha_2 = alpha_2;
        end
    end
end
