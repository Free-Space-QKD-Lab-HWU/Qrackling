% a script which converts MODTRAN data in this folder into environment
% files which can be used for simulations.

% the resulting environment files have no brightness data, so are "dark"

MODTRAN_File_Root = 'Elevation_Wavelength_Atmospheric_Transmittance';
Visibility_Strings = {'100m','200m','500m','1km','2km','5km','10km','20km','50km','clear'};
Num_Files = numel(Visibility_Strings);

%what parameters should the environment filter have?
Headings = [0,90,180,270];

for i=1:Num_Files
    %iterating over different MODTRAN files
    load([MODTRAN_File_Root,Visibility_Strings{i},'.mat'],...
        'Elevation','Transmittance','Wavelength')

    %build environment object

        %need a repeated copy of transmittance data
            %some elevations have not been simulated in all data, these are
            %denoted by nan values
            Simulated = ~isnan(Transmittance(1,:));
            Elevation = Elevation(Simulated);
            Transmittance = permute(Transmittance(:,Simulated),[1,3,2]);
        T = repmat(Transmittance,[1,numel(Headings),1]);

        %need a dummy, empty spectral radiance
        SR = zeros(size(T));
    %now, can build
    Env = environment.Environment(Headings,Elevation,Wavelength,SR,T,"attenuation_unit","probability");

    %and save
    Env.Save(['Dark Environment ',Visibility_Strings{i}]);
end