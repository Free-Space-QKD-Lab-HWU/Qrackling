function eff = opticalEfficiencyLoss(kind, receiver, transmitter)
% opticalEfficiencyLoss
%
% Computes the optical efficiency loss for either beacon or QKD systems.
%
% Syntax:
% eff = opticalEfficiencyLoss(kind, receiver, transmitter)
%
% Inputs:
% kind        - string, either "beacon" or "qkd"
% receiver    - nodes.QKD_Receiver object
% transmitter - nodes.QKD_Transmitter object
%
% Output:
% eff - units.Loss object representing total optical efficiency loss

    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {utilities.mustBeSubclassOf(receiver, 'nodes.QKD_Receiver')}
        transmitter {utilities.mustBeSubclassOf(transmitter, 'nodes.QKD_Transmitter')}
    end

    switch kind
        case "beacon"
            if isempty(transmitter.Beacon)
                error('Transmitter.Beacon of %s must not be empty', inputname(3))
            end

            if isempty(receiver.Camera)
                error('Receiver.Camera of %s must not be empty', inputname(2))
            end

            eff = transmitter.Beacon.Total_Efficiency * receiver.Camera.Total_Efficiency;

        case "qkd"
            % Compute received wavelength from Doppler shift
            shifted_wavelength = nodes.Doppler_Shift(receiver, transmitter);
            filter_efficiency = receiver.Detector.Spectral_Filter ...
                .ComputeTransmission(shifted_wavelength)';

            % Combine all efficiency sources
            eff = transmitter.Source.Efficiency ...
                * transmitter.Telescope.Optical_Efficiency ...
                * receiver.Detector.Detection_Efficiency ...
                * receiver.Detector.Jitter_Loss ...
                * receiver.Telescope.Optical_Efficiency ...
                * filter_efficiency;
    end

    % Expand scalar efficiency to match number of positions
    if isscalar(eff)
        n = max(receiver.N_Position, transmitter.N_Position);
        eff = eff * ones(1, n);
    end

    eff = units.Loss(eff);
end