%% run
clear all
close all
clc

ContentsOfDirectory = @(DirPath) {dir(adduserpath(DirPath)).name};

FilterFiles = @(DirectoryContents, Query) ...
    {DirectoryContents{cellfun( ...
        @(fp) contains(fp, Query), ...
        DirectoryContents)} ...
    };

in_target_path = '~/Documents/tqi_data/inputs/';

in_radianceFiles = FilterFiles( ...
    ContentsOfDirectory(in_target_path), ...
    '__radiance');

disp(in_radianceFiles')

in_file = strjoin({in_target_path, in_radianceFiles{1}}, '')

rf = radiance_file(in_file)

radiance = rf.pickRadianceForWavelength(1550);
[r, t] = meshgrid(rf.elevations, deg2rad(rf.azimuths - 270));

figure
[M, C] = contourf( ...
    r.*cos(t), ...
    r.*sin(t), ...
    radiance, ...
    levels=1);
set(C, 'LineColor', 'none')

extrema = @(arraylike) [min(arraylike(:)), max(arraylike(:))];

extrema(radiance)

%% 

radiance ./ 1000

%%
Receiver_Diameter = 0.08;
Wavelength = 850;
Receiver_Telescope = Telescope(Receiver_Diameter, "Wavelength", Wavelength);

%%

fov = Receiver_Telescope.FOV;

h = 6.626e-34;
c = 3e8;

nb = (radiance ./ 1000) ...
    .* (Receiver_Telescope.FOV * pi * (Receiver_Diameter^2) * 1) ...
    ./ (4 * h * c);

figure
hold on
s = pcolor( ...
    r.*cos(t), ...
    r.*sin(t), ...
    log10(nb))
s.EdgeColor = 'none'
hold off

figure
hold on
axis off;
s = pcolor( ...
    r.*cos(t), ...
    r.*sin(t), ...
    log10(nb))
s.EdgeColor = 'none'
pax = polaraxes();
hold off

%%
%close all
ff = polarpcolor(rad2deg(rf.elevations), rf.azimuths, radiance)
