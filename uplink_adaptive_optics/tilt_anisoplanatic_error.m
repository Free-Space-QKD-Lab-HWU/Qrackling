function ta_error = tilt_anisoplanatic_error(satellite_altitude, ...
                                             zenith_angle, ...
                                             tx_diameter, ...
                                             delta_tilt, ...
                                             wavelength, ...
                                             ghv_args)

    N = length(zenith_angle);
    results = zeros(1, N);
    M = 64;
    alts = linspace(0, satellite_altitude, M);
    temp = zeros(1, length(alts));

    for i = 1:N;
        z = zenith_angle(i);
        fun = @(x) (generalised_hufnagel_valley(ghv_args, x) ...
                .* weighting_integral(z, delta_tilt(i), tx_diameter, x));

        %results(i) = integral(@(x) fun(x), 0, satellite_altitude);
        %temp = fun(alts);
        for j=1:M;
            temp(j) = fun(alts(j));
        end;
        results(i) = trapz(temp);

        % fun = @(u, w, x) generalised_hufnagel_valley(ghv_args, x) ...
        %         .* weighting_function(u, w, x, delta_tilt, z, tx_diameter);

        % results(i) = integral3(@(u, w, x) fun(u, w, x), ...
        %                         0, 2*pi, ...
        %                         0, 1, ...
        %                         0, satellite_altitude);
    end;

    ta_error = (6.14 * (tx_diameter ^ (-1/6)) ...
            .* ((sec(zenith_angle) .* results) .^ (1/2)) );
end

function [c1, c2, d, e, f]  = weighting_params(u, w, S)
    a = u .^ 2;
    b = S .^ 2;
    c = 2 .* u .* S .* cos(w);
    c1 = 0.5 .* ((a + c + b) .^ (5/6));
    c2 = 0.5 .* ((a - c + b) .^ (5/6));
    d = u .^ (5/3);
    e = S .^ (5/3);
    f = u .* (acos(u) - ((3 .* u - (2 .* u .^ 3)) .* sqrt(1 - (u .^ 2))));
end


function weight = weighting_function(u, w, tilt, alt, tilt_angle, d)
    S = (tilt .* alt .* sec(tilt_angle)) / d;
    [c1, c2, d, e, f] = weighting_params(u, w, S);
    weight = (c1 + c2 - d - e) .* f;
end

function weight = weighting_term(u, w, zenith, delta_tilt, ...
                                 transmitter_diameter, alt)
    S = (delta_tilt .* alt .* sec(zenith)) / transmitter_diameter;
    a = u .^ 2;
    b = 2 .* u .* S .* cos(w);
    c =  (S .^ 2);
    c1 = 0.5 .* ((a + b + c) .^ (5/6));
    c2 = 0.5 .* ((a - b + c) .^ (5/6));
    d = u .^ (5/3);
    e = S .^ (5/3);
    f = u .* ((acos(u)) - (3 .* u - (2 .* u .^ 3)) .* sqrt(1 - a));
    weight = (c1 + c2 - d - e) .* f;
end

function weight = weighting_integral(zenith, delta_tilt, ...
                                     transmitter_diameter, alt)

    fun = @(u, w) weighting_term(u, w, zenith, delta_tilt, ...
                                 transmitter_diameter, alt);
    weight = integral2(@(u, w) fun(u,w), 0, 1, 0, 2 * pi);
end
