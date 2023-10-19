function probability = nPhotonPairProbability(n, mean_photon_number)
    lambda = mean_photon_number ./ 2;
    probability = ((n + 1) .* (lambda .^ n)) ./ ((1 + lambda) .^ (n + 2));
end
