function result = sum_fields(struct_of_arrays, fields)
    assert(0 < numel(fields), 'No fields given');
    result = struct_of_arrays.(fields{1});
    for i = 2 : numel(fields)
        result = result + struct_of_arrays.(fields{i});
    end
end
