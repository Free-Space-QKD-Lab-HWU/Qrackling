classdef Telescope
    %TELESCOPE contain the relevant properties of optical systems for
    %transmitters and receivers

    properties
        Diameter{mustBeScalarOrEmpty,mustBePositive}                       %diameter of the transmitter in m
        Far_Field_Divergence_Coefficient{mustBeScalarOrEmpty,mustBePositive}=1;%ratio between theoretical and acutal far field divergence angle
        Optical_Efficiency{mustBeScalarOrEmpty,mustBePositive}=0.6;        %optical efficiency- from cassegrain telescope obscuration (Link loss analysis for a satellite quantum communication downlink, Single photon group)
        Pointing_Jitter{mustBeScalarOrEmpty,mustBePositive}=10^-6;         %rms error in pointing in radians
    end
    properties(SetAccess=protected)
        Wavelength{mustBeScalarOrEmpty,mustBePositive};                    %wavelength of the transmitter (in nm), set by the satellite it is mounted to
        FOV{mustBeScalarOrEmpty,mustBeNonnegative}                         %angle in rads describing spread of photons as the propagate
    end

    methods
        function obj = Telescope(Diameter,varargin)
            %%TELESCOPE construct a telescope object

            %% create and use input parser
            P=inputParser();
            %required inputs
            addRequired(P,'Diameter')

            %optional inputs
            addParameter(P,'Wavelength',[])
            addParameter(P,'Optical_Efficiency',obj.Optical_Efficiency);
            addParameter(P,'Far_Field_Divergence_Coefficient',obj.Far_Field_Divergence_Coefficient);
            addParameter(P,'Pointing_Jitter',obj.Pointing_Jitter);
            %parse inputs
            parse(P,Diameter,varargin{:});

            %% set values
            obj.Diameter=P.Results.Diameter;
            obj.Far_Field_Divergence_Coefficient=P.Results.Far_Field_Divergence_Coefficient;
            obj.Optical_Efficiency=P.Results.Optical_Efficiency;
            obj=SetPointingJitter(obj,P.Results.Pointing_Jitter);
            obj=SetWavelength(obj,P.Results.Wavelength);

        end

        function Telescope=SetWavelength(Telescope,Wavelength)
            %%SETWAVELENGTH set the wavelength (nm) of the transmitter
            Telescope.Wavelength=Wavelength;
            Telescope.FOV=2.44*Telescope.Far_Field_Divergence_Coefficient*(Telescope.Wavelength*10^-9)/Telescope.Diameter;
        end

        function Telescope=SetDiameter(Telescope,Diameter)
            %%SETWAVELENGTH set the diameter (in m) of the transmitter
            Telescope.Diameter=Diameter;
            Telescope.FOV=2.44*Telescope.Far_Field_Divergence_Coefficient*(Telescope.Wavelength*10^-9)/Telescope.Diameter;
        end

        function Telescope=SetPointingJitter(Telescope,Pointing_Jitter)
            %%SETPOINTINGJITTER set pointing jitter of the OGS
            Telescope.Pointing_Jitter=Pointing_Jitter;
        end

        function Telescope = SetFOV(Telescope, FOV)
            %%SETFOV set the FOV of a telescope and update the far field
            %%divergence coefficient to suit
            Telescope.FOV = FOV;
        end
    end
end