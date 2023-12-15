function [keys, data] = readInputFile(lrt_input_file_path)
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

        % the line could be empty, if it is, skip it
        if numel(line) == 0
            line = fgetl(fd);
            continue
        end

        % if the line starts with '#' then its a comment, skip it
        if startsWith(line, '#')
            line = fgetl(fd);
            continue
        end

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
