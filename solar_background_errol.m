classdef solar_background_errol
    properties(SetAccess=protected, Hidden=true)
        card_types = {{'ispr',   'sitePressure'}, ...
                      {'iatmos', 'atmosphere'}, ...
                      {'ih20',   'water_vapour'}, ...
                      {'i03',    'ozone'}, ...
                      {'igas',   'carbon_dioxide'}, ...
                      {'ico2',   'aerosol'}, ...
                      {'iaeros', 'turbidity'}, ...
                      {'iturb',  'far_field_albedo'}, ...
                      {'ialbdx', 'far_field_albedo'}, ...
                      {'isolar', 'extra_spectral'}, ...
                      {'iprt',   'printing'}, ...
                      {'icirc',  'circum_solar'}, ...
                      {'iscan',  'scanning'}, ...
                      {'illum',  'illuminance'}, ...
                      {'iuv',    'broadband_uv'}, ...
                      {'imass',  'solar_position_and_airmass'}};
    end

    properties(SetAccess=protected)
        configuration SMARTS_input;
    end

    methods
        function solar_background_errol = solar_background_errol(varargin)

            card_types = solar_background_errol.card_types;

            p = inputParser;
            for i = 1 : length(card_types)
                addParameter(p, card_types{i}{1}, nan);
            end

            addParameter(p, 'executable_path', '');

            parse(p, varargin{:});

            ispr = sitePressure(spr=1013.25, altit=0, height=0);
            iatmos = atmosphere(atmos='STS');
            ih20 = water_vapour(w=1);
            i03 = ozone();
            igas = gas_atmospheric_absorption(iload=0); 
            ico2 = carbon_dioxide(amount=370);
            iaeros = aerosol(aeros='S&F_RURAL');
            iturb = turbidity(visi=50);
            ialbdx = far_field_albedo(spectral_reflectance=38, ...
                                      tilt=45, wazim=90, ialbdg=38);
            isolar = extra_spectral(wlmin=280, wlmax=4000, ....
                                    suncor=1, solarc=1367);
            iprt = printing(output_options=linspace(1, 43, 43), ....
                            wpmn=280, wpmx=4000, intvl=0.5);
            icirc = circum_solar(slope=0, apert=2.9, limit=0);
            iscan = scanning(filtering=0);
            illum = illuminance(value=0);
            iuv =  broadband_uv(value=0);
            imass = solar_position_and_airmass(dateAndTime=datetime('now'), ...
                    latitude=56.405, longitude=-3.183);

            defaults = {ispr, iatmos, ih20, i03, igas, ico2, iaeros, ...
                        iturb, ialbdx, isolar, iprt, icirc, iscan, ...
                        illum, iuv, imass};

            input_cards = {};

            for i = 1 : length(card_types)
                % if card is nan use the corresponding default
                if ~isa(p.Results.(card_types{i}{1}), 'card')
                    for j = 1 : length(defaults)
                        if isa(defaults{j}, card_types{i}{2})
                            input_cards{end + 1} = defaults{j};
                            break;
                        end
                    end
                % otherwise check if the card is valid
                else
                    assert(...
                        isa(p.Results.(card_types{i}{1}), card_types{i}{2}), ...
                        ['Argument: [', card_types{i}{1}, ...
                        '] must be of type: ', card_types{i}{2}, ...
                        ', not of type ', ...
                        class( p.Results.(card_types{i}{1}) )...
                        ]);
                    input_cards{end + 1} = p.Results.(card_types{i}{1});
                end
            end

            solar_background_errol.configuration = SMARTS_input(...
                comment='Errol_airstrip', args=input_cards, ...
                executable_path = p.Results.executable_path);

        end

        function solar_background_errol = update(solar_background_errol, new_cards)

            if ~iscell(new_cards)
                new_cards = {new_cards};
            end

            keys = unqiue( cellfun(@(object) class(object), ...
                                  new_cards, uniformoutput=false) );
            counts = zeros(1, numel(keys));



           % card_classes = cellfun(@(pair) pair{2}, ...
           %                        solar_background_errol.card_types, ...
           %                        uniformoutput=false);
           % instances = zeros(1, numel(card_classes));

           % card_to_use = zeros(1, numel(new_cards));

           % for i = 1 : numel(new_cards)
           %     mask = contains(card_classes, class(new_cards{i}));
           %     instances = instances + mask;
           %     if 0 == card_to_use(i)
           %         card_to_use(i) = i;
           %     end
           % end

           % instances

           %disp(card_to_use) 

        end

    end
end
