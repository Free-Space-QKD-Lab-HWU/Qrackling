classdef PassSimulationResultNext
    properties
        transmitter_name = []
        receiver_name = []
        direction nodes.LinkDirection = nodes.LinkDirection.empty(0,0)
        heading (:, :) {mustBeNumeric} = []
        elevation (:, :) {mustBeNumeric} = []
        range (:, :) {mustBeNumeric} = []
        time (:, :) = []
        elevation_limit = 0
        loss nodes.LossResult = nodes.LossResult.empty(0, 0)
        noise environment.Noise = environment.Noise.empty(0, 0)
        sifted_key_rate (1, :) {mustBeNumeric} = []
        secret_key_rate (1, :) {mustBeNumeric} = []
        qber (1, :) {mustBeNumeric} = []
    end

    methods
        function result = PassSimulationResultNext(receiver, transmitter, ...
            link_direction, heading, elevation, range, time, limit, ...
            loss, noise, ...
            sifted_key_rate, secret_key_rate, qber)
            arguments
                receiver { ...
                    nodes.mustBeReceiverOrTransmitter(receiver), ...
                    nodes.mustHaveDetector(receiver) } = {}
                transmitter { ...
                    nodes.mustBeReceiverOrTransmitter(transmitter), ...
                    nodes.mustHaveSource(transmitter) } = {}
                link_direction nodes.LinkDirection = nodes.LinkDirection.empty(0,0)
                heading (:, :) {mustBeNumeric} = []
                elevation (:, :) {mustBeNumeric} = []
                range (:, :) {mustBeNumeric} = []
                time (:, :) = []
                limit {mustBeNumeric} = 0
                loss nodes.LossResult = nodes.LossResult.empty(0, 0)
                noise environment.Noise = environment.Noise.empty(0, 0)
                sifted_key_rate (1, :) {mustBeNumeric} = []
                secret_key_rate (1, :) {mustBeNumeric} = []
                qber (1, :) {mustBeNumeric} = []
            end

            if isscalar(transmitter)
                result.transmitter_name = utilities.node_name(transmitter);
            else
                result.transmitter_name = ...
                    cellfun(@(tx) utilities.node_name(tx), transmitter, ...
                            "UniformOutput", false);
            end

            if isscalar(receiver)
                result.receiver_name = utilities.node_name(receiver);
            else
                result.receiver_name = ...
                    cellfun(@(tx) utilities.node_name(tx), receiver, ...
                            "UniformOutput", false);
            end

            result.direction = link_direction;
            result.heading = heading;
            result.elevation = elevation;
            result.range = range;
            result.time = time;
            result.elevation_limit = limit;
            result.loss = loss;
            result.noise = noise;
            result.sifted_key_rate = sifted_key_rate;
            result.secret_key_rate = secret_key_rate;
            result.qber = qber;
        end
    end
end


