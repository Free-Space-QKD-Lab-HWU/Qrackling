classdef Jamming_Laser < Background_Source & Telescope
    %JAMMING_LASER a Background_Source object which behaves as a deliberate adversarial jamming terminal
    % using properties inherited from the Transmitter class
    properties
        Spectral_Width;                                               %spectral width of the laser emission in nm
        Power;                                                        %emission power of the interference source in W
    end
    methods
        function obj = Jamming_Laser(Wavelength,Diameter,LLA,name,Power,Spectral_Width)
            %JAMMING_LASER Construct an instance of this class
            
            %% first construct a transmitter object
            obj@Telescope(Diameter,Wavelength)

            %% Then construct Background_Source parts
            Divergence_Angle=2.44*(Wavelength*10^-9)/Diameter;
            Spectral_Pointance=Power/(Spectral_Width*(pi/4)*Divergence_Angle^2);
            Wavelength_Limits=[Wavelength-Spectral_Width/2,Wavelength+Spectral_Width/2];
            obj@Background_Source(LLA,Spectral_Pointance,Wavelength_Limits,name);

            %% then record specific properties
            obj.Spectral_Width=Spectral_Width;
            obj.Power=Power;
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