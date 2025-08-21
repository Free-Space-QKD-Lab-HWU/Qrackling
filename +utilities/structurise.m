function struct = structurise(obj)
% structurise
%
% Convert an object to a structure containing only fields which
% are python conversion compatible.
%
% Syntax:
%   struct = structurise(obj)
%
% Inputs:
%   obj - any object of any dimension
%
% Outputs:
%   struct     - scalar struct containing only MATLAB base
%   classes which are python convertible.
arguments(Input)
    obj
end
arguments(Output)
    struct
end


%% iterate through properties of class
props = properties(obj);
for property = string(props')

    %% get property object
    property_obj = obj.(property);

    %% check that the current property is python conversion compatible
    %list all python conversion compatible classes
    PYTHON_COMPATIBLE_CLASSES = ...
        {'double',...
        'single',...
        'int8',...
        'uint8',...
        'int16',...
        'uint16',...
        'int32',...
        'uint32',...
        'int64',...
        'uint64',...
        'logical',...
        'string',...
        'char',...
        'cell',...
        'dictionary',...
        'struct',...
        'datetime',...
        'duration'};

    %check if property_obj class is compatible
    if ismember(class(property_obj), PYTHON_COMPATIBLE_CLASSES)
        % Assign compatible property to struct
        struct.(property) = property_obj;

        %otherwise, check if object is unpackable and unpack to
        %structure
    elseif ~isempty(properties(property_obj))
        substruct = utilities.structurise(property_obj);
        %then store this
        struct.(property) = substruct;

        % Finally, check if object can be converted to a string, double,
        % datetime or logical as a last ditch attempt to convert
    else
        try
            struct.(property) = string(property_obj);
        catch
            try
                struct.(property) = double(property_obj);
            catch
                try
                    struct.(property) = datetime(property_obj);
                catch
                    try
                        struct.(property) = logical(property_obj);
                    catch
                        % If this does not work, abandon storage and
                        % throw a warning
                        warning('Property "%s" is a "%s" and is not compatible with Python conversion.\nTherefore it has not been stored', property,class(property_obj));
                    end
                end
            end
        end
    end
end

