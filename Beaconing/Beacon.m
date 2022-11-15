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
    end

    methods
        function Beacon = Beacon(Power,Wavelength,Efficiency)
            %%BEACON construct a beacon class
            
            %% too simple to use inputParser, minimum number of inputs is 2
            Beacon.Power = Power;
            Beacon.Wavelength = Wavelength;
            if nargin==3
                Beacon.Efficiency=Efficiency;
            end
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