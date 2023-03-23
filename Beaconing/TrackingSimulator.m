function [Satellite_Position,...
    Tracking_Error] = TrackingSimulator(PassSimulation)

%% an add-on function which simulates downlink beacon tracking

%% extract data
%flags over which beaconing can take place
LOS_Flags = PassSimulation.Line_Of_Sight_Flags;
LOS_Times = PassSimulation.Times(LOS_Flags);


%camera FOV
Camera_FOV_rad = PassSimulation.Ground_Station.Camera.FOV*[1;1];
Camera_FOV_deg = rad2deg(Camera_FOV_rad);
%handover angle requirement- determined by FSM
Handover_FOV_rad = PassSimulation.Ground_Station.Camera.Fine_Pointing_Handover_Angle;
Handover_FOV_deg = rad2deg(Handover_FOV_rad);

%camera pixels
Camera_Pixels = PassSimulation.Ground_Station.Camera.Pixels';

%satellite parameters
Actual_Heading = PassSimulation.Downlink_Beacon_Link_Model.Heading;
Actual_Elevation = PassSimulation.Downlink_Beacon_Link_Model.Elevation;
Range = PassSimulation.Downlink_Beacon_Link_Model.Length;

%in this sim we record sky position as a vector
%[Heading
%Elevation];
%we perform calculations in degrees to be consistent with telescope metrics
Satellite_Position = [Actual_Heading
                    Actual_Elevation];

% initial heading and elevation position is based on TLE data uncertainty
Initial_Poisition = GenerateTLEPosition(Satellite_Position(:,1),Range(1),Satellite);

% iterating over timesteps
Num_Timesteps=sum(LOS_Flags);
Time_Step_Width = seconds(PassSimulation.Times(2)-PassSimulation.Times(1));
%prepare memory
Telescope_Position=zeros(2,Num_Timesteps);
Telescope_Position(:,1)=Initial_Poisition;
Tracking_Error = zeros(2,Num_Timesteps);
Control_Signal = zeros(2,Num_Timesteps);
Tracking_Fail_Flags = false(1,Num_Timesteps);




%% control model
Error = 0;
Error_Integral=[0;0];
Error_Integral_anti_windup = [0;0];
for t=1:Num_Timesteps-1
    

    %%= compute pointing error
    [Tracking_Error(:,t),Tracking_Fail_Flags(t)] = CameraControlModel(Telescope_Position(:,t),Satellite_Position(:,t),Camera_FOV_deg,Camera_Pixels,Range(t),Satellite);

    % compute control signal
    K_prop=1*eye(2,2);
    K_int = (1/Time_Step_Width)*eye(2,2);
    K_Diff = 0.1*eye(2,2);
    Max_Windup = Camera_FOV_deg*Time_Step_Width/2;
    %error, error integral, error differential. need to cache these to deal with
    %problems at t=0
    Error_Differential = (Tracking_Error(:,t)-Error)/Time_Step_Width;
    Error = Tracking_Error(:,t);
    Error_Integral = Error_Integral + Tracking_Error(:,t) * Time_Step_Width;
    %antiwindup error integral
    Error_Integral_anti_windup = Error_Integral_anti_windup + Tracking_Error(:,t) *Time_Step_Width;
    Error_Integral_anti_windup(Error_Integral_anti_windup>Max_Windup)=Max_Windup(Error_Integral_anti_windup>Max_Windup);
    Error_Integral_anti_windup(Error_Integral_anti_windup<-Max_Windup)=-Max_Windup(Error_Integral_anti_windup<-Max_Windup);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%choose your controller model!
    %P
    %Control_Signal(:,t) = -K_prop*Error;

    %PI
    %Control_Signal(:,t) = -K_prop*Error - K_int*Error_Integral;

    %PID
    %Control_Signal(:,t) = -K_prop*Error -K_int*Error_Integral -K_Diff*Error_Differential;

    %PI with anti-windup
    Control_Signal(:,t) = -K_prop*Error - K_int*Error_Integral_anti_windup;

    %PID with anti-windup
    %Control_Signal(:,t) = -K_prop*Error - K_int*Error_Integral_anti_windup - K_Diff*Error_Differential;


    %% pass control signal to telescope model
    Telescope_Position(:,t+1) = TelescopeControlModel(Telescope_Position(:,t),Control_Signal(:,t),Time_Step_Width);

