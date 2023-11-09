function [keys, data] = read_input_file(lrt_input_file_path)
    arguments
        lrt_input_file_path {mustBeFile}
    end

    keys = {};
    data = {};

    fd = fopen(lrt_input_file_path);
    line = fgetl(fd);
    while ischar(line)
        tokens = strsplit(line, ' ');
        key = tokens(1);
        keys = [keys, key{1}];

        rest_of_line = strjoin(tokens(2:end), ' ');
        if numel(tokens) == 1
            data = [data, true];
        else
            [numbers, status] = str2num(rest_of_line);

            if status
                data = [data, numbers];
            else
                data = [data, rest_of_line];
            end
        end

        line = fgetl(fd);
    end
    fclose(fd);
end
