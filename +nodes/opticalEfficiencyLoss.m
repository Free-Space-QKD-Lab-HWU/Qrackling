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
        receiver {utilities.mustBeSubclassOf(receiver, 'nodes.QKDReceiver')}
        transmitter {utilities.mustBeSubclassOf(transmitter, 'nodes.QKDTransmitter')}
    end

    switch kind
        case "beacon"
            if isempty(transmitter.beacon)
                error('Transmitter.beacon of %s must not be empty', inputname(3))
            end

            if isempty(receiver.camera)
                error('Receiver.camera of %s must not be empty', inputname(2))
            end

            eff = transmitter.beacon.total_efficiency * receiver.camera.total_efficiency;

        case "qkd"
            % Compute received wavelength from Doppler shift
            shifted_wavelength = nodes.dopplerShift(receiver, transmitter);
            filter_efficiency = receiver.detector.spectral_filter ...
                .computeTransmission(shifted_wavelength)';

            % Combine all efficiency sources
            eff = transmitter.source.efficiency ...
                * transmitter.telescope.optical_efficiency ...
                * receiver.detector.detection_efficiency ...
                * receiver.detector.jitter_loss ...
                * receiver.telescope.optical_efficiency ...
                * filter_efficiency;
    end

    % Expand scalar efficiency to match number of positions
    if isscalar(eff)
        n = max(receiver.n_position, transmitter.n_position);
        eff = eff * ones(1, n);
    end

    eff = units.Loss(eff);
end