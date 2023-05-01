%% Saturation
clear all
close all
clc

%% declare lambdas...

circAreaFromDiameter = @(d) pi * (d / 2)^2;
obscurationRatio = @(d, obs) 1 - (circAreaFromDiameter(d*obs) ...
                                  / circAreaFromDiameter(d));

%% Set Params and Simulate
OrbitDataFileLocation= '500kmSSOrbitLLAT.txt';

% wvl = 808;
wvl = 780;
%wvl = 550;
n_ph_opts = linspace(0.3, 0.8, 6);
n_ph = n_ph_opts(1);
reprate = 50e6;
% reprate = 200e6;
% reprate = 1e9;
time_gate = 10^-9;
spectral_filter = 1; 
dcr = 1000; % optionally 200

central_obscuration_ratio_rx = 0.3;
diameter_tx = 0.08;
diameter_rx = 0.7;

reprates = 10 .^ linspace(1, 9, 50);
%reprates = linspace(10, 1e12, 50);
%reprates = linspace(10, 1e9, 50);
reprates = linspace(10, 3e8, 50);
reprates = linspace(10, 1e10, 50);
total_skr = zeros(1, numel(reprates));
max_skr = zeros(1, numel(reprates));
rate_det = zeros(1, numel(reprates));

protocol = Protocol(qkd_protocols.DecoyBB84);
telescope_tx = Telescope(diameter_tx, Wavelength = wvl);
telescope_rx = Telescope(diameter_rx, Wavelength = wvl);
telescope_rx.Optical_Efficiency = obscurationRatio(diameter_rx, ...
                                                central_obscuration_ratio_rx);

detector_dv = MPD_Detector(wvl, reprates(1), time_gate, spectral_filter);
detector_dv = Excelitas_Detector(wvl, reprate, time_gate, spectral_filter);
ogs = Errol_OGS(detector_dv, telescope_rx);

for i = 1 : numel(reprates)
    reprate = reprates(i);
    source_dv = Source(wvl, ...
                       Repetition_Rate = reprate, ...
                       Mean_Photon_Number = [n_ph, 1-n_ph,0], ...
                       State_Prep_Error = 0.025, ...
                       State_Probabilities =[0.7,0.2,0.1]);
    %source_dv = BB84_Source(wvl);
    
    satellite = Satellite(source_dv, telescope_tx, ...
                          'OrbitDataFileLocation',OrbitDataFileLocation, ...
                          'Protocol', protocol);
    
    decoybb84_pass = PassSimulation(satellite, protocol, ogs);
    decoybb84_pass = Simulate(decoybb84_pass);
    total_skr(i) = decoybb84_pass.Total_Sifted_Key;
    max_skr(i) = max(decoybb84_pass.Secret_Key_Rates);
    rate_det(i) = max(decoybb84_pass.Rates_Det);
end

% figure
% semilogy(detector_dv.PDF)
% figure
% plot(detector_dv.CDF)

figure
plot(reprates, rate_det)

figure
plot(reprates ./ (1e6), total_skr ./ (1e3));
xlabel('Repetition Rate (MHz)')
ylabel('Total SKR (kBits)');
title(['Detector Saturation:', newline, ...
       'Fixed Dead Time and Increasing Repetition Rate']);

figure
plot(decoybb84_pass.QBERs(decoybb84_pass.QBERs ~= 0).*100)

decoybb84_pass.plot();
 

%%further testing

%decoybb84_pass.Headings = Headings;
%decoybb84_pass.Elevations = Elevations;
%decoybb84_pass.Link_Losses_dB = [decoybb84_pass.Link_Model.Link_Loss_dB];
%decoybb84_pass.Background_Count_Rates = Background_Count_Rates; 
%decoybb84_pass.Any_Communication_Flag = any(decoybb84_pass.Communicating_Flags);
%decoybb84_pass.Elevation_Viability_Flag = any(decoybb84_pass.Elevation_Limit_Flags);

%compute total data downlink
%first produce a vector of time bin widths
Downlink_Time_Windows = decoybb84_pass.Times(decoybb84_pass.Communicating_Flags) ...
                        -decoybb84_pass.Times([decoybb84_pass.Communicating_Flags(2:end), false]);

%the dot with sifted data rate
profile on
if ~isempty(Downlink_Time_Windows) && isnumeric(Downlink_Time_Windows)
    Total_Sifted_Key = dot(Downlink_Time_Windows, ...
            decoybb84_pass.Secret_Key_Rates(decoybb84_pass.Communicating_Flags));

elseif ~isempty(Downlink_Time_Windows) && isduration(Downlink_Time_Windows)
    Total_Sifted_Key = dot(seconds(Downlink_Time_Windows), ...
            decoybb84_pass.Secret_Key_Rates(decoybb84_pass.Communicating_Flags));
else
    Total_Sifted_Key = 0;
end

