classdef Source
    % Source
    %
    % Transmitter source model containing key parameters for a QKD system.
    % Stores wavelength, repetition rate, state probabilities, and losses.
    %
    % Syntax:
    %   src = components.Source(wavelength, options)
    %
    % Additional options and defaults are given in the constructor.

    properties (SetAccess = protected)
        % Wavelength of the source (nm), set by the mounting platform.
        wavelength {mustBeScalarOrEmpty, mustBePositive}

        % Wavelength units (e.g., 'nano' for nm).
        units units.Magnitude

        % Number of photon pulses per second (Hz).
        repetition_rate {mustBeScalarOrEmpty, mustBeNonnegative} = 1e9

        % Transmitter power efficiency (fraction).
        efficiency {mustBeScalarOrEmpty, mustBePositive} = 1

        % Average photons per pulse for signal, vacuum, decoy.
        mpn_signal {mustBeNumeric, mustBeNonnegative} = 0.01
        mpn_vacuum {mustBeNumeric, mustBeNonnegative} = 0
        mpn_decoy  {mustBeNumeric, mustBeNonnegative} % optional

        % State preparation error fraction.
        state_prep_error {mustBeScalarOrEmpty, mustBeNonnegative} = 0.01

        % Normalised autocorrelation at zero delay (g2).
        g2 {mustBeScalarOrEmpty, mustBeNonnegative} = 0.01

        % Probabilities of emitting different states.
        probability_signal {mustBeNumeric, mustBeNonnegative, ...
            mustBeLessThanOrEqual(probability_signal, 1)}
        probability_decoy {mustBeNumeric, mustBeNonnegative, ...
            mustBeLessThanOrEqual(probability_decoy, 1)}

        % Loss between source and local receiver for entanglement protocols.
        local_loss {mustBeInRange(local_loss, 0, 1)} = 1
    end

    properties(Dependent)
        %probability of no photon sent
        probability_vacuum {mustBeNumeric, mustBeNonnegative, ...
            mustBeLessThanOrEqual(probability_vacuum, 1)}
    end

    methods
        function obj = Source(wavelength, options)
            % Source constructor.
            %
            % Syntax:
            %   obj = Source(wavelength, options)
            %
            % Inputs:
            %   wavelength - (1,1) double, wavelength in given units
            %   options    - name-value arguments for other parameters
            %
            % Outputs:
            %   obj        - Source object

            arguments
                wavelength
                options.Wavelength_Scale units.Magnitude = "nano"
                options.Repetition_Rate = 1e9
                options.Efficiency = 1
                options.MPN_Signal = 0.01
                options.MPN_Decoy
                options.State_Prep_Error = 0.01
                options.g2 = 0.01
                options.Probability_Signal {mustBeNumeric, ...
                    mustBeNonnegative, ...
                    mustBeLessThanOrEqual(options.Probability_Signal, 1)} = 1
                options.Probability_Decoy {mustBeNumeric, ...
                    mustBeNonnegative, ...
                    mustBeLessThanOrEqual(options.Probability_Decoy, 1)}
                options.Local_Loss {mustBeInRange(options.Local_Loss, 0, 1)} = 1
            end

            for option = fieldnames(options)'
                opt = option{1};
                switch opt
                    case 'Wavelength_Scale'
                        obj = obj.setWavelength(wavelength, ...
                            "Wavelength_Scale", options.Wavelength_Scale);
                    case 'Repetition_Rate'
                        obj = obj.setRepetitionRate(options.Repetition_Rate);
                    otherwise
                        obj.(matlab.lang.makeValidName(lower(opt))) = ...
                            options.(opt);
                end
            end
        end

        function p_vacuum = get.probability_vacuum(obj)
            % updateVacuumProbability
            %
            % Calculate and set the vacuum state probability based on the
            % configured signal and (optionally) decoy state probabilities.
            % If the decoy probability is not set, vacuum is simply
            % 1 − probability_signal.

            arguments
                obj
            end

            if isempty(obj.probability_decoy)
                obj.probability_vacuum = 1 - obj.probability_signal;
                return
            end

            total_probability = obj.probability_signal + obj.probability_decoy;

            if total_probability > 1
                error('probabilities of signal and decoy must not sum to more than 1');
            end

            p_vacuum = 1 - total_probability;
        end


        function obj = setWavelength(obj, wavelength, options)
            % setWavelength
            %
            % Set the wavelength (nm) of the source.
            %
            % Syntax:
            %   obj = setWavelength(obj, wavelength, options)
            %
            % Inputs:
            %   wavelength - (1,1) double, wavelength to set
            %   options    - struct with field Wavelength_Scale
            %
            % Outputs:
            %   obj        - updated Source object

            arguments
                obj
                wavelength
                options.Wavelength_Scale units.Magnitude = "nano"
            end

            obj.wavelength = units.Magnitude.convert( ...
                options.Wavelength_Scale, "nano", wavelength);
            obj.units = options.Wavelength_Scale;
        end


        function obj = setRepetitionRate(obj, repetition_rate)
            % setRepetitionRate
            %
            % Set the repetition rate (Hz) of the source.

            obj.repetition_rate = repetition_rate;
        end


        function obj = setEfficiency(obj, efficiency)
            % setEfficiency
            %
            % Set the transmitter/source efficiency (fraction).

            obj.efficiency = efficiency;
        end


        function obj = setMeanPhotonNumber(obj, state, mean_photon_number)
            % setMeanPhotonNumber
            %
            % Set the mean photon number for the given state.
            %
            % Inputs:
            %   state              - 'Signal' or 'Decoy'
            %   mean_photon_number - nonnegative double

            arguments
                obj
                state {mustBeMember(state, {"Signal", "Decoy"})}
                mean_photon_number {mustBeNumeric, mustBeNonnegative}
            end

            switch state
                case "Signal"
                    obj.mpn_signal = mean_photon_number;
                case "Decoy"
                    obj.mpn_decoy = mean_photon_number;
            end
        end


        function obj = setStateProbabilities(obj, state, probability)
            % setStateProbabilities
            %
            % Set the probability of a given state and update the vacuum
            % probability accordingly.
            %
            % Inputs:
            %   state       - 'Signal' or 'Decoy'
            %   probability - (1,1) double in [0,1]

            arguments
                obj
                state {mustBeMember(state, {"Signal", "Decoy"})}
                probability {mustBeNumeric, mustBeNonnegative, ...
                    mustBeLessThanOrEqual(probability, 1)}
            end

            switch state
                case "Signal"
                    obj.probability_signal = probability;
                case "Decoy"
                    obj.probability_decoy = probability;
            end

            obj = obj.updateVacuumProbability();
        end


        function obj = setg2(obj, g2_value)
            % setg2
            %
            % Set the g2 value for the source.

            obj.g2 = g2_value;
        end


        function obj = setStatePrepError(obj, state_prep_error)
            % setStatePrepError
            %
            % Set the probability of preparing a quantum state incorrectly.

            obj.state_prep_error = state_prep_error;
        end
    end
end