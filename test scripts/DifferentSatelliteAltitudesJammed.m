%% a script which explores the effectiveness of QKD as a function of satellite altitude
%% while adding a jamming source nearby

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

%% jammer
Jamming_Range = 2000E3;                                                          %range from OGS to jammer in m
Jamming_Heading = 90;                                                           %heading of jammer from OGS
[Jamming_Lat,Jamming_Lon]=MoveAlongSurface(OGS.Latitude,OGS.Longitude,Jamming_Range/earthRadius,Jamming_Heading);
Jamming_Location = [Jamming_Lat,Jamming_Lon,OGS.Altitude];
Jamming_Diameter = 0.1;%diameter in m
Jamming_Power = 1;    %power in W
Jamming_Spectral_Width = 10;%spectral width in nm
Jammer = Jamming_Laser(Wavelength,Jamming_Diameter,Jamming_Location,Jamming_Power,Jamming_Spectral_Width);

%% iterating over altitudes
%100km to 1000km 
Altitudes = linspace(100,1000,30);
N_Altitudes = numel(Altitudes);
%prepare memory
Unjammed_Passes = cell(1,N_Altitudes);
Jammed_Passes = cell(1,N_Altitudes);
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
                             'sampleTime',seconds(10),...
                             'Surface',Satellite_Foil_Surface(0.01));
    %create unjammed pass
    Unjammed_Pass = PassSimulation(Satellite,protocol,OGS);
    %simulate
    Unjammed_Pass=Simulate(Unjammed_Pass);
    %store
    Unjammed_Passes{i}=Unjammed_Pass;

    %create unjammed pass
    Jammed_Pass = PassSimulation(Satellite,protocol,OGS,'Background_Source',Jammer);
    %simulate
    Jammed_Pass=Simulate(Jammed_Pass);
    %store
    Jammed_Passes{i}=Jammed_Pass;
    i=i+1;
end

%% plot
Unjammed_Secret_Key_Total = cellfun( @(x) x.Total_Secret_Key,Unjammed_Passes);
Unjammed_Sifted_Key_Total = cellfun( @(x) x.Total_Sifted_Key,Unjammed_Passes);
Jammed_Secret_Key_Total = cellfun( @(x) x.Total_Secret_Key,Jammed_Passes);
Jammed_Sifted_Key_Total = cellfun( @(x) x.Total_Sifted_Key,Jammed_Passes);
plot(Altitudes,Unjammed_Sifted_Key_Total,'b:',Altitudes,Unjammed_Secret_Key_Total,'b-',...
    Altitudes,Jammed_Sifted_Key_Total,'r:',Altitudes,Jammed_Secret_Key_Total,'r-');
xlabel('Altitude (km)')
ylabel('key per pass (bits)')
legend({'Sifted key (unjammed)','Secret key (unjammed)','Sifted key (jammed)','Secret key (jammed)'},'NumColumns',2)