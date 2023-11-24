classdef (Abstract) QKD_Receiver < nodes.Optical_Node
    %QKD_Receiver an abstract class containing function templates for any
    %receiver architecture

    properties
        % a detector object, validated individually in subclasses
        Detector =[];

        % background count rate (in counts/s) as a function of heading and 
        % elevation, stored as a structure with fields 'Count_Rate', 'Heading' 
        % and 'Elevation'
        Background_Rates{isstruct, ...
                         isfield(Background_Rates, 'Heading'), ...
                         isfield(Background_Rates, 'Elevation'), ...
                         isfield(Background_Rates, 'Count_Rate')}

        % count rates at the Ground station due to light pollution
        Light_Pollution_Count_Rates{mustBeVector, mustBeNonnegative} = 0;

        % count rates at the Ground station due to dark counts
        Dark_Count_Rates{mustBeVector, mustBeNonnegative} = 0;

        % count rates at the Ground station due to reflected light off satellite
        Reflection_Count_Rates{mustBeVector, mustBeNonnegative} = 0;

        % count rates at the Ground station due to reflected light off satellite
        Directed_Count_Rates{mustBeVector, mustBeNonnegative} = 0;
    end

    methods (Abstract = true)

            PlotBackgroundCountRates(QKD_Receiver, Plotting_Indices, X_Axis)

            [Total_Background_Count_Rate,QKD_Receiver] = ComputeTotalBackgroundCountRate(QKD_Receiver, Background_Sources, QKD_Transmitter, Headings, Elevations, SMARTS_Configuration, Count_Map)
    end

    methods (Abstract=false)

        function Received_Wavelengths = DopplerShift(QKD_Receiver,QKD_Transmitter)
            %%DOPPLERSHIFT compute the apparent wavelength at the receiver
            %%of a transmitted QKD signal


            %speed of light (m/s)
            c=2.998E8;

            %% Compute doppler velocity over time
            % get distance between receiver and transmitter over time
            Distances = ComputeDistanceBetween(QKD_Receiver,QKD_Transmitter);
            %get time stamps
            if isa(QKD_Receiver,'Satellite')
                Times = QKD_Receiver.Times;
            elseif isa(QKD_Transmitter,'Satellite')
                Times = QKD_Transmitter.Times;
            else
                error('one of transmitter or receiver must be a satellite')
            end
            %differentiate wrt time
            Doppler_Velocity = (Distances(2:end)-Distances(1:end-1))./seconds(Times(2:end)-Times(1:end-1));
            %append last result to fill end slot
            Doppler_Velocity = [Doppler_Velocity,Doppler_Velocity(end)];

            %% use this to modify wavelength
            Received_Wavelengths = (1+Doppler_Velocity/c)*QKD_Transmitter.Source.Wavelength;
        end

        function Phi = ComputeMotionPhaseShift(QKD_Receiver,QKD_Transmitter)
            %%MOTIONPHASESHIFT compute the phase shift which relative
            %%motion between transmitter and receiver causes between pulses
           
            c=2.998E8;%speed of light
            Wavelength = QKD_Transmitter.Source.Wavelength*1E-9;
            Rep_Rate = QKD_Transmitter.Source.Repetition_Rate;

            % get distance between receiver and transmitter over time
            Distances = ComputeDistanceBetween(QKD_Receiver,QKD_Transmitter);
            %get time stamps
            if isa(QKD_Receiver,'Satellite')
                Times = QKD_Receiver.Times;
            elseif isa(QKD_Transmitter,'Satellite')
                Times = QKD_Transmitter.Times;
            else
                error('one of transmitter or receiver must be a satellite')
            end
            %differentiate wrt time
            Relative_Velocity = (Distances(2:end)-Distances(1:end-1))./seconds(Times(2:end)-Times(1:end-1));
            %append last result to fill end slot
            Relative_Velocity = [Relative_Velocity,Relative_Velocity(end)];

            %% compute phase shift
            Phi = -2*pi*(c/(Wavelength*Rep_Rate))*(Relative_Velocity./(Relative_Velocity+c));
        end

    
        function Visibility = ComputeVisibility(QKD_Receiver,QKD_Transmitter)
            %%COMPUTEVISIBILITY compute the visibility of an interferometer
            %%at the QKD receiver due to transmitter motion

            %speed of light
            c=2.998E8;

            %% Doppler shift
            Received_Wavelengths = DopplerShift(QKD_Receiver,QKD_Transmitter);
            delta_Wavelengths = Received_Wavelengths-QKD_Transmitter.Source.Wavelength;


            %% phase difference induced by moving between pulses
            Phi = ComputeMotionPhaseShift(QKD_Receiver,QKD_Transmitter);

            %% compute visibility
            Received_Phase_Offset = 2*pi*delta_Wavelengths*c/(QKD_Transmitter.Source.Repetition_Rate*(QKD_Transmitter.Source.Wavelength*1E-9)^2) + Phi;
            Visibility = abs(cos(Received_Phase_Offset)-cos(Received_Phase_Offset+pi))./(2+cos(Received_Phase_Offset)+cos(Received_Phase_Offset+pi));
        end
    end
end
