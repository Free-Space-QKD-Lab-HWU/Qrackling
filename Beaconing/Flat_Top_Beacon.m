classdef Flat_Top_Beacon < Beacon
    %Flat_Top_Beacon a pointing beacon with a uniform intensity distribution

    properties
        %the half-angle at which the uniform intensity distribution drops to 0
        Limit_Half_Angle (1,1) double {mustBeNonnegative}
    end

    methods
        function Flat_Top_Beacon = Flat_Top_Beacon(Power,...
                                                   Wavelength,...
                                                   Limit_Half_Angle,...
                                                   varargin)
            %%Gaussian_Beacon Construct an instance of this class
            
            %construct abstract beacon class
            Flat_Top_Beacon@Beacon(Power,Wavelength,varargin{:});
            %then implement Flat_Top_Beacon properties
            Flat_Top_Beacon.Limit_Half_Angle = Limit_Half_Angle;
        end

        function Loss = GetAPTLoss(Flat_Top_Beacon, Angle)
        %Get the loss (absolute, i.e. the fraction of transmitted power)
        % at an angle off the optical axis of the beacon


            %% compute intensity distribution function at this angle
            Loss = double(Angle <= Flat_Top_Beacon.Limit_Half_Angle);

        end

        function GeoLoss = GetGeoLoss(Flat_Top_Beacon, Range, Camera)
        %%GETGEOLOSS Get the loss incurred by the spreading of the beacon beam
        %value is returned as a value in m^-2

        GeoLoss = Camera.Collecting_Area./(pi*(Flat_Top_Beacon.Limit_Half_Angle*Range).^2);
        end
    end
end