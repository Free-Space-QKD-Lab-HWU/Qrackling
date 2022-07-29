classdef Jamming_Laser < Background_Source & Telescope
    %JAMMING_LASER a Background_Source object which behaves as a deliberate adversarial jamming terminal
    % using properties inherited from the Transmitter class
    properties
        Spectral_Width;                                               %spectral width of the laser emission in nm
        Power;                                                        %emission power of the interference source in W
    end
    methods
        function obj = Jamming_Laser(Wavelength,Diameter,LLA,Power,Spectral_Width,varargin)
            %JAMMING_LASER Construct an instance of this class

            %% create an use inputParser
            P=inputParser();
            %required inputs
            addRequired(P,'Wavelength');
            addRequired(P,'Diameter');
            addRequired(P,'LLA');
            addRequired(P,'Power');
            addRequired(P,'Spectral_Width')
            %optional inputs of telescope
            addParameter(P,'Far_Field_Divergence_Coefficient',1);          %default FF divergence coefficient and optical efficiency to 1
            addParameter(P,'Optical_Efficiency',1);
            addParameter(P,'Location_Name','Janice')                                %default name to janice
            %parse inputs
            parse(P,Wavelength,Diameter,LLA,Power,Spectral_Width,varargin{:});

            %% first construct a transmitter object
            obj@Telescope(P.Results.Diameter,'Wavelength',P.Results.Wavelength,'Far_Field_Divergence_Coefficient',P.Results.Far_Field_Divergence_Coefficient,'Optical_Efficiency',P.Results.Optical_Efficiency);

            %% Then construct Background_Source parts
            Divergence_Angle=P.Results.Far_Field_Divergence_Coefficient*2.44*(P.Results.Wavelength*10^-9)/P.Results.Diameter;
            Spectral_Pointance=P.Results.Power/(P.Results.Spectral_Width*(pi/4)*Divergence_Angle^2);
            Wavelength_Limits=[P.Results.Wavelength-P.Results.Spectral_Width/2,P.Results.Wavelength+P.Results.Spectral_Width/2];
            obj@Background_Source(LLA,Spectral_Pointance,Wavelength_Limits,'Location_Name',P.Results.Location_Name);

            %% then record specific properties
            obj.Spectral_Width=P.Results.Spectral_Width;
            obj.Power=P.Results.Power;
        end

        function Jamming_Laser=SetWavelengthLimits(Jamming_Laser,Centre_Wavelength,Spectral_Width)
            %%SETWAVELENGTH set the wavelength limits (nm) of the transmitter

            Jamming_Laser.Wavelength=Centre_Wavelength;
            Jamming_Laser.Spectral_Width=Spectral_Width;
            Jamming_Laser.Wavelength_Limits=[Wavelength-Spectral_Width/2,Wavelength+Spectral_Width/2];
            Jamming_Laser.Divergence_Angle=2.44*Jamming_Laser.Far_Field_Divergence_Coefficient*(Jamming_Laser.Wavelength*10^-9)/Jamming_Laser.Diameter;
        end

        function Jamming_Laser=SetPointingJitter(Jamming_Laser,Pointing_Jitter)
            %%SETPOINTINGJITTER set pointing jitter of the Jamming laser
            Jamming_Laser.Pointing_Jitter=Pointing_Jitter;
        end

    end
end