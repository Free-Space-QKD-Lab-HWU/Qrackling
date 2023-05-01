%% Start
clear all
close all
clc

% %% protocol enum
proto = Protocol(qkd_protocols.DecoyBB84)
disp(proto.source_requirements')

Wavelength = 800;
BB84_S = BB84_Source(Wavelength);
dBB84_S = decoyBB84_Source(Wavelength);

proto.compatibleSource(dBB84_S)

Time_Gate_Width = 1;
Repetition_Rate = 1;
Spectral_Filter_Width = 1;
Spectral_Filter_Width_arr = 10 .^ linspace(-4, 0, 25);

BB84_D = MPD_Detector(Wavelength, ...
                      Repetition_Rate, ...
                      Time_Gate_Width, ...
                      Spectral_Filter_Width_arr(1));
proto.compatibleDetector(BB84_D)
