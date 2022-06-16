%% plot transmittance against elevation for several different wavelengths

%plotting parameters
Elevation=0:1:90;
Wavelength=[680,780,850,910,1550];
Wavelength=sort(Wavelength,'descend');
colors = {'#F00','#F80','#FF0','#0B0','#00F','#50F','#A0F'};
MODTRAN_Transmittance=zeros(numel(Wavelength),numel(Elevation));
MATLAB_Transmittance=MODTRAN_Transmittance;

%iterating over wavelength
figure
hold on
for i=1:numel(Wavelength)
MODTRAN_Transmittance(i,:)=AtmosphericTransmittance(Wavelength(i),Elevation);
plot(Elevation,MODTRAN_Transmittance(i,:),'Color',colors{i},'LineStyle','-','DisplayName',sprintf('%inm MODTRAN',Wavelength(i)));

MATLAB_Transmittance(i,:)=AtmosphericTransmittance_Legacy(Wavelength(i),Elevation);
plot(Elevation,MATLAB_Transmittance(i,:),'Color',colors{i},'LineStyle','--','DisplayName',sprintf('%inm geometric approximation',Wavelength(i)));
end


legend('Location','southeast');
xlabel('Elevation (degrees)')
ylabel('Atmospheric Transmittance')
