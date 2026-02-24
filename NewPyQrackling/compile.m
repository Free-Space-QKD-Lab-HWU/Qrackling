% compile the contents of Qrackling into a class-based python package


% what files do we need to compile?
classNames = ExportedClassNames();
%% ------------------------------------------------------------
%  Qrackling Build Script
%  Automatically adds project root to path, verifies visibility,
%  collects all entry points, and compiles to Python.
% -------------------------------------------------------------

% Determine project root (folder containing this script)
projectRoot = pwd();

fprintf("Project root detected as:\n  %s\n\n", projectRoot);

%% ------------------------------------------------------------
%  1. Add project root to MATLAB path
% -------------------------------------------------------------

addpath(projectRoot);

fprintf("MATLAB path updated. Checking visibility...\n\n");

%% ------------------------------------------------------------
%  2. Verify that MATLAB can see your package folders
% -------------------------------------------------------------

packages = ["beacon","components","environment","fibre","nodes", ...
            "protocol","units","utilities"];

for pkg = packages
    pkgFolder = strcat(projectRoot, strcat('\+', pkg));
    if isfolder(pkgFolder)
        fprintf("  ✓ Found package folder: %s\n", pkgFolder);
    else
        fprintf("  ✗ Missing package folder: %s\n", pkgFolder);
    end
end


fprintf("\n");

%% ------------------------------------------------------------
%  3. Collect all .m files under all +package folders
% -------------------------------------------------------------

projectRoot = pwd();
addpath(projectRoot);

% 1) Get all .m files recursively
allFiles = dir(fullfile(projectRoot, '**', '*.m'));

% 2) Keep only those that live under at least one +package folder
hasPlusPkg = contains({allFiles.folder}, [filesep, '+']);
files = allFiles(hasPlusPkg);

entryPoints = strings(1, numel(files));

for k = 1:numel(files)
    % Full path to file
    f = fullfile(files(k).folder, files(k).name);

    % Strip project root
    rel = erase(f, strcat(projectRoot,filesep));

    % Split into path segments
    parts = strsplit(rel, filesep);

    % Drop any leading non-package segments (defensive)
    firstPkgIdx = find(startsWith(parts, '+'), 1, 'first');
    parts = parts(firstPkgIdx:end);

    % Strip '+' from package segments
    for i = 1:numel(parts)
        if startsWith(parts{i}, '+')
            parts{i} = extractAfter(parts{i}, 1);  % remove leading '+'
        end
    end

    % Last part is filename → strip .m
    parts{end} = parts{end}(1:end-2);

    % Join with dots to form fully qualified name
    entryPoints(k) = strjoin(parts, '.');
end

% 3) keep only non-abstract classes
filtered = strings(0);

for k = 1:numel(entryPoints)
    name = entryPoints(k);

    % Try to load class metadata
    mc = meta.class.fromName(name);

    if isempty(mc)
        % Not a class → keep it (it's a function)
        filtered(end+1) = name;
        continue
    end

    % It's a class → check if abstract
    if mc.Abstract
        fprintf("Skipping abstract class: %s\n", name);
        continue
    end

    % Concrete class → keep it
    filtered(end+1) = name;
end

entryPoints = filtered;
fprintf("Total entry points found: %d\n", numel(entryPoints));
disp(entryPoints(1:min(10, numel(entryPoints))));


%% ------------------------------------------------------------
%  4. Verify that MATLAB can resolve each entry point
% -------------------------------------------------------------

fprintf("\nVerifying entry points...\n");

for k = 1:numel(entryPoints)
    if isempty(which(entryPoints(k)))
        fprintf("  ✗ Cannot resolve: %s\n", entryPoints(k));
    else
        fprintf("  ✓ Resolved: %s\n", entryPoints(k));
    end
end

fprintf("Verification complete.\n\n");

%% ------------------------------------------------------------
%  5. Build Python package
% -------------------------------------------------------------

fprintf("Starting Python package build...\n");


buildResults = compiler.build.pythonPackage( ...
    entryPoints, ...
    "OutputDir", fullfile(projectRoot, "PyQrackling") ...
);

fprintf("\nBuild complete.\n");

