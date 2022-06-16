%% a script which tests the performance of jamming with varying power and optical diameter

%% Declare comms values
    Transmitter_Diameter=0.3;                                              %transmitter diameter in m
    Receiver_Diameter=1;                                                   %receiver diameter in m
    OrbitDataFileLocation='500kmOrbitLLAT.txt';                            %500km orbit
    BackgroundLightDataLocation='none';                                    %no point simulating background light
    Wavelength=850;                                                        %quantum comms wavelength in nm
    OGS_Location=[56.40555555,-3.18833333,10];                             %OGS is at Errol
    Time_Gate_Width=10^-9;
    Spectral_Filter_Width=1;
    Repetition_Rate=10^9;
    Generic_Detector_Factory=Generic_Detector_Factory();


    %% declare common components
    %telescopes
    Transmitter_Telescope=Telescope(Transmitter_Diameter,Wavelength,0.6);
    Receiver_Telescope=Telescope(Receiver_Diameter,Wavelength,0.16);
    %source, detector, protocol
    BB84_S=BB84_Source(Wavelength);
    BB84_D=CreateDetector(Generic_Detector_Factory,Wavelength,'BB84',Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);
    BB84_P=BB84_Protocol();
    %satellite and OGS
    SimSatellite=Satellite(OrbitDataFileLocation,BB84_S,Transmitter_Telescope);
    SimGround_Station=Ground_Station(BackgroundLightDataLocation,BB84_D,Receiver_Telescope,'Errol',OGS_Location);
    SimGround_Station=SetElevationLimit(SimGround_Station,10);


 %% Declare jamming variables
    %common values
    Mean_Satellite_Altitude=mean(SimSatellite.Altitude);                   %satellite altitude in m
    Jamming_Elevation_Limit=0;
    Jamming_Angular_Distance=sqrt(ComputeLOSWindow(Mean_Satellite_Altitude,Jamming_Elevation_Limit)^2-ComputeLOSWindow(Mean_Satellite_Altitude,SimGround_Station.Elevation_Limit)^2);

    Jamming_Heading=90;                                                    %jamming laser is east of OGS
    [Jamming_Laser_Lat,Jamming_Laser_Lon]=MoveAlongSurface(OGS_Location(1),OGS_Location(2),Jamming_Angular_Distance,Jamming_Heading);
    Jamming_Laser_Location=[Jamming_Laser_Lat,Jamming_Laser_Lon,OGS_Location(3)];
    Jamming_Spectral_Width=1;                                              %1nm jamming spectral width

    %power
    N_Powers=30;                                                           %number of power increments
    Max_Laser_Power=10000;                                                 %max power 10kW
    Min_Laser_Power=10;                                                   %min power 100W

    %diameter
    N_Diameters=30;                                                        %number of diameter increments
    Max_Jamming_Diameter=0.1;                                                %max diameter 1m
    Min_Jamming_Diameter=0.001;                                             %min diameter 1cm

    %storage
    Sifted_Key=zeros(N_Powers,N_Diameters);
    Uptime=zeros(N_Powers,N_Diameters);


    %% zero jamming case
    BB84_Simple_Pass=PassSimulation(SimSatellite,BB84_P,SimGround_Station,[]);
    BB84_Simple_Pass=Simulate(BB84_Simple_Pass);
    Zero_Jamming_Data=GetTotalSiftedKey(BB84_Simple_Pass);
    Zero_Jamming_Uptime=GetUpTime(BB84_Simple_Pass);


    %% iterating over different jamming power and optic diameters
    Jamming_Powers=logspace(log10(Min_Laser_Power),log10(Max_Laser_Power),N_Powers);
    Jamming_Diameters=logspace(log10(Min_Jamming_Diameter),log10(Max_Jamming_Diameter),N_Diameters);
    
    parfor i=1:N_Powers
        for j=1:N_Diameters
    %perform parallelised simulations
    Laser=Jamming_Laser(Wavelength,Jamming_Diameters(j),Jamming_Laser_Location,'Janice',Jamming_Powers(i),Jamming_Spectral_Width);
    BB84_Jamming_Sim=PassSimulation(SimSatellite,BB84_P,SimGround_Station,Laser);
    BB84_Jamming_Sim=Simulate(BB84_Jamming_Sim);
    Sifted_Key(i,j)=GetTotalSiftedKey(BB84_Jamming_Sim);
    Uptime(i,j)=GetUpTime(BB84_Jamming_Sim);
        end
    end


    %% plot results
    %meshgrid powers and diameters
    [Plotting_Powers,Plotting_Diameters]=meshgrid(Jamming_Powers,Jamming_Diameters);
    %values of PD^2
    PD2=0.1;

    
    %plot downlinked sk
    figure('Name','Sifted key as a function of jamming terminal power and diameter');
    hold on
    surf(Plotting_Powers,Plotting_Diameters,Sifted_Key'/Zero_Jamming_Data);
    sk_Axis=set(gca,'XScale','log','YScale','log');
    xlabel('Jamming Power (W)')
    ylabel('Jamming Terminal Diameter (m)');
    zlabel('Total sifted key (proportion of unjammed case)');
    colormap winter
    cb=colorbar;
    cb.Limits=[0,1];
    cb.Label.String='Total sifted key (proportion of unjammed case)';
    view(60,60);
        %lines of constant PD^2
        Line_Diameters=(PD2./(Jamming_Powers)).^(1/2);
        plot3(Jamming_Powers,Line_Diameters,zeros(size(Line_Diameters)),'r--','LineWidth',3);
        legend('','$P_{jan} D_{jan}^2 =0.1Wm^2$','Interpreter','Latex','Location','northeast')
        hold off


    %plot uptime
    figure('Name','Link availability as a function of jamming terminal power and diameter');
    hold on
    surf(Plotting_Powers,Plotting_Diameters,Uptime'/Zero_Jamming_Uptime);
    sk_Axis=set(gca,'XScale','log','YScale','log');
    xlabel('Jamming Power (W)')
    ylabel('Jamming Terminal Diameter (m)');
    zlabel('Link availability (proportion of unjammed case)');
    colormap winter
    cb=colorbar;
    cb.Limits=[0,1];
    cb.Label.String='Link availability (proportion of unjammed case)';
    view(60,60);
        %lines of constant PD^2
        plot3(Jamming_Powers,Line_Diameters,zeros(size(Line_Diameters)),'r--','LineWidth',3);
        legend('','$P_{jan} D_{jan}^2 =0.1Wm^2$','Interpreter','Latex','Location','northeast')
        hold off
