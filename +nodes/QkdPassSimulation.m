function results = QkdPassSimulation(receivers, transmitters, qkd_protocol)
%%QKDPASSSIMULATION this function architects the simulation of a QKD pass.
%%It takes at least one receiver, a transmitter, a protocol and an
%%(optional) environment, then finds and performs the required links
    arguments
        receivers { ...
            nodes.mustBeReceiverOrTransmitter(receivers), ...
            nodes.mustHaveDetector(receivers) }
        transmitters { ...
            nodes.mustBeReceiverOrTransmitter(transmitters), ...
            nodes.mustHaveSource(transmitters) }
        qkd_protocol protocol.proto
    end    

    %% Check that we have the correct number of transmitters and receivers for this protocol
    qkd_protocol.mustHaveCorrectTransmittersAndReceivers(transmitters,receivers)

    %% what direction are links between 

    %% Establish the loss and noise between each transmitter and receiver pair
    %prepare memory
    loss_results = repmat(nodes.LossResult(),[qkd_protocol.num_transmitters,qkd_protocol.num_receivers]);
    total_loss = zeros(qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0);
    noise_results = repmat(environment.Noise('',[]),[qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0]);
    total_noise = zeros(qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0);
    headings = zeros(qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0);
    elevations = zeros(qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0);
    ranges = zeros(qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0);
    times = NaT(qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0,'TimeZone','UTC');
    elevation_flags = false(qkd_protocol.num_transmitters,qkd_protocol.num_receivers,0);
    link_directions = repmat(nodes.LinkDirection.Downlink,[qkd_protocol.num_transmitters,qkd_protocol.num_receivers]);
    elevation_limits = zeros(1,qkd_protocol.num_receivers);

    %iterating over each transmitter-receiver pair
    for receiver_index = 1:qkd_protocol.num_receivers
        for transmitter_index = 1:qkd_protocol.num_transmitters
            %what direction is the link?
            if utilities.isSubclassOf(transmitters(transmitter_index),'nodes.Satellite')&&...
                    utilities.isSubclassOf(receivers(receiver_index),'nodes.Ground_Station')
                link_directions(transmitter_index,receiver_index)=nodes.LinkDirection.Downlink;
            elseif utilities.isSubclassOf(receivers(receiver_index),'nodes.Satellite')&&...
                    utilities.isSubclassOf(transmitters(transmitter_index),'nodes.Ground_Station')
                link_directions(transmitter_index,receiver_index)=nodes.LinkDirection.Uplink;
            else
                error('Unimplemented')
            end
            
            %determine when the link has line of sight
            switch link_directions(transmitter_index,receiver_index)
                case nodes.LinkDirection.Downlink
                    [current_headings,current_elevations,current_ranges] = RelativeHeadingAndElevation(transmitters(transmitter_index),receivers(receiver_index));
                    current_time = transmitters(transmitter_index).Times;
                case nodes.LinkDirection.Uplink
                    [current_headings,current_elevations,current_ranges] = RelativeHeadingAndElevation(receivers(receiver_index),transmitters(transmitter_index));
                    current_time = transmitters(transmitter_index).Times;
            end
            current_elevation_flags = current_elevations > receivers(receiver_index).Elevation_Limit;
            num_time_steps = numel(current_time);

            

            [loss,noise]=loss_and_noise_for_channel(transmitters(transmitter_index),...
                                                    receivers(receiver_index),...
                                                    qkd_protocol);
            %store loss and noise in cells with index transmitter x
            %receiver
            loss_results(transmitter_index,receiver_index) = loss;
            total_loss(transmitter_index,receiver_index,1:num_time_steps) = loss.TotalLoss;
            noise_results(transmitter_index,receiver_index,1:numel(noise)) = noise;
            total_noise(transmitter_index,receiver_index,1:num_time_steps) = noise.Total;
            headings(transmitter_index,receiver_index,1:num_time_steps) = current_headings;
            elevations(transmitter_index,receiver_index,1:num_time_steps) = current_elevations;
            ranges(transmitter_index,receiver_index,1:num_time_steps) = current_ranges;
            times(transmitter_index,receiver_index,1:num_time_steps) = current_time;
            elevation_flags(transmitter_index,receiver_index,1:num_time_steps) = current_elevation_flags;
        end

        %record elevation limit of this receiver
        elevation_limits(receiver_index)=receivers(receiver_index).Elevation_Limit;
    end

    %% specifically calculate where all elevation limits are met
    all_elevation_flags = squeeze(all(elevation_flags,[1,2]));
    total_loss_all_elevation_flags = total_loss(:,:,all_elevation_flags);
    total_noise_all_elevation_flags = total_noise(:,:,all_elevation_flags);

    %% Evaluate QKD link
    %prepare memory which is zero outside elevation limits
    secret_key_rate = zeros(1,num_time_steps);
    sifted_key_rate = zeros(1,num_time_steps);
    qber = 0.5*ones(1,num_time_steps);

    %calculate
    [secret_key_rate_elevation_flag, sifted_key_rate_elevation_flag, qber_elevation_flag] = qkd_protocol.Calculate(transmitters, ...
                                                                      receivers, ...
                                                                      total_loss_all_elevation_flags, ...
                                                                      total_noise_all_elevation_flags);
    %transfer to appropriate point in time-domain memory
    secret_key_rate(all_elevation_flags) = secret_key_rate_elevation_flag;
    sifted_key_rate(all_elevation_flags) = sifted_key_rate_elevation_flag;
    qber(all_elevation_flags) = qber_elevation_flag;

     %% store results
     results = repmat(nodes.PassSimulationResult.empty,[qkd_protocol.num_transmitters,qkd_protocol.num_receivers]);
        for receiver_index = 1:qkd_protocol.num_receivers
            for transmitter_index = 1:qkd_protocol.num_transmitters
                results(transmitter_index,receiver_index) = nodes.PassSimulationResult( ...
                    transmitters(transmitter_index),...
                    receivers(receiver_index),...
                    qkd_protocol,...
                    link_directions(transmitter_index,receiver_index),...
                    headings(transmitter_index,receiver_index,:),...
                    elevations(transmitter_index,receiver_index,:),....
                    ranges(transmitter_index,receiver_index,:),...
                    times(transmitter_index,receiver_index,:), ...
                    all_elevation_flags, ...
                    loss_results(transmitter_index,receiver_index),...
                    noise_results(transmitter_index,receiver_index,:), ...
                    sifted_key_rate,...
                    secret_key_rate, ...
                    qber);
            end
        end
