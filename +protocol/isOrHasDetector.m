function ret_val = isOrHasDetector(maybe_detector)

    arg_name = inputname(1);

    switch class(maybe_detector)
    case 'components.Detector'
        ret_val = 1;
        return

    case 'nodes.Satellite'
        ret_val = 2;
        if any(isempty([maybe_detector.Detector]))
            throw(arg_name);
        end

    case 'nodes.Ground_Station'
        ret_val = 3;
        if any(isempty([maybe_detector.Detector]))
            throw(arg_name);
        end

    otherwise
        % if we don't get one of the known cases run through the properties and
        % check if we have a detector
        props = properties(maybe_detector);
        for p = props'
            if isa(maybe_detector.(p{1}), 'components.Detector')
                if isempty(maybe_detector.(p{1}))
                    throw(arg_name);
                end
            end
        end

        ret_val = 4;
        % if we got this far we definitely don't have a detector so throw
        throw(arg_name);
    end
end

function throw(arg_name)
    if 0 == numel(arg_name)
        arg_name = '{anonymous}';
    end
    error('"%s" can not be used as a detector', arg_name)
end
