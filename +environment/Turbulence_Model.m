classdef Turbulence_Model
    %% a class which contains the arguments which describe atmospheric turbulence
    % according to the hufnagel-valley model

    %this describes a turbulence function which looks like
    %A*exp(-h/HA)+B*exp(-h/HB)+C*exp(-h/HC)
    %we generalise this to as many terms as are wanted

    %the model used here is described in
    %"Adaptive optics beneﬁt for quantum key distribution uplink from ground to a satellite"
    % www.doi.org/10.1515/aot-2020-0017
    properties
        %% default values
        %HV5-7 normal sea level
        Magnitudes (1,:) {mustBeNonnegative} = [17e-15,27e-17,3.59e-53]; %first exponential magnitude
        Heights (1,:) {mustBeNonnegative} = [100,1500,1000]; %first exponential height decay length (m)
    end

    methods
        function hv = Turbulence_Model(options)
            arguments
                options.Magnitudes (1,:) {mustBeNonnegative} = [];
                options.Heights (1,:) {mustBeNonnegative} = [];
                options.Preset {mustBeMember(options.Preset,{'HV5-7','2HV5-7','HV10-10','HV15-12','none'})} = 'none';
            end

            %% first, consider if no preset is used, we need to use the provided magnitudes and heights
            if isequal(options.Preset,'none')
                %check that heights and magnitudes are provided
                assert(~(isempty(options.Magnitudes)||isempty(options.Heights)),'If no preset is used, must provide magnitudes and heights for turbulence calculation')
                %check that heights and magnitudes are the same length
                assert(length(options.Magnitudes)==length(options.Heights),'Heights and magnitudes must be vectors of the same length')

                hv.Magnitudes = options.Magnitudes;
                hv.Heights = options.Heights;
            end

            %% otherwise, use a preset
            switch options.Preset
                case 'HV5-7'
                    %HV5-7 normal sea level
                    hv.Magnitudes = [17e-15,27e-17,3.59e-53];

                case '2HV5-7'
                    %2 * HV5-7 bad day at sea level
                    hv.Magnitudes = [34e-15,54e-17,7.18e-53];

                case 'HV10-10'
                    %HV10-10 astronomical average
                    hv.Magnitudes = [4.5e-15,9e-17,2e-53];

                case 'HV15-12'
                    %HV15-12 an excellent site
                    hv.Magnitudes = [2e-15,7e-17,1.54e-53];
                otherwise
                    error('GHV preset must be one of "2HV5-7","HV5-7","HV10-10" or "HV15-12"')
            end
        end

        function cn2 = Cn2(turbulence_model,h)
            % compute the hufnagel valley model Cn^2 value at a given
            % altitude
            arguments
                turbulence_model environment.Turbulence_Model
                h {mustBeNonnegative}
            end

            cn2 = 0;
            %iterate through contributions to exponential sum
            for i=1:numel(turbulence_model.Magnitudes)
                cn2 = cn2 + turbulence_model.Magnitudes(i).*exp(-h/turbulence_model.Heights(i));
            end
        end

        function r0 = R0(turbulence_model,...
                link_direction,...
                wavelength,...
                elevation,...
                options)
            %computes the turbulence r0 value for the full thickness of the
            %atmosphere by default, but can have limits adjusted
            arguments
                turbulence_model (1,1) environment.Turbulence_Model
                link_direction (1,1) nodes.LinkDirection
                wavelength (1,1) {mustBeNonnegative} %wavelength of light in nm
                elevation {mustBeNonnegative} %link elevation in degrees from the horizon, may be any dimension
                options.BottomHeight {mustBeNumeric} = 0 %optional height for start of link in m. default is sea level
                options.TopHeight {mustBeNumeric} = 500E3 %optional height for end of link in m. default is a 500km orbit
            end

            %% the integral limits (top and bottom height) can vary with time
            %to deal with this, we will compute need to compute this
            %integral many times (this is not the maximally efficient way
            %to do this, but so be it)

            %expand limits up to vectors like elevation
            if isscalar(options.BottomHeight)
                options.BottomHeight = ones(size(elevation))*options.BottomHeight;
            end
            %expand limits up to vectors like elevation
            if isscalar(options.TopHeight)
                options.TopHeight = ones(size(elevation))*options.TopHeight;
            end

            %% decide on integral
            switch link_direction
                case nodes.LinkDirection.Uplink
                    %with uplink, use integral from paper
                    integrand = @(h,top,bottom) Cn2(turbulence_model, h) .* (((1- (h-bottom) ./ (top-bottom))) .^ (5/3));

                case nodes.LinkDirection.Downlink
                    %for downlink, reverse component of integral
                    integrand = @(h,top,bottom) Cn2(turbulence_model, h) .* ((((h-bottom) ./ (top-bottom))) .^ (5/3));

                case nodes.LinkDirection.Intersatellite
                    %intersatellite links produce no turbulence
                    integrand = @(h,top,bottom) zeros(size(h));

                case nodes.LinkDirection.Terrestrial
                    %terrestrial not implemented yet
                    error('terrestrial links not implemented yet')
            end

            %% compute integral
            definite_integral = zeros(size(elevation));
            for i=1:numel(definite_integral)
                bottom = options.BottomHeight(i);
                top = options.TopHeight(i);
                definite_integral(i) = integral(@(x) integrand(x,top,bottom),bottom,top);
            end


            %% compute multipliers
            k = 2*pi/(wavelength*1E-9);

            zenith = 90-elevation;
            sec_zenith = secd(zenith);

            %% compute r0
            r0 = (0.423 * k^2 * sec_zenith .* definite_integral).^(-3/5);
        end


        function [expanded_beam,r0] = BeamSpread(turbulence_model,...
                link_direction,...
                wavelength,...
                elevation,...
                length,...
                geometric_beam_width,...
                options)

            arguments
                turbulence_model (1,1) environment.Turbulence_Model
                link_direction (1,1) nodes.LinkDirection
                wavelength (1,1) {mustBeNonnegative} %wavelength of light in nm
                
                %these three variables must all be the same dimensions, but
                %can be any shape
                elevation {mustBeNonnegative} %link elevation in degrees from the horizon, may be any dimension
                length {mustBeNonnegative} %link length in m
                geometric_beam_width {mustBePositive} %initial (pre-turbulence) beam width at the receiver in m


                options.BottomHeight {mustBeNumeric} = 0 %optional height for start of link in m. default is sea level
                options.TopHeight {mustBeNumeric} = 500E3 %optional height for end of link in m. default is a 500km orbit
            end
            %verify consistent dimensions
            assert(isequal(size(elevation),size(length))&&isequal(size(length),size(geometric_beam_width)),...
                'elevation, length and geometric_beam_width must have the same dimensions');

            %% first, compute R0
            r0 = R0(turbulence_model,...
                link_direction,...
                wavelength,...
                elevation,...
                'BottomHeight',options.BottomHeight,...
                'TopHeight',options.TopHeight);

            %% then, use this to compute turbulent expansion distance
            k = 2*pi/(wavelength*1E-9);
            turbulent_beam_expansion = sqrt(2*4.2*length./(k*r0));

            %% then calculate distance
            expanded_beam = sqrt(geometric_beam_width.^2 + turbulent_beam_expansion.^2);

        end
    end
end
