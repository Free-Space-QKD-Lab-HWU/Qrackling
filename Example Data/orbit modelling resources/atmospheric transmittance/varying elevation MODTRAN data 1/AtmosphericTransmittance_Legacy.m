function Transmittance=AtmosphericTransmittance_Legacy(Wavelength,Elevation,TransmittanceSimulation)
% wavelength is in nm
% elevation is in degrees
%TransmittanceSimulation is a .mat file containing Wavelength and
%Transmittance data. This is loaded if it is not provided
% T is atmospheric transmittance at the given wavelength perpendicular to the surface.


% thickness of atmosphere is 10km
Thickness=10000;
% earth radius is 6371km
Radius=earthRadius();

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
TransmittanceSimulation=load("Atmospheric_Transmittance_Legacy.mat","Transmittance","Wavelength_nm");
end

%interpolate this data to return transmittance
Straight_Up_Transmittance=interp1(TransmittanceSimulation.Wavelength_nm,TransmittanceSimulation.Transmittance,Wavelength);

%% compute the link length in the atmosphere
% convert elevation angle to an increase factor describing distance travelled through the atmosphere
Atmospheric_Distance=-Radius.*sind(Elevation)+sqrt((Radius.*sind(Elevation)).^2+2*Radius*Thickness+Thickness^2);
Exponent=Atmospheric_Distance/Thickness;

%% modify straight-up transmittance by this value
Transmittance=Straight_Up_Transmittance.^Exponent;