%% Run
clear all;
close all;

decibel_to_percent = @(db) 100 .* (10 .^ (db ./ 10));
qkd_wl = 785e-9;
qkd_k = (2 * pi) / qkd_wl;
a = 10;
b = 90;
c = 1;
elevation = linspace(a, b, round((b-a)/c));
zenith = deg2rad(90 - elevation);

H = 600e3;
D_r = 0.4;
D_t = 0.7;
eta_r = 0.5;
eta_t = 0.5;
eta_0 = 0.8;
% delta_tilt = 50e-6;
correction_bandwidth = 200;
J = 45;
J = 8;

waist = D_t / 2;

g_args = ghv_defaults();
b_args = bfw_defaults();

rr = rayleigh_range(waist, qkd_wl, 1);
L = fliplr(slant_range(H, elevation)); % We are working terms of the zenith,
                                       % for this we would expect that at
                                       % small zenith angles the slant range
                                       % will be smallest. Since slant range
                                       % deals in elevation we will reverse 
                                       % the order of the array.

delta_tilt = point_ahead_angle(L);

atm_turb_cor_len = atmospheric_turbulence_coherence_length(qkd_k, zenith, ...
                                                           H, g_args);

% Error Terms
f_track = tracking_frequency(D_t, qkd_wl, zenith, H, b_args, g_args);
error_snr = 0.15e-6;
error_delay = tilt_feedback_delay_error(f_track, correction_bandwidth, ...
                                        qkd_wl, D_t);
error_centroid = centroid_anisoplantism_errors(qkd_wl, D_t, atm_turb_cor_len);
error_tilt = tilt_anisoplanatic_error(H, zenith, D_t, ...
                                      delta_tilt, qkd_wl, g_args);


% Diffraction Limited
spot_diff = diffraction_limited_gaussian_beam_width(waist, L, rr);
wander_diff = residual_beam_wander(error_snr, error_delay, error_centroid, ...
                                   error_tilt, spot_diff, L);
wander_diff = ones(1, length(zenith));
eta_diff = link_efficiency(eta_r, eta_t, eta_0, zenith, D_r, ...
                            spot_diff, wander_diff);

% Turbulence Limited
spot_tl = long_term_gaussian_beam_width(waist, L , rr, qkd_k, atm_turb_cor_len);
wander_tl = residual_beam_wander(error_snr, error_delay, error_centroid, ...
                                   error_tilt, spot_tl, L);
wander_tl = ones(1, length(zenith));
eta_tl = link_efficiency(eta_r, eta_t, eta_0, zenith, D_r, spot_tl, wander_tl);

% Adaptive Optics corrections
fg = greenwood_frequency(qkd_wl, zenith, H, g_args, b_args);
zeta_afd = adaptive_optics_feedback_delay_error(qkd_wl, zenith, H, g_args, ...
                                                b_args, correction_bandwidth);
zeta_afd = ones(1, length(zenith));
%zeta_fit = fit_error(J, D_t, atm_turb_cor_len);
%zeta_pa = phase_anisoplanatic_error(zenith, qkd_k, H, g_args, delta_tilt);
%strehl = strehl_ratio(zeta_afd, zeta_fit, zeta_pa);
strehl = ones(1, length(zenith));


% Beam wander and wavefront correction
spot_st = short_term_gaussian_beam_width(waist, L, rr, qkd_k, ...
                                            atm_turb_cor_len);
wander_st = residual_beam_wander(error_snr, error_delay, error_centroid, ...
                                   error_tilt, spot_st, L);
eta_bw_wc = link_efficiency_adaptive_optics(eta_r, eta_t, eta_0, zenith, D_r,...
                                          wander_diff, wander_st, spot_diff, ...
                                          spot_st, strehl);
wander_st = ones(1, length(zenith));

eta_st = link_efficiency(eta_r, eta_t, eta_0, zenith, D_r, spot_st, wander_st);


figure
grid on
hold on
plot(elevation, eta_diff)
plot(elevation, eta_tl)
plot(elevation, eta_st)
lgd = legend(...
    'Diffraction Limited', ...
    'Turbulence Limited', ...
    'Beam Wander & Wavefront Correction');
xlabel('Elevation (\circ)');
ylabel('Transmission (dB)');
title('Transmitter Diameter: 0.7m');


r_singles = ones(1, length(zenith)) .* 20e6;
eta_det = 0.5;
eta_herald = 0.5;

rate_tl = r_singles .* decibel_to_percent(eta_tl) ./ 100 ./ 1000;
rate_st = r_singles .* decibel_to_percent(eta_st) ./ 100 ./ 1000;

figure
grid on
hold on
plot(elevation, rate_tl)
plot(elevation, rate_st)
lgd = legend(...
    'Turbulence Limited', ...
    'Beam Wander & Wavefront Correction');
xlabel('Elevation (\circ)');
ylabel('Singles Reaching Satellite (KHz)');
title('Transmitter Diameter: 0.7m');
