function SSSat = SunSynchSat(Altitude_km,varargin)
%% return a satellite in a sun-synchronous polar orbit at a particular orbit altitude

%% default components if none are provided
DefaultSource = Source(850,'Repetition_Rate',1E8);
DefaultTelescope = Telescope(0.1,'Wavelength',850,...
                                'Pointing_Jitter',1E-6);
%% parameters specified by this kind of orbit
eccentricity = 0;
SemiMajorAxis = earthRadius + Altitude_km * 1000;
argumentOfPeriapsis = 0; %in a circular orbit, AOP is meaningless

p=inputParser();
addRequired(p,'Altitude_km');
addParameter(p,'Telescope',DefaultTelescope);
addParameter(p, 'Source',DefaultSource);
addParameter(p, 'inclination', SunSynchronousPolarOrbit(Altitude_km));
addParameter(p, 'rightAscensionOfAscendingNode', 0);
addParameter(p, 'argumentOfPeriapsis', 0);
addParameter(p, 'trueAnomaly', 0);
addParameter(p, 'startTime', datetime(2000,1,1,0,0,0));
addParameter(p, 'stopTime', datetime(2000,1,2,0,0,0));
addParameter(p, 'sampleTime', seconds(1));
addParameter(p, 'Name', 'SunSynchronous Sat');
addParameter(p, 'TLE_Uncertainty',5E3);
% satellite surface reflection properties
addParameter(p, 'Surface', Satellite_Foil_Surface(4))
addParameter(p, 'Area', [])
% downlink beacon, if wanted
addParameter(p, 'Beacon', [])
%up link beacon camera, if wanted
addParameter(p, 'Camera', []);
%detector, for uplink
addParameter(p,'Detector',[]);
%parse inputs
parse(p,Altitude_km,varargin{:});


SSSat = Satellite(p.Results.Telescope,...
                'Source',p.Results.Source,...
                'Name',p.Results.Name,...
                'semiMajorAxis',SemiMajorAxis,...
                'eccentricity',eccentricity,...
                'inclination',p.Results.inclination,...
                'rightAscensionOfAscendingNode',p.Results.rightAscensionOfAscendingNode,...
                'argumentOfPeriapsis',argumentOfPeriapsis,...
                'trueAnomaly',p.Results.trueAnomaly,...
                'startTime',p.Results.startTime,...
                'stopTime',p.Results.stopTime,...
                'sampleTime',p.Results.sampleTime);