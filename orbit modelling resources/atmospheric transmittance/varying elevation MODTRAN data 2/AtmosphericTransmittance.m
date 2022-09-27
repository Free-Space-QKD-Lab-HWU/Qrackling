function Transmittance=AtmosphericTransmittance(Wavelength,Elevation,TransmittanceSimulation)
% wavelength is in nm
% elevation is in degrees
%TransmittanceSimulation is a .mat file containing Wavelength and elevation
%Transmittance data. This is loaded if it is not provided
% T is atmospheric transmittance at the given wavelength perpendicular to the surface.

%% input validation
if nargin==1
    %if only 1 input, assume elevation is 90 degrees
    Elevation=90;
end
if any(Wavelength<300|Wavelength>2000)
    error('wavelength must be between 300nm and 2000nm')
end


%% compute the loss straight up through the atmosphere for this wavelength
%transmittance data is the result of MODTRAN simulation of the atmosphere
%and is stored in the .mat file 'atmoshperic transmittance'
if nargin<3
TransmittanceSimulation=load("Elevation_Wavelength_Atmospheric_Transmittance.mat","Transmittance","Wavelength","Elevation");
else
TransmittanceSimulation=load(TransmittanceSimulation,"Transmittance","Wavelength","Elevation");
end

%interpolate this data to return transmittance
Transmittance=interp2(TransmittanceSimulation.Elevation,TransmittanceSimulation.Wavelength,TransmittanceSimulation.Transmittance,Elevation,Wavelength);

%if not in the interpolated data range (usually elevation<0), return 0 rather than NaN
Transmittance(Elevation<0)=0;