end

function [loss_results, noise] = loss_and_noise_for_channel(transmitter, receiver, qkd_protocol)
    arguments
        transmitter (1,1) { ...
            nodes.mustBeReceiverOrTransmitter(transmitter), ...
            nodes.mustHaveSource(transmitter) }
        receiver (1,1) { ...
            nodes.mustBeReceiverOrTransmitter(receiver), ...
            nodes.mustHaveDetector(receiver) }
        qkd_protocol protocol.proto
    end


    %% get background light data from ground station's environment
    switch class(transmitter)
    case "nodes.Satellite"
        [headings, elevations, ~] = transmitter.RelativeHeadingAndElevation(receiver);
        background_radiance = receiver.Environment.Interp( ...
            "spectral_radiance", headings, elevations, transmitter.Source.Wavelength);
    case "nodes.Ground_Station"
        [headings, elevations, ~] = receiver.RelativeHeadingAndElevation(transmitter);
        background_radiance = transmitter.Environment.Interp( ...
            "spectral_radiance", headings, elevations, transmitter.Source.Wavelength);
    end
        t = receiver.Detector.Spectral_Filter.transmission;
        w = receiver.Detector.Spectral_Filter.wavelengths;
        w_range = w(t ~= 0);
        filter_width = max(w_range) - min(w_range);

        background_counts_per_second = environment.countRateFromRadiance( ...
            background_radiance, ...
            receiver.Telescope.FOV, ...
            receiver.Telescope.Diameter, ...
            filter_width, ...
            1, ...
            receiver.Detector.Wavelength);


    %noise due to detector dark counts
    dark_counts = ones(size(headings)) ...
        .* receiver.Detector.Dark_Count_Rate ...
        .* qkd_protocol.num_detectors;

    %record as noise objects
    noise = [ ...
        environment.Noise("Detector Dark Counts", dark_counts), ...
        environment.Noise("Background Counts", background_counts_per_second), ...
    ];

    %% compute losses
    [loss_results, ~] = nodes.linkLoss('qkd',...
                                receiver,...
                                transmitter,...
                                'apt',...
                                'optical',...
                                'geometric',...
                                'turbulence',...
                                'atmospheric');
end

