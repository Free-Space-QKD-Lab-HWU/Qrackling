function ImportMODTRANData(atmosphere_tag)
%%Import all of the data in the files which have a given start to form an array
%%of atmospheric transmittances over wavelength and elevation

%% prepare different values of elevation
Elevation = [1,2,5,10,20,30,40,50,60,70,80,85,88,89,90];

el=Elevation(1);
%read file in
try
FileNameStart = 'Trans_Sep_2022';
FileName = [FileNameStart,'_zen_',sprintf('%i',90-el),'deg_',atmosphere_tag,'_scan'];
[Wavelength, Transmittance_at_el] = readvars(FileName,"NumHeaderLines",5);
catch
%if this fails, try a different file name
FileNameStart = 'Trans_Feb_2023';
FileName = [FileNameStart,'_zen_',sprintf('%i',90-el),'deg_',atmosphere_tag,'_scan'];
[Wavelength, Transmittance_at_el] = readvars(FileName,"NumHeaderLines",5);
end

%remove nans from both, these occur at file ends
    Wavelength=Wavelength(1:end-1);
    Transmittance_at_el=Transmittance_at_el(1:end-1);
%append this data onto transmittance matrix
Transmittance = Transmittance_at_el;

%% iterate over different elevation values
for el = Elevation(2:end)
try
FileNameStart = 'Trans_Sep_2022';
FileName = [FileNameStart,'_zen_',sprintf('%i',90-el),'deg_',atmosphere_tag,'_scan'];
[Wavelength, Transmittance_at_el] = readvars(FileName,"NumHeaderLines",5);
catch
%if this fails, try a different file name
try
FileNameStart = 'Trans_Feb_2023';
FileName = [FileNameStart,'_zen_',sprintf('%i',90-el),'deg_',atmosphere_tag,'_scan'];
[Wavelength, Transmittance_at_el] = readvars(FileName,"NumHeaderLines",5);
catch
    %if THIS fails, skip the file
    Transmittance_at_el=nan([size(Transmittance,1)+1,1]);
end
end
        %remove nans from both, these occur at file ends
        Wavelength=Wavelength(1:end-1);
        Transmittance_at_el=Transmittance_at_el(1:end-1);
    %append this data onto transmittance matrix
    Transmittance = [Transmittance,Transmittance_at_el]; %#ok<AGROW> 
end

SaveName = ['Elevation_Wavelength_Atmospheric_Transmittance',atmosphere_tag];
save(SaveName,"Transmittance","Wavelength","Elevation");