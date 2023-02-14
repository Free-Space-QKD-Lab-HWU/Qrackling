function HubSat = NOTQUARC(StartTime,StopTime,SampleTime)
            %NOTQUARC Construct a model of the Quantum Comms hub satellite
            
            %% allow variable start and stop time of simulations
            switch nargin
                case 0
                    StartTime = datetime(2024,1,1,5,0,0);
                    StopTime = datetime(2024,1,1,6,0,0);
                    SampleTime = 1;
                case 1
                    assert(isdatetime(StartTime));
                    StopTime = StartTime + days(1);
                    SampleTime = 1;
                case 2
                    assert(isdatetime(StartTime));
                    assert(isdatetime(StopTime));
                    SampleTime = 1;
                case 3
                    assert(isdatetime(StartTime));
                    assert(isdatetime(StopTime));
                    if isduration(SampleTime)
                        SampleTime = seconds(SampleTime);
                    end
            end

            %need to implement parameters and components first, then create a
            %satellite with the correct orbital parameters

            %Telescope
            %for details (and details of downlink beacon) see
            % Quarc: Quantum research cubesat—a constellation for quantum communication
            %Mazzarella, Luc, Lowe, Christopher, Lowndes, David, Joshi, Siddarth Koduru, Greenland, Steve
            %McNeil, Doug, Mercury, Cassandra, Macdonald, Malcolm, Rarity, John, Oi, Daniel Kuan Li
            Wavelength = 785;                                                   %wavelength of source in nm
            HubSat_Scope_Diameter = 0.08;                                        %telescope diameter in m
            HubSat_Scope_Efficiency = 1;                                      %telescope optical efficiency (unitless)
            HubSat_Pointing_Jitter = 1E-6;                                      %telescope pointing error in rads
            HubSat_Scope_FOV = 22E-6;                                          %quantum signal FOV in rads
            HubSatScope = Telescope(HubSat_Scope_Diameter,...
                'Wavelength',Wavelength,...
                'Optical_Efficiency',HubSat_Scope_Efficiency,...
                'Pointing_Jitter',HubSat_Pointing_Jitter,...
                'FOV',HubSat_Scope_FOV);

            %source
            %for details see
            % "Design and test of optical payload for polarization encoded QKD for Nanosatellites"
            % by Sagar, Jaya, Hastings, Elliott, Zhang, Piede, Stefko, Milan, Lowndes, David, Oi, Daniel, Rarity, John, Joshi, Siddarth K.
            HubSatSource_MPNs = [0.5,0.3,0];                                    %source mean photon numbers (unitless)
            HubSatSource_Probs = [0.75,0.25,0.25];                              %source state probabilities (unitless)
            HubSatSource_Rep_Rate = 1E8;                                        %source pulse rate in Hz
            HubSatSource_g2 = 0.01;                                             %source g2 (unitless)
            HubSatSource_Efficiency = 1;                                        %source efficiency (unitless)
            HubSatSource_State_Prep_Error = 0.00817;                            %source state preparation error probability (unitless)
            HubSatSource = Source(Wavelength,...
                'Mean_Photon_Number',HubSatSource_MPNs,...
                'State_Probabilities',HubSatSource_Probs,...
                'Repetition_Rate',HubSatSource_Rep_Rate,...
                'g2',HubSatSource_g2,...
                'Efficiency',HubSatSource_Efficiency,...
                'State_Prep_Error',HubSatSource_State_Prep_Error);

            %beacon
            BeaconPower = 2;                                                    %beacon optical power in w
            BeaconWavelength = 910;                                             %beacon wavelength in nm
            BeaconEfficiency = 1;                                               %beacon optical efficiency (unitless)
            BeaconPointingPrecision = 1E-6;                                    %beacon pointing precision (coarse pointing precision) in rads
            %initially, uncertainty in satellite position is 5km and range is roughly
            BeaconTelescope = Telescope(0.01,'FOV',0.4*pi/180,'Wavelength',BeaconWavelength); %downlink beacon has 10mm diameter and 0.4 degrees cone angle
            HubSatBeacon = Flat_Top_Beacon(BeaconTelescope,BeaconPower,BeaconWavelength,...
                                'Power_Efficiency',BeaconEfficiency,...
                                'Pointing_Jitter',BeaconPointingPrecision);

            %camera
            Exposure_Time = 1;                                                  %camera exposure time in s
            Spectral_Filter_Width = 10;                                         %spectral filter width in nm
            HubSatCamera = ATIK(Exposure_Time,Spectral_Filter_Width); %until we have a better idea, this will have to do for the uplink camera

            %% construct satellite with correct orbital parameters
            HubSat=Satellite(HubSatScope,...
                            'Name', 'HubSat',...
                            'Source',HubSatSource,...
                            'Beacon',HubSatBeacon,...
                            'Camera',HubSatCamera,...
                            'Surface',Satellite_Foil_Surface(0.01),...          %correctly set reflevctive surface proporties and area
                            'SemiMajorAxis',500E3 + earthRadius,...             %mean orbital radius = Altitude + Earth radius
                            'eccentricity',0,...                                %measure of ellipticity of the orbit, for circular, =0
                            'inclination',1.006316534636167e+02,...             %inclination of orbit in deg- set by sun synchronicity
                            'rightAscensionOfAscendingNode',-1.5,...            %measure of location of orbit in longitude
                            'argumentOfPeriapsis',0,...                         %measurement of location of ellipse nature of orbit in longitude, irrelevant for circular orbits
                            'trueAnomaly',0,...                                 %initial position through orbit of satellite
                            'StartTime',StartTime,...                           %start of simulation
                            'StopTime',StopTime,...                             %end of simulation
                            'sampleTime',SampleTime);                           %simulation interval in s     

            %% passes
            %this orbit will directly overfly Errol between 0700 and 0710 on
            %christmas day 2022.
            %you can simulate this period using
            %StartTime = datetime(2022,12,25,6,40,0);
            %StopTime = datetime(2022,12,25,7,20,0);

            %additional passes are:
            %25/12/22 0844

            %25/12/22 1450
            %25/12/22 1622
            %25/12/22 1755

            %26/12/22 0515
            %26/12/22 0649
            %26/12/22 0822
            %26/12/22 0954

            %26/12/22 1427
            %26/12/22 1600
            %26/12/22 1732
            %26/12/22 1907

            %27/12/22 0420
            %27/12/22 0627
            %27/12/22 0800
            %27/12/22 0931

            %passes tend to be arranged in groups of 4. This is the number of
            %orbits the satellite makes while its orbital path is inside the
            %elevation window of the ground station. The middle passes tend to
            %be higher performance as they pass closer to Errol.
end

