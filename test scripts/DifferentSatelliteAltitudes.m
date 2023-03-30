%% a script which explores the effectiveness of QKD as a function of satellite altitude

%% common components to all satellites
%channel parameters
Wavelength = 808;
protocol=decoyBB84_Protocol();
Satellite_Telescope_Diameter = 0.1;
%receiver
OGS = HOGS(Wavelength);
%source
source = decoyBB84_Source(Wavelength);
%telescope
telescope = Telescope(Satellite_Telescope_Diameter,'Wavelength',Wavelength);

%% iterating over altitudes
%100km to 1000km 
Altitudes = linspace(100,1000,30);
N_Altitudes = numel(Altitudes);
%prepare memory
Passes = cell(1,N_Altitudes);
%iterate
i=1;
for altitude = Altitudes

    %determine how satellite should be oriented to have an overpass 12 hours into
    %its orbit
    TargetTime = datetime(2000,1,1,23,1,0);
    startTime = TargetTime - hours(1);
    stopTime = TargetTime + hours(1);
    [RAAN,TrueAnomaly,Inclination]=SunSynchOverpassFinder(OGS.Latitude,OGS.Longitude,TargetTime,altitude,startTime);

    %create satellite
    Satellite = SunSynchSat(altitude,...
                            'Telescope',telescope,...
                             'Source',source,...
                             'inclination',Inclination,...
                             'argumentOfPeriapsis',0,...
                             'rightAscensionOfAscendingNode',RAAN,...
                             'trueAnomaly',TrueAnomaly,...
                             'startTime',startTime,...
                             'stopTime',stopTime,...
                             'sampleTime',seconds(10));
    %create pass
    Pass = PassSimulation(Satellite,protocol,OGS);
    %simulate
    Pass=Simulate(Pass);
    %store
    Passes{i}=Pass;
    i=i+1;
end

%% plot
Secret_Key_Total = cellfun( @(x) x.Total_Secret_Key,Passes);
Sifted_Key_Total = cellfun( @(x) x.Total_Sifted_Key,Passes);
plot(Altitudes,Sifted_Key_Total,'b:',Altitudes,Secret_Key_Total,'b-');
xlabel('Altitude (km)')
ylabel('key per pass (bits)')
legend('Sifted key','Secret key')