%{
Class to hold 'CARD2' of a SMARTS input parameter set

Parameters
    - spr -> site_pressure : millibar
    - altit -> altitude : distance above sea level in km
    - height -> height : height above ground surface (i.e. above altitude) in km
    - latit -> latitude : decimal degrees (North positive)

%}

classdef sitePressure < card
    properties(SetAccess=protected)
        site_pressure{mustBeNumeric} = -1;
        altitude{mustBeNumeric} = -1;
        height{mustBeNumeric} = -1;
        latitude{mustBeNumeric} = -1;
    end

    methods
        function sitePressure = sitePressure(varargin)

            sitePressure.card_type = 'ISPR';
            sitePressure.card_num = 2;
            sitePressure.groups = { {'site_pressure'}, ...
                       {'site_pressure', 'altitude', 'height'}, ...
                       {'latitude', 'altitude', 'height'} ...
                    };
            sitePressure.suffix = { 'a', 'a', 'a'};

            p = inputParser;
            addParameter(p, 'spr', 0);
            addParameter(p, 'altit', 0);
            addParameter(p, 'height', 0);
            addParameter(p, 'latit', 45.0);

            parse(p, varargin{:});

            if 100 < p.Results.altit + p.Results.height
                error('Altitude and height must be less than 100');
            end

            sitePressure.site_pressure = p.Results.spr;
            sitePressure.altitude = p.Results.altit;
            sitePressure.height = p.Results.height;
            sitePressure.latitude = p.Results.latit;

            if 0.0004 < p.Results.spr
                sitePressure.flag = 0;

                if 0 < p.Results.altit & 0 < p.Results.height
                    sitePressure.flag = 1;
                end
            else
                sitePressure.flag = 2;
            end
        end
    end
end
