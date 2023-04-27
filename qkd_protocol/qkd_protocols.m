classdef qkd_protocols

    enumeration
        BB84, DecoyBB84, E91, COW, DPS
    end

    methods

        function [req_source, req_detector] = requirements(proto)
            req_source = {};
            req_detector = {};

            switch proto
                case qkd_protocols.BB84
                    req_source = { ...
                        'g2', 'Mean_Photon_Number', 'State_Prep_Error' ...
                        };
                    req_detector = { ...
                        'Dark_Count_Rate','Time_Gate_Width','Dead_Time' ...
                        };

                case qkd_protocols.DecoyBB84
                    req_source = { ...
                            'Mean_Photon_Number', ...
                            'State_Prep_Error', ...
                            'State_Probabilities' ...
                        };
                    req_detector = { ...
                        'Dark_Count_Rate','Time_Gate_Width','Dead_Time' ...
                        };

                case qkd_protocols.E91
                    req_source = { ...
                        'g2', 'Mean_Photon_Number', 'State_Prep_Error' ...
                        };
                    req_detector = { ...
                        'Dark_Count_Rate','Time_Gate_Width','Dead_Time' ...
                        };

                case qkd_protocols.COW
                    req_source = { ...
                        'State_Probabilities', ...
                        'Mean_Photon_Number', ...
                        'State_Prep_Error'
                        };
                    req_detector = { ...
                        'Time_Gate_Width', 'Dead_Time', 'Visibility'
                        };

                case qkd_protocols.DPS
                    req_source = { ...
                        'Mean_Photon_Number', ...
                        'State_Prep_Error', ...
                        'State_Probabilities' ...
                        };
                    req_detector = { ...
                        'Dark_Count_Rate', ...
                        'Time_Gate_Width', ...
                        'QBER_Jitter', ...
                        'Visibility'
                        };
            end
        end

    end

end