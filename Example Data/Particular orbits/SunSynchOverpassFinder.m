function [RAAN,theta_0,i]=SunSynchOverpassFinder(lat,lon,t,altitude,epochTime)
%% compute the right ascension of the ascending node (RAAN), true anomaly (theta_0) and inclination
%% which cause a circular, sunsynchronous orbit of a given altitude to overfly the position (lat,lon) at time t


%% validate inputs
%the optional input epochTime is the time at which orbital parameters are
%specified. the default is the standard epoch of midday, jan 1, 2000
if nargin == 4
    epochTime = datetime(2000,1,1,12,0,0);
elseif nargin == 5
else
    error('must provide at least 4 inputs:\nLatitude\nLongitude\nTarget time\nOrbital altitude (km)');
end
%altitude must be outside of the atmosphere for a stable orbit and must lie
%below 6554km to support sunsynch nature https://en.wikipedia.org/wiki/Sun-synchronous_orbit
if altitude<100
    error('altitude must be outside of the atmosphere (>=100km) for a stable orbit')
elseif altitude>6554
    error('altitude must be below 6554km to achieve sunsynchronicity')
end

%note that t and epochTime must be a datetime and altitude is in km

%% first, compute inclination and orbital period in order to have sunsynchronicity
[i,Period_s]=SunSynchronousPolarOrbit(altitude);

%% compute geocentric position of the OGS at time t
Standard_Epoch = datetime(2000,1,1,12,0,0);
phi_0=-80;%this value is the angle between geographic and geocentric coordinates at 0s past midnight on 1,1,2000 (the millenium)
phi = 360*days(t-Standard_Epoch)+phi_0;
ogs_xyz = [cosd(lat)*cosd(lon+phi)
           cosd(lat)*sind(lon+phi)
           sind(lat)];

%% compute the RAAN and true anomaly which causes the orbit to overpass this location at 
%% the standard astonomical epoch, 12:00 (midday) on 1 jan 2000

%overpass is designated by maximising the dot product of OGS and sat geocentric
%positions. the satellite position is projected forward in time from the
%epochTime to the time requested
Satellite_Progress_Angle = 360*mod(seconds(t-epochTime)/Period_s,1);
%define a function which computes the geocentric position of the satellite at
%time t: satpos(Omega_Theta(1),Omega_Theta(2)+Satellite_Progress_Angle,i)

%then compute the negative of the dot with the position of the OGS at time t.
%Minimising this will give the optimal orbit
DOT_minus = @(Omega_Theta) -dot(ogs_xyz,satpos(Omega_Theta(1),Omega_Theta(2)+Satellite_Progress_Angle,i));

%minimise the negative dot product
[Solution,fval] = fminunc(DOT_minus,[45;45],optimoptions("fminunc","Display","off"));
%this produces a solution vector which needs processing

%check that solution is 'good enough'
if fval>-0.95
    warning('optimisation to find overpass has failed');
end

RAAN = Solution(1);
%check that RAAN is is 0-360
if RAAN < 0
    RAAN = RAAN+360;
end



%% finally, backdate this solution so that it overpasses at the desired time
theta_0 = Solution(2);
%and make sure this is in 0-360
theta_0=mod(theta_0,360);

end

function sat_xyz = satpos(Omega,theta,i)
%return the normalised xyz position of the satellite at standard epoch
% 12:00 (midday) on 1 jan 2000
R_Omega = [cosd(Omega) -sind(Omega) 0
            sind(Omega) cosd(Omega) 0
            0           0          1];

R_i =  [1  0      0
        0 cosd(i) -sind(i)
        0 sind(i) cosd(i)];


sat_xyz=R_Omega*R_i*[cosd(theta);sind(theta);0];
end



