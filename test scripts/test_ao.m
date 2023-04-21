%%init
clear all;
close all;
clc;
addpath('~/Projects/free_space_modelling/matlab');

disp("Starting...");
decibel_to_percent = @(db) 100 .* (10 .^ (db ./ 10));
qkd_wl = 785e-9;
qkd_k = (2 * pi) / qkd_wl;
a = 10;
b = 90;
c = 2.5;
elevation = linspace(a, b, round((b-a)/c));
zenith = deg2rad(90 - elevation);

H = 600e3;
D_r = 0.4;
D_t = 0.5;
eta_r = 0.5;
eta_t = 0.5;
eta_0 = 0.8;
% delta_tilt = 50e-6;
correction_bandwidth = 200;
J = 45;
J = 8;

waist = D_t / 1.5;
% waist = 0.1;

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

% %%Naive case -> Beam wander = 1
spot_diff = diffraction_limited_gaussian_beam_width(waist, L, rr);
eta_diff = link_efficiency(eta_r, eta_t, eta_0, zenith, D_r, spot_diff, 1);

spot_lt = long_term_gaussian_beam_width(waist, L , rr, qkd_k, atm_turb_cor_len);
eta_lt = link_efficiency(eta_r, eta_t, eta_0, zenith, D_r, spot_lt, 1);

spot_st = short_term_gaussian_beam_width(waist, L, rr, qkd_k, ...
                                            atm_turb_cor_len);
eta_st = link_efficiency(eta_r, eta_t, eta_0, zenith, D_r, spot_st, 1);





% figure
% grid on
% hold on
% plot(elevation, eta_diff);
% plot(elevation, eta_lt);
% plot(elevation, eta_st);
% 
% lgd = legend('Diffraction Limited', ...
%        'Turbulence Limited (long term)', ...
%        'Beam Wander & Wavefront Correction (short term)');
% lgd.Location = 'best';
% hold off

% figure
% grid on
% hold on
% plot(elevation, decibel_to_percent(eta_lt));
% plot(elevation, decibel_to_percent(eta_st));
% 
% lgd = legend('Turbulence Limited (long term)', ...
%              'Beam Wander & Wavefront Correction (short term)');
% lgd.Location = 'best';
% hold off

% %%Inclusion of Error terms
disp("Error terms...");
f_track = tracking_frequency(D_t, qkd_wl, zenith, H, b_args, g_args);

error_snr = ones(1, length(zenith)) .* (0.15e-6);

error_delay = tilt_feedback_delay_error(f_track, correction_bandwidth, ...
                                        qkd_wl, D_t);
% error_delay = ones(1, length(zenith)) .* 0.25;

error_centroid = centroid_anisoplantism_errors(qkd_wl, D_t, atm_turb_cor_len);

error_tilt = tilt_anisoplanatic_error(H, zenith, D_t, ...
                                      delta_tilt, qkd_wl, g_args);
% error_tilt = ones(1, length(zenith)) .* 0.7e-6;

wander_diff = residual_beam_wander(error_snr, error_delay, error_centroid, ...
                                   error_tilt, spot_diff, L);

wander_lt = residual_beam_wander(error_snr, error_delay, error_centroid, ...
                                   error_tilt, spot_lt, L);

wander_st = residual_beam_wander(error_snr, error_delay, error_centroid, ...
                                   error_tilt, spot_st, L);

eta_diff = link_efficiency(eta_r, eta_t, eta_0, zenith, D_r, ...
                            spot_diff, wander_diff);

eta_lt = link_efficiency(eta_r, eta_t, eta_0, zenith, D_r, spot_lt, wander_lt);
eta_st = link_efficiency(eta_r, eta_t, eta_0, zenith, D_r, spot_st, wander_st);

% Plots for lt and st are showing up approx 5dB lower than they should be, didn't this all work in the python implementation from a while back though, should probably check that to see how they differ if at all!!


% figure
% grid on
% hold on
% plot(elevation, eta_diff);
% plot(elevation, eta_lt);
% plot(elevation, eta_st);
% 
% lgd = legend('Diffraction Limited', ...
%        'Turbulence Limited (long term)', ...
%        'Beam Wander & Wavefront Correction (short term)');
% lgd.Location = 'best';
% hold off

% %%Adaptive optics correction of wavefront error

fg = greenwood_frequency(qkd_wl, zenith, H, g_args, b_args);

zeta_afd = adaptive_optics_feedback_delay_error(qkd_wl, zenith, H, g_args, ...
                                                b_args, correction_bandwidth);
% zeta_afd = ones(1, length(zenith)) .* 1;
zeta_fit = fit_error(J, D_t, atm_turb_cor_len);
zeta_pa = phase_anisoplanatic_error(zenith, qkd_k, H, g_args, delta_tilt);
zeta_pa = zeros(1, length(zenith));
strehl = fliplr(strehl_ratio(zeta_afd, zeta_fit, zeta_pa));
%strehl = ones(1, length(zenith)) .* 0.01;

eta_ao = link_efficiency_adaptive_optics(eta_r, eta_t, eta_0, zenith, D_r,...
                                         wander_diff, wander_st, spot_diff, ...
                                         spot_st, strehl);

figure
grid on
hold on
plot(elevation, eta_diff);
plot(elevation, eta_lt);
plot(elevation, eta_st);
plot(elevation, eta_ao);

lgd = legend('Diffraction Limited', ...
       'Turbulence Limited (long term)', ...
       'Beam Wander & Wavefront Correction (short term)',...
       'Adaptive Optics');
lgd.Location = 'best';
hold off

figure
hold on
nrows = 2;
ncols = 2;

subplot(nrows, ncols, 1);
grid on
plot(zenith, zeta_afd);
title("\zeta_{afd}");

subplot(nrows, ncols, 2);
grid on
plot(zenith, zeta_fit);
title("\zeta_{fit}");

subplot(nrows, ncols, 3);
grid on
plot(zenith, zeta_pa);
title("\zeta_{pa}");

subplot(nrows, ncols, 4);
grid on
plot(zenith, strehl);
title("strehl");

hold off

