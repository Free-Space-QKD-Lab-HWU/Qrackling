function [wavelengths, transmission] = readModtranFile(file_path)
    arguments
        file_path
    end

    tmp = readtable(file_path, VariableNamingRule='preserve');
    columns = tmp.Properties.VariableNames;

    check = contains(columns, "Waveln");
    assert(any(check), "Input file does not contain any wavelengths");
    wavelengths = tmp.(columns{check});

    check = contains(columns, "combin");
    assert(any(check), "Input file does not contain data for combined transmission");
    transmission = tmp.(columns{check});
end
