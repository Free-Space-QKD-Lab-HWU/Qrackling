classdef protocol

    properties(SetAccess = protected)
        QKD_protocol qkd_protocols;
        source_requirements = {};
        detector_requirements = {};
    end

    methods

        function protocol = protocol(protoEnum)
            arguments
                protoEnum qkd_protocols
            end

            [rs, rd] = protoEnum.requirements;
            assert(~isempty(rs) | ~isempty(rd), ...
                ['Protocol: \{', string(protoEnum), '\} is not supported']);

            protocol.QKD_protocol = protoEnum;
            protocol.source_requirements = rs;
            protocol.detector_requirements = rd;
        end


        function [SKR, QBER, Rate_In, Rate_Det] = EvaluateQKDLink( ...
            protocol, Source, Detector, Link_Loss_dB, Background_Count_Rate)

            dark_counts = 1 - exp(-Background_Count_Rate * Detector.Time_Gate_Width);

            switch protocol.QKD_protocol
                case qkd_protocols.BB84
                    [SKR, QBER, Rate_In, Rate_Det] = BB84_single_photon_model( ...
                         Source, dark_counts, Link_Loss_dB, prot_eff, Detector);

                case qkd_protocols.DecoyBB84
                    assert(isvector(Link_Loss_dB) ...
                           && isvector(Background_Count_Rate), ...
                           'Link loss and BCR must be at most 1-dimensional arrays');

                    sz = size(Link_Loss_dB);
                    SKR = zeros(sz);
                    QBER = nan(sz);
                    Rate_In = zeros(sz);
                    Rate_Det = zeros(sz);

                    for i = 1 : max(sz)
                        [s, q, ri, rd] = decoyBB84_model( ...
                            Source, prob_dark_counts, Link_Loss_dB, prot_eff, Detector);

                        SKR(i) = s;
                        %use the first QBER as this is from the signal states
                        QBER(i) = q(1);
                        Rate_In(i) = ri;
                        Rate_Det(i) = rd;
                    end

                case qkd_protocols.E91
                    [SKR, QBER, Rate_In, Rate_Det] = ekart92_model( ...
                        Source, dark_counts, Link_Loss_dB, prot_eff, Detector)


                case qkd_protocols.COW
                    [SKR, QBER, Rate_In, Rate_Det] = COW_model( ...
                        Source, dark_counts, Link_Loss_dB, Detector)


                case qkd_protocols.DPS
                    error('Broken, protocol missing...')

            end

        end

    end

end
