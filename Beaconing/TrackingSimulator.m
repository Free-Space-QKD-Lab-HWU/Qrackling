function [Actual_Position,Images,...
    Position_Innovation,...
    Actual_Tracking_Error] = TrackingSimulator(PassSimulation)

%% an add-on function which produces and analyses downlink beacon images based on a simulated pass

%% extract data
%flags over which beaconing can take place
LOS_Flags = PassSimulation.Line_Of_Sight_Flags;
LOS_Times = PassSimulation.Times(LOS_Flags);

%beacon performance parameters
Downlink_Beacon_Power = PassSimulation.Downlink_Beacon_Power(LOS_Flags);
Downlink_Beacon_Noise = Downlink_Beacon_Power./db2mag(PassSimulation.Downlink_Beacon_SNR_dB(LOS_Flags));
Exposure_Time = 0.001;
Saturation_Limit = PassSimulation.Ground_Station.Camera.Full_Well_Capacity;
Camera_FOV_rad = PassSimulation.Ground_Station.Camera.FOV*[1;1];
Camera_FOV_deg = rad2deg(Camera_FOV_rad);
%camera pixels (not recorded)
Camera_Pixels = [1080,1080];
%number of different values each pixel can record
Camera_Pixel_Range = 256;
SNR_Limit = 5;

%satellite parameters
[Heading,Elevation,Range]=RelativeHeadingAndElevation(PassSimulation.Satellite,...
                                                      PassSimulation.Ground_Station);
%in this sim we record sky position as a vector
%[Heading
%Elevation];
%we perform calculations in degrees to be consistent with telescope metrics
Actual_Position = [Heading(LOS_Flags)
    Elevation(LOS_Flags)];
%uncertainty in initial TLE data position (2D standard deviations of gaussian)
TLE_Data_Uncertainty = rad2deg([1E-3
    1E-3]); %1mrad in each direction

%% initial heading and elevation position is based on TLE data uncertainty
Initial_Poisition = GenerateTLEPosition(Actual_Position(:,1),TLE_Data_Uncertainty);

%% iterating over timesteps
Num_Timesteps=sum(LOS_Flags);
Time_Step_Width = seconds(PassSimulation.Times(2)-PassSimulation.Times(1));
%prepare memory
Prior_Position=zeros(2,Num_Timesteps);
Prior_Position(:,[1,2,3])=[Initial_Poisition,Initial_Poisition,Initial_Poisition];
Posterior_Position=zeros(2,Num_Timesteps);
Posterior_Position(:,[1,2,3])=[Initial_Poisition,Initial_Poisition,Initial_Poisition];
Position_Innovation = zeros(2,Num_Timesteps);
SNR = zeros(1,Num_Timesteps);
Tracking_Fail_Flag = false;
Images = zeros([Camera_Pixels,Num_Timesteps],'int8');

