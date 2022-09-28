classdef ozone < card

    properties
        altitude_correction;
        abundance;
    end

    methods
        function ozone = ozone(varargin)
            ozone.card_type = 'IO3';
            ozone.card_num = 5;
            ozone.groups = {{'altitude_correction', 'abundance'}, {}};
            ozone.suffix = {'a', ''};

            p = inputParser;
            addParameter(p, 'ialt', []);
            addParameter(p, 'abO3', []);

            parse(p, varargin{:});

            if any(isempty([p.Results.ialt, p.Results.abO3]))
                ozone.flag = 1;
            else
                assert(p.Results.ialt == 0 | p.Results.ialt == 1);
                ozone.altitude_correction = p.Results.ialt;
                ozone.abundance = p.Results.abO3;
                ozone.flag = 0;
            end
        end
    end
end
