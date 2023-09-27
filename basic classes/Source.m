classdef Source
    %Source object containing transmitter details

    properties(SetAccess = protected)
        %wavelength of the source (in nm),  set by the satellite it is mounted to
        Wavelength{mustBeScalarOrEmpty, mustBePositive};

        %number of photon pulses per s (Hz)
        Repetition_Rate{mustBeScalarOrEmpty, mustBeNonnegative} = 10^9;

        %transmitter power efficiency
        Efficiency{mustBeScalarOrEmpty, mustBePositive} = 1;

        %average number of photons per pulse
        Mean_Photon_Number{mustBeVector, mustBeNonnegative} = 0.01;

        %convolution of errors due to state preparation (as a fraction)
        State_Prep_Error{mustBeScalarOrEmpty, mustBeNonnegative} = 0.01;

        %normalised autocorrelation of emitted photon at zero delay
        g2{mustBeScalarOrEmpty, mustBeNonnegative} = 0.01;

        %probability of emitting the different states used (for decoyBB84 and COW)
        State_Probabilities{mustBeNumeric,  mustBeNonnegative,  mustBeLessThanOrEqual(State_Probabilities,  1)} = 1;

    end

    methods
        % function obj  =  Source(Wavelength, varargin)
        %     %%SOURCE construct a source object

        function obj = Source(Wavelength, options)
            arguments (Input)
                Wavelength
                options.Wavelength_Scale OrderOfMagnitude = "nano"
                options.Repetition_Rate = 1e9
                options.Efficiency = 1
                options.Mean_Photon_Number = 0.01
                options.State_Prep_Error = 0.01
                options.g2 = 0.01
                options.State_Probabilities = 1
            end

            % BUG: Why is Wavelength assigned to anything

            for option = fieldnames(options)'
                opt = option{1};
                switch opt
                    case 'Wavelength_Scale'
                        obj = obj.SetWavelength(Wavelength, ...
                            "Wavelength_Scale", options.Wavelength_Scale);
                    case 'Repetition_Rate'
                        obj = obj.SetRepetitionRate(options.Repetition_Rate);
                    otherwise
                        obj.(opt) = options.(opt);
                end
            end

        end

        function Source = SetWavelength(Source, Wavelength, options)
            arguments
                Source
                Wavelength
                options.Wavelength_Scale OrderOfMagnitude = OrderOfMagnitude.nano
            end
            %%SETWAVELENGTH set the wavelength (nm) of the source
            factor = 10 ^ OrderOfMagnitude.Ratio("nano", options.Wavelength_Scale);
            Source.Wavelength = Wavelength * factor;
        end

        function Source = SetRepetitionRate(Source, Repetition_Rate)
            %%SETREPETITIONRATE set the repetition rate (Hz) of the source
            Source.Repetition_Rate = Repetition_Rate;
        end

        function Source = SetEfficiency(Source, Efficiency)
            %%SETEFICIENCY set the source efficiency
            Source.Efficiency = Efficiency;
        end

        function Source = SetStates(Source, MPNs, State_Probabilities)
            %%SETSTATES set the mean photon number and state probabilities
            %%of the source for decoy BB84

            %% input validation
            if ~numel(MPNs) == numel(State_Probabilities)
                error('State mean photon numbers and probabilities must have equal numbers of elements')
            end
            Source = SetMeanPhotonNumber(Source, MPNs);
            Source = SetStateProbabilities(Source, State_Probabilities);
        end

        function Source = SetMeanPhotonNumber(Source, Mean_Photon_Number)
            %%SETMEANPHOTONNUMBER set the mean photon number(s) of the
            %%source
            Source.Mean_Photon_Number = Mean_Photon_Number;
        end

        function Source = SetStateProbabilities(Source, State_Probabilities)
            %%SETSTATEPROBABILITIES set the probabilities of states for the
            %%source
            Source.State_Probabilities = State_Probabilities;
        end

        function Source = Setg2(Source, g2)
            %%SETG2 set the g2 value of the source
            Source.g2 = g2;
        end

        function Source = SetStatePrepError(Source, State_Prep_Error)
            %%SETSTATEPREPERROR set the probability of a quantum state
            %%being prepared incorrectly
            Source.State_Prep_Error = State_Prep_Error;
        end

    end
end
