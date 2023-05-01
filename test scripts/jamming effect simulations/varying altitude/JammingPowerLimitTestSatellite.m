%% a script which explores the power and diameter required of a jammer to be JUST
%% line-of-sight limited as a function of altitude for a satellite

%% common components to all satellites
%channel parameters
Wavelength = 808;
Repetition_Rate = 1E9;
Time_Gate_Width = 1E-9;
Spectral_Filter_Width = 1;
protocol=decoyBB84_Protocol();
Satellite_Telescope_Diameter = 0.01;
Satellite_Reflecting_Area = 75.3*2.4;%area of a NASA Helios
Comms_Heading = -90;                   %satellite is west of OGS
Jammed_Count_Rate = 1E6;           %we consider a link jammed when it has 1000cps of extra counts
%receiver
OGS = HOGS(Wavelength);
OGS.Detector = Perfect_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
%source
source = decoyBB84_Source(Wavelength);
%telescope
telescope = Telescope(Satellite_Telescope_Diameter,'Wavelength',Wavelength);

%jamming parameters
Jamming_Heading = 90;          %jammer is east of OGS
Jamming_FOV = 1E-3;
Jamming_Diameter = 0.1;%diameter in m
Jamming_Power = 1E-9;    %power in W
Jamming_Spectral_Width = 10;%spectral width in nm
Jamming_Pointing_Jitter = 1E-4;
Jamming_Elevation_Limit = 0.1; % can jam down to within 1 deg of horizon
%% iterating over altitudes
%1000ft to 100,000ft
Altitudes = linspace(100E3,1000E3,50);
N_Altitudes = numel(Altitudes);
%prepare memory
Unjammed_Passes = cell(1,N_Altitudes);
Jammed_Passes = cell(1,N_Altitudes);
LOS_Limit_Power = zeros(1,N_Altitudes);
LOS_Limit_PD2 = zeros(1,N_Altitudes);
%iterate
i=1;
for altitude = Altitudes

    %% jammer
    Complete_Jamming_Range = JammingRange(altitude,OGS.Elevation_Limit,Jamming_Elevation_Limit);
    [Jamming_Lat,Jamming_Lon]=MoveAlongSurface(OGS.Latitude,OGS.Longitude,Complete_Jamming_Range/earthRadius,Jamming_Heading);
    Jamming_Location = [Jamming_Lat,Jamming_Lon,OGS.Altitude];
    Jammer = Jamming_Laser(Wavelength,Jamming_Diameter,Jamming_Location,Jamming_Power,Jamming_Spectral_Width);
    Jammer = SetFOV(Jammer,Jamming_FOV);
    Jammer = SetPointingJitter(Jammer,Jamming_Pointing_Jitter);
    %% satellite
    %locate satellite on northern edge of comms region
    Comms_Range = earthRadius*ComputeLOSWindow(altitude,OGS.Elevation_Limit+1);
    [Satellite_Lat,Satellite_Lon]=MoveAlongSurface(OGS.Latitude,OGS.Longitude,Comms_Range/earthRadius,Comms_Heading);
    LLAT = [Satellite_Lat,Satellite_Lon,altitude,0
            Satellite_Lat,Satellite_Lon,altitude,1
            Satellite_Lat,Satellite_Lon,altitude,2]; %stationary for 2 seconds at position
    Sat = Satellite(telescope,'source',source,'LLAT',LLAT,'Surface',Undyed_Anodised_Aluminium(Satellite_Reflecting_Area));

    %create jammed pass
    Unjammed_Pass = PassSimulation(Sat,protocol,OGS,'Background_Source',Jammer);
    %simulate
    Unjammed_Pass=Simulate(Unjammed_Pass);
    %compute how much power is required to provide at least 1000cps at receiver
    LOS_Limit_Power(i) = Jamming_Power * Jammed_Count_Rate/min(Unjammed_Pass.Background_Count_Rates(Unjammed_Pass.Elevation_Limit_Flags),[],'all');
    %store
    Unjammed_Passes{i} = Unjammed_Pass;

    %update jammed pass to have described power
    Jammer.Power = LOS_Limit_Power(i);
    Jammed_Pass = PassSimulation(Sat,protocol,OGS,'Background_Source',Jammer);
    %simulate
    Jammed_Pass=Simulate(Jammed_Pass);
    %store
    Jammed_Passes{i}=Jammed_Pass;
    
    
    %next iteration
    i=i+1;
end


%% plotting
figure('Name','Power required for LOS limited jamming')
yyaxis left
plot(LOS_Limit_Power,Altitudes/1000,'k-')
ylabel('Altitude (km)')
xlabel('Power for LOS limitation (W)')
yyaxis right
ylim([Altitudes(1)/1000+6371,Altitudes(end)/1000+6371])
ylabel('Orbital radius (km)')

figure('Name','Range limit for LOS limited jamming')
[Complete_Jamming_Ranges, Possible_Jamming_Ranges] = JammingRange(Altitudes,OGS.Elevation_Limit,Jamming_Elevation_Limit);
yyaxis left
plot(Complete_Jamming_Ranges/1000,Altitudes/1000,'k-',Possible_Jamming_Ranges/1000,Altitudes/1000,'k--');
legend('Complete Jamming Range','No Jamming Range');
xlabel('Range (km)');
ylabel('Altitude (km)');
yyaxis right
ylim([Altitudes(1)/1000+6371,Altitudes(end)/1000+6371])
ylabel('Orbital radius (km)')