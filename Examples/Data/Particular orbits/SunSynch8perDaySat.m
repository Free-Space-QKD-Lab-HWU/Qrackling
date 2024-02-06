function SSSat = SunSynch8perDaySat()
%% provide a default implemntation of a sun synchronous satellite which can have
%% its on-board details replaced

SatTelescope = Telescope(0.1,'Wavelength',850,...
                                'Pointing_Jitter',1E-6);

SatSource = Source(850,'Repetition_Rate',1E8);

SSSat = Satellite(SatTelescope,...
                'Source',SatSource,...
                'Name','SunSynchronous Sat',...
                'semiMajorAxis',10560.1*1E3,...
                'eccentricity',0,...
                'inclination',123.473880028008,...
                'rightAscensionOfAscendingNode',0,...
                'argumentOfPeriapsis',0,...
                'trueAnomaly',0,...
                'startTime',datetime(2000,1,1,0,0,0),...
                'stopTime',datetime(2000,1,8,0,0,0),...
                'sampleTime',seconds(1));