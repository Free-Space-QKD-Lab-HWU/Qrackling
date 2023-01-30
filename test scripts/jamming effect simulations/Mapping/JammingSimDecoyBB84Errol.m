%% vary the position of a jamming terminal and plot the effect on uptime and downlink data
%this function takes approximately 8 seconds per simulation


%% Declare common values
    Transmitter_Diameter=0.3;
    Receiver_Diameter=0.7;
    OrbitDataFileLocation='500kmSSOrbitLLAT.txt';
    BackgroundLightDataLocation='none';
    Wavelength=850;
    Time_Gate_Width=10^-9;
    Spectral_Filter_Width=1;
    Repetition_Rate=10^8;
    OGS_Location=[56.40555555,-3.18833333,10];
    Laser_Elevation_Limit=0;
    Orbit_Longitude_Offset=(0.1867614400611942-OGS_Location(2))*pi/180; %longitude difference in rads between the satellite path and OGS at the same latitude

    %% declare common components
    Transmitter_Telescope=Telescope(Transmitter_Diameter,'Optical_Efficiency',0.6,'Wavelength',Wavelength);
    Transmitter_Telescope=SetFOV(Transmitter_Telescope,10E-6);
    Receiver_Telescope=Telescope(Receiver_Diameter,'Optical_Efficiency',0.6);

    %% BB84 simple hardware
    %declare specific components
    BB84_S=Source(Wavelength,'Mean_Photon_Number',[0.8,0.1,0],'State_Probabilities',[0.5,0.25,0.25]);
    BB84_D=MPD_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
    decoyBB84_P=decoyBB84_Protocol();
    %make generic components
    SimSatellite=Satellite(BB84_S,Transmitter_Telescope,'OrbitDataFileLocation',OrbitDataFileLocation);
    SimGround_Station=Ground_Station(BB84_D,Receiver_Telescope,'LLA',OGS_Location,'name','Errol');
    SimGround_Station=SetElevationLimit(SimGround_Station,10);




%% zero jamming case
%make passsimulation
BB84_Simple_Pass=PassSimulation(SimSatellite,decoyBB84_P,SimGround_Station);
BB84_Simple_Pass=Simulate(BB84_Simple_Pass);
Zero_Jamming_Data=GetTotalSiftedKey(BB84_Simple_Pass);
Zero_Jamming_Uptime=GetUpTime(BB84_Simple_Pass);

%% jamming cases
    %% jamming properties
    Jamming_Laser_Diameter=0.1;
    Jamming_Power=1000; %in watts
    Jamming_Spectral_Width=1; % in nms

    %% delcare jamming positions
    %radius
    N_Radii=50;
    Rad_Max=5*10^6;
    Rad_Min=0.5*10^6;
    Radii=linspace(Rad_Min,Rad_Max,N_Radii);
    Earth_Radius=earthRadius();

    %heading
    N_Headings=20;
    Heading_Max=180;
    Heading_Min=90;
    Headings=linspace(Heading_Min,Heading_Max,N_Headings);

    %output positions
    Jamming_Positions=cell(N_Radii,N_Headings);
    Latitudes=ones(N_Radii,N_Headings);
    Longitudes=ones(N_Radii,N_Headings);
    Altitudes=ones(N_Radii,N_Headings);
    Jamming_Data=ones(N_Radii,N_Headings);
    Jamming_Uptime=ones(N_Radii,N_Headings);
    JammingLOSPrediction = zeros(N_Radii,N_Headings);
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
            Laser=Jamming_Laser(Wavelength,Jamming_Laser_Diameter,[Lat,Lon,OGS_Location(3)],Jamming_Power,Jamming_Spectral_Width);
            Laser=SetElevationLimit(Laser,Laser_Elevation_Limit);
            BB84_Jamming_Sim=PassSimulation(SimSatellite,decoyBB84_P,SimGround_Station,'Background_Sources',Laser);
            BB84_Jamming_Sim=Simulate(BB84_Jamming_Sim);
            Jamming_Data(i,j)=GetTotalSiftedKey(BB84_Jamming_Sim);
            Jamming_Uptime(i,j)=GetUpTime(BB84_Jamming_Sim);


            %% predict jamming performance using LOS
            %find which sim points the satellite is in view of the laser
            [~,Elevations] = RelativeHeadingAndElevation(SimSatellite,Laser);
            IsInJammingLOS = Elevations>=Laser_Elevation_Limit;
            %find the proportion of times when the satellite is in view of the
            %OGS when it is also in view of the laser
            JamableProportion = sum(double(IsInJammingLOS).*GetSecretKeyRates(BB84_Simple_Pass))/GetTotalSiftedKey(BB84_Simple_Pass);
            %store jamming performance prediction as this proportion
            JammingLOSPrediction(i,j)=JamableProportion;
        end
    end

