function ret_val = isOrHasSource(maybe_source)

    arg_name = inputname(1);

    switch class(maybe_source)
    case 'components.Source'
        ret_val = 1;
        return

    case 'nodes.Satellite'
        ret_val = 2;
        if isempty([maybe_source.Source])
            throw(arg_name);
        end

    case 'nodes.Ground_Station'
        ret_val = 3;
        if isempty([maybe_source.Source])
            throw(arg_name);
        end

    otherwise
        % if we don't get one of the known cases run through the properties and
        % check if we have a detector
        props = properties(maybe_source);
        for p = props'
            if isa(maybe_source.(p{1}), 'components.Source')
                if isempty(maybe_source.(p{1}))
                    throw(arg_name);
                end
            end
        end

        ret_val = 4;
        % if we got this far we definitely don't have a source so throw
        throw(arg_name);
    end
end

function throw(arg_name)
    if 0 == numel(arg_name)
        arg_name = '{anonymous}';
    end
    error('"%s" can not be used as a source', arg_name)
end