end


%% plot error results
figure('Name','Downlink beacon tracking performance')
tiledlayout(2,1)
nexttile
plot(LOS_Times,1000*deg2rad(Tracking_Error(1,:)),'r-',LOS_Times,1000*deg2rad(Tracking_Error(2,:)),'g-')
xlabel('Time')
ylabel('tracking error angle (mrad)')
hold on

%camera FOV
plot(LOS_Times,1000*ones(1,Num_Timesteps)*Camera_FOV_rad(1)/2,'b--',LOS_Times,1000*ones(1,Num_Timesteps)*-Camera_FOV_rad(1)/2,'b--')
ylim([-0.5*1000*Camera_FOV_rad(1),0.5*1000*Camera_FOV_rad(1)]);
%handover error requirement
plot(LOS_Times,1000*ones(1,Num_Timesteps)*Handover_FOV_rad(1)/2,'b:',LOS_Times,1000*ones(1,Num_Timesteps)*-Handover_FOV_rad(1)/2,'b:')

legend('Heading Error','Elevation Error','Camera FOV','','Handover to fine pointing','');

nexttile
plot(LOS_Times,Actual_Heading(LOS_Flags),LOS_Times,Actual_Elevation(LOS_Flags));
xlabel('Time')
ylabel('angle (deg)')
legend('heading','elevation')

% readout tracking error performance to console

%coarse tracking failures
[Coarse_Tracking_Failure_Start_Times,Coarse_Tracking_Failure_End_Times] = TrackingFailureTimes(Tracking_Error,Camera_FOV_deg,LOS_Times);
for i=1:numel(Coarse_Tracking_Failure_Start_Times)
    fprintf('Coarse Tracking Failure from %s to %s\n',...
        string(Coarse_Tracking_Failure_Start_Times(i),'hh:mm:ss'),...
        string(Coarse_Tracking_Failure_End_Times(i),'hh:mm:ss'));
end
fprintf('\n');

%fine tracking failure
[Fine_Tracking_Failure_Start_Times,Fine_Tracking_Failure_End_Times] = TrackingFailureTimes(Tracking_Error,Handover_FOV_deg,LOS_Times);
for i=1:numel(Fine_Tracking_Failure_Start_Times)
    fprintf('Fine Tracking Failure from %s to %s\n',...
        string(Fine_Tracking_Failure_Start_Times(i),'hh:mm:ss'),...
        string(Fine_Tracking_Failure_End_Times(i),'hh:mm:ss'));
end
fprintf('\n');

Position_Error_Std_Dev = std(Tracking_Error,0,2)';
fprintf('Heading Error std dev = %3.2drad\nElevation Error std dev = %3.2drad\n\n',deg2rad(Position_Error_Std_Dev(1)),deg2rad(Position_Error_Std_Dev(2)));

Position_Error_Median = median(abs(Tracking_Error),2)';
fprintf('Median Heading Error = %3.2drad\nMedian Elevation Error = %3.2drad\n\n',deg2rad(Position_Error_Median(1)),deg2rad(Position_Error_Median(2)));

Position_Error_95th = prctile(abs(Tracking_Error),95,2)';
fprintf('95th Percentile Heading Error = %3.2drad\n95th Percentile Elevation Error = %3.2drad\n\n',deg2rad(Position_Error_95th(1)),deg2rad(Position_Error_95th(2)));
end


