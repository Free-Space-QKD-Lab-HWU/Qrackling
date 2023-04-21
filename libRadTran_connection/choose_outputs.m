function result = choose_outputs(outputs)
    p = parameters();
    output_user = p.output_user;
    options = output_user.Value.Option;

    isInOptions = @(opt) sum(contains(options, opt)) > 0;

    if ~iscell(outputs)
        assert(isInOptions(outputs), 'Not a valid output option');
        result = strjoin({output_user.Name, outputs}, ' ');
        return
    end

    result = output_user.Name;
    n_outs = numel(outputs);
    for i = 1:n_outs
        out = outputs{i};
        if isa(out, 'Variable')
            if out.Tag == TagEnum.IsValue
                result = strjoin({result, out.Value}, ' ');
                continue
            end
        end
        if isInOptions(out)
            result = strjoin({result, out}, ' ');
        end
    end

end
