function [RAAN,theta_0,inc]=sunSyncOverpassFinder(lat,lon,t,altitude,epochTime)
%% compute the right ascension of the ascending node (RAAN), true anomaly (theta_0) and inclination
%% which cause a circular, sunsynchronous orbit of a given altitude to overfly the position (lat,lon) at time t
arguments
    lat (1,1) {mustBeNumeric}
    lon (1,1) {mustBeNumeric}
    t (1,1) datetime
    altitude (1,1) {mustBeGreaterThan(altitude,100)}
    epochTime (1,1) datetime = datetime(2000,1,1,12,0,0)
end
%note that t and epochTime must be a datetime and altitude is in km

%% first, compute inclination and orbital period in order to have sunsynchronicity
inc=utilities.sunSyncPolarOrbit(altitude);


%% minimise the difference in lat and lon between sat and OGS
%define constraints in form Ax<=b

[Solution,fval] = lsqnonlin(@geographicDistance,[0,0],[-180,-180],[180,180],...
                            optimoptions("lsqnonlin","Algorithm","trust-region-reflective",...
                            "Display","off"));
%this produces a solution vector which needs processing

%check that solution is 'good enough'
if fval>1
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


%% we need a function which computes the LLA of a satellite at time t
%as a function of raan and theta_0
    function lla_sat = computeSatLLA(raan,theta_0)
        %% compute the position of the satellite in the orbital frame
        radius_sat = earthRadius + altitude*1000;
        lla_sat = propagateOrbit(t,radius_sat,0,inc,raan,0,theta_0,...
                                 "Epoch",epochTime,...
                                  "OutputCoordinateFrame","geographic",...
                                  "PropModel","two-body-keplerian");

    end

%% and a function which computes some form of geographic distance between sat and ogs
    function d = geographicDistance(raan_and_theta_0)
        sat_lla = computeSatLLA(raan_and_theta_0(1),raan_and_theta_0(2));
        d = [wrapTo180(sat_lla(1) - lat), wrapTo180(sat_lla(2) - lon)];
    end
end