%% compute LOS jamming range
%here, we simulate a pass directly N->S over the OGS. Therefore the max
%distance between jamming terminal and bob for 100% jamming is given by
%Jam->OGS arc^2+comms arc^2=jamming arc^2
Mean_Satellite_Altitude=mean(SimSatellite.Altitude);
Comms_Window_Arc=ComputeLOSWindow(Mean_Satellite_Altitude,SimGround_Station.Elevation_Limit); %arcdistance to the satellite inside which the OGS has LOS
Jamming_Window_Arc=ComputeLOSWindow(Mean_Satellite_Altitude,Laser_Elevation_Limit); %arcdistance to the satellite inside which the jamming terminal has LOS

%{
predict limits on LOS
%upper bound on 100% jamming performance eastwards
Eastwards_100_Jamming_Arc=sqrt(Jamming_Window_Arc^2-Comms_Window_Arc^2);   %max eastward arc between jamming terminal and OGS when 100% jamming is possible
Eastwards_100_Jamming_Distance=Eastwards_100_Jamming_Arc*Earth_Radius; %max eastwards ground distance between jamming terminal and OGS when 100% jamming is possible
%lower bound on 0% jamming eastwards
Eastwards_0_Jamming_Arc=Orbit_Longitude_Offset+Jamming_Window_Arc;
Eastwards_0_Jamming_Distance=Eastwards_0_Jamming_Arc*Earth_Radius;
%upper bound on 100% jamming northwards
Southwards_100_Jamming_Arc=Jamming_Window_Arc-Comms_Window_Arc;   %max northwards arc between jamming terminal and OGS when 100% jamming is possible
Southwards_100_Jamming_Distance=Southwards_100_Jamming_Arc*Earth_Radius; %max northwards ground distance between jamming terminal and OGS when 100% jamming is possible
%lower bound on 0% jamming northwards
Southwards_0_Jamming_Arc=Jamming_Window_Arc+Comms_Window_Arc;
Southwards_0_Jamming_Distance=Southwards_0_Jamming_Arc*Earth_Radius;
%}

%% do plotting
Latitude_Vector=Latitudes(:);
Longitude_Vector=Longitudes(:);
Jamming_Data_Vector=Jamming_Data(:);

%2d figure
%first row is northwards, last row is eastwards
e1=figure('name','Jamming performance as a function of jamming terminal distance');
hold on
plot(Radii,1-Jamming_Data(:,1)/Zero_Jamming_Data,'Color',[0.8500 0.3250 0.0980])
plot(Radii,1-Jamming_Data(:,end)/Zero_Jamming_Data,'Color',[0.4940 0.1840 0.5560]);

%{
plot limits of LOS
xline(Eastwards_100_Jamming_Distance,'Color',[0.8500 0.3250 0.0980],'LineStyle','--')
xline(Eastwards_0_Jamming_Distance,'Color',[0.8500 0.3250 0.0980],'LineStyle','--')
xline(Southwards_100_Jamming_Distance,'Color',[0.4940 0.1840 0.5560],'LineStyle','--');
xline(Southwards_0_Jamming_Distance,'Color',[0.4940 0.1840.5560],'LineStyle','--');
%}

plot(Radii,JammingLOSPrediction(:,1),'Color',[0.8500 0.3250 0.0980],'LineStyle','none','Marker','*')
plot(Radii,JammingLOSPrediction(:,end),'Color',[0.4940 0.1840 0.5560],'LineStyle','none','Marker','*');
legend({sprintf('Eastwards\n($\\perp$ satellite path)'),sprintf('Southwards\n($||$ to satellite path)'),'$\perp$ LOS performance prediction','$||$ LOS performance prediction'},'Location','northeast','Interpreter','latex')
xlabel('Distance from jamming terminal to ground station (m)')
ylabel('Jamming performance')
hold off

hold off


%% map based figures
g3=figure('name','Total sifted key as function of jamming terminal position');
%plot each individual point with different colour
geoscatter(Latitude_Vector,Longitude_Vector,'filled','Marker','o','CDataMode','manual','CData',1-Jamming_Data_Vector/Zero_Jamming_Data);
cb=colorbar('east','Limits',[0,1]);
cb.Label.String='Jamming Performance';
colormap('winter')
hold on
geoscatter(OGS_Location(1),OGS_Location(2),'Marker','*','MarkerEdgeColor','k')
%plot satellite path
SatPath=GetLLA(SimSatellite);
geoplot(SatPath(:,1),SatPath(:,2),'k--');
legend({'Jamming terminal locations','Receiver location','Satellite ground path'})
geolimits([10,60],[-10,80])
hold off
