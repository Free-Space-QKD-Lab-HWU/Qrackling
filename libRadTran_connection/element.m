classdef element < dynamicprops
    properties
    end
    methods
        function obj = element(names);
            n = length(names);
            for i = 1:n
                %disp(names{i});
                obj.addprop(names{i});
            end
        end
        function element = addoptions(element, opts)
            element.addprop('Options');
            element.('Options') = options(opts);
        end
    end
end
