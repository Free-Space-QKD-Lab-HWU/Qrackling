function S = strehl_ratio(zeta_afd, ...
                          zeta_fit, ...
                          zeta_pa)

    zeta_sq = (zeta_afd .^ 2) + (zeta_fit .^ 2) + (zeta_pa .^ 2);
    S = exp(-zeta_sq);
end
