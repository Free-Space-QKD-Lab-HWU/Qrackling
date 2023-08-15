function SF = IdealBPFilter(Centre_Wavelength,Spectral_Width,Steepness,Max_Wavelength)
%%IDEALBPFILTER return a SpectralFilter object with ideal performance and
%%the specified parameters

arguments
    Centre_Wavelength {mustBePositive,mustBeScalarOrEmpty}
    Spectral_Width {mustBePositive,mustBeScalarOrEmpty}
    Steepness {mustBePositive,mustBeScalarOrEmpty} = 1E3;
    %optional input- how steep should the changes in wavelength be? in
    %units of transmission/nm
    Max_Wavelength {mustBePositive,mustBeScalarOrEmpty} = 1E4;
    %what's the max wavelength mapped to by the spectral filter. default is
    %10um
end
%create a set of wavelength
Change_Width = 1/Steepness;

%detect and correct and error where if the Spectral_Width is less than or equal to the
%change width the points will not be unique and ordered
if Spectral_Width<=Change_Width
    Change_Width = Spectral_Width/10;
    warning('had to increase default steepness of spectral filter edges to cope with narrowness of filter')
end
Wavelengths = [0,Centre_Wavelength-Spectral_Width/2-Change_Width/2,Centre_Wavelength-Spectral_Width/2+Change_Width/2,Centre_Wavelength+Spectral_Width/2-Change_Width/2,Centre_Wavelength+Spectral_Width/2+Change_Width/2,Max_Wavelength];

%add corresponding transmission
Transmission = [0,0,1,1,0,0];

SF = SpectralFilter('wavelength',Wavelengths,'transmission',Transmission);
end
