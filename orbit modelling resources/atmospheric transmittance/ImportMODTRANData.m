function ImportMODTRANData(FileNameStart, atmosphere_tag)
%%Import all of the data in the files which have a given start to form an array
%%of atmospheric transmittances over wavelength and elevation


%% prepare different values of elevation
Elevation = 10:10:90;

el=Elevation(1);
FileName = [FileNameStart,'_zen_',sprintf('%i',el),'deg_',atmosphere_tag,'_scan'];
%read file in
[Wavelength, Transmittance_at_el] = readvars(FileName,"NumHeaderLines",5);
    %remove nans from both, these occur at file ends
    Wavelength=Wavelength(1:end-1);
    Transmittance_at_el=Transmittance_at_el(1:end-1);
%append this data onto transmittance matrix
Transmittance = Transmittance_at_el;

%% iterate over different elevation values
for el = Elevation(2:end)
    %produce file name
    FileName = [FileNameStart,'_zen_',sprintf('%i',90-el),'deg_',atmosphere_tag,'_scan'];
    %read file in
    [Wavelength, Transmittance_at_el] = readvars(FileName,"NumHeaderLines",5);
        %remove nans from both, these occur at file ends
        Wavelength=Wavelength(1:end-1);
        Transmittance_at_el=Transmittance_at_el(1:end-1);
    %append this data onto transmittance matrix
    Transmittance = [Transmittance,Transmittance_at_el]; %#ok<AGROW> 
end

SaveName = ['Elevation_Wavelength_Atmospheric_Transmittance',atmosphere_tag];
save(SaveName,"Transmittance","Wavelength","Elevation");