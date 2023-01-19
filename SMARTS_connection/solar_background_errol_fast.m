% Default SMARTS cards for Errol Airstrip, with reduced granularity for faster
% ops
% ### USAGE ###
% errol_smarts = solar_background_errol(...
%                           executable_path='path/to/smarts.exe', ...
%                           stub='/location/to/write/smarts/results/to);
%
% % Updating azimuth (heading) and elevation
% ialbdx = far_field_albedo(...
%         spectral_reflectance = errol_smarts.ialbdx.spectral_reflectance, ...
%         tilt = el, ...
%         wazim = az, ...
%         ialbdg = errol_smarts.ialbdx.local_foreground_albedo);
%
% errol_smarts = errol_smarts.update_card(ialbdx);
%
% % Run SMARTS and write to file "new_result". The full path to the result
% % will be returned in 'result_file_path'
% [errol_smarts, success, result_file_path] = run_smarts(errol_smarts, ...
%                                                    file_name='new_result');
% assert(success, 'SMARTS Simulation failed...');

function configuration = solar_background_errol_fast(varargin)


    %% specify the reduced wavelength range simulated
    Wavelength_Min=600;
    Wavelength_Max=950;
    Step=10;
    %card_types = solar_background_errol.card_types;

    p = inputParser;
    addParameter(p, 'executable_path', '');
    addParameter(p, 'stub', '');
    addParameter(p, 'dateAndTime', datetime("now"))
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
    isolar = extra_spectral(wlmin=Wavelength_Min, wlmax=Wavelength_Max, ....
                            suncor=1, solarc=1367);
    iprt = printing(output_options=linspace(1, 43, 43), ....
                    wpmn=Wavelength_Min, wpmx=Wavelength_Max, intvl=Step);
    icirc = circum_solar(slope=0, apert=2.9, limit=0);
    iscan = scanning(filtering=0,...
        wavelength_min=Wavelength_Min,...
        wavelength_max=Wavelength_Max,...
        step=Step);
    illum = illuminance(value=0);
    iuv =  broadband_uv(value=0);
    imass = solar_position_and_airmass(dateAndTime=p.Results.dateAndTime, ...
            latitude=56.405, longitude=-3.183);

    defaults = {ispr, iatmos, ih20, i03, igas, ico2, iaeros, ...
                iturb, ialbdx, isolar, iprt, icirc, iscan, ...
                illum, iuv, imass};

    % input_cards = {};

    % for i = 1 : length(card_types)
    %     % if card is nan use the corresponding default
    %     if ~isa(p.Results.(card_types{i}{1}), 'card')
    %         for j = 1 : length(defaults)
    %             if isa(defaults{j}, card_types{i}{2})
    %                 input_cards{end + 1} = defaults{j};
    %                 break;
    %             end
    %         end
    %     % otherwise check if the card is valid
    %     else
    %         assert(...
    %             isa(p.Results.(card_types{i}{1}), card_types{i}{2}), ...
    %             ['Argument: [', card_types{i}{1}, ...
    %             '] must be of type: ', card_types{i}{2}, ...
    %             ', not of type ', ...
    %             class( p.Results.(card_types{i}{1}) )...
    %             ]);
    %         input_cards{end + 1} = p.Results.(card_types{i}{1});
    %     end
    % end

    % solar_background_errol.configuration = SMARTS_input(...
    %     comment='Errol_airstrip', args=input_cards, ...
    %     executable_path = p.Results.executable_path);
configuration = SMARTS_input(comment = 'Errol_airstrip', ...
                             args = defaults, ...
                             executable_path = p.Results.executable_path, ...
                             stub = p.Results.stub);

end

% function solar_background_errol = update(solar_background_errol, new_cards)
% 
%     if ~iscell(new_cards)
%         new_cards = {new_cards};
%     end
% 
%     keys = unqiue( cellfun(@(object) class(object), ...
%                           new_cards, uniformoutput=false) );
%     counts = zeros(1, numel(keys));
% 
% 
% 
%    % card_classes = cellfun(@(pair) pair{2}, ...
%    %                        solar_background_errol.card_types, ...
%    %                        uniformoutput=false);
%    % instances = zeros(1, numel(card_classes));
% 
%    % card_to_use = zeros(1, numel(new_cards));
% 
%    % for i = 1 : numel(new_cards)
%    %     mask = contains(card_classes, class(new_cards{i}));
%    %     instances = instances + mask;
%    %     if 0 == card_to_use(i)
%    %         card_to_use(i) = i;
%    %     end
%    % end
%    % instances
% 
%    %disp(card_to_use) 
% 
% end
