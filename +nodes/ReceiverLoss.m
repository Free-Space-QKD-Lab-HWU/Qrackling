function eff = ReceiverLoss(kind, receiver, transmitter,total_prior_loss,N_Detectors)
    arguments
        kind {mustBeMember(kind, ["beacon", "qkd"])}
        receiver {mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])}
        transmitter {mustBeA(transmitter, ["nodes.Satellite", "nodes.Ground_Station"])}
        total_prior_loss =[];
        N_Detectors {mustBeScalarOrEmpty,mustBePositive} = [];
    end

    switch kind
    case "beacon"
        if isempty(receiver.Camera)
            error(['Receiver.Camera of ', inputname(2), ' must not be empty'])
        end

        eff = receiver.Camera.Total_Efficiency;

    case "qkd"
        %% compute received wavelenth from doppler shift
        shifted_wavelength = nodes.Doppler_Shift(receiver, transmitter);
        filter_efficiency = receiver.Detector.Spectral_Filter ...
            .ComputeTransmission(shifted_wavelength)';

        %% detection efficiency
        Det_Eff = receiver.Detector.Detection_Efficiency;

        %% dead time loss requires knowledge of previous channel (to calculate click rates)
        assert(~isempty(total_prior_loss),'total prior loss required to calculate dead time loss')
        assert(~isempty(N_Detectors),'number of detectors is required to calculate dead time loss')
        %compute detector photon arrival rate
        photon_detection_rate = transmitter.Source.Repetition_Rate*total_prior_loss*Det_Eff/N_Detectors + receiver.Detector.Dark_Count_Rate;
        %compute dead time loss
        dead_time_loss = receiver.Detector.DeadTimeLoss(photon_detection_rate).As('probability');
        

        %% sources of efficiency
        eff = Det_Eff ...
            .* dead_time_loss ...
            .* receiver.Detector.Jitter_Loss ...
            .* receiver.Telescope.Optical_Efficiency ...
            .* filter_efficiency;
    end

    n = max(receiver.N_Position, transmitter.N_Position);
    eff = units.Loss("probability", "Receiver", utilities.validateLoss(eff, n));
end
