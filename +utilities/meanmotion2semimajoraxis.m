function semimajor_axis = meanmotion2semimajoraxis(mean_motion)
    M = 5.97237e24;
    G = 6.67430e-11;
    mu = G * M;

    semimajor_axis = mu ./ (mean_motion .^ 2);
end
