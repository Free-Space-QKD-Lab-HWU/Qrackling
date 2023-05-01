%% randomly generate several jamming scenarios with different setups but different non-dimensional groups and plot their results

%% declare important variables
%storage
N=10000;                                                                    %number of randomly generated simulations
%dimensionless variable storage
Jamming_Performance=nan(1,N);                                              %sifted key under jamming / unjammed sifted key
Reflected_Loss=zeros(1,N);                                                 %total reflected path link loss
Direct_Loss=zeros(1,N);
ND_Power=zeros(1,N);                                                       %laser power/hclambdaT where T is receiver time gate width
ND_Diameter=zeros(1,N);                                                    %laser diameter / wavelength
ND_Spectral_Width=zeros(1,N);                                              %comms spectral width/jamming filter spectral width
ND_Area=zeros(1,N);
%other variables
Reflected_Link_Model=Satellite_Reflection_Link_Model_Constructor(2);
Direct_Link_Model=Satellite_Link_Model(2);
hc=1.98644568*10^-25;
%source
MPN=0.01;           
g2=0.01;
State_Prep_Error=0.01;


%% Iterating over simulations
for i=1:N
%generate random seed for comms system
Random_0_to_1=rand(1,9);

Wavelength=600+400*Random_0_to_1(1);
Repetition_Rate=2*10^9*Random_0_to_1(2);
Source=BB84_Source(Wavelength,MPN,g2,State_Prep_Error);
Source=SetRepetitionRate(Source,Repetition_Rate);
%transmitter telescope
T_Diameter=0.3*Random_0_to_1(3);
T_Tele=Telescope(T_Diameter,Wavelength,1,1);
%satellite
SimSatellite=Satellite(sprintf('Stationed_at_N_Pole_%i00km.txt',ceil(10*Random_0_to_1(4))),Source,T_Tele);
SimSatellite=SetFrontalArea(SimSatellite,10*Random_0_to_1(8));
SimSatellite=SetReflectivity(SimSatellite,Random_0_to_1(9));
Altitude=ceil(10*Random_0_to_1(4))*100000;
Time_Gate_Width=2*10^-10*Random_0_to_1(5);
Spectral_Filter_Width=3*Random_0_to_1(6);
Detector=MPD_Detector(Wavelength,Repetition_Rate,Time_Gate_Width,Spectral_Filter_Width);
%receiver telescope
R_Diameter=1.5*Random_0_to_1(7);
R_Tele=Telescope(R_Diameter,Wavelength,1,1);
%ground station
SimGroundStation=Ground_Station('none',Detector,R_Tele,'N Pole',[89.9,0,0]);

% jammingless simulation
UnjammedSimulation=PassSimulation(SimSatellite,Protocol(qkd_protocols.BB84),SimGroundStation,[]);
UnjammedSimulation=Simulate(UnjammedSimulation);

%generate random seed
Random_0_to_1=rand(1,5);

%jammer
J_Diameter=0.2*Random_0_to_1(1);
J_Power=500*Random_0_to_1(2);
Jamming_Latitude=90-(ComputeLOSWindow(Altitude,0)-ComputeLOSWindow(Altitude,SimGroundStation.Elevation_Limit))*(180/pi)*Random_0_to_1(3);
Jamming_Spectral_Width=3*Random_0_to_1(4);
Jammer=Jamming_Laser(Wavelength,J_Diameter,[Jamming_Latitude,0,0],'Janice',J_Power,Jamming_Spectral_Width);
%Jammer.Pointing_Jitter=0;
%jammed simulation
JammedSimulation=PassSimulation(SimSatellite,Protocol(qkd_protocols.BB84),SimGroundStation,Jammer);
JammedSimulation=Simulate(JammedSimulation);

%% extract results
Jamming_Performance(i)=1-GetTotalSiftedKey(JammedSimulation)/GetTotalSiftedKey(UnjammedSimulation);

[Reflected_Link_Model,Reflected_Loss_i]=Compute_Link_Loss(Reflected_Link_Model,SimSatellite,SimGroundStation,Jammer);
[Direct_Link_Model,Direct_Loss_i]=Compute_Link_Loss(Direct_Link_Model,SimSatellite,SimGroundStation);

Reflected_Loss(i)=Reflected_Loss_i(2);
Direct_Loss(i)=Direct_Loss_i;

ND_Power(i)=Jammer.Power*(Wavelength*10^-9)*Time_Gate_Width/(hc);

ND_Diameter(i)=J_Diameter/(Wavelength*10^-9);

ND_Spectral_Width(i)=Spectral_Filter_Width/Jamming_Spectral_Width;
end

%% plot
X=10*log10(ND_Power.*(ND_Diameter.^2).*min(ND_Spectral_Width,ones(size(ND_Spectral_Width))));
Y=Reflected_Loss-Direct_Loss;
scatter3(X,Y,Jamming_Performance,'CDataMode','manual','CData',Jamming_Performance,'Marker','X');
ax=gca;
xlabel('$\Pi_{jamming}$ (dB)','Interpreter','latex')
ylabel('$\Pi_{loss}$ (dB)','Interpreter','latex');
zlabel('$Jamming \ Performance =1-\frac{jammed \ total \ sifted \ key}{unjammed \ total \ sifted \ key}$','Interpreter','latex');
cb=colorbar();
cb.Label.Interpreter='latex';
cb.Label.String='Jamming Performance';
view(0,90);
hold on
plot3(160:220,190:250,ones(1,61),'r--')
hold off
legend('','Gradient=1','Location','northwest')
xlim([160,220]);
ylim([190,250])
axis equal
