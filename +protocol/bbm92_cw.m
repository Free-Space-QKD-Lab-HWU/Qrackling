classdef bbm92_cw
    properties
        source_features   = {'Mean_Photon_Number', 'Coincidence_Window', 'State_Prep_Error'}
        detector_features = {'Dark_Count_Rate'}
        efficiency = 0.5
    end

    methods
        function [sifted_key_rate, secret_key_rate, qber] = QkdModel( ...
            protocol, Alice, Bob, dark_count_prob, channel_loss)

            arguments
                protocol
                Alice { ...
                    mustBeA(Alice, ["protocol.Alice", "nodes.Satellite", "nodes.Ground_Station"]), ...
                    nodes.mustHaveSource(Alice)}
                Bob { ...
                    mustBeA(Bob, ["protocol.Bob", "nodes.Satellite", "nodes.Ground_Station"]), ...
                    nodes.mustHaveDetector(Bob)}
                dark_count_prob
                channel_loss
            end

            [~] = [protocol, Alice, Bob, dark_count_prob, channel_loss];
            secret_key_rate = 1;
            sifted_key_rate = 1;
            qber = 1;

        end
    end
end
