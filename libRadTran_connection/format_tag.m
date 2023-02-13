function result = format_tag(parameter)
    result = cellfun(...
        @(P) isa(parameter.(P), 'TagEnum'), ...
        properties(parameter));
    assert(sum(result) == 1, 'Not a parameter');

    switch parameter.Tag
        case TagEnum.IsFile
            result = formatIsFile(parameter);

        case TagEnum.IsFileName
            result = formatIsFileName(parameter);

        case TagEnum.IsValue
            result = formatIsValue(parameter);

        case TagEnum.IsOnOff
            result = formatIsOnOff(parameter);

        case TagEnum.IsOptionResult
            result = formatIsOptionResult(parameter);

        case TagEnum.IsPosition
            result = formatIsPosition(parameter);

        case TagEnum.IsCondition
            result = formatIsCondition(parameter);

        case TagEnum.IsObsolete
            result = formatIsCondition(parameter);

        case TagEnum.IsArray
            result = formatIsArray(parameter);

        case TagEnum.IsSetScale
            result = formatIsSetScale(parameter);

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

function result = walkParameter(parameter)
    props = properties(parameter);
    if isenum(parameter.Value)
        result = walkParameter(parameter.Value);
    else
        result = parameter.Value;
    end
end

function result = formatIsFile(parameter)
    disp('IsFile');
    result = strjoin({parameterString(parameter), adduserpath(parameter.Value)}, ' ');
end

function result = formatIsFileName(parameter)
    disp('IsFileName');
    result = strjoin({parameterString(parameter), adduserpath(parameter.Value)}, ' ');
end

function result = formatIsValue(parameter)
    disp('IsValue');
    result = strjoin({parameterString(parameter), parameter.Value}, ' ');
end

function result = formatIsOnOff(parameter)
    disp('IsOnOff');
    onoff = 'off';
    if parameter.Value == true
        onoff = 'on';
    end
    result = strjoin({parameterString(parameter), onoff}, ' ');
end

function result = formatIsOptionResult(parameter)
    walked = walkParameter(parameter);
    result = strjoin({parameter.Parent, parameter.Name, walked.Result}, ' ');
end

function result = formatIsPosition(parameter)
    disp('IsPosition');
    result = strjoin({parameter.Parent, parameter.Name}, ' ');
end

function result = formatIsCondition(parameter)
    disp('IsCondition');
    result = strjoin({parameter.Parent, parameter.Name}, ' ');
end

function result = formatIsObsolete(parameter)
    disp('IsObsolete');
    result = strjoin({parameter.Parent, parameter.Name}, ' ');
end

function result = formatIsArray(parameter)
    disp('IsArray');
    result = strjoin({parameter.Parent, parameter.Name}, ' ');
end

function result = formatIsSetScale(parameter)
    disp('IsSetScale');
    result = strjoin({parameter.Parent, parameter.Name}, ' ');
end
