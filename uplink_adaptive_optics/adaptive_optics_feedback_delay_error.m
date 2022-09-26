function zeta = adaptive_optics_feedback_delay_error(wavelength, ...
                                                     zenith_angle, ...
                                                     satellite_altitude, ...
                                                     ghv_args, ...
                                                     bfw_args, ...
                                                     correction_bandwidth)
    fg = greenwood_frequency(wavelength, ...
                             zenith_angle, ...
                             satellite_altitude, ...
                             ghv_args, ...
                             bfw_args);
    % The below commented out line is the form for this statement we see in the
    % paper, however the results this produces are always incredibly large when
    % compared to the other error terms. The line proceeding it appears to fix
    % this issue however I am no longer convinced about the dimensions being
    % accurate / consistent.
    zeta = (fg ./ correction_bandwidth) .^ (5/6);
    zeta =  wavelength .* (fg ./ correction_bandwidth) .^ (5/6);

end

