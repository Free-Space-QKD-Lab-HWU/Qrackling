function beam_wander =  residual_beam_wander(sigma_snr, ...
                                             sigma_tfd, ...
                                             sigma_ca, ...
                                             sigma_ta, ...
                                             beam_waist, ...
                                             ogs_sat_distance)

    W = @(w) sqrt(2) .* w;
    S = @(w, L) W(w) ./ L;
    Beta = @(sigma, w, L) ((S(w, L) ./ sigma) .^ 2) ./ 8;
    Beta = @(sigma, w, L) ((((sqrt(2) .* w) ./ L) ./ sigma) .^ 2) ./ 8;

    beta_snr = Beta(sigma_snr, beam_waist, ogs_sat_distance);
    beta_tfd = Beta(sigma_tfd, beam_waist, ogs_sat_distance);
    beta_ca = Beta(sigma_ca, beam_waist, ogs_sat_distance);
    beta_ta = Beta(sigma_ta, beam_waist, ogs_sat_distance);

    N = length(sigma_tfd);
    beam_wander = zeros(1, N);
    for i = 1:N
        betas = mean([beta_snr(i), beta_tfd(i), beta_ca(i), beta_ta(i)]);
        % beam_wander(i) = mean(betas ./ (betas + 1));
        beam_wander(i) = betas ./ (betas + 1);
    end
end
