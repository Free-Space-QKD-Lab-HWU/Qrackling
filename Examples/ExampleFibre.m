%a simulation of a decoy BB84 fibre link
%used

%% 1. Choose parameters
Wavelength=1550;                                                           %wavelength is measured in nm
Time_Gate_Width=1E-9;                                                      %times are measured in s
Spectral_Filter_Width=10;                                                  %consistent with wavelength, spectral width is measured in nm
%% 2. Construct components
%2.1 source
source = components.Source(Wavelength,...
                           'MPN_Signal',0.7,'MPN_Decoy',0.2,...
                           'Probability_Signal',0.75,'Probability_Decoy',0.2);
%2.2 transmitter
t = fibre.Fibre_Node('Source',source);

%2.3 detector
d = components.Detector(Wavelength,source.Repetition_Rate,...
                        Time_Gate_Width,Spectral_Filter_Width,...
                        'Preset','QuantumOpus1550_CryogenicAmplifier');
%2.4 receiver
r = fibre.Fibre_Node('Detector',d);
%2.5 fibre
f = fibre.Fibre(1E5);%10km fibre

%% 3 run and plot simulation
%3.1 run simulation
Result=fibre.QKDFibreSimulation(r,t,f,protocol.decoyBB84);
%3.2 plot results
Result.plot()
