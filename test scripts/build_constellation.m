%%Test Constellation class
close all;
clc;
clear all;

startTime = datetime(2020,6,02,8,23,0);
startTime = datetime(2020,6,02,18,43,16);
stopTime = startTime + hours(5);
sampleTime = 360;
%sampleTime = 6;

Transmitter_Diameter=0.08;
Receiver_Diameter=0.7;
Time_Gate_Width=10^-9;
Repetition_Rate=10^9;
Spectral_Filter_Width=1;
Wavelength=850;
Excelitas_Detector_Factory=Excelitas_Detector_Factory();

Transmitter_Telescope=Telescope(Transmitter_Diameter,Wavelength);
Receiver_Telescope=Telescope(Receiver_Diameter,Wavelength);

BB84_S=BB84_Source(Wavelength);

% following gives polar orbit going directly overhead of UK
% sma = [6878e3];
% ecc = [1.34229e-15];
% inc = [90];
% raan = [350];
% aop = [0];
% ta = [133.242];

n = 60;
step_size = 360 / n;
sma = ones(1, n) .* 6878e3;
ecc = ones(1, n) .* 1.34229e-15;
inc = ones(1, n) .* 60;
%raan = ones(1, n) .* 350;
raan = linspace(0, 360-step_size, n);
%aop = ones(1, n) .* 0;
aop = linspace(0, 360-step_size, n);
ta = ones(1, n) .* 133.242;

n = 10;
sma = ones(1, n) .* 6878e3;
ecc = ones(1, n) .* 1.34229e-15;
inc = ones(1, n) .* 70;
raan = ones(1, n) .* 20;
%aop = ones(1, n) .* 0;
step_size = 360 / n;
aop = linspace(0, 360-step_size, n);
ta = ones(1, n) .* 133.242;

kepler_elements = [sma', ecc', inc', raan', aop', ta'];

constellation = Constellation(source=BB84_S, ...
                              telescope=Receiver_Telescope, ...
                              startTime = startTime, ...
                              stopTime = stopTime, ...
                              sampleTime = sampleTime, ...
                              KeplerElements=kepler_elements);

show(constellation.toolbox_satellites{1});
