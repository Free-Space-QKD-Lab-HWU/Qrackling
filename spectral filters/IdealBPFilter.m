function SF = IdealBPFilter(Centre_Wavelength, Spectral_Width, ...
    Steepness, Max_Wavelength, options)
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
        options.Wavelength_Scale OrderOfMagnitude = 'nano'
    end

    %create a set of wavelength
    Change_Width = 1/Steepness;

    % detect and correct and error where if the Spectral_Width is less than or
    % equal to the change width the points will not be unique and ordered
    if Spectral_Width <= Change_Width
        Change_Width = Spectral_Width / 10;
        warning('had to increase default steepness of spectral filter edges to cope with narrowness of filter')
    end

    Half_Width = Spectral_Width / 2;
    Half_Change = Change_Width / 2;

    Wavelengths = [0, ...
        Centre_Wavelength - Half_Width - Half_Change, ...
        Centre_Wavelength - Half_Width + Half_Change, ...
        Centre_Wavelength + Half_Width - Half_Change, ...
        Centre_Wavelength + Half_Width + Half_Change, ...
        Max_Wavelength];

    %add corresponding transmission
    Transmission = [0,0,1,1,0,0];

    SF = SpectralFilter( ...
        'wavelength', Wavelengths, ...
        'transmission', Transmission, ...
        'Wavelength_Scale', options.Wavelength_Scale);
end
