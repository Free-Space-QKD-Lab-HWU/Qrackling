function [Secret_Key_Rate,QBER]=EvaluateQKDLink(Satellite,Ground_Station,Link_Loss_dB,Background_Count_Rate)
%%EVALUATEQKDLINK   compute the sifted key rate and qber for the particular
%%protocol being used for a pass between a given satellite and ground
%%station exposed to given loss and BCR


%% switch between protocols being used. The same protocol must be present in satellite and ground station
if ~isequal(Satellite.Source.Protocol,Ground_Station.Detector.Protocol)
    error('Satellite and ground station must use the same protocol');
else
    Protocol=Satellite.Source.Protocol;
end   

%% input validation
if ~isequal(size(Link_Loss_dB),size(Background_Count_Rate))
    error('Link loss and background count rate inputs must be the same dimensions')
end

%% if link loss and background count rate inputs are of zero size, return zero size outputs
if any(size(Link_Loss_dB)==0)
Secret_Key_Rate=zeros(size(Link_Loss_dB));
QBER=nan(zeros(size(Link_Loss_dB)));
return
end

%% switch between protocols being used
switch Protocol
    case 'BB84'
        %% using simulation BB84_single_photon_model from lab fileshare
        %compute probability that a background count occurs inside the time
        %window of the detector
        Background_Count_Probability=1-exp(1).^(-Background_Count_Rate*Ground_Station.Detector.Time_Gate_Width);
        %then use model
        [Secret_Key_Rate, QBER] = BB84_single_photon_model(Satellite.Source.Mean_Photon_Number,...
            Satellite.Source.g2,...
            Satellite.Source.State_Prep_Error,...
            Satellite.Source.Repetition_Rate,...
            Ground_Station.Detector.Detection_Efficiency,...
            Background_Count_Probability,...
            Link_Loss_dB,...
            Satellite.Protocol_Efficiency,...
            Ground_Station.Detector.QBER_Jitter,...
            Ground_Station.Detector.Dead_Time);
    case 'E91'
        %% using simulation ekart92_model from lab fileshare
        %compute probability that a background count occurs inside the time
        %window of the detector
        Background_Count_Probability=1-exp(-Background_Count_Rate*Ground_Station.Detector.Time_Gate_Width);
        %then use model
        [Secret_Key_Rate, QBER] = ekart92_model( ...
            Satellite.Source.Repetition_Rate, ...
            Ground_Station.Detector.Detection_Efficiency, ...
            Background_Count_Probability, ...
            Link_Loss_dB, ...
            Satellite.Protocol_Efficiency, ...
            Ground_Station.Detector.QBER_Jitter, ...
            Ground_Station.Detector.Dead_Time);
    otherwise
        error('protocol not recognised');
end