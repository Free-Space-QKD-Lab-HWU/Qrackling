% Author: Cameron Simmons
% Date: 14/11/22

classdef(Abstract) Beacon
    %BEACON simulation of classical beacon used to assist QKD pointing

    properties
        %optical power sent by the beacon in W
        Power(1,1) double {mustBeNonnegative}
        %wavelength of the optical signal in nm
        Wavelength (1,1) double {mustBeNonnegative}
        %efficiency of the power conversion to laser light
        Power_Efficiency (1,1) double {mustBeNonnegative,mustBeLessThanOrEqual(Power_Efficiency,1)}=1;
        %total efficiency including laser and telescope
        Total_Efficiency (1,1) double {mustBeNonnegative,mustBeLessThanOrEqual(Total_Efficiency,1)}
        %pointing jitter of beacon (i.e. coarse pointing precision)
        Pointing_Jitter (1,1) double {mustBeNonnegative}
        %Telescope which beacon uses
        Telescope (1,1) Telescope =[];
    end

    methods
        function Beacon = Beacon(Telescope, Power, Wavelength, varargin)
            %%BEACON construct a beacon class
            
           %% use inputparser
           p=inputParser();
           addRequired(p,'Telescope')
           addRequired(p,'Power');
           addRequired(p,'Wavelength');
           addParameter(p,'Efficiency',1);
           addParameter(p,'Pointing_Jitter',1E-3)
           parse(p,Telescope,Power,Wavelength,varargin{:});
           %required
           Beacon.Power = p.Results.Power;
           Beacon.Wavelength = p.Results.Wavelength;
           Beacon.Telescope = p.Results.Telescope;
           %make sure wavelength is set correctly
           Beacon.Telescope = SetWavelength(Beacon.Telescope,Beacon.Wavelength);
           %optional
           Beacon.Power_Efficiency=p.Results.Efficiency;
           Beacon.Pointing_Jitter = p.Results.Pointing_Jitter;
        end
    end
    methods (Abstract = true)
        APTLoss = GetAPTLoss(Beacon, Angle)
        %Get the loss (absolute, i.e. the fraction of transmitted power)
        % at an angle off the optical axis of the beacon

        %value is returned as a unitless ratio

        %must take at least vector angle input and produce the same shaped output
        %of intensity values

        [GeoLoss,GeoSpotDiameter] = GetGeoLoss(Beacon,Range,Camera)
        %Get the loss incurred by the spreading of the beacon beam relative to
        %the size of the receiver camera

        %GeoLoss is a unitless ratio, GeoSpotDiameter is the spot diameter at the
        %receiver in m (used to compute turbulence loss).

        %must take at least vector angle input and produce the same shaped output
        %of intensity values
    end

    methods
        function Pointing_Jitter =  get.Pointing_Jitter(Beacon)
                    Pointing_Jitter = Beacon.Telescope.Pointing_Jitter;
        end

        function Total_Efficiency = get.Total_Efficiency(Beacon)
                    Total_Efficiency = Beacon.Telescope.Optical_Efficiency*Beacon.Power_Efficiency;
        end
    end
end