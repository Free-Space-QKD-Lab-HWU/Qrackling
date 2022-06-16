%% vary the position of a jamming terminal and plot the effect on uptime and downlink data
%% with a very high performance satellite, OGS and jamming terminal to verify limits
%this function takes approximately 8 seconds per simulation


%% Declare common values
    Transmitter_Diameter=0.6;
    Receiver_Diameter=2;
    OrbitDataFileLocation='500kmOrbitLLAT.txt';
    BackgroundLightDataLocation='none';
    Wavelength=850;
    Time_Gate_Width=10^-9;
    Spectral_Filter_Width=1;
    Repetition_Rate=10^9;
    Generic_Detector_Factory=Generic_Detector_Factory();
  
    OGS_Location=[56.40555555,-3.18833333,10];
    Laser_Elevation_Limit=0;
    Orbit_Longitude_Offset=(0.1867614400611942-OGS_Location(2))*pi/180; %longitude difference in rads between the satellite path and OGS at the same latitude

    %% declare common components
    Transmitter_Telescope=Telescope(Transmitter_Diameter,Wavelength,1);
    Receiver_Telescope=Telescope(Receiver_Diameter,Wavelength,1);

    %% BB84 simple hardware
    %declare specific components
    BB84_S=BB84_Source(Wavelength);
    BB84_D=CreateDetector(Generic_Detector_Factory,Wavelength,'BB84',Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
    BB84_P=BB84_Protocol();
    %make generic components
    SimSatellite=Satellite(OrbitDataFileLocation,BB84_S,Transmitter_Telescope);
    SimSatellite=SetPointingJitter(SimSatellite,0); %zero pointing jitter for high performance
    SimGround_Station=Ground_Station(BackgroundLightDataLocation,BB84_D,Receiver_Telescope,'Errol',OGS_Location);
    SimGround_Station=SetElevationLimit(SimGround_Station,10);
    SimGround_Station=SetPointingJitter(SimGround_Station,0); %zero pointing jitter for high performance

%% zero jamming case
%make passsimulation
BB84_Simple_Pass=PassSimulation(SimSatellite,BB84_P,SimGround_Station,[]);
BB84_Simple_Pass=Simulate(BB84_Simple_Pass);
Zero_Jamming_Data=GetTotalSiftedKey(BB84_Simple_Pass);
Zero_Jamming_Uptime=GetUpTime(BB84_Simple_Pass);

%% jamming cases
    %% jamming properties
    Jamming_Laser_Diameter=1;
    Jamming_Power=1000; %in watts
    Jamming_Spectral_Width=1; % in nms

    %% delcare jamming positions
    %radius
    N_Radii=100;
    Rad_Max=5*10^6;
    Rad_Min=0.5*10^6;
    Radii=linspace(Rad_Min,Rad_Max,N_Radii);
    Earth_Radius=earthRadius();

    %heading
    N_Headings=2;
    Heading_Max=90;
    Heading_Min=0;
    Headings=linspace(Heading_Min,Heading_Max,N_Headings);

    %output positions
    Jamming_Positions=cell(N_Radii,N_Headings);
    Latitudes=ones(N_Radii,N_Headings);
    Longitudes=ones(N_Radii,N_Headings);
    Altitudes=ones(N_Radii,N_Headings);
    Jamming_Data=ones(N_Radii,N_Headings);
    Jamming_Uptime=ones(N_Radii,N_Headings);
    parfor i=1:N_Radii
        for j=1:N_Headings
            %produce lla of jamming terminal
            Radius=Radii(i);
            Heading=Headings(j); %#ok<*PFBNS> 
            [Lat,Lon]=MoveAlongSurface(OGS_Location(1),OGS_Location(2),Radius/Earth_Radius,Heading);
            Latitudes(i,j)=Lat;
            Longitudes(i,j)=Lon;
            Altitudes(i,j)=OGS_Location(3);
            Jamming_Positions{i,j}=[Latitudes(i,j),Longitudes(i,j),Altitudes(i,j)];
            %% do jamming simulation
            Laser=Jamming_Laser(Wavelength,Jamming_Laser_Diameter,[Lat,Lon,OGS_Location(3)],'Janice',Jamming_Power,Jamming_Spectral_Width);
            Laser=SetElevationLimit(Laser,Laser_Elevation_Limit);
            Laser=SetPointingJitter(Laser,0);
            BB84_Jamming_Sim=PassSimulation(SimSatellite,BB84_P,SimGround_Station,Laser);
            BB84_Jamming_Sim=Simulate(BB84_Jamming_Sim);
            Jamming_Data(i,j)=GetTotalSiftedKey(BB84_Jamming_Sim);
            Jamming_Uptime(i,j)=GetUpTime(BB84_Jamming_Sim);

        end
    end

%% compute LOS jamming range
%here, we simulate a pass directly N->S over the OGS. Therefore the max
%distance between jamming terminal and bob for 100% jamming is given by
%Jam->OGS arc^2+comms arc^2=jamming arc^2
Mean_Satellite_Altitude=mean(SimSatellite.Altitude);
Comms_Window_Arc=ComputeLOSWindow(Mean_Satellite_Altitude,SimGround_Station.Elevation_Limit); %arcdistance to the satellite inside which the OGS has LOS
Jamming_Window_Arc=ComputeLOSWindow(Mean_Satellite_Altitude,Laser_Elevation_Limit); %arcdistance to the satellite inside which the jamming terminal has LOS

%upper bound on 100% jamming performance eastwards
Eastwards_100_Jamming_Arc=sqrt(Jamming_Window_Arc^2-Comms_Window_Arc^2);   %max eastward arc between jamming terminal and OGS when 100% jamming is possible
Eastwards_100_Jamming_Distance=Eastwards_100_Jamming_Arc*Earth_Radius; %max eastwards ground distance between jamming terminal and OGS when 100% jamming is possible
%lower bound on 0% jamming eastwards
Eastwards_0_Jamming_Arc=Orbit_Longitude_Offset+Jamming_Window_Arc;
Eastwards_0_Jamming_Distance=Eastwards_0_Jamming_Arc*Earth_Radius;
%upper bound on 100% jamming northwards
Northwards_100_Jamming_Arc=Jamming_Window_Arc-Comms_Window_Arc;   %max northwards arc between jamming terminal and OGS when 100% jamming is possible
Northwards_100_Jamming_Distance=Northwards_100_Jamming_Arc*Earth_Radius; %max northwards ground distance between jamming terminal and OGS when 100% jamming is possible
%lower bound on 0% jamming northwards
Northwards_0_Jamming_Arc=Jamming_Window_Arc+Comms_Window_Arc;
Northwards_0_Jamming_Distance=Northwards_0_Jamming_Arc*Earth_Radius;

%% do plotting
Latitude_Vector=Latitudes(:);
Longitude_Vector=Longitudes(:);
Plot_Height=Earth_Radius/5;
Jamming_Data_Vector=Jamming_Data(:);
Jamming_Uptime_Vector=Jamming_Uptime(:);

%2d figure
%first row is northwards, last row is eastwards
e1=figure('name','Total sifted key as function of jamming terminal distance');
hold on
plot(Radii,Jamming_Data(:,1)/Zero_Jamming_Data,'Color',[0.8500 0.3250 0.0980])
plot(Radii,Jamming_Data(:,end)/Zero_Jamming_Data,'Color',[0.4940 0.1840 0.5560]);
xline(Northwards_100_Jamming_Distance,'Color',[0.8500 0.3250 0.0980],'LineStyle','--')
xline(Northwards_0_Jamming_Distance,'Color',[0.8500 0.3250 0.0980],'LineStyle','--')
xline(Eastwards_100_Jamming_Distance,'Color',[0.4940 0.1840 0.5560],'LineStyle','--');
xline(Eastwards_0_Jamming_Distance,'Color',[0.4940 0.1840 0.5560],'LineStyle','--');
legend({sprintf('Northwards\n(along satellite path)'),sprintf('Eastwards\n(perpendicular to satellite path)'),'Northwards LOS bounds','','Eastwards LOS bounds'},'Location','southeast')
xlabel('distance from jamming terminal to ground station (m)')
ylabel('Total sifted key (proportion of unjammed case)')
hold off


e2=figure('name','Link availability as function of jamming terminal distance');
hold on
plot(Radii,Jamming_Uptime(:,1)/Zero_Jamming_Uptime,'Color',[0.8500 0.3250 0.0980])
plot(Radii,Jamming_Uptime(:,end)/Zero_Jamming_Uptime,'Color',[0.4940 0.1840 0.5560]);
xline(Northwards_100_Jamming_Distance,'Color',[0.8500 0.3250 0.0980],'LineStyle','--')
xline(Northwards_0_Jamming_Distance,'Color',[0.8500 0.3250 0.0980],'LineStyle','--')
xline(Eastwards_100_Jamming_Distance,'Color',[0.4940 0.1840 0.5560],'LineStyle','--');
xline(Eastwards_0_Jamming_Distance,'Color',[0.4940 0.1840 0.5560],'LineStyle','--');
legend({sprintf('Northwards\n(along satellite path)'),sprintf('Eastwards\n(perpendicular to satellite path)'),'Northwards LOS bounds','','Eastwards LOS bounds'},'Location','southeast')
xlabel('distance from jamming terminal to ground station (m)')
ylabel('link availability time (proportion of unjammed case)')
hold off