%%Test Constellation class

% %% test conversion
close all;
clc;
clear all;

tests = 3;
pass = 0;
debug = false;

%startTime = datetime(2020,6,02,8,23,0);
startTime = datetime(2020,6,02,18,43,16);
stopTime = startTime + hours(5);
%sampleTime = 360;
sampleTime = 6;

Transmitter_Diameter=0.08;
Receiver_Diameter=0.7;
Time_Gate_Width=10^-9;
Repetition_Rate=10^9;
Spectral_Filter_Width=1;
Wavelength=850;

Transmitter_Telescope=Telescope(Transmitter_Diameter,...
                                Wavelength=Wavelength);

Receiver_Telescope=Telescope(Receiver_Diameter,...
                             Wavelength=Wavelength);

BB84_S=BB84_Source(Wavelength);

constellation = Constellation(source=BB84_S, ...
                              telescope=Receiver_Telescope, ...
                              startTime = startTime, ...
                              stopTime = stopTime, ...
                              sampleTime = sampleTime, ...
                              TLE="threeSatelliteConstellation.tle");


% [sma, ecc, inc, raan, aop, ta] = constellation.elementsFromScenario(constellation.toolbox_satellites{1})
% 
% sc = satelliteScenario(startTime, stopTime, sampleTime);
% sat = satellite(sc, sma, ecc, inc, raan, aop, ta);
% con_sat = constellation.toolbox_satellites{1};

% %% other
assert(constellation.N == 3);
pass = pass + 1;

if debug
    for i = 1 : constellation.N
        disp(constellation.Satellites{i});
    end
end

fprintf(1, 'Passing test [%d / %d]\n', pass, tests);

tle = sprintf([...
'AO-07\n', ...
'1 07530U 74089B   22188.54104284 -.00000029  00000-0  10357-3 0  9993\n', ...
'2 07530 101.9048 168.4749 0012358   5.5276 108.6298 12.53655723179980' ...
    ]);

[name, kepler_elements] = utils().TLE2Kepler(TLE=tle);
[sma, ecc, inc, raan, aop, ta] = utils().splat(kepler_elements);

constellation = Constellation(source=BB84_S, ...
                              telescope=Receiver_Telescope, ...
                              startTime = startTime, ...
                              stopTime = stopTime, ...
                              sampleTime = sampleTime, ...
                              name=name, ...
                              KeplerElements=[sma, ecc, inc, raan, aop, ta]);

if debug
    for i = 1 : constellation.N
        disp(constellation.Satellites{i});
    end
end

assert(constellation.N == 1);
pass = pass + 1;

fprintf(1, 'Passing test [%d / %d]\n', pass, tests);

tle_4lines = sprintf([...
'AO-07\n', ...
'1 07530U 74089B   22188.54104284 -.00000029  00000-0  10357-3 0  9993\n', ...
'2 07530 101.9048 168.4749 0012358   5.5276 108.6298 12.53655723179980\n', ...
'UO-11\n', ...
'1 14781U 84021B   22188.48131999  .00000483  00000-0  64471-4 0  9992\n', ...
'2 14781  97.6178 175.0032 0006849 253.3585 106.6878 14.83701924 43010\n', ...
'LO-19\n', ...
'1 20442U 90005G   22188.48850489  .00000049  00000-0  34414-4 0  9996\n', ...
'2 20442  98.7948 153.6570 0012827 108.1633 252.0948 14.33068186695974\n', ...
'HUBBLE\n', ...
'1 20580U 90037B   22188.33037000  .00001415  00000-0  72628-4 0  9991\n', ...
'2 20580  28.4709  37.0879 0002358 248.6535 282.4652 15.10634529569221']);

[names, kepler_elements] = utils().TLE2Kepler(TLE=tle_4lines);

[sma, ecc, inc, raan, aop, ta] = utils().splat(kepler_elements);


constellation = Constellation(source=BB84_S, ...
                              telescope=Receiver_Telescope, ...
                              startTime = startTime, ...
                              stopTime = stopTime, ...
                              sampleTime = sampleTime, ...
                              name=names, ...
                              KeplerElements=kepler_elements);

if debug
    for i = 1 : constellation.N
        disp(constellation.Satellites{i});
    end
end

sat = constellation.toolbox_satellites{1};
show(sat);

assert(constellation.N == 4);
pass = pass + 1;

fprintf(1, 'Passing test [%d / %d]\n', pass, tests);
