classdef Telescope
    % Telescope
    %
    % Optical system model for transmitters and receivers.
    % Stores geometry, efficiency, pointing, and field-of-view parameters.
    %
    % Syntax:
    %   tel = components.Telescope(diameter, options)
    %
    % Additional options and defaults are provided in the constructor.

    properties
        % Diameter of the transmitter aperture (m)
        diameter {mustBeScalarOrEmpty, mustBePositive}

        % Ratio between theoretical and actual far-field divergence angle
        far_field_divergence_coefficient {mustBeScalarOrEmpty, ...
            mustBeGreaterThanOrEqual(far_field_divergence_coefficient, 1)} = 1

        % Optical efficiency (Cassegrain telescope obscuration)
        optical_efficiency {mustBeScalarOrEmpty, mustBePositive} = 1 - 0.3^2

        % RMS pointing jitter (rad)
        pointing_jitter {mustBeScalarOrEmpty, mustBeNonnegative} = 1e-6

        % Focal length (m) of collecting optics
        focal_length {mustBeScalarOrEmpty, mustBeNonnegative} = []

        % F-number = focal_length / diameter
        f_number {mustBeScalarOrEmpty, mustBeNonnegative} = 12

        % Eyepiece focal length (m) for magnification computation
        eyepiece_focal_length {mustBeScalarOrEmpty, mustBeNonnegative} = 0.076
    end

    properties (SetAccess = protected)
        % Wavelength of transmitter (nm), set by mounting platform
        wavelength {mustBeScalarOrEmpty, mustBePositive} = []
    end

    properties (Dependent, SetAccess = private)
        % Field-of-view (rad), computed from wavelength and geometry
        fov

        % Collecting area (m^2), computed from diameter
        collecting_area

        % Magnification: applied to beam expansion/angle compression
        magnification {mustBeScalarOrEmpty, mustBePositive}
    end

    methods
        function obj = Telescope(diameter, options)
            % Telescope constructor
            %
            % Syntax:
            %   obj = Telescope(diameter, options)
            %
            % Inputs:
            %   diameter - (1,1) double, aperture diameter (m)
            %   options  - name-value struct of optional parameters
            %
            % Outputs:
            %   obj      - Telescope instance

            arguments
                diameter
                options.Wavelength = []
                options.Wavelength_Scale units.Magnitude = "nano"
                options.Optical_Efficiency = 1 - (0.3 ^ 2)
                options.Far_Field_Divergence_Coefficient = 1
                options.Pointing_Jitter = 1e-6
                options.F_Number = 12
                options.Eyepiece_Focal_Length = 0.076
                options.FOV
                options.Focal_Length
            end

            % require properties
            obj.diameter = diameter;
            obj.f_number = options.F_Number;
            obj.focal_length = obj.f_number * obj.diameter;
            obj.pointing_jitter = options.Pointing_Jitter;

            % optional properties
            if ismember('Wavelength',fields(options))
            obj = obj.setWavelength(options.Wavelength);
            end
            if ismember('FOV',fields(options))
            obj = obj.setFOV(options.FOV);
            end
            if ismember('Focal_Length',fields(options))
            obj.focal_length = options.Focal_Length;
            end
        end

        function obj = setWavelength(obj, wavelength, options)
            % setWavelength
            %
            % Set the transmitter wavelength (nm) for this telescope.
            %
            % Syntax:
            %   obj = setWavelength(obj, wavelength, options)

            arguments
                obj components.Telescope
                wavelength
                options.Wavelength_Scale units.Magnitude = 'nano'
            end

            obj.wavelength = units.Magnitude.convert( ...
                options.Wavelength_Scale, "nano", wavelength);
        end

        function obj = setFarFieldDivergenceCoefficient(obj, fov, wavelength, diameter)
            % setFarFieldDivergenceCoefficient
            %
            % Set the divergence coefficient required to maintain a given
            % FOV at a given wavelength and diameter.

            if isempty(fov) || isempty(wavelength)
                obj.far_field_divergence_coefficient = 1;
                return
            end

            coeff = fov / (2.44 * (wavelength * 1e-9) / diameter);

            if coeff < 1
                warning(['Requested FOV is narrower than diffraction limit. ', ...
                         'Reverting to diffraction limit']);
                obj.far_field_divergence_coefficient = 1;
            else
                obj.far_field_divergence_coefficient = coeff;
            end
        end

        function obj = setDiameter(obj, diameter)
            % setDiameter
            %
            % Set the diameter (m) of the transmitter aperture.
            obj.diameter = diameter;
        end

        function obj = setPointingJitter(obj, pointing_jitter)
            % setPointingJitter
            %
            % Set the RMS pointing jitter (rad) of the OGS.
            obj.pointing_jitter = pointing_jitter;
        end

        function obj = setFOV(obj, fov)
            % setFOV
            %
            % Set the telescope FOV (rad) indirectly by updating the
            % far-field divergence coefficient.

            if isempty(obj.wavelength)
                error('cannot set FOV without first setting wavelength')
            end

            obj = obj.setFarFieldDivergenceCoefficient( ...
                fov, obj.wavelength, obj.diameter);
        end

        function area = get.collecting_area(obj)
            % collecting_area (getter)
            %
            % Return the total collecting area of the telescope (m^2).
            area = (pi / 4) * obj.diameter^2;
        end

        function fov = get.fov(obj)
            % fov (getter)
            %
            % Return the FOV (rad), scaling the diffraction-limited FOV by
            % the far-field divergence coefficient.
            %
            % Reference:
            % Zhang et al., "Link loss analysis for a satellite quantum
            % communication down-link", Proc. SPIE 11540 (2020).
            fov = 2.44 ...
                * obj.far_field_divergence_coefficient ...
                * (obj.wavelength * 1e-9) ...
                / obj.diameter;
        end

        function mag = get.magnification(obj)
            % magnification (getter)
            %
            % Return the magnification of the telescope
            %

            mag = obj.focal_length / obj.eyepiece_focal_length;
        end
    end
end