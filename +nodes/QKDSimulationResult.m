classdef QKDSimulationResult
    %%SIMULATIONRESULT a notionally abstract class which provides an interface for
    %%simulation results
    properties (Access=public)
        transmitter (1,1) {utilities.mustBeSubclassOf(transmitter,'nodes.QKD_Transmitter')} = fibre.Fibre_Node.empty()
        receiver (1,1) {utilities.mustBeSubclassOf(receiver,'nodes.QKD_Receiver')} = fibre.Fibre_Node.empty()
        protocol (1,1) {utilities.mustBeSubclassOf(protocol,'protocol.proto')} = protocol.bb84()
        time (1, :) = []
        loss nodes.LossResult {mustBeScalarOrEmpty} = nodes.LossResult.empty()
        noise environment.Noise = environment.Noise.empty(0,0)
        sifted_key_rate (1, :) {mustBeNumeric} = []
        secret_key_rate (1, :) {mustBeNumeric} = []
        qber (1, :) {mustBeNumeric} = []
    end

    methods
        function result = QKDSimulationResult(transmitter,...
                                       receiver,...
                                       protocol,...
                                       time,...
                                       loss,...
                                       noise,...
                                       sifted_key_rate,...
                                       secret_key_rate,...
                                       qber)
            arguments
                    transmitter (1,1) {utilities.mustBeSubclassOf(transmitter,'nodes.QKD_Transmitter')}
                    receiver (1,1) {utilities.mustBeSubclassOf(receiver,'nodes.QKD_Receiver')}
                    protocol (1,1) {utilities.mustBeSubclassOf(protocol,'protocol.proto')}
                    time (1, :) = []
                    loss nodes.LossResult {mustBeScalarOrEmpty} = nodes.LossResult.empty()
                    noise environment.Noise = environment.Noise.empty(0, 0)
                    sifted_key_rate (1, :) {mustBeNumeric} = []
                    secret_key_rate (1, :) {mustBeNumeric} = []
                    qber (1, :) {mustBeNumeric} = []
            end

            %record data
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

        function [total_secret, total_sifted] = total_key_rates(result)
            arguments
                result nodes.QKDSimulationResult
            end

            %% get data
            communicating = ~(isnan(result.secret_key_rate) | (result.secret_key_rate <= 0));
            time = result.time(communicating);
            %time should be a row vector
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

            %pad to match width of other arrays
            time_window_widths = [time_window_widths,time_window_widths(end)];

            if isnumeric(time_window_widths)
                total_sifted  = dot(time_window_widths, result.sifted_key_rate(communicating));
                total_secret = dot(time_window_widths, result.secret_key_rate(communicating));
                return
            end

            time_seconds = seconds(time_window_widths);
            total_sifted  = dot(time_seconds, result.sifted_key_rate(communicating));
            total_secret = dot(time_seconds, result.secret_key_rate(communicating));
        end
    end

    %new SimulationResult objects must implement these methods
    methods (Abstract)
         fig = plot(result)
    end
    methods (Abstract,Static)
         result = empty()
    end
end
