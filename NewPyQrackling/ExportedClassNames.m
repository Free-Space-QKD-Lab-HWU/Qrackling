% read through all of the object files in this package and
% list them in the appropriate format for the compiler.build.pythonPackage
% method

function classNamesArray = ExportedClassNames()

% create list of class names
classNamesArray = {};

% list all folders which start with +
folders = dir('+*');

% iterate over all of these folders, finding .m files within them
for k = 1:length(folders)
    mFiles = dir(fullfile(folders(k).name, '*.m'));
    folder_name = strrep(folders(k).name,'+','');
    for j = 1:length(mFiles)
        [path,name,filetype]=fileparts(mFiles(j).name);
        final_name = [folder_name,'.',name];
        fprintf([final_name,'\n'])
        classNamesArray{end+1} = final_name;

    end
end