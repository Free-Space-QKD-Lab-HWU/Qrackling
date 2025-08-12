function results = qkdFibreSimulation(receivers, transmitters, fibres, qkd_protocol)
% 2
%
% Architect and execute a fibre-based QKD simulation between transmitters
% and receivers using a specified protocol.
%
% Syntax:
% results = QKDFibreSimulation(receivers, transmitters, fibres, qkd_protocol)
%
% Inputs:
% receivers     - array of nodes.QKD_Receiver objects
% transmitters  - array of nodes.QKD_Transmitter objects
% fibres        - fibre.Fibre array representing link geometry
% qkd_protocol  - protocol.proto object defining QKD behavior
%
% Output:
% results       - array of fibre.FibreSimulationResult objects

    arguments
        receivers { ...
            nodes.mustBeReceiverOrTransmitter(receivers), ...
            nodes.mustHaveDetector(receivers) }
        transmitters { ...
            nodes.mustBeReceiverOrTransmitter(transmitters), ...
            nodes.mustHaveSource(transmitters) }
        fibres fibre.Fibre
        qkd_protocol protocol.Proto
    end


    %% Validate transmitter/receiver configuration
    qkd_protocol.mustHaveCorrectTransmittersAndReceivers(transmitters, receivers);


    %% Initialize loss and noise containers
    loss_results = repmat(nodes.LossResult(), ...
        [qkd_protocol.num_transmitters, qkd_protocol.num_receivers]);

    total_loss = zeros(qkd_protocol.num_transmitters, ...
        qkd_protocol.num_receivers, 0);

    noise_results = repmat(environment.Noise('', []), ...
        [qkd_protocol.num_transmitters, qkd_protocol.num_receivers, 0]);

    total_noise = zeros(qkd_protocol.num_transmitters, ...
        qkd_protocol.num_receivers, 0);

    ranges = fibres.length;


    %% Compute channel loss and noise
    for receiver_index = 1:qkd_protocol.num_receivers
        for transmitter_index = 1:qkd_protocol.num_transmitters

            [loss, noise] = lossAndNoiseForChannel( ...
                transmitters(transmitter_index), ...
                receivers(receiver_index), ...
                fibres(transmitter_index, receiver_index), ...
                qkd_protocol);

            loss_results(transmitter_index, receiver_index, 1) = loss;
            total_loss(transmitter_index, receiver_index, 1) = loss.totalLoss;
            noise_results(transmitter_index, receiver_index, 1:numel(noise)) = noise;
            total_noise(transmitter_index, receiver_index, 1) = noise.total;
        end
    end


    %% Evaluate QKD performance
    [secret_key_rate, sifted_key_rate, qber] = qkd_protocol.calculate( ...
        transmitters, receivers, total_loss, total_noise);


    %% Store results
    results = repmat(fibre.FibreSimulationResult.empty(), ...
        [qkd_protocol.num_transmitters, qkd_protocol.num_receivers]);

    for receiver_index = 1:qkd_protocol.num_receivers
        for transmitter_index = 1:qkd_protocol.num_transmitters
            results(transmitter_index, receiver_index) = fibre.FibreSimulationResult( ...
                transmitters(transmitter_index), ...
                receivers(receiver_index), ...
                qkd_protocol, ...
                datetime('now'), ...
                loss_results(transmitter_index, receiver_index), ...
                noise_results(transmitter_index, receiver_index, :), ...
                sifted_key_rate, secret_key_rate, qber, ...
                ranges(transmitter_index, receiver_index));
        end
    end
end


function [loss_results, noise] = lossAndNoiseForChannel(transmitter, receiver, fibre_model, qkd_protocol)
% lossAndNoiseForChannel
%
% Compute channel-specific loss and noise between a transmitter and receiver
% over a fibre link, using the specified QKD protocol.
%
% Syntax:
% [loss_results, noise] = lossAndNoiseForChannel(transmitter, receiver, fibre, qkd_protocol)
%
% Inputs:
% transmitter   - nodes.QKD_Transmitter object
% receiver      - nodes.QKD_Receiver object
% fibre         - fibre.Fibre object representing the link
% qkd_protocol  - protocol.proto object
%
% Outputs:
% loss_results  - nodes.LossResult object
% noise         - array of environment.Noise objects

    arguments
        transmitter (1, 1) { ...
            nodes.mustBeReceiverOrTransmitter(transmitter), ...
            nodes.mustHaveSource(transmitter) }
        receiver (1, 1) { ...
            nodes.mustBeReceiverOrTransmitter(receiver), ...
            nodes.mustHaveDetector(receiver) }
        fibre_model (1, 1) fibre.Fibre
        qkd_protocol protocol.Proto
    end


    %% Detector dark counts
    dark_counts = receiver.detector.dark_count_rate * qkd_protocol.num_detectors;

    noise = [ ...
        environment.Noise("Detector Dark Counts", dark_counts) ...
    ];


    %% Compute losses
    loss_results = fibre.linkLoss(fibre_model, receiver, transmitter, ...
        'source efficiency', ...
        'detector efficiency', ...
        'jitter', ...
        'fibre', ...
        'coupling');
end