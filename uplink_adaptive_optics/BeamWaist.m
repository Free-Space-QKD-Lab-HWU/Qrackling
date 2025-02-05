classdef BeamWaist
    methods (Static)
        function w = ShortTerm(Wave_Number, Initial_Waist, Slant_Range, ...
                Cn2_Model, Reference_Height, Zenith_Angle, ...
                Turbulent_Propagation_Length,  Initial_Wavefront_Radius, ...
                Link_Direction, Aperture_Radius)

            arguments
                Wave_Number
                Initial_Waist
                Slant_Range
                Cn2_Model
                Reference_Height
                Zenith_Angle
                Turbulent_Propagation_Length
                Initial_Wavefront_Radius
                Link_Direction
                Aperture_Radius
            end

            omega = BeamWaist.FresnelNumber(Wave_Number, Initial_Waist, Slant_Range);
            Cn02 = BeamWaist.ReferenceRefractiveIndexStructureConstant(Cn2_Model, Reference_Height, Zenith_Angle);
            rho = BeamWaist.RadiusOfSpatialCoherence(Cn02, Wave_Number, Turbulent_Propagation_Length);
            Chi2 = BeamWaist.ChiSquared(Link_Direction, Cn02, Cn2_Model, Slant_Range, Zenith_Angle);

            first = (1 - (Slant_Range ./ Initial_Wavefront_Radius)) .^ 2;


            a = ((Initial_Waist .^ 2) ./ (rho .^ 2));
            b = rho ./ (Aperture_Radius .* sqrt(Chi2));
            c = 1 + (0.24 .* (b .^ (1/3)));

            second = 1 + (a .* (Chi2 ./ c));

            w = Initial_Waist .* sqrt(first + (second ./ (omega .^ 2)));
        end
    end

    methods (Static)
        function w = LongTerm(Wave_Number, Initial_Waist, Slant_Range, ...
                Cn2_Model, Reference_Height, Zenith_Angle, ...
                Turbulent_Propagation_Length,  Initial_Wavefront_Radius, ...
                Link_Direction)

            arguments
                Wave_Number
                Initial_Waist
                Slant_Range
                Cn2_Model
                Reference_Height
                Zenith_Angle
                Turbulent_Propagation_Length
                Initial_Wavefront_Radius
                Link_Direction
            end

            omega = BeamWaist.FresnelNumber(Wave_Number, Initial_Waist, Slant_Range);
            Cn02 = BeamWaist.ReferenceRefractiveIndexStructureConstant(Cn2_Model, Reference_Height, Zenith_Angle);
            rho = BeamWaist.RadiusOfSpatialCoherence(Cn02, Wave_Number, Turbulent_Propagation_Length);
            Chi2 = BeamWaist.ChiSquared(Link_Direction, Cn02, Cn2_Model, Slant_Range, Zenith_Angle);

            first = (1 - (Slant_Range ./ Initial_Wavefront_Radius)) .^ 2;
            second = 1 + (((Initial_Waist .^ 2) ./ (rho .^ 2)) .* Chi2);

            w = Initial_Waist .* sqrt(first + (second ./ (omega .^ 2)));
        end
    end

    methods (Static, Access=private)

        function omega = FresnelNumber(Wave_Number, Initial_Waist, Slant_Range)
            arguments
                Wave_Number {mustBeNumeric}
                Initial_Waist {mustBeNumeric}
                Slant_Range {mustBeNumeric}
            end

            omega = (Wave_Number .* (Initial_Waist .^ 2)) / (2 .* Slant_Range);
        end

        function rho = RadiusOfSpatialCoherence(Cn02, Wave_Number, TurbulentPropagationLength)
            arguments
                Cn02 {mustBeNumeric}
                Wave_Number {mustBeNumeric}
                TurbulentPropagationLength {mustBeNumeric}
            end

            rho = (1.5 ...
                .* Cn02 ...
                .* (Wave_Number .^ 2) ...
                .* TurbulentPropagationLength) .^ (-3 / 5);
        end

        function Cn02 = ReferenceRefractiveIndexStructureConstant( ...
                Cn2_Model, Reference_Height, Zenith_Angle)
            arguments
                Cn2_Model AFGL_Plus
                Reference_Height {mustBeNumeric}
                Zenith_Angle {mustBeNumeric}
            end
            h = Reference_Height .* sec(Zenith_Angle);
            Cn02 = Cn2_Model.RefractiveIndexStructureConstant(h);
        end

        function result = ChiSquared(Link_Direction, Cn02, Cn2_Model, ...
                Slant_Range, Zenith_Angle)
            arguments
                Link_Direction LinkDirection
                Cn02 {mustBeNumeric}
                Cn2_Model AFGL_Plus
                Slant_Range {mustBeReal, mustBeNumeric, mustBePositive}
                Zenith_Angle {mustBeNumeric}
            end

            kernel = @(xi) ...
                Cn2_Model.RefractiveIndexStructureConstant( ...
                    Link_Direction.LayerHeight(Slant_Range, Zenith_Angle));
            integr = integral(kernel, 0, 1);

            result = (1 ./ Cn02) .* integr;

        end

    end
end
