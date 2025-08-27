classdef QKDSimulationResult
% QKDSimulationResult
%
% Abstract base class for storing and analyzing QKD simulation results.
% Subclasses must implement plot and empty methods.

    properties (Access = public)
        % transmitter - QKD transmitter node
        transmitter (1, 1) {utilities.mustBeSubclassOf(transmitter, 'nodes.QKDTransmitter')} = fibre.FibreNode.empty()

        % receiver - QKD receiver node
        receiver (1, 1) {utilities.mustBeSubclassOf(receiver, 'nodes.QKDReceiver')} = fibre.FibreNode.empty()

        % protocol - QKD protocol object
        protocol (1, 1) {utilities.mustBeSubclassOf(protocol, 'protocol.Proto')} = protocol.BB84()

        % time - simulation time vector
        time (1, :) = []

        % loss - total loss result
        loss nodes.LossResult {mustBeScalarOrEmpty} = nodes.LossResult.empty()

        % noise - array of noise sources
        noise environment.Noise = environment.Noise.empty(0, 0)

        % sifted_key_rate - sifted key rate over time
        sifted_key_rate (1, :) {mustBeNumeric} = []

        % secret_key_rate - secret key rate over time
        secret_key_rate (1, :) {mustBeNumeric} = []

        % qber - quantum bit error rate over time
        qber (1, :) {mustBeBetween(qber,0,1)} = []
    end

    properties (Dependent)
        % fidelity - calculated using qber
        fidelity (1,:) {mustBeBetween(fidelity,0,1)}

        % photon arrival rate - calculated using sifted key rate
        photon_arrival_rate (1, :) {mustBeNumeric}
    end

    methods
        function result = QKDSimulationResult( ...
                transmitter, receiver, protocol, time, ...
                loss, noise, sifted_key_rate, secret_key_rate, qber)
        % QKDSimulationResult constructor

            arguments
                transmitter (1, 1) {utilities.mustBeSubclassOf(transmitter, 'nodes.QKDTransmitter')}
                receiver (1, 1) {utilities.mustBeSubclassOf(receiver, 'nodes.QKDReceiver')}
                protocol (1, 1) {utilities.mustBeSubclassOf(protocol, 'protocol.Proto')}
                time (1, :) = []
                loss nodes.LossResult {mustBeScalarOrEmpty} = nodes.LossResult.empty()
                noise environment.Noise = environment.Noise.empty(0, 0)
                sifted_key_rate (1, :) {mustBeNumeric} = []
                secret_key_rate (1, :) {mustBeNumeric} = []
                qber (1, :) {mustBeNumeric} = []
            end

            result.transmitter = transmitter;
            result.receiver = receiver;
            result.protocol = protocol;
            result.time = time;
            result.loss = loss;
            result.noise = noise;
            result.sifted_key_rate = sifted_key_rate;
            result.secret_key_rate = secret_key_rate;
            result.qber = qber;
        end


        function [total_secret, total_sifted] = totalKeyRates(result)
        % total_key_rates
        %
        % Computes total secret and sifted key rates over valid communication windows.

            arguments
                result nodes.QKDSimulationResult
            end

            communicating = ~(isnan(result.secret_key_rate) | result.secret_key_rate <= 0);
            time = result.time(communicating);

            if iscolumn(time)
                time = time';
            end

            time_window_widths = time(2:end) - time(1:end-1);

            if isempty(time_window_widths)
                warning("No communication occurs in this simulation");
                total_secret = 0;
                total_sifted = 0;
                return
            end

            time_window_widths = [time_window_widths, time_window_widths(end)];

            if isnumeric(time_window_widths)
                total_sifted  = dot(time_window_widths, result.sifted_key_rate(communicating));
                total_secret = dot(time_window_widths, result.secret_key_rate(communicating));
            else
                time_seconds = seconds(time_window_widths);
                total_sifted  = dot(time_seconds, result.sifted_key_rate(communicating));
                total_secret = dot(time_seconds, result.secret_key_rate(communicating));
            end
        end
    
        function fid = get.fidelity(Result)
        % get.fidelity
        %
        % compute fidelity using 1-QBER
        fid = 1 - Result.qber;
        end

        function par = get.photon_arrival_rate(Result)
        % get.photon_arrival_rate
        %
        % compute photon arrival rate by using sifted key rate
        par = Result.sifted_key_rate/Result.protocol.efficiency;
        end
    end

    methods (Abstract)
        fig = plot(result)
    end

    methods (Abstract, Static)
        result = empty()
    end
end