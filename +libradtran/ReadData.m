function data = ReadData(lrt)
    arguments
        lrt libradtran.libRadtran
    end

    [keys, values] = libradtran.readInputFile(lrt.File);
    for i = numel(keys)
        msg = [keys{i}, " --> ", values{1}];
        disp(msg)
    end

    % data = libradtran.outputFromInputFile(lrt.File);
end
