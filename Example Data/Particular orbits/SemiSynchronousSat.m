function SSSat = SemiSynchronousSat()
%% provide a default implemntation of a semisynchronous satellite which can have
%% its on-board details replaced

SatTelescope = Telescope(0.1,'Wavelength',850,...
                                'Pointing_Jitter',1E-6);

SatSource = Source(850,'Repetition_Rate',1E8);

SSSat = Satellite(SatTelescope,...
                'Source',SatSource,...
                'Name','SemiSynchronous Sat',...
                'semiMajorAxis',26517*1E3,...
                'eccentricity',0,...
                'inclination',77,...
                'rightAscensionOfAscendingNode',282,...
                'argumentOfPeriapsis',0,...
                'trueAnomaly',0,...
                'startTime',datetime(2000,1,1,0,0,0),...
                'stopTime',datetime(2000,1,8,0,0,0),...
                'sampleTime',seconds(1));