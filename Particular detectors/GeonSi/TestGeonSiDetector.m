%% a script which runs and plots several tests on the GeonSi class detector


%% set losses, time gate width and rep rate
Loss=0:0.1:20;
Repetition_Rate=10^4;
Time_Gate_Width=150*10^-9;
Spectral_Filter_Width=1;
%% Germanium on silicoln detector factory
F_G=GeonSi_Detector_Factory;
%and set default values.
D_G=CreateDetector(F_G,1300,'BB84',Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);

%% Indium gallium arsenide/ indium phosphide detector factory
F_I=InGaAsInP_Detector_Factory();
%and set default values
D_I=CreateDetector(F_I,1300,'BB84',Time_Gate_Width,Spectral_Filter_Width,Repetition_Rate);

%% compute for BB84 and decoy for GeonSi
[GeonSi_BB84_SKR,GeonSi_BB84_QBER]=BB84Model(D_G,Loss,Repetition_Rate);
[GeonSi_decoyBB84_SKR,GeonSi_decoyBB84_QBER]=decoyBB84Model(D_G,Loss,Repetition_Rate);

%% plot
close all
figure('Name','BB84 performance of GeonSi detector')
title('BB84 performance')
yyaxis left
plot(Loss,GeonSi_BB84_SKR)
ylabel('Sifted Key Rate (bits/s)')
yyaxis right
plot(Loss,GeonSi_BB84_QBER)
xlabel('Loss (dB)');
ylabel('QBER')

figure('Name','decoy BB84 performance of GeonSi detector')
title('decoy BB84 performance')
yyaxis left
plot(Loss,GeonSi_decoyBB84_SKR)
ylabel('Sifted Key Rate (bits/s)')
yyaxis right
plot(Loss,GeonSi_decoyBB84_QBER(1,:))
xlabel('Loss (dB)');
ylabel('QBER')

%% compute for BB84 and decoy for InGaAsInP
[InGaAsInP_BB84_SKR,InGaAsInP_BB84_QBER]=BB84Model(D_I,Loss,Repetition_Rate);
[InGaAsInP_decoyBB84_SKR,InGaAsInP_decoyBB84_QBER]=decoyBB84Model(D_I,Loss,Repetition_Rate);

%% plot
figure('Name','BB84 performance of InGaAsInP detector')
title('BB84 performance')
yyaxis left
plot(Loss,InGaAsInP_BB84_SKR)
ylabel('Sifted Key Rate (bits/s)')
yyaxis right
plot(Loss,InGaAsInP_BB84_QBER)
xlabel('Loss (dB)');
ylabel('QBER')

figure('Name','decoy BB84 performance of InGaAsInP detector')
title('decoy BB84 performance')
yyaxis left
plot(Loss,InGaAsInP_decoyBB84_SKR)
ylabel('Sifted Key Rate (bits/s)')
yyaxis right
plot(Loss,InGaAsInP_decoyBB84_QBER(1,:))
xlabel('Loss (dB)');
ylabel('QBER')

%% compare effect of DCR and detection efficiency
Fixed_Loss=5; %fixed loss in dB
Source_MPN=[0.7,0.3,0];
Source_Probabilities=[0.7,0.2,0.1];
Source_G2=0;
Source_State_Prep_Error=0;
Protocol_Efficiency=0.5;

DCR_Range=10000:100:40000;
N_DCR=numel(DCR_Range);
Det_Eff_Range=0.2:0.01:1;
N_Det=numel(Det_Eff_Range);
SKR=zeros(N_DCR,N_Det);
QBER=zeros(N_DCR,N_Det);

%% iterate over many DCRs and Det Effs
for i=1:N_DCR
    for j=1:N_Det
[skr,qber]=decoyBB84_model(Source_MPN,Source_Probabilities,Source_State_Prep_Error,Repetition_Rate,Det_Eff_Range(j),1-exp(-DCR_Range(i)*Time_Gate_Width),Fixed_Loss,Protocol_Efficiency,D_G.QBER_Jitter,D_G.Dead_Time);
SKR(i,j)=skr;
QBER(i,j)=qber(1);
    end
end

%% plot
[DCR,Det_Eff]=meshgrid(DCR_Range,Det_Eff_Range);
figure('Name','sifted key rate comparison of DCR and detection efficiency @5dB Loss')
surf(DCR',Det_Eff',SKR,'EdgeAlpha',0.1)
xlabel('dark count rate (cps)');
ylabel('detection efficiency');
zlabel('sifted key rate (bits/s)');

figure('Name','QBER comparison of DCR and detection efficiency @5dB Loss')
surf(DCR',Det_Eff',QBER,'EdgeAlpha',0.1)
xlabel('dark count rate (cps)');
ylabel('detection efficiency');
zlabel('QBER');


%% create a function to evaluate the BB84 model for each detector
function [SKR,QBER]=BB84Model(Detector, Loss, Repetition_Rate)
%% create source data
Source_MPN=0.01;
Source_G2=0;
Source_State_Prep_Error=0;
Protocol_Efficiency=0.5;

[SKR, QBER] = BB84_single_photon_model(Source_MPN, Source_G2, Source_State_Prep_Error, Repetition_Rate,...
    Detector.Detection_Efficiency, 1-exp(-Detector.Dark_Count_Rate*Detector.Time_Gate_Width), Loss-10*log10(Detector.Jitter_Loss), Protocol_Efficiency, Detector.QBER_Jitter, Detector.Dead_Time);
end
%% create a function to evaluate the decoyBB84 model for each detector
function [SKR,QBER]=decoyBB84Model(Detector, Loss, Repetition_Rate)
%% create source data
Source_State_Probabilities=[0.7,0.2,0.1];
Source_MPN=[0.7,0.3,0];
Source_State_Prep_Error=0;
Protocol_Efficiency=0.5;

[SKR, QBER] = decoyBB84_model(Source_MPN, Source_State_Probabilities, Source_State_Prep_Error, Repetition_Rate,...
    Detector.Detection_Efficiency, 1-exp(-Detector.Dark_Count_Rate*Detector.Time_Gate_Width), Loss-10*log10(Detector.Jitter_Loss), Protocol_Efficiency, Detector.QBER_Jitter, Detector.Dead_Time);
end