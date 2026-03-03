classdef entanglementSingleDistribution < protocol.Proto

    % entanglementSingleDistribution
    %
    % A protocol which describes the distribution of one of an entangled
    % photon pair. this requires a detector at the transmitter
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
        num_receivers = 1;
    end

    methods

        function [secret_key_rate, entangled_bit_rate, qber] = qkdModel(protocol, ...
                alice, bob, total_loss, total_erroneous_count_rate)
            % qkdModel
            %
            % Computes the secret key rate (always 0), entangled photon
            % rate and fidelity of an entanglement distribution link
            % QBER is used to denote 1-Fidelity
            %
            % Syntax:
            % [zeros, entangled_bit_rate, qber] = protocol.entanglementDistribution.qkdModel(...)
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
                protocol (1,1) protocol.entanglementSingleDistribution
                alice { ...
                    nodes.mustBeReceiverOrTransmitter(alice), ...
                    nodes.mustHaveSource(alice) }
                bob { ...
                    nodes.mustBeReceiverOrTransmitter(bob), ...
                    nodes.mustHaveDetector(bob) }
                total_loss {mustBeNumeric}
                total_erroneous_count_rate {mustBeNumeric}
            end

            assert(isscalar(bob), ...
                "Can only support a single receiver, when alice has the source");

            loss_alice = alice.source.local_loss;
            loss_bob = total_loss;

            %entangled bit rate is just pair rate scaled down by the TOTAL
            %loss to both receivers
            correct_detection_probability = loss_alice .* loss_bob;
            entangled_bit_rate = correct_detection_probability .* alice.source.repetition_rate;

            %qber is the proportion of detector pairs which do not
            %correspond
            double_dark_count_probability = ...
                protocol.backgroundCountProbability(protocol.receiverDarkCountRate(alice),alice.detector.time_gate_width)*...
                protocol.backgroundCountProbability(total_erroneous_count_rate,bob.detector.time_gate_width);

            alice_dark_count_probability = protocol.receiverDarkCountRate(alice) * alice.detector.time_gate_width *loss_bob;
            bob_dark_count_probability = total_erroneous_count_rate * bob.detector.time_gate_width *loss_alice;


            qber_alice_dark_counts = 0.5 * alice_dark_count_probability .* loss_bob ./ (correct_detection_probability +  alice_dark_count_probability .* loss_bob);
            qber_bob_dark_counts = 0.5 * bob_dark_count_probability .* loss_alice ./ (correct_detection_probability + bob_dark_count_probability .* loss_alice);
            qber_both_dark_counts = 0.5 * double_dark_count_probability./ (correct_detection_probability + double_dark_count_probability);
            qber_state_prep_error = alice.source.state_prep_error;

            qber = protocol.combineQBER(qber_alice_dark_counts,qber_bob_dark_counts,qber_both_dark_counts,qber_state_prep_error);

            % deal with case where no counts are present from correct or
            % incorrect detections
            qber(total_erroneous_count_probability==0&correct_detection_probability==0)=0.5;

            secret_key_rate = zeros(size(qber));
        end
    end
end