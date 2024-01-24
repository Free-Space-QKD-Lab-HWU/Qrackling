classdef Source
    %Source object containing transmitter details

    properties(SetAccess = protected)
        %wavelength of the source (in nm),  set by the satellite it is mounted to
        Wavelength{mustBeScalarOrEmpty, mustBePositive};
        Units units.Magnitude

        %number of photon pulses per s (Hz)
        Repetition_Rate{mustBeScalarOrEmpty, mustBeNonnegative} = 10^9;

        %transmitter power efficiency
        Efficiency{mustBeScalarOrEmpty, mustBePositive} = 1;

        %average number of photons per pulse
        MPN_Signal {mustBeNumeric, mustBeNonnegative} = 0.01
        MPN_Vacuum {mustBeNumeric, mustBeNonnegative} = 0
        MPN_Decoy {mustBeNumeric, mustBeNonnegative} % optional

        %convolution of errors due to state preparation (as a fraction)
        % NOTE: Error when encoding polariation, i.e. accidentally encoding 'H'
        % when trying to encode 'V'
        State_Prep_Error{mustBeScalarOrEmpty, mustBeNonnegative} = 0.01;

        %normalised autocorrelation of emitted photon at zero delay
        g2{mustBeScalarOrEmpty, mustBeNonnegative} = 0.01;

        %probability of emitting the different states used (for decoyBB84 and COW)
        Probability_Signal { ...
                    mustBeNumeric, ...
                    mustBeNonnegative, ...
                    mustBeLessThanOrEqual(Probability_Signal, 1)}
        Probability_Vacuum { ...
                    mustBeNumeric, ...
                    mustBeNonnegative, ...
                    mustBeLessThanOrEqual(Probability_Vacuum, 1)}
        Probability_Decoy { ...
                    mustBeNumeric, ...
                    mustBeNonnegative, ...
                    mustBeLessThanOrEqual(Probability_Decoy, 1)}
    end

    methods
        % function obj  =  Source(Wavelength, varargin)
        %     %%SOURCE construct a source object

        function obj = Source(Wavelength, options)
            arguments
                Wavelength
                options.Wavelength_Scale units.Magnitude = "nano"
                options.Repetition_Rate = 1e9
                options.Efficiency = 1
                options.MPN_Signal = 0.01
                options.MPN_Decoy
                options.State_Prep_Error = 0.01
                options.g2 = 0.01
                options.Probability_Signal { ...
                    mustBeNumeric, ...
                    mustBeNonnegative, ...
                    mustBeLessThanOrEqual(options.Probability_Signal, 1)} = 1
                options.Probability_Decoy { ...
                    mustBeNumeric, ...
                    mustBeNonnegative, ...
                    mustBeLessThanOrEqual(options.Probability_Decoy, 1)}
            end

            % BUG: Why isn't Wavelength assigned to anything

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

            obj = obj.UpdateVacuumProbability();

        end

        function Source = UpdateVacuumProbability(Source)
            arguments
                Source
            end

            if isempty(Source.Probability_Decoy)
                Source.Probability_Vacuum = 1 - Source.Probability_Signal;
                return
            end


            total_probability = Source.Probability_Signal + Source.Probability_Decoy;

            msg = [sprintf( ...
                '\nSum of state probabilities exceeds 1:\n\tSignal = %s\n\tVacuum = % s\n\tDecoy = %s\n\t', ...
                Source.Probability_Signal, ...
                1 - total_probability, ...
                Source.Probability_Decoy), ...
                'This has resulted in negative vacuum probability'];

            if total_probability > 1;
                error(msg)
            end
            Source.Probability_Vacuum = 1 - total_probability;
        end

        function Source = SetWavelength(Source, Wavelength, options)
            arguments
                Source
                Wavelength
                options.Wavelength_Scale units.Magnitude = "nano"
            end
            %%SETWAVELENGTH set the wavelength (nm) of the source
            Source.Wavelength = units.Magnitude.Convert( ...
                options.Wavelength_Scale, "nano", Wavelength);
            Source.Units = options.Wavelength_Scale;
        end

        function Source = SetRepetitionRate(Source, Repetition_Rate)
            %%SETREPETITIONRATE set the repetition rate (Hz) of the source
            Source.Repetition_Rate = Repetition_Rate;
        end

        function Source = SetEfficiency(Source, Efficiency)
            %%SETEFICIENCY set the source efficiency
            Source.Efficiency = Efficiency;
        end

        % function Source = SetStates(Source, MPNs, State_Probabilities)
        %     %%SETSTATES set the mean photon number and state probabilities
        %     %%of the source for decoy BB84

        %     %% input validation
        %     if ~numel(MPNs) == numel(State_Probabilities)
        %         error('State mean photon numbers and probabilities must have equal numbers of elements')
        %     end
        %     Source = SetMeanPhotonNumber(Source, MPNs);
        %     Source = SetStateProbabilities(Source, State_Probabilities);
        % end

        function Source = SetMeanPhotonNumber(Source, State, Mean_Photon_Number)
            arguments
                Source
                State {mustBeMember(State, {"Signal", "Decoy"})}
                Mean_Photon_Number {mustBeNumeric, mustBeNonnegative}
            end
            %%SETMEANPHOTONNUMBER set the mean photon number(s) of the
            %%source
            switch State
            case "Signal"
                Source.MPN_Signal = Mean_Photon_Number;
            case "Decoy"
                Source.MPN_Decoy = Mean_Photon_Number;
            end
        end

        function Source = SetStateProbabilities(Source, State, Probability)
            arguments
                Source
                State {mustBeMember(State, {"Signal", "Decoy"})}
                Probability { ...
                    mustBeNumeric, ...
                    mustBeNonnegative, ...
                    mustBeLessThanOrEqual(Probability, 1)}
            end
            %%SETSTATEPROBABILITIES set the probabilities of states for the
            %%source
            %Source.State_Probabilities = State_Probabilities;
            switch State
            case "Signal"
                Source.Probability_Signal = Probability;
            case "Decoy"
                Source.Probability_Decoy = Probability
            end

            Source = Source.UpdateVacuumProbability();
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
