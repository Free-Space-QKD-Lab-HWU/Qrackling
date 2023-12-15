function interfacefunc(target, next)

    [~, hv_tags] = enumeration('HufnagelValley');
    % hv_names = cellfun( ...
    %     @(tag) strjoin({'HufnagelValley', hv_tags}, '.'), ...
    %     UniformOutput=false);

    % mustBeMember(target, hv_tags);

    arguments
        target {mustBeMember(target, {'HV5_7', 'HV10_10'})}
        next {mustBeMember(next, hv_tags)}
    end

    disp(target)

end
