function total_spectral_pointance = radiantEmission(spectral_pointance, filter_wavelengths, filter_transmittance)
    %GETRADIANTEMISSION output the total emission in a wavelength
    %range specified by its minimum and maximum
    arguments
        spectral_pointance % is this an array or matrix?
        filter_wavelengths
        filter_transmittance
    end

    % compute radiance at each wavelength the filter is specified
    % for
    %find and store wavelength range and radiance
    % Wavelength_Limits = background_source.Wavelength_Limits; %#ok<*PROPLC>
    % spectral_pointance = background_source.spectral_pointance;
    
    %Interpolate spectral_pointance onto filter wavelengths
    spectral_pointance_At_filter_wavelengths = interp1(filter_wavelengths, [spectral_pointance, spectral_pointance(end)], filter_wavelengths);
    %values outside filter range ar returned nan, these should be
    %zero
    spectral_pointance_At_filter_wavelengths(isnan(spectral_pointance_At_filter_wavelengths)) = 0;

    %multiply with transmittance and total
    total_spectral_pointance = dot(spectral_pointance_At_filter_wavelengths, filter_transmittance);

    %% compute emission inside specified range
    %find and store wavelength range and radiance
    % filter_wavelengths = background_source.filter_wavelengths; %#ok<*PROPLC>
    % spectral_pointance = background_source.spectral_pointance;

    wavelength_floor = min(filter_wavelengths);
    wavelength_ceiling = max(filter_wavelengths);

    %% detect if no emission occurs in specified range
    if wavelength_ceiling<min(filter_wavelengths)||wavelength_floor>max(filter_wavelengths)
        total_spectral_pointance = 0;
        return
    end

    %% detect if entire background source emission is within wavelength ceiling and floor
    if wavelength_floor <= min(filter_wavelengths) && wavelength_ceiling >= max(filter_wavelengths)
        total_spectral_pointance = dot(spectral_pointance, filter_wavelengths(2:end) - filter_wavelengths(1:end-1));
        return
    end

    %% detect if entire requested range is within one radiance measurement
    if all(wavelength_floor >= filter_wavelengths|wavelength_ceiling <= filter_wavelengths)
        [~, Relevant_Radiance_Index] = min(filter_wavelengths >= wavelength_floor);
        Relevant_SP = spectral_pointance(Relevant_Radiance_Index);
        total_spectral_pointance = Relevant_SP * (wavelength_ceiling-wavelength_floor) / (filter_wavelengths(Relevant_Radiance_Index + 1) - filter_wavelengths(Relevant_Radiance_Index));
        return
    end

    %% segment wavelength vector by bounds
    Below_wavelength_floor_Indices   = filter_wavelengths < wavelength_floor;
    Between_Bounds_Indices           = (filter_wavelengths >= wavelength_floor) & (filter_wavelengths <= wavelength_ceiling);
    Above_wavelength_ceiling_Indices = filter_wavelengths > wavelength_ceiling;

    %% compute radiance from lower bound edge
    %get nearby values
    Below_wavelength_floor             = filter_wavelengths(Below_wavelength_floor_Indices);
    Immediately_Below_wavelength_floor = max(Below_wavelength_floor);
    Between_Bounds                     = filter_wavelengths(Between_Bounds_Indices);
    Immediately_Above_wavelength_floor = min(Between_Bounds);

    %compute value
    Lower_Bound_Radiance = spectral_pointance(sum(Below_wavelength_floor_Indices)) * (Immediately_Above_wavelength_floor - wavelength_floor) / (Immediately_Above_wavelength_floor - Immediately_Below_wavelength_floor);

    %% compute radiance from upper bound edge
    %get nearby values
    Above_wavelength_ceiling             = filter_wavelengths(Above_wavelength_ceiling_Indices);
    Immediately_Above_wavelength_ceiling = min(Above_wavelength_ceiling);
    Immediately_Below_wavelength_ceiling = max(Between_Bounds);

    %compute value
    Upper_Bound_Radiance = spectral_pointance(end + 1 - sum(Above_wavelength_ceiling_Indices)) * (wavelength_ceiling - Immediately_Below_wavelength_ceiling) / (Immediately_Above_wavelength_ceiling - Immediately_Below_wavelength_ceiling);

    %% compute radiance between bounds
    In_Range_Radiance = sum(spectral_pointance(Between_Bounds_Indices));

    %% compute total
    total_spectral_pointance = Lower_Bound_Radiance + In_Range_Radiance+Upper_Bound_Radiance;

end
