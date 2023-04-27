classdef parameterToObject < dynamicprops
    properties
    end

    methods
        function parameterToObject = parameterToObject(param)
            fields = fieldnames(param);
            for i = 1:numel(fields)
                parameterToObject.addprop(fields{i});
                parameterToObject.(fields{i}) = param.(fields{i});
            end
        end

        function printOptions(parameterToObject)
            props = properties(parameterToObject);
            for i = 1:numel(props)
                p = props{i};
                total = sum(contains(properties(parameterToObject.(p)), 'Tag'));
                if total > 0
                    options = parameterToObject.(p).Value.Option;
                    disp([newline, 'Options for {', p, '}:']);
                    for j = 1:numel(options)
                        disp([num2str(j), char(9) '->', char(9), options{j}])
                    end
                end
            end
        end
    end
end
