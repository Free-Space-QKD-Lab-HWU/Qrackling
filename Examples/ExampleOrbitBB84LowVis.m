% a simulation of BB84 with limited visibility

%% 1. Choose parameters
Wavelength=690;                                                            %wavelength is measured in nm
Transmitter_Telescope_Diameter=0.1;                                        %diameters are measured in m
OrbitDataFileLocation='100kmSSOrbitLLAT.txt';                                %orbits are described by files containing latitude, longitude, altitude and time stamps. These are in the 'orbit modelling resources' folder
Receiver_Telescope_Diameter=1;                                           
Time_Gate_Width=1E-10;                                                      %times are measured in s
Spectral_Filter_Width=10;                                                  %consistemt with wavelength, spectral width is measured in nm                           
% %% 2. Construct components

%2.1 Satellite
%2.1.1 Source
Transmitter_Source=components.Source(Wavelength);                                       %we use default values to simplify this example

%2.1.2 Transmitter telescope
Transmitter_Telescope=components.Telescope(Transmitter_Telescope_Diameter);        %do not need to specify wavelength as this will be set by satellite object

%2.1.3 Construct satellite
SimSatellite=nodes.Satellite(Transmitter_Telescope,...
                        'Source',Transmitter_Source,...
                        'OrbitDataFileLocation',OrbitDataFileLocation);

%2.2 Ground station
%2.2.1 Detector
Detector=components.Detector(Wavelength,Transmitter_Source.Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width,'Preset',components.loadPreset("PerkinElmer"));
%need to provide repetition rate in order to compute QBER and loss due to
%time gating

%2.2.2 Receiver telescope
Receiver_Telescope=components.Telescope(Receiver_Telescope_Diameter);

%2.2.3 construct ground station, use Heriot-Watt as an example
SimGround_Station=nodes.Ground_Station(Receiver_Telescope,...
                                'Detector',Detector,...
                                'LLA',[55.909723, -3.319995,10],...
                                'Name','Heriot-Watt');

%% 3 create a low visibility environment
%3.1 load in low-visibility data (choose from MODTRAN files)
load("Examples/Data/atmospheric transmittance/varying elevation MODTRAN data 3/Elevation_Wavelength_Atmospheric_Transmittance5km.mat","Elevation","Transmittance","Wavelength");
%we simulate low visibility here. Options are:
                                                                          %clear,
                                                                          %100m,
                                                                          %200m,
                                                                          %500m,
                                                                          %1km,
                                                                          %2km,
                                                                          %5km,
                                                                          %10km,
                                                                          %20km,
                                                                          %50km
%3.2 reformat this data to be a wavelength x heading x elevation
%interpolatable array
Dummy_Headings = [1,359]; %need to be able to interpolate, so use two heading values
    % provide two copies of Transmittance to correspond to two headings
    Transmittance(isnan(Transmittance))=0;
    Transmittance = permute(Transmittance,[1,3,2]);
    Transmittance = cat(2,Transmittance,Transmittance);
%3.3 provide Dummy background spectrum data (zeros)
Dummy_Spectral_Radiance = zeros(size(Transmittance));
%3.4 environment
Env = environment.Environment(Dummy_Headings,Elevation,Wavelength,Dummy_Spectral_Radiance,Transmittance);

%% 4 run and plot simulation
%4.1 run simulation
Result=nodes.QkdPassSimulation(SimGround_Station,SimSatellite,protocol.bb84,'Environment',Env);
%4.2 plot results
Result.plot()