%Downlink_Time_Windows
rate = max(decoybb84_pass.Secret_Key_Rates(decoybb84_pass.Secret_Key_Rates ~= 0))
profile viewer

%% jitter calculation 
   function Detector = SetJitterPerformance(Detector, Repetition_Rate)
       % Repetition Rate: This is the rate of photons ARRIVING at the
       % detector, this will need to be recalculated for every value of
       % photons arriving at the detector.

       % How do we optimise the calculations this performs?

       %%SETJITTERPERFORMANCE compute the QBER and loss due to jitter and record it in the detector.

       %% input validation
       %check that Histogram is a correctly computed histogram
       if ~(numel(Detector.Histogram_Data) > 1) && all(isreal(Detector.Histogram_Data) & Detector.Histogram_Data > 0)
           error('Detector.Histogram_Data must be a correctly computed count histogram, of many elements containing positive values')
       end
       %check that Detector.Histogram_Bin_Width is a real scalar  > 0
       if ~isscalar(Detector.Histogram_Bin_Width) && isreal(Detector.Histogram_Bin_Width) && Detector.Histogram_Bin_Width > 0
           error('Detector.Histogram_Bin_Width must be a scalar real value  > 0')
       end
       %check that repetition rate is a real scalar  > 0
       if ~isscalar(Repetition_Rate) && isreal(Repetiton_Rate) && Repetition_Rate > 0
           error('Repetition_Rate must be a scalar real value  > 0')
       end
       %check that gate width is a real scalar  > 0
       if ~isscalar(Detector.Time_Gate_Width) && isreal(Detector.Time_Gate_Width) && Detector.Time_Gate_Width > 0
           error('Detector.Time_Gate_Width must be a scalar real value  > 0')
       end

       %% turn Detector.Histogram_Data into a CDF
       Total_Counts = sum(Detector.Histogram_Data);
       N = numel(Detector.Histogram_Data);
       CDF = zeros(1,N);
       PDF = zeros(1,N);
       
       %iterating over elements in the Detector.Histogram_Data
       PDF(1) = Detector.Histogram_Data(1)/Total_Counts;
       CDF(1) = 0;
       for i = 2:N
           PDF(i) = Detector.Histogram_Data(i)/Total_Counts;
           CDF(i) = sum(PDF(1:i));
       end

       %% turn time measures into index increments
       Time_Gate_Width_Index = 2 * round(Detector.Time_Gate_Width / (2 * Detector.Histogram_Bin_Width));
       Repetition_Period_Index = round(1 / (Repetition_Rate * Detector.Histogram_Bin_Width));
       %check that rounding results in reasonable precision
       if Time_Gate_Width_Index < 10
           warning('gate width is less than 10 histogram bins resulting in rounding errors')
       end
       if Repetition_Period_Index < 10
           warning('repetition period is less than 10 histogram bins resulting in rounding errors')
       end

       %% compute mode point
       [~,Mode_Time_Index] = max(PDF);

       %% compute loss
       Loss =  - CDF(max(Mode_Time_Index - Time_Gate_Width_Index / 2, 1)) ...
               + CDF(min(Mode_Time_Index + Time_Gate_Width_Index / 2, N));

       %% compute QBER
       QBER = 0;

       %iterating over previous pulses
       Current_Shifted_Mode = Mode_Time_Index + Repetition_Period_Index;
       while Current_Shifted_Mode < N
           QBER = QBER ...
                  + 0.5*(CDF(min(Current_Shifted_Mode ...
                                 + Time_Gate_Width_Index / 2, N)) ...
                  - CDF(max(Current_Shifted_Mode ...
                            - Time_Gate_Width_Index / 2, 1)) );

           Current_Shifted_Mode = Current_Shifted_Mode ...
                                  + Repetition_Period_Index;
       end

       %iterating over forward pulses
       Current_Shifted_Mode = Mode_Time_Index - Repetition_Period_Index;
       while Current_Shifted_Mode > 0
           QBER = QBER ...
                  + 0.5*(CDF(min(Current_Shifted_Mode ...
                                 + Time_Gate_Width_Index / 2, N)) ...
                  - CDF(max(Current_Shifted_Mode ...
                            - Time_Gate_Width_Index / 2, 1)) );
           Current_Shifted_Mode = Current_Shifted_Mode ...
                                  - Repetition_Period_Index;
       end
       %QBER cannot exceed 0.5 due to this
       if QBER > 0.5
           QBER = 0.5;
       end


       %% store answers
       Detector.QBER_Jitter = QBER;
       Detector.Jitter_Loss = Loss;
   end

%% some pulp

% Current_Shifted_Mode = Current_Shifted_Mode ...
%                        + Repetition_Period_Index;

a = 1;
b = 2;

while a < 20;
    disp(a);
    a = a + b;
end

linspace(1, 21, floor(20 / 2) + 1)
