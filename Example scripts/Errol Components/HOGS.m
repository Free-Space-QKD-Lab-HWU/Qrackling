function HOGS = HOGS(Wavelength)
%HOGS Construct HOGS
% need to detail the correct OGS parameters and components
% need to implement the Errol_OGS class to give the correct position

%% ChannelFlag describes which channel is to be modelled. Options are 780, 808 and 1550
assert(ismember(Wavelength,[785,808,1550]),'Wavelength must be one of the intended channels, 780, 808 or 1550 (nm)');

%% parameters and components
%Telescope
Telescope_Diameter = 0.7;                                           %telescope diameter in m
Telescope_Focal_Length = 8.4;
Telescope_Eyepiece_Focal_Length = 0.076;
Pointing_Jitter = 1E-6;                                             %pointing error in rads
Optical_Efficiency = (1-0.3^2)*10^(-1.1/10);                              %optical efficiency of telescope (dimensionless), including obscuration and back-end losses
HOGS_Telescope = Telescope(Telescope_Diameter,...
    'Pointing_Jitter',Pointing_Jitter,...
    'Optical_Efficiency',Optical_Efficiency,...
    'Focal_Length',Telescope_Focal_Length,...
    'Eyepiece_Focal_Length',Telescope_Eyepiece_Focal_Length);

%Detector
switch Wavelength
    case 785
Channel_Wavelength = 785;                                    %signal wavelength in nm
Repetition_Rate = 1E8;                                              %signal rep rate in Hz
Time_Gate = 2E-9;                                                   %time gate width in s
Spectral_Filter = SpectralFilter('input_file',['spectral filters',filesep(),'FBH780-10.xlsx']);
HOGS_Detector = Detector(Channel_Wavelength,Repetition_Rate,...
    Time_Gate,Spectral_Filter,Preset=DetectorPresets.Excelitas.LoadPreset());

    case 808
Channel_Wavelength = 808;                                    %signal wavelength in nm
Repetition_Rate = 1E8;                                              %signal rep rate in Hz
Time_Gate = 2E-9;                                                   %time gate width in s
Spectral_Filter = SpectralFilter('input_file',['spectral filters',filesep(),'FBH850-10.xlsx']);
HOGS_Detector = Detector(Channel_Wavelength,Repetition_Rate,...
    Time_Gate,Spectral_Filter,Preset=DetectorPresets.Excelitas.LoadPreset());

    case 1550
Channel_Wavelength = 1550;                                    %signal wavelength in nm
Repetition_Rate = 1;                                              %signal rep rate in Hz
Time_Gate = 1;                                                   %time gate width in s
Spectral_Filter = SpectralFilter('input_file',['spectral filters',filesep(),'FBH1550-12.xlsx']);
HOGS_Detector = Detector(Channel_Wavelength,Repetition_Rate,...
    Time_Gate,Spectral_Filter,Preset=DetectorPresets.Excelitas.LoadPreset());
end

%beacon camera
Camera_Scope_Diameter = 0.4;
Camera_Scope_Focal_Length = 2.72;
Camera_Scope_Optical_Efficiency = 1-0.39^2;
Camera_Pointing_Precision = 1E-3;
Camera_Telescope = Telescope(Camera_Scope_Diameter,...
                            'Wavelength',685,...
                            'Optical_Efficiency',Camera_Scope_Optical_Efficiency,...
                            'Focal_Length',Camera_Scope_Focal_Length,...
                            'Pointing_Jitter',Camera_Pointing_Precision);
Exposure_Time = 0.01;
Spectral_Filter_Width = 10;
HOGS_Camera = AC4040(Camera_Telescope,Exposure_Time,Spectral_Filter_Width);%this is a constructor for the ATIK camera we use

%uplink beacon
Beacon_Power = 40E-3;                                                           %power of uplink beacon in W
Beacon_Wavelength = 850;                                                        %uplink beacon wavelength in nm
BeaconPointingPrecision = 1E-6;                                                 %beacon pointing precision (coarse pointing precision) in rads
Beacon_Beam_Divergence = 0.0070;%49.9E-6; %7mrad = 0.5 deg is the divergence of RAL's uplink beacon system. 50urad is out uplink beacon divergence
Beacon_Telescope = SetWavelength(HOGS_Telescope,Beacon_Wavelength);
Beacon_Telescope = SetFOV(Beacon_Telescope,Beacon_Beam_Divergence);
%initially, uncertainty in satellite position is 5km and range is roughly
%500km/sin(30), so pointing precision is on the order 5mrads.
BeaconEfficiency = 1;                                                           %beacon optical efficiency (unitless)
HOGSBeacon = Gaussian_Beacon(Beacon_Telescope,Beacon_Power,Beacon_Wavelength,...
                   'Pointing_Jitter',BeaconPointingPrecision,...
                   'Power_Efficiency',BeaconEfficiency);

% #### DEPRECATED ####
    % Atmosphere_File_Location using SMARTS data, now gone
% %% construct OGS at Errol
% HOGS=Ground_Station(HOGS_Telescope,...
%                 'Detector',HOGS_Detector,...
%                 'Camera',HOGS_Camera,...
%                 'Beacon',HOGSBeacon,...
%                 'Atmosphere_File_Location',['SMARTS_connection',filesep,'SMARTS cache',filesep,'Errol_Atmosphere_Visibility_10km_winter_times.mat'],...
%                 'Sky_Brightness_Store_Location',['orbit modelling resources',filesep,'background count rate files',filesep,'Errol_Experimental_Sky_Brightness_Store.mat'],...
%                 'LLA',[55.909723,-3.319995,10],...
%                 'name','Heriot Watt');%choose a midnight simulation so that time is night );
% end


%% construct OGS at Errol
HOGS=Ground_Station(HOGS_Telescope,...
                'Detector',HOGS_Detector,...
                'Camera',HOGS_Camera,...
                'Beacon',HOGSBeacon,...
                'Sky_Brightness_Store_Location',['orbit modelling resources',filesep,'background count rate files',filesep,'Errol_Experimental_Sky_Brightness_Store.mat'],...
                'LLA',[55.909723,-3.319995,10],...
                'name','Heriot Watt');%choose a midnight simulation so that time is night );
end
