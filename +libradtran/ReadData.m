function data = ReadData(lrt)
    arguments
        lrt libradtran.libRadtran
    end

    [keys, values] = libradtran.readInputFile(lrt.File);

    has_mc_basename = any(contains(keys, 'mc_basename'));
    has_output_file = any(contains(keys, 'output_file'));
    has_quantity = any(contains(keys, 'output_quantity'));

    if has_quantity
        [~, i] = max(contains(keys, 'output_quantity'));
        quantity = values{i};
    end

    % NOTE: the output files when using the montecarlo backend can have
    % different context depeneding on what inputs were supplied, the output file
    % will look the same however. So, how best to differentiate the results?
    % All we really want is to add a string somewhere so the user can quickly
    % check which kind it is or use that info to make a figure title, etc.

    % data = libradtran.outputFromInputFile(lrt.File);
end
