classdef TurbulenceModel
    % TurbulenceModel
    %
    % Contains arguments describing atmospheric turbulence according to the
    % Hufnagel-Valley model.
    %
    % The turbulence profile is modeled as a sum of exponentials:
    %
    %     A*exp(-h/HA) + B*exp(-h/HB) + C*exp(-h/HC)
    %
    % This can be generalized to any number of terms.
    %
    % Reference:
    % "Adaptive optics benefit for quantum key distribution uplink from
    % ground to a satellite", doi: 10.1515/aot-2020-0017
    %
    % Syntax:
    % hv = environment.TurbulenceModel('Preset', 'HV5-7')
    % hv = environment.TurbulenceModel('Preset', 'none', ...
    %     'magnitudes', M, 'heights', H)

    
    %% Properties
    properties
        % magnitudes
        %
        % Vector of exponential magnitudes for the HV model terms.
        magnitudes (1, :) {mustBeNonnegative} = ...
            [17e-15, 27e-17, 3.59e-53]

        % heights
        %
        % Vector of exponential height decay lengths (m).
        heights (1, :) {mustBeNonnegative} = ...
            [100, 1500, 1000]

        % r0
        %
        % the fried parameter (length scale of turbulence at the receiver)
        % in m. By default, this is calculated, but can be set instead
        r0 (1,:) {mustBeNonnegative} = []
    end


    %% Public methods
    methods
        function hv = TurbulenceModel(options)
            % TurbulenceModel
            %
            % Construct a TurbulenceModel object, using either a preset or
            % user-specified magnitudes and heights.
            %
            % Name-Value options:
            % magnitudes - (1xN) numeric, nonnegative
            % heights    - (1xN) numeric, nonnegative
            % Preset     - one of:
            %              {'HV5-7','2HV5-7','HV10-10','HV15-12','none'}
            %              default 'none'
            % r0         - (1,1) numeric, nonnegative

            arguments
                options.magnitudes (1, :) {mustBeNonnegative} = []
                options.heights (1, :) {mustBeNonnegative} = []
                options.Preset {mustBeMember(options.Preset, ...
                    {'HV5-7','2HV5-7','HV10-10','HV15-12','none'})} = 'none'
                options.r0 {mustBeNonnegative,mustBeScalarOrEmpty} = []
            end

            % No preset: must provide magnitudes and heights, or r0
            if isequal(options.Preset, 'none')
                if isempty(options.r0)
                    assert(~(isempty(options.magnitudes) || isempty(options.heights)), ...
                        'If no preset and no r0 are provided, must provide magnitudes and heights')
                    assert(length(options.magnitudes) == length(options.heights), ...
                        'Magnitudes and heights must be the same length')
    
                    hv.magnitudes = options.magnitudes;
                    hv.heights = options.heights;
                else
                    assert(isscalar(options.r0)&&options.r0>=0, ...
                        'If r0 is provided, must be scalar and non-negative')
                    hv.r0 = options.r0;
                end

            end

            % Otherwise, apply preset
            switch options.Preset
                case 'HV5-7'
                    hv.magnitudes = [17e-15, 27e-17, 3.59e-53];

                case '2HV5-7'
                    hv.magnitudes = [34e-15, 54e-17, 7.18e-53];

                case 'HV10-10'
                    hv.magnitudes = [4.5e-15, 9e-17, 2e-53];

                case 'HV15-12'
                    hv.magnitudes = [2e-15, 7e-17, 1.54e-53];

                case 'none'
                    % Already handled above
            end
        end


        function cn2_val = cn2(TurbulenceModel, h)
            % cn2
            %
            % Compute the HV model Cn^2 value at altitude h.
            %
            % Syntax:
            % cn2_val = cn2(TurbulenceModel, h)
            %
            % Inputs:
            % h - nonnegative altitude(s) in m
            %
            % Outputs:
            % cn2_val - same size as h

            arguments
                TurbulenceModel environment.TurbulenceModel
                h {mustBeNonnegative}
            end

            % Initialise total turbulence strength
            cn2_val = 0;

            % Sum exponential contributions
            for i = 1:numel(TurbulenceModel.magnitudes)
                cn2_val = cn2_val + ...
                    TurbulenceModel.magnitudes(i) .* ...
                    exp(-h / TurbulenceModel.heights(i));
            end
        end


        function r0_val = compute_r0(TurbulenceModel, ...
                link_direction, ...
                wavelength, ...
                elevation, ...
                options)
            % r0
            %
            % Compute the Fried parameter (r0) for given link conditions.
            %
            % Syntax:
            % r0_val = compute_r0(TurbulenceModel, link_direction, wavelength, ...
            %     elevation, 'BottomHeight', b, 'TopHeight', t)
            %
            % Inputs:
            % link_direction - nodes.LinkDirection
            % wavelength     - numeric (nm)
            % elevation      - numeric degrees from horizon
            % BottomHeight   - start height (m), scalar or array
            % TopHeight      - end height (m), scalar or array
            %
            % Outputs:
            % r0_val - same size as elevation

            arguments
                TurbulenceModel (1, 1) environment.TurbulenceModel
                link_direction (1, 1) nodes.LinkDirection
                wavelength (1, 1) {mustBeNonnegative}
                elevation {mustBeNonnegative}
                options.BottomHeight {mustBeNumeric} = 0
                options.TopHeight {mustBeNumeric} = 500E3
            end

            % Expand scalar height limits to match elevation array
            if isscalar(options.BottomHeight)
                options.BottomHeight = ...
                    ones(size(elevation)) * options.BottomHeight;
            end
            if isscalar(options.TopHeight)
                options.TopHeight = ...
                    ones(size(elevation)) * options.TopHeight;
            end

            % Define integrand based on link direction
            switch link_direction
                case nodes.LinkDirection.Uplink
                    integrand = @(h, top, bottom) cn2(TurbulenceModel, h) .* ...
                        ((1 - (h - bottom) ./ (top - bottom)) .^ (5/3));

                case nodes.LinkDirection.Downlink
                    integrand = @(h, top, bottom) cn2(TurbulenceModel, h) .* ...
                        (((h - bottom) ./ (top - bottom)) .^ (5/3));

                case nodes.LinkDirection.Intersatellite
                    integrand = @(h, top, bottom) zeros(size(h));

                case nodes.LinkDirection.Terrestrial
                    error('Terrestrial links not implemented yet')
            end

            % Perform integration for each elevation element
            definite_integral = zeros(size(elevation));
            for i = 1:numel(definite_integral)
                bottom = options.BottomHeight(i);
                top = options.TopHeight(i);
                definite_integral(i) = ...
                    integral(@(x) integrand(x, top, bottom), bottom, top);
            end

            % Compute constants
            k = 2 * pi / (wavelength * 1E-9);  % Wave number
            zenith = 90 - elevation;           % Zenith angle (deg)
            sec_zenith = secd(zenith);         % Secant of zenith angle

            % Calculate r0
            r0_val = (0.423 * k^2 .* sec_zenith .* definite_integral) .^ (-3/5);
        end


        function [expanded_beam, r0_val] = beamSpread(TurbulenceModel, ...
                link_direction, ...
                wavelength, ...
                elevation, ...
                length, ...
                geometric_beam_width, ...
                options)
            % beamSpread
            %
            % Compute turbulent beam spreading for a link.
            %
            % Syntax:
            % [expanded_beam, r0_val] = beamSpread(TurbulenceModel, ...
            %     link_direction, wavelength, elevation, length, ...
            %     geometric_beam_width, 'BottomHeight', b, 'TopHeight', t)
            %
            % Outputs:
            % expanded_beam - beam diameter at receiver (m)
            % r0_val        - Fried parameter (m)

            arguments
                TurbulenceModel (1, 1) environment.TurbulenceModel
                link_direction (1, 1) nodes.LinkDirection
                wavelength (1, 1) {mustBeNonnegative}

                % Must have consistent dimensions
                elevation {mustBeNonnegative}
                length {mustBeNonnegative}
                geometric_beam_width {mustBePositive}

                options.BottomHeight {mustBeNumeric} = 0
                options.TopHeight {mustBeNumeric} = 500E3
            end

            % Verify dimension consistency
            assert(isequal(size(elevation), size(length)) && ...
                   isequal(size(length), size(geometric_beam_width)), ...
                   'elevation, length and geometric_beam_width must have the same dimensions');

            %% First, check if r0 is already set and compute if not
            if isempty(TurbulenceModel.r0)
                r0_val = compute_r0(TurbulenceModel, ...
                    link_direction, ...
                    wavelength, ...
                    elevation, ...
                    'BottomHeight', options.BottomHeight, ...
                    'TopHeight', options.TopHeight);
            elseif isscalar(TurbulenceModel.r0)
                r0_val = TurbulenceModel.r0 * ones(size(length));
            else
                r0_val = TurbulenceModel.r0;
                assert(isequal(size(r0_val),size(length)), ...
                    "if r0 is specified as a vector, it should be consistent with the time dimension of simulation" + ...
                    "here, time is (%s), and r0 is (%s)",num2str(size(length)),num2str(size(r0_val)))
            end


            %% Then, compute turbulent expansion distance
            k = 2 * pi / (wavelength * 1E-9);   % Wave number [1/m]
            turbulent_beam_expansion = sqrt( ...
                2 * 4.2 * length ./ (k * r0_val));

            %% Finally, calculate expanded beam width
            expanded_beam = sqrt( ...
                geometric_beam_width.^2 + ...
                turbulent_beam_expansion.^2);
        end
    
        
        function model = set.r0(model,r0)
            % set.r0
            %
            % set r0 value of turbulence model (prevents calculation in
            % future)
            %
            % Syntax:
            % model.r0 = r0
            % 
            % Inputs:
            % model - scalar TurbulenceModel
            % r0 - fried parameter >=0, either scalar or vector with
            % dimensions equal to number of time steps
            %
            % Outputs:
            % model - scalar TurbulenceModel
            arguments
                model (1,1) environment.TurbulenceModel
                r0 (1,:) {mustBeNonnegative}
            end
            model.r0 = r0;
        end


    end
end

