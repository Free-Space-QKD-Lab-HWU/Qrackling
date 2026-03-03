classdef entanglementDoubleDistribution < protocol.Proto

    % entanglementDoubleDistribution
    %
    % A protocol which describes the distribution of both of an entangled
    % photon pair. this requires two receivers and two channel losses
    %
    % Syntax:
    % Output = protocol.entanglementSingleDistribution(Input1, Input2, …)

    properties (SetAccess = protected)
        method = 'entanglement';
        source_features = protocol.SourceRequirements.features( ...
            "MPN_Signal", "Local_Loss", "State_Prep_Error");
        detector_features = protocol.DetectorRequirements.features("Dark_Count_Rate");
        efficiency = 1;
        num_detectors = 4;
        name = 'Entanglement distribution';

        num_transmitters = 1;
        num_receivers = 2;
    end

    methods

        function [secret_key_rate, entangled_bit_rate, qber] = qkdModel(protocol, ...
                alice, bobs, total_loss, total_erroneous_count_rate)
            % qkdModel
            %
            % Computes the secret key rate (always 0), entangled photon
            % rate and fidelity of an entanglement distribution link
            % QBER is used to denote 1-Fidelity
            %
            % Syntax:
            % [zeros, entangled_bit_rate, qber] = protocol.entanglementDoubleDistribution.qkdModel(...)
            %
            % Inputs:
            % protocol - (1x1) BBM92 object
            % alice - (1x1) node with source and detector
            % bob - (1x1) node with detector
            % total_loss - (1xN) numeric, total channel loss
            % total_erroneous_count_rate - (1xN) numeric, external noise rate
            %
            % Outputs:
            % secret_key_rate - (1xN) numeric, final secure key rate
            % sifted_key_rate - (1xN) numeric, sifted key rate
            % qber - (1xN) numeric, quantum bit error rate

            arguments
                protocol (1,1) protocol.entanglementDoubleDistribution
                alice { ...
                    nodes.mustBeReceiverOrTransmitter(alice), ...
                    nodes.mustHaveSource(alice) }
                bobs { ...
                    nodes.mustBeReceiverOrTransmitter(bobs), ...
                    nodes.mustHaveDetector(bobs) }
                total_loss {mustBeNumeric}
                total_erroneous_count_rate {mustBeNumeric}
            end

            % losses on two channels
            loss_bob_1 = total_loss(1, :);
            loss_bob_2 = total_loss(2, :);

            % background counts on two channels
            background_probability_bob_1 = protocol.backgroundCountProbability( ...
                squeeze(total_erroneous_count_rate(1, 1, :)), bobs(1).detector.time_gate_width)';

            background_probability_bob_2 = protocol.backgroundCountProbability( ...
                squeeze(total_erroneous_count_rate(1, 2, :)), bobs(2).detector.time_gate_width)';

            %entangled bit rate is just pair rate scaled down by the TOTAL
            %loss to both receivers
            correct_double_detection_probability = loss_bob_1 .* loss_bob_2;
            entangled_bit_rate = correct_double_detection_probability .* alice.source.repetition_rate;

            %qber is the proportion of detector pairs which do not
            %correspond
            double_dark_count_probability = ...
                background_probability_bob_1 .* background_probability_bob_2;

            bob_1_background_count_probability = protocol.backgroundCountProbability(total_erroneous_count_rate(1,1,:),bobs(1).detector.time_gate_width);
            bob_2_background_count_probability = protocol.backgroundCountProbability(total_erroneous_count_rate(1,2,:),bobs(2).detector.time_gate_width);

            qber_bob_1_dark_counts = 0.5 * bob_1_background_count_probability .* loss_bob_2 ./ (correct_detection_probability +  bob_1_background_count_probability .* loss_bob_2);
            qber_bob_2_dark_counts = 0.5 * bob_2_background_count_probability .* loss_bob_1 ./ (correct_detection_probability +  bob_2_background_count_probability .* loss_bob_1);
            qber_both_dark_counts = 0.5 * double_dark_count_probability./ (correct_detection_probability + double_dark_count_probability);
            qber_state_prep_error = alice.source.state_prep_error;

            qber = protocol.combineQBER(qber_bob_1_dark_counts,qber_bob_2_dark_counts,qber_both_dark_counts,qber_state_prep_error);

            % deal with case where no counts are present from correct or
            % incorrect detections
            qber(total_erroneous_count_probability==0&correct_detection_probability==0)=0.5;


            secret_key_rate = zeros(size(qber));
        end
    end
end