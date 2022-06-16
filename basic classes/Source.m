classdef(Abstract) Source
    %Source object containing transmitter details


    properties(SetAccess=protected)
        Wavelength{mustBeScalarOrEmpty,mustBePositive};                    %wavelength of the source (in nm), set by the satellite it is mounted to
        Repetition_Rate{mustBeScalarOrEmpty,mustBeNonnegative}=10^9        %number of photon pulses per s (Hz)
        Efficiency{mustBeScalarOrEmpty,mustBePositive}=1;                  %transmitter power efficiencyend
    end
    properties(SetAccess=protected,Abstract=true)
    Protocol
    end

    methods
        function obj = Source(Wavelength,Repetition_Rate,Efficiency)
            %Transmitter Construct an instance of this class
            switch nargin
                case 1
            obj=SetWavelength(obj,Wavelength);
                case 2
            obj.Wavelength=Wavelength;
            obj.Repetition_Rate=Repetition_Rate;
                case 3
            obj.Wavelength=Wavelength;
            obj.Repetition_Rate=Repetition_Rate;
            obj.Efficiency=Efficiency;
                otherwise
                    error('to construct a source provide at least a wavelength (in nm) and optional repetition rate (Hz) and efficiency');
            end
        end

        function Source=SetWavelength(Source,Wavelength)
            %%SETWAVELENGTH set the wavelength (nm) of the transmitter
            Source.Wavelength=Wavelength;
        end
        function Source=SetRepetitionRate(Source,Repetition_Rate)
            Source.Repetition_Rate=Repetition_Rate;
        end
        
    end
end