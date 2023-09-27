classdef Telescope
    %TELESCOPE contain the relevant properties of optical systems for
    %transmitters and receivers

    properties
        %diameter of the transmitter in m
        Diameter{mustBeScalarOrEmpty,mustBePositive};

        %ratio between theoretical and acutal far field divergence angle
        Far_Field_Divergence_Coefficient{mustBeScalarOrEmpty,mustBeGreaterThanOrEqual(Far_Field_Divergence_Coefficient,1)}=1;

        %optical efficiency- from cassegrain telescope obscuration (Link loss analysis for a satellite quantum communication downlink, Single photon group)
        Optical_Efficiency{mustBeScalarOrEmpty,mustBePositive}=1-0.3^2;

        %rms error in pointing in radians
        Pointing_Jitter{mustBeScalarOrEmpty,mustBeNonnegative}=10^-6;

        %focal length (in m_ of the telescope collecting optics
        Focal_Length {mustBeScalarOrEmpty,mustBeNonnegative}=[];

        %F number is the ratio of focal length to diameter
        F_Number {mustBeScalarOrEmpty,mustBeNonnegative}=12;   %default is 12

        %magnification of telescope- applied directly to beam expansion and
        %inversely to angle compression
        Magnification {mustBeScalarOrEmpty,mustBePositive};

        %eyepiece focal length (in m) to compute magnification
        Eyepiece_Focal_Length {mustBeScalarOrEmpty,mustBeNonnegative}= 0.076; %default is 3 inches
    end
    properties(SetAccess=protected)
        %wavelength of the transmitter (in nm), set by the satellite it is mounted to
        Wavelength{mustBeScalarOrEmpty,mustBePositive}=[];

        %angle in rads describing spread of photons as the propagate
        FOV{mustBeScalarOrEmpty,mustBeNonnegative};

        %collecting area of the telescope in m^2
        Collecting_Area (1,1) double {mustBeNonnegative}
    end

    methods
        function obj = Telescope(Diameter, options)
            arguments (Input)
                Diameter
				options.Wavelength = []
                options.Wavelength_Scale OrderOfMagnitude = "nano"
				options.Optical_Efficiency = 1 - (0.3 ^ 2)
				options.Far_Field_Divergence_Coefficient = 1
				options.Pointing_Jitter = 1e-6
				options.F_Number = 12
				options.Eyepiece_Focal_Length = 0.076
				options.FOV
				options.Focal_Length
            end
            arguments (Output)
                obj Telescope
            end

            obj.Diameter = Diameter;
            obj.F_Number = options.F_Number;
            obj.Focal_Length = obj.F_Number * obj.Diameter;

            % Loop over fields that we have and apply specific case
            for option = fieldnames(options)
                opt = option{1};
                switch opt
                    case 'FOV'
                        obj = obj.SetFOV(options.FOV);

                    case 'Focal_Length'
                        obj.Focal_Length = options.Focal_Length;
                        obj.F_Number = obj.Focal_Length / obj.Diameter;

                    case 'Pointing_Jitter'
                        obj = obj.SetPointingJitter(options.Pointing_Jitter);

                    case 'Wavelength'
                        obj = obj.SetWavelength(options.Wavelength);

                    otherwise
                        % Our default case is to just lookup the property by
                        % name in the class and the options struct and set it
                        obj.(opt) = options.(opt);
                end
            end

            obj.Magnification = obj.Focal_Length / obj.Eyepiece_Focal_Length;

        end


        function Telescope=SetWavelength(Telescope, Wavelength, options)
            arguments
                Telescope
                Wavelength
                options.Wavelength_Scale OrderOfMagnitude = 'nano'
            end
            %%SETWAVELENGTH set the wavelength (nm) of the transmitter
            factor = 10 ^ OrderOfMagnitude.Ratio("nano", options.Wavelength_Scale);
            Telescope.Wavelength = Wavelength * factor;
        end

        function Telescope=SetFarFieldDivergenceCoefficient(Telescope,FOV,Wavelength,Diameter)
            %%SETFARFIELDDIVERGENCECOEFFICIENT set the FFDC required to
            %%maintain a given FOV at a given wavelegngth

            if isempty(FOV)||isempty(Wavelength)
                Telescope.Far_Field_Divergence_Coefficient=1;
                return
            end

            Far_Field_Divergence_Coefficient=FOV/(2.44 *( Wavelength * 10^-9 )/ Diameter);

            %check that this farfield divergence coeff is not impossible
                if Far_Field_Divergence_Coefficient <1
                    warning('Requested FOV is narrower than diffraction limit. Reverting to diffraction limit');
                    Telescope.Far_Field_Divergence_Coefficient = 1;
                else
                    Telescope.Far_Field_Divergence_Coefficient = Far_Field_Divergence_Coefficient;
                end
        end

        function Telescope=SetDiameter(Telescope,Diameter)
            %%SETWAVELENGTH set the diameter (in m) of the transmitter
            Telescope.Diameter=Diameter;
        end

        function Telescope=SetPointingJitter(Telescope,Pointing_Jitter)
            %%SETPOINTINGJITTER set pointing jitter of the OGS
            Telescope.Pointing_Jitter=Pointing_Jitter;
        end

        function Telescope = SetFOV(Telescope, FOV)
            %%SETFOV set the FOV of a telescope by updating the far field
            %%divergence coefficient to suit

            if isempty(Telescope.Wavelength)
                error('cannot set FOV without first setting wavelength')
            end

            Telescope = SetFarFieldDivergenceCoefficient(Telescope,FOV,Telescope.Wavelength,Telescope.Diameter);

        end

        function Area = get.Collecting_Area(Telescope)
            %%COLLECTINGAREA return the total collecting area of the telescope in
            %%m^2

            Area = (pi/4)*Telescope.Diameter^2;
        end

        function FOV = get.FOV(Telescope)
            %%FOV return the FOV of the telescope in radians, computed by
            %%scaling the divergence limited FOV

            %compute the diffraction-limited FOV at a particular wavelength
            %with a modification
            %see
            % Chunmei Zhang, Alfonso Tello, Ugo Zanforlin, Gerald S. Buller,
            % and Ross J. Donaldson "Link loss analysis for a satellite quantum
            % communication down-link", Proc. SPIE 11540, Emerging Imaging and
            % Sensing Technologies for Security and Defence V; and Advanced
            % Manufacturing Technologies for Micro- and Nanosystems in Security
            % and Defence III, 1154007 (20 September 2020);
            % https://doi.org/10.1117/12.2573489
            FOV = 2.44 ...
                * Telescope.Far_Field_Divergence_Coefficient ...
                *( Telescope.Wavelength * 10^-9 ) ...
                / Telescope.Diameter;
        end
    end
end
