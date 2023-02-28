function results = format_tag(parameter)
    %if ~isstruct(parameter)
    %    opt.('opt') = parameter;
    %else
    %    opt = parameter;
    %end

    %fields = fieldnames(opt);
    %n_opts = numel(fields);

    %results = {};

    %for i = 1:n_opts
    %    param = opt.(fields{i});
    %    %result = cellfun(...
    %    %    @(P) isa(parameter.(P), 'TagEnum'), ...
    %    %    properties(parameter));
    %    %assert(sum(result) == 1, 'Not a parameter');
    %    results{i} = format(param);

    %end

    if isstruct(parameter)
        results = resultFromStruct(parameter);
        return
    end

    results = format(parameter);

end

function result = resultFromStruct(parameter)

    fields = fieldnames(parameter);
    n_fields = numel(fields);

    result = parameter.(fields{1}).Parent;
    for i = 1:n_fields
        %disp(parameter.(fields{i}));
        disp(i);
        raw_result = strsplit(format(parameter.(fields{i})), ' ');
        result = strjoin({result, raw_result{end}}, ' ');
    end

end

function result = format(param)
    switch param.Tag
        case TagEnum.IsFile
            result = formatIsFile(param);

        case TagEnum.IsFileName
            result = formatIsFileName(param);

        case TagEnum.IsValue
            result = formatIsValue(param);

        case TagEnum.IsOnOff
            result = formatIsOnOff(param);

        case TagEnum.IsOptionResult
            result = formatIsOptionResult(param);

        case TagEnum.IsPosition
            result = formatIsPosition(param);

        case TagEnum.IsCondition
            result = formatIsCondition(param);

        case TagEnum.IsObsolete
            result = formatIsCondition(param);

        case TagEnum.IsArray
            result = formatIsArray(param);

        case TagEnum.IsSetScale
            result = formatIsSetScale(param);

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
    %result = strjoin({parameterString(parameter), adduserpath(parameter.Value)}, ' ');
    parent = parameter.Parent;
    name = parameter.Name;
    value = parameter.Value;
    if ~isempty(value)
        value = adduserpath(value);
    end
    if strcmp(parent, name)
        result = strjoin({parent, value}, ' ');
        return
    end
    result = strjoin({parent, name, value}, ' ');
end

function result = formatIsFileName(parameter)
    result = strjoin({parameterString(parameter), adduserpath(parameter.Value)}, ' ');
end

function result = formatIsValue(parameter)
    %result = strjoin({parameterString(parameter), num2str(parameter.Value)}, ' ');
    parent = parameter.Parent;
    value = parameter.Value;
    if isempty(value)
        result = parent;
        return
    end
    result = strjoin({parent, num2str(value)}, ' ');
end

function result = formatIsOnOff(parameter)
    onoff = 'off';
    if parameter.Value == true
        onoff = 'on';
    end
    result = strjoin({parameterString(parameter), onoff}, ' ');
end

function result = formatIsOptionResult(parameter)
    %walked = walkParameter(parameter);
    walked = parameter;
    %result = strjoin({parameter.Parent, parameter.Name, walked.Result}, ' ');
    result = strjoin({parameter.Parent, parameter.Name, parameter.Value}, ' ');
end

function result = formatIsPosition(parameter)
    result = strjoin({parameter.Parent, parameter.Value}, ' ');
end

function result = formatIsCondition(parameter)
    parent = parameter.Parent;
    name = parameter.Name;
    if strcmp(parent, name)
        result = name;
        return
    end
    result = strjoin({parameter.Parent, parameter.Name}, ' ');
end

function result = formatIsObsolete(parameter)
    result = strjoin({parameter.Parent, parameter.Name}, ' ');
end

function result = formatIsArray(parameter)
    result = strjoin({parameter.Parent, num2str(parameter.Value)}, ' ');
end

function result = formatIsSetScale(parameter)
    result = strjoin({parameter.Parent, num2str(parameter.Value)}, ' ');
end
