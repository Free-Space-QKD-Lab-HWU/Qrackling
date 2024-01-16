classdef proto

    properties (Abstract, SetAccess = protected)
        method {mustBeMember(method, {'prepare_and_measure', 'entanglement'})}
        source_features protocol.sourceRequirements
        detector_features protocol.detectorRequirements
        efficiency
    end

    methods (Abstract)
        %[secret_key_rate, sifted_key_rate, qber] = QkdModel( ...
        %    protocol, source, detector, dark_count_prob, channel_loss);
        [secret_key_rate, sifted_key_rate, qber] = QkdModel(protocol, alice, bob);
    end


    methods



        function [secret_rate, sifted_rate, qber] = Calculate(proto, alice, bob, options)
            arguments
                proto
                alice {mustBeA(alice, ["protocol.Alice", "nodes.Satellite", "nodes.Ground_Station"])}
                bob {mustBeA(bob, ["protocol.Bob", "nodes.Satellite", "nodes.Ground_Station"])}
                % The following optionals can be used to over ride the values in
                % alice and bob (if they are present)
                options.channel_loss {mustBeNumeric}
                options.background_counts {mustBeNumeric}
            end

            node_types = ['nodes.Satellite', 'nodes.Ground_Station'];
            isaNode = @(obj) any(isa(obj, node_types));

            have_nodes = false;
            if isaNode(alice) && isaNode(bob)
                have_nodes = true;
            end

            % if Alice is not a protocol.Alice, then cast it
            if ~isa(alice, "protocol.Alice")
                alice = alice.Alice();
            end

            % if Bob is not a protocol.Bob, then cast it
            if ~isa(bob, "protocol.Bob")
                bob = bob.Bob();
            end

            [secret_rate, sifted_rate, qber] = proto.QkdModel(alice, bob);

        end


        function [secret_key_rate, qber, sifted_key_rate] = EvaluateQKDLink( ...
            proto, source, detector, Link_Loss_dB, Background_Count_Rate)
            % EVALUATEQKDLINK enact the link performance simulation for the
            % particular protocol

            arguments
                 proto protocol.proto
                 source components.Source
                 detector components.Detector
                 Link_Loss_dB
                 Background_Count_Rate
            end

            %check compatibility
            [~] = proto.CompatibleComponent(source);
            [~] = proto.CompatibleComponent(detector);

            %get inputs to evaluation function (probability of dark counts in a
            %pulse)
            dark_count_probability = 1 - exp(-Background_Count_Rate * detector.Time_Gate_Width);

            %run protocol's evaluation function
            %all evaluation functions must conform to this format
            [secret_key_rate, sifted_key_rate, qber] = proto.QkdModel( ...
                    source, detector, dark_count_probability, Link_Loss_dB);
        end

        function result = CompatibleComponent(protocol, component)
            % Determine whether a supplied source or detector meets the
            % requirements defined in the concrete implementation of
            % source_features and detector_features
            arguments
                protocol protocol.proto
                component {mustBeA(component, ["components.Detector", "components.Source"])}
            end

            component_name = inputname(2);
            props = properties(component);

            switch class(component)
            case "components.Detector"
                mask = ismember(props, protocol.detector_features);
            case "components.Source"
                mask = ismember(props, protocol.source_features);
            otherwise
                error([component_name, ': Not a components.Detector or components.Source']);
            end

            msg = @(p_name) [ ...
                'Field: [ ', p_name, ' ] of [ ', component_name, ...
                ' ] is required. ', p_name, ' must be nonempty and not nan' ...
            ];
            result = true;
            for p = props(mask)'
                prop_name = p{1};
                value = component.(prop_name);
                if all(isempty(value)) || all(isnan(value))
                    error(msg(prop_name));
                    result = false;
                    return
                end
            end
        end

    end
end
