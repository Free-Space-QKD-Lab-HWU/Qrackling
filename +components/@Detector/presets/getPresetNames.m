function names = getPresetNames()
%returns the names of the available preset files stored in
%"+components/Detector/presets"
%as a cell array of chars


%% read out contents of folder
listarray = ls("+components\@Detector\presets\");

%% iterating over files listed
names = {};
for filename = listarray'

    %remove any spaces and transpose to row vector
    shortenedname = strrep(filename',' ','');

    %remove any files with names of 4 characters or less, as these cannot be
    %.mat files
    if numel(shortenedname)<5
        continue
    end



    %retain only .mat files
    if isequal(shortenedname(end-3:end),'.mat')
        % and remove .mat from end
        names = [names,shortenedname(1:end-4)];
    end
end
