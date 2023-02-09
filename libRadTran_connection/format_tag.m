function result = format_tag(parameter)
    result = cellfun(...
        @(P) isa(parameter.(P), 'TagEnum'), ...
        properties(parameter));
    assert(sum(result) == 1, 'Not a parameter');

    switch parameter.Tag
        case TagEnum.IsValue
            result = formatIsFile(parameter);
        case TagEnum.IsCondition
            result = formatIsCondition(parameter);
        otherwise
            result = '';
    end
end

function result = parameterString(parameter)
    parent = parameter.Parent;
    name = parameter.Name;
    result = strjoin({parent, name}, ' ');
    if strcmp(parameter.Parent, parameter.Name);
        result = name;
    end
end

function result = formatIsFile(parameter)
    result = strjoin({parameterString(parameter), getlibradtranfolder(parameter.Value)}, ' ');
end

function result = formatIsValue(parameter)
    result = strjoin({parameterString(parameter), parameter.Value}, ' ');
end

function result = formatIsCondition(parameter)
    result = strjoin({parameter.Parent, parameter.Name}, ' ');
end