for t=3:Num_Timesteps-1

    %can actually generate and analyse images, but this is slow
    %{
    %% create image
    [CurrentImage,SNR]=GenerateImage(Downlink_Beacon_Power(t)*Exposure_Time,...
        Downlink_Beacon_Noise(t)*Exposure_Time,...
        Camera_Pixels,...
        Camera_Pixel_Range,...
        Saturation_Limit,...
        Actual_Position(:,t),...
        Prior_Position(:,t),...
        Camera_FOV_deg);
    %store image
    Images(:,:,t)=CurrentImage;


    %% analyse image for satellite position
    [Signal_Value,Measured_Index]=max(CurrentImage,[],'all');
    [Measured_Position(1),Measured_Position(2)] = ind2sub(Camera_Pixels,Measured_Index);
    %}
    %instead, return image pixel coords and SNR
    [Measured_Position,SNR(t)] = GenerateImageFast(Downlink_Beacon_Power(t)*Exposure_Time,...
        Downlink_Beacon_Noise(t)*Exposure_Time,...
        Camera_Pixels,...
        Camera_Pixel_Range,...
        Saturation_Limit,...
        Actual_Position(:,t),...
        Prior_Position(:,t),...
        Camera_FOV_deg);


    %if image SNR is low or satellite is not on image
    if SNR(t) < SNR_Limit
        Posterior_Position(:,t) = GenerateTLEPosition(Actual_Position(:,t),TLE_Data_Uncertainty);
        if ~Tracking_Fail_Flag
        fprintf('tracking failed at %s. Using TLE data\n',string(LOS_Times(t),'HH:mm:ss'));
        Tracking_Fail_Flag = true;
        end
    else
        %IF snr IS OK, use tracking camera data for posterior
        Tracking_Fail_Flag = false;
        %current posterior from meaurement
        Posterior_Position(:,t) = (Measured_Position-Camera_Pixels'/2).*Camera_FOV_deg./Camera_Pixels' + Prior_Position(:,t);
    
    end

    %% control theory predicted next step

    %% compute pointing error
    Position_Innovation(:,t)=Prior_Position(:,t)-Posterior_Position(:,t);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% select a control model
    Prior_Position(:,t+1) = Posterior_Position(:,t) - Position_Innovation(:,t);

end

%% calculate acutal tracking error
Actual_Tracking_Error = Prior_Position-Actual_Position;

%% plot error results
tiledlayout(2,1)
nexttile
plot(LOS_Times,Actual_Tracking_Error(1,:),'r-',LOS_Times,Actual_Tracking_Error(2,:),'g-')
xlabel('Time')
ylabel('tracking error angle (deg)')
hold on
plot(LOS_Times,ones(1,Num_Timesteps)*Camera_FOV_deg(1)/2,'r:',LOS_Times,ones(1,Num_Timesteps)*Camera_FOV_deg(2)/2,'g:')
plot(LOS_Times,-ones(1,Num_Timesteps)*Camera_FOV_deg(1)/2,'r:',LOS_Times,-ones(1,Num_Timesteps)*Camera_FOV_deg(1)/2,'g:')
legend('Heading Error','Elevation Error','Camea FOV (heading)','Camera FOV (elevation)');

nexttile
plot(LOS_Times,10*log10(SNR));
xlabel('Time')
ylabel('Beacon SNR (dB)')

%% readout tracking error performance to console
Position_Error_Std_Dev = std(Actual_Tracking_Error,0,2)';
fprintf('Heading Error std dev = %3.2drad\n Elevation Error std dev = %3.2drad\n',Position_Error_Std_Dev(1),Position_Error_Std_Dev(2));
end







function [Image,SNR] = GenerateImage(Signal_Energy,...
    Noise_Energy,...
    Pixels,...
    Pixel_Range,...
    Saturation,...
    Satellite_Position, ...
    Telescope_Position,...
    FOV)
%% generate a spot image with the requested SNR

%% generate noise image
Mean_Noise_Value = Noise_Energy*Pixel_Range/Saturation;
Image = int8(poissrnd(Mean_Noise_Value,Pixels));


%% add in signal
%signal pixel value
if Signal_Energy+Noise_Energy<Saturation
    Signal_Value = round(Signal_Energy*Pixel_Range/Saturation);
else
    Signal_Value = Pixel_Range;
end
Signal_Value = int8(Signal_Value);

%generate position of satellite on imaging sensor
Image_Position = (Satellite_Position-Telescope_Position)./FOV;
%round to the correct pixel and centre on middle
Image_Position = round(Image_Position) + Pixels'/2;

%% test for tracking failure!
if any(Image_Position<0) | any(Image_Position>Pixels)
Signal_Value = 0;
end
% add in signal
Image(Image_Position(1),Image_Position(2))=Image(Image_Position(1),Image_Position(2))+Signal_Value;

%% compute and return SNR
SNR = Signal_Value/sqrt(Mean_Noise_Value);

end

function [Image_Position,SNR] = GenerateImageFast(Signal_Energy,...
    Noise_Energy,...
    Pixels,...
    Pixel_Range,...
    Saturation,...
    Satellite_Position, ...
    Telescope_Position,...
    FOV)
%% skip very slow image generation and return image pixel coords of satellite and SNR

%% generate noise image
Mean_Noise_Value = Noise_Energy*Pixel_Range/Saturation;


%% add in signal
%signal pixel value
if Signal_Energy+Noise_Energy<Saturation
    Signal_Value = round(Signal_Energy*Pixel_Range/Saturation);
else
    Signal_Value = Pixel_Range;
end
Signal_Value = int8(Signal_Value);

%generate position of satellite on imaging sensor
Image_Position = (Satellite_Position-Telescope_Position)./FOV;
%round to the correct pixel and centre on middle
Image_Position = round(Image_Position) + Pixels'/2;

%% test for tracking failure!
if any(Image_Position<0) | any(Image_Position>Pixels)
Signal_Value = 0;
end

%% compute and return SNR
SNR = Signal_Value/sqrt(Mean_Noise_Value);

end


function TLE_Position = GenerateTLEPosition(Actual_Position,TLE_Uncertainty)
%% add uncertainty from TLE data onto actual satellite data to simulate TLE uncertainty
TLE_Position = Actual_Position + normrnd([0;0],TLE_Uncertainty);
end