function Next_Step_Telescope_Position = TelescopeControlModel(Telescope_Position,Arriving_Control_Signal,Time_Step_Width)
        %%simulate the action of the telescope responding to the control model

        %% telescope has maximum slew speed of 50deg/s
        Telescope_Slew_Rate = 50; %telescope max slew speed in deg/s
        if norm(Arriving_Control_Signal/Time_Step_Width)>Telescope_Slew_Rate
            %if more than this, saturate at 50
            Arriving_Control_Signal = Telescope_Slew_Rate * Arriving_Control_Signal/norm(Arriving_Control_Signal);
        end

        %% ideal response
        %the previous position, plus control signal
        Next_Step_Ideal_Position = Telescope_Position + Arriving_Control_Signal;
        
        %% then corrupt with noise
        arcsec_to_deg = 1/3600;
        %Jitter = 0.5arcsec
        Jitter = normrnd([0;0],[2;2]*arcsec_to_deg);
        %Pointing accuracy
        Pointing_Accuracy = normrnd([0;0],[30;30]*arcsec_to_deg);

        %% actual output
        Next_Step_Telescope_Position = Next_Step_Ideal_Position + Jitter + Pointing_Accuracy;

        %bound to heading -0360 elevation 0-90
        if Next_Step_Telescope_Position(2)>90
            Next_Step_Telescope_Position(2) = 180 - Next_Step_Telescope_Position(2);
            Next_Step_Telescope_Position(1) = Next_Step_Telescope_Position(1)-180;
        end
        if Next_Step_Telescope_Position(1)>360
            Next_Step_Telescope_Position(1) = Next_Step_Telescope_Position(1) - 360;
        end
        if Next_Step_Telescope_Position(1)<0
            Next_Step_Telescope_Position(1) = Next_Step_Telescope_Position(1) + 360;
        end
end

function [Position_Error_Estimate,TrackingFailFlag] = CameraControlModel(Telescope_Position,Satellite_Position,Camera_FOV_deg,Camera_Pixels,Range,Satellite)
        %%simulate the camera on the telescope)

        %% ideal response
        Position_Error_Actual = Telescope_Position - Satellite_Position;
        %deal with transition at 0 to 360 degrees in heading, limit error to
        %+-180
        if Position_Error_Actual(1) > 180
            Position_Error_Actual(1) = - 360 + Position_Error_Actual(1);
        elseif Position_Error_Actual(1) < -180
            Position_Error_Actual(1) = 360 + Position_Error_Actual(1);
        end
        TrackingFailFlag = false;
        %% add in pixelisation
        Discretisation_Error_Max = Camera_FOV_deg./Camera_Pixels;
        Discretisation_Error = unifrnd(-Discretisation_Error_Max,Discretisation_Error_Max);
        Position_Error_Estimate = Position_Error_Actual + Discretisation_Error;

        if any(abs(Position_Error_Estimate) > Camera_FOV_deg)
            TrackingFailFlag=true;
        %if tracking fails (satellite outside of camera FOV, then use TLE
        Position_Error_Estimate = Telescope_Position - GenerateTLEPosition(Satellite_Position,Range,Satellite);
        end


end

function TLE_Position = GenerateTLEPosition(Satellite_Position,Range,Satellite)
%% add uncertainty from TLE data onto actual satellite data to simulate TLE uncertainty

TLE_Error_Angles_rad = normrnd([0;0],Satellite.TLE_Uncertainty*[1;1])/Range;
TLE_Error_Angles_deg = rad2deg(TLE_Error_Angles_rad);
TLE_Position = Satellite_Position + TLE_Error_Angles_deg;
end

function [Tracking_Failure_Starts,Tracking_Failure_Ends] = TrackingFailureTimes(Tracking_Error,Error_Max,Times)
%% return the start and end times of any period when tracking does not meet the stated maximum requirement

%when does tracking fail
Tracking_Fail_Flags = any(abs(Tracking_Error)>Error_Max);

%indices in arrays
Indices = 1:numel(Times);

%fine tracking failure
Tracking_Failure_Start_Flags = ~Tracking_Fail_Flags(1:end-1)&Tracking_Fail_Flags(2:end);
Tracking_Failure_Start_Indices = Indices(Tracking_Failure_Start_Flags);
Tracking_Failure_End_Flags = Tracking_Fail_Flags(1:end-1)&~Tracking_Fail_Flags(2:end);
Tracking_Failure_End_Indices = Indices(Tracking_Failure_End_Flags);

%return times
Tracking_Failure_Starts = Times(Tracking_Failure_Start_Indices);
Tracking_Failure_Ends = Times(Tracking_Failure_End_Indices);
end