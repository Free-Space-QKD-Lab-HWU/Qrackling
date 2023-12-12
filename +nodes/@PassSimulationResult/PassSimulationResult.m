classdef PassSimulationResult
    properties (SetAccess = protected)
        heading = []
        elevation = []
        range = []
        time = []
        within_elevation_limit = []
        communications = []
        line_of_sight = []
        losses nodes.LossResult
        total_loss_db = []
        sifted_rate = []
        secure_rate = []
        qber = []
        total_sifted_rate = []
        total_secure_rate = []
    end

    methods
        function result = PassSimulationResult( ...
            heading,           elevation,              range,          ...
            time,              within_elevation_limit, communications, ...
            line_of_sight,     losses,                 total_loss_db,  ...
            sifted_rate,       secure_rate,            qber,           ...
            total_sifted_rate, total_secure_rate)

            result.heading                = heading;
            result.elevation              = elevation;
            result.range                  = range;
            result.time                   = time;
            result.within_elevation_limit = within_elevation_limit;
            result.communications         = communications;
            result.line_of_sight          = line_of_sight;
            result.losses                 = losses;
            result.total_loss_db          = total_loss_db;
            result.sifted_rate            = sifted_rate;
            result.secure_rate            = secure_rate;
            result.qber                   = qber;
            result.total_sifted_rate      = total_sifted_rate;
            result.total_secure_rate      = total_secure_rate;
        end
    end
end
