classdef Telescope
    %TELESCOPE contain the relevant properties of optical systems for
    %transmitters and receivers

    properties
        Diameter{mustBeScalarOrEmpty,mustBePositive}=0.08;                 %diameter of the transmitter in m
        Far_Field_Divergence_Coefficient{mustBeScalarOrEmpty,mustBePositive}=1;%ratio between theoretical and acutal far field divergence angle
        Optical_Efficiency{mustBeScalarOrEmpty,mustBePositive}=0.6;        %optical efficiency- from cassegrain telescope obscuration (Link loss analysis for a satellite quantum communication downlink, Single photon group)
        Pointing_Jitter{mustBeScalarOrEmpty,mustBePositive}=10^-6;         %rms error in pointing in radians
    end
    properties(SetAccess=protected)
        Wavelength{mustBeScalarOrEmpty,mustBePositive};                    %wavelength of the transmitter (in nm), set by the satellite it is mounted to
        FOV{mustBeScalarOrEmpty,mustBeNonnegative}                         %angle in rads describing spread of photons as the propagate
    end

    methods
        function obj = Telescope(Diameter,Wavelength,Optical_Efficiency,Far_Field_Divergence_Coefficient)
            %%TELESCOPE construct a telescope object

            %   wavelength can be left blank for implementation inside
            %   another object which determines its wavelength
            obj.Diameter = Diameter;
            if nargin>=2
                obj=SetWavelength(obj,Wavelength);
                if nargin>=3
                    obj.Optical_Efficiency=Optical_Efficiency;
                    if nargin>=4
                        obj.Far_Field_Divergence_Coefficient=Far_Field_Divergence_Coefficient;
                    end
                end
            end
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
    end
end