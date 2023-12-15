classdef Inter_Satellite_Link_Model
    properties
        transmitter Telescope
        receiver Telescope
    end
    methods
        function isl = Inter_Satellite_Link_Model()
        end

        function loss = LinkLoss(isl)
            arguments
                isl Inter_Satellite_Link_Model
            end
        end

        function distance = Intersatellite_distance()
        end

    end
end
