function HubSat = HubSat()
            %HUBSAT Construct a model of the Quantum Comms hub satellite

            %need to implement parameters and components first, then create a
            %satellite with the correct orbital parameters

            %Telescope
            HubSat_Scope_Diameter = 0.1;                                        %telescope diameter in m
            HubSat_Scope_Efficiency = 0.6;                                      %telescope optical efficiency (unitless)
            HubSat_Pointing_Jitter = 1E-6;                                      %telescope pointing error in rads
            HubSatScope = Telescope(HubSat_Scope_Diameter,...
                'Optical_Efficiency',HubSat_Scope_Efficiency,...
                'Pointing_Jitter',HubSat_Pointing_Jitter);

            %source
            Wavelength = 780;                                                   %wavelength of source in nm
            HubSatSource_MPNs = [0.8,0.1,0];                                    %source mean photon numbers (unitless)
            HubSatSource_Probs = [0.75,0.25,0.25];                              %source state probabilities (unitless)
            HubSatSource_Rep_Rate = 1E8;                                        %source pulse rate in Hz
            HubSatSource_g2 = 0.01;                                             %source g2 (unitless)
            HubSatSource_Efficiency = 1;                                        %source efficiency (unitless)
            HubSatSource_State_Prep_Error = 0.01;                               %source state preparation error probability (unitless)
            HubSatSource = Source(Wavelength,...
                'Mean_Photon_Number',HubSatSource_MPNs,...
                'State_Probabilities',HubSatSource_Probs,...
                'Repetition_Rate',HubSatSource_Rep_Rate,...
                'g2',HubSatSource_g2,...
                'Efficiency',HubSatSource_Efficiency,...
                'State_Prep_Error',HubSatSource_State_Prep_Error);

            %beacon
            BeaconPower = 1;                                                    %beacon optical power in w
            BeaconWavelength = 850;                                             %beacon wavelength in nm
            BeaconEfficiency = 1;                                               %beacon optical efficiency (unitless)
            BeaconHalfAngle = 1E-3;                                             %beacon flat top half angle in rads
            HubSatBeacon = Flat_Top_Beacon(BeaconPower,BeaconWavelength,...
                                BeaconHalfAngle,'Efficiency',BeaconEfficiency);

            %% construct satellite with correct orbital parameters
            HubSat=Satellite(HubSatSource,HubSatScope,'Beacon',HubSatBeacon,...
                            'Surface',Satellite_Foil_Surface(0.01),...          %correctly set reflevctive surface proporties and area
                            'SemiMajorAxis',500E3 + earthRadius,...             %mean orbital radius = Altitude + Earth radius
                            'eccentricity',0,...                                %measure of ellipticity of the orbit, for circular, =0
                            'inclination',90,...                                %inclination of orbit in deg
                            'rightAscensionOfAscendingNode',0,...               %measure of location of orbit in longitude
                            'argumentOfPeriapsis',0,...                         %measurement of location of orbit in latitude
                            'trueAnomaly',0,...                                 
                            'StartTime',datetime(2024,1,1,5,0,0),...                   %start of simulation
                            'StopTime',datetime(2024,1,1,6,0,0),...                 %end of simulation
                            'sampleTime',1);                                    %simulation interval in s     
end

