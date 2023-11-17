function data = ReadData(lrt)
    arguments
        lrt libradtran.libRadtran
    end

    [keys, values] = libradtran.readInputFile(lrt.File);
    for i = 1:numel(keys)
        disp(keys{i})
    end

    

    % data = libradtran.outputFromInputFile(lrt.File);
end
