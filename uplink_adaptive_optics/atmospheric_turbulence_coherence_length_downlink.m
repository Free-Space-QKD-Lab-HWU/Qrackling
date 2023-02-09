function atm_turb_cor_len = atmospheric_turbulence_coherence_length_downlink( ...
                    wavenumber, zenith_angle, satellite_altitude, ghv_args)

    fun = @(x,sat_alt) (generalised_hufnagel_valley(ghv_args, x) ...
                    .* (1-(x ./ sat_alt) .^ (5/3)));
    
    %% iterate over different satellite altitudes
    assert(iscolumn(satellite_altitude),'Satellite Altitude must be a column vector input');
    Num_Altitudes = numel(satellite_altitude);
    result = zeros(size(satellite_altitude));

    for i=1:Num_Altitudes
    result(i) = integral(@(x) -fun(x,satellite_altitude(i)), satellite_altitude(i), 0);
    end

    atm_turb_cor_len = (0.423 ...
                        .* (wavenumber ^ 2) ...
                        .* secd(zenith_angle) ...
                        .* result) .^ (-3/5);

    %% check that output is real
    assert(isreal(atm_turb_cor_len),'atmospheric turbulence coherence length has returned complex. This is likely due to zenith > 90')
end
