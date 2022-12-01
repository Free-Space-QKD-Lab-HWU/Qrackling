% Author: Cameron Simmons
% Date: 14/11/22

classdef(Abstract) Beacon
    %BEACON simulation of classical beacon used to assist QKD pointing

    properties
        %optical power sent by the beacon in W
        Power(1,1) double {mustBeNonnegative}
        %wavelength of the optical signal in nm
        Wavelength (1,1) double {mustBeNonnegative}
        %efficiency of the optical pass in the transmitter
        Efficiency (1,1) double {mustBeNonnegative,mustBeLessThanOrEqual(Efficiency,1)}=1;
        %pointing jitter of beacon (i.e. coarse pointing precision)
        Pointing_Jitter (1,1) double {mustBeNonnegative}
    end

    methods
        function Beacon = Beacon(Power,Wavelength,varargin)
            %%BEACON construct a beacon class
            
           %% use inputparser
           p=inputParser();
           addRequired(p,'Power');
           addRequired(p,'Wavelength');
           addParameter(p,'Efficiency',1);
           addParameter(p,'Pointing_Jitter',1E-3)
           parse(p,Power,Wavelength,varargin{:});
           %required
           Beacon.Power = p.Results.Power;
           Beacon.Wavelength = p.Results.Wavelength;
           %optional
           Beacon.Efficiency=p.Results.Efficiency;
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

        GeoLoss = GetGeoLoss(Beacon,Range,Camera)
        %Get the loss incurred by the spreading of the beacon beam relative to
        %the size of the receiver camera

        %value is a unitless ratio

        %must take at least vector angle input and produce the same shaped output
        %of intensity values
    end
end