% Author: Peter Barrow
% Data: 28 / 11 / 2022
% Convert AoS (Array-of-Structs) to SoA (Structure-of-Arrays) pattern, this
% helps follow data-oriented design principles and improves ergonomics
function soa = struct_of_arrays(obj_array, dimensions, varargin)
    p = inputParser;

    addRequired(p, 'obj_array');
    addRequired(p, 'dimensions');
    addParameter(p, 'mask', []);
    addParameter(p, 'restrict_to', {});

    parse(p, obj_array, dimensions, varargin{:});

    if ~isempty(p.Results.mask)
        assert(0 == min(p.Results.mask), 'Mask must be boolean array');
        assert(1 == max(p.Results.mask), 'Mask must be boolean array');
        mask = p.Results.mask;
    else
        mask = ones(1, numel(obj_array));
    end

    if numel(dimensions) == 1;
        dimensions = [1, dimensions];
    end

    structs_fields = fieldnames(obj_array);

    if isempty(p.Results.restrict_to)
        fields = structs_fields;
    else
        fields = p.Results.restrict_to;
    end

    found = 0;
    for i = 1 : numel(fields)
        found = found + sum(contains(structs_fields, fields{i}));
    end
    assert(0 < found, 'No matching fields found');

    soa = cell2struct(cell(length(fields), 1), fields);

    j = 0;
    k = sum(mask);
    N = numel(fields);
    for i = 1 : numel(mask)
        if mask(i) == false
            continue
        end

        if j == k
            break
        end

        j = j + 1;
        for fn = 1 : N
            field = fields{fn};
            soa.(field)(j) = obj_array(i).(field);
        end
    end

end
