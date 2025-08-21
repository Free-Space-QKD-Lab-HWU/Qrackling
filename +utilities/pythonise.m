function output = pythonise(obj)
% pythonise
%
% Convert an object to a python compatible format
%
% Syntax:
%   output = pythonise(obj)
%
% Inputs:
%   obj - any object of any dimension
%
% Outputs:
%   output - a python equivalent object
arguments(Input)
    obj
end
arguments(Output)
    output
end

%% first, check if object is empty. if so, return python none
if isempty(obj)
    output = py.None;
    return
end

%% Otherwise we move on to determine class of object
obj_class = class(obj);

%% and if object is a row vector of numerics, logicals or datetimes, transpose it
if isrow(obj) && (isnumeric(obj)||islogical(obj)||isdatetime(obj))
    obj = obj';
end

%% deal with object depending on class
switch obj_class
    case 'double'
        if isscalar(obj)
            output = py.float(obj);
        else
            output = py.numpy.asarray(obj, dtype='float');
        end
    case 'logical'
        if isscalar(obj)
            output = py.bool(obj);
        else
            output = py.numpy.asarray(obj,dtype='bool');
        end
    case 'datetime'
        if isscalar(obj)
            output = py.datetime.datetime(obj);
        else
            output = py.numpy.asarray(obj,dtype='datetime64[s]');
        end
    case 'duration'
        if isscalar(obj)
            output = py.datetime.timedelta(obj);
        else
            output = py.numpy.asarray(obj,dtype='timedelta64[s]');
        end
    case 'char'
        output = py.str(obj);

    case 'string'
        if isscalar(obj)
            output = py.str(obj);
        else
            warning('Conversion to python of string arrays vectors is not supported')
            output = py.None;
        end

    case 'cell'
        % for cell vectors, we iterate through and convert entries
        assert(isvector(obj),'Python cannot receive cells which are not vectors')

        output = py.list();
        for entry = obj
            unpacked_entry = entry{1};
            list_entry = utilities.pythonise(unpacked_entry);
            output.append(list_entry);
        end

        % if list is empty, return none
        if isempty(output)
            output = py.None;
        end

    case 'units.Loss'
        % losses are convertible to double
        if isscalar(obj)
            output = py.float(double(obj));
        else
            output = py.numpy.asarray(double(obj),dtype='float');
        end

    case 'environment.Noise'
        % noise can be converted to float
        if isscalar(obj)
            output = dictionary('label',obj.label,...
                                'values',obj.values);
            output = py.dict(output);
        
        else
            num_times = numel(obj.values);
            values = zeros([size(obj),num_times]);
            for i = 1:numel(obj)
                values(i:i+num_times-1) = obj(i).values;
            end

            %convert to python ndarray
            output = py.numpy.asarray(values,dtype='float');
        end
            
    otherwise
        % for all other classes, we assume either an enum or a custom class.

        if isenum(obj)
            output = utilities.pythonise(string(obj));
        else
            % if not an enumeration, likely a custom class.


            % if scalar
            if isscalar(obj)
                % iterate through properties and convert
                output = py.dict();
                props = string(properties(obj))';
                for property = props
                    sub_output = utilities.pythonise(obj.(property));
                    output.update(dictionary(property,sub_output));
                end

            else
                % if array

                % create a cell array with the same dimensions as obj to
                % stand in for the numpy array for now
                output = cell(size(obj));
                for idx = 1:numel(obj)
                    sub_output = utilities.pythonise(obj(idx));
                    output{idx} = sub_output;
                end
            end
        end
end