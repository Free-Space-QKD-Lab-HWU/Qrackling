classdef Beacon_Downlink_Model < Link_Model
        %Beacon_Downlink_Model a link model specific to satellite to OGS downlink

    properties (SetAccess=protected,Abstract=false)
        N                                                                  %number of timestamps simulated, equal to the dimension of all loss vectors
        Link_Loss;                                                         %link loss in absolute terms
        Link_Loss_dB;                                                      %link loss measured in dB
        Shadow_Flag;                                                       %flag describing when the link is shadowed
    end
    properties (SetAccess=protected)
        Visibility {mustBeText} ='clear'                                   %tag identifying the visibility conditions of this link

        %% all of these properties are 1xN vectors
        Geometric_Loss(1,:)=nan;                                                %geometric loss in absolute terms
        Geometric_Loss_dB(1,:)=nan;                                             %geometric loss in dB
        Optical_Efficiency_Loss(1,:)=nan;                                       %Optical Efficiency loss in absolute terms
        Optical_Efficiency_Loss_dB(1,:)=nan;                                    %Optical Efficiency loss in dB
        APT_Loss(1,:)=nan;                                                      %tracking loss in absolute term s
        APT_Loss_dB(1,:)=nan;                                                   %tracking loss in dB
        Atmospheric_Loss(1,:)=nan;                                              %atmospheric loss in absolute terms
        Atmospheric_Loss_dB(1,:)=nan;                                           %atmospheric loss in dB
        Turbulence_Loss=nan;                                               %turbulence loss in absolute terms
        Turbulence_Loss_dB=nan;                                            %loss due to atmospheric turbulence
        Length(1,:)=nan;                                                        %link distance in m
    end

    methods (Access=public)

    function Beacon_Downlink_Model=Beacon_Downlink_Model(N,Visibility)
            %%BEACON_DOWNLINK_MODEL construct an instance of Beacon_Downlink_Model with the indicated number of modelled points
            if nargin==0
                return
            elseif nargin==1
                Beacon_Downlink_Model=SetNumSteps(Beacon_Downlink_Model,N);
            elseif nargin==2
                Beacon_Downlink_Model=SetNumSteps(Beacon_Downlink_Model,N);
                Beacon_Downlink_Model=SetVisibility(Beacon_Downlink_Model,Visibility);
            else
                error('To instantiate link model, provide a number of steps and, optionally, a visibility string')
            end
        end

    function [Beacon_Downlink_Model,Link_Loss_dB] = Compute_Link_Loss(Beacon_Downlink_Model,Satellite,Ground_Station)
        %%COMPUTE_LINK_LOSS compute loss between satellite and ground
        %station

        %% compute link lengths
        Link_Lengths=ComputeDistanceBetween(Satellite,Ground_Station);
        Beacon_Downlink_Model=SetLinkLength(Beacon_Downlink_Model,Link_Lengths);

        %% see Link loss analysis for a satellite quantum communication down-link Chunmei Zhang*, Alfonso Tello, Ugo Zanforlin, Gerald S. Buller, Ross J. Donaldson
        [Geo_Loss,Geo_Spot_Diameter] = GetGeoLoss(Satellite.Beacon,Link_Lengths,Ground_Station.Camera);
        %compute when earth shadowing of link is present
        Shadowing=IsEarthShadowed(Satellite,Ground_Station);
        Geo_Loss(Shadowing)=0;

        %% efficiency loss
        Eff_Loss=Satellite.Beacon.Total_Efficiency*Ground_Station.Camera.Total_Efficiency;

        %% turbulence loss
        %see Point ahead angle prediction based on Kalman filtering of
        % optical axis pointing angle in satellite laser communication
        % Zhang Furui · Ruan Ping · Han Junfeng

        %we assume turbulence limited behaviour (with no adaptive
        %optics)
        %parameters
        Wavelength = Satellite.Source.Wavelength*10^-9;
        Wavenumber = 2*pi/Wavelength;
        %can only compute for positive elevation
        [~,Elevation_Angles]=RelativeHeadingAndElevation(Satellite,Ground_Station);
        Elevation_Flags = Elevation_Angles'>0;
        Zenith = 90-Elevation_Angles(Elevation_Flags)';
        Satellite_Altitude = Satellite.Altitude(Elevation_Flags);
        Atmospheric_Turbulence_Coherence_Length = ...
            atmospheric_turbulence_coherence_length_downlink(Wavenumber,...
                                         Zenith, ...
                                         Satellite_Altitude, ghv_defaults);
        %output variables
        Turbulence_Beam_Width_Increase = long_term_gaussian_beam_width(Geo_Spot_Diameter(Elevation_Flags), Link_Lengths(Elevation_Flags) ,...
                                    2*pi/(Satellite.Source.Wavelength*10^-9), Atmospheric_Turbulence_Coherence_Length);
        %residual beam wander is not needed here as this is dealt with in
        %APT loss
        %wander_tl = residual_beam_wander(error_snr, error_delay, error_centroid, ...
        %                                   error_tilt, spot_tl, L);

        %turbulence loss is the ratio of geometric and turbulent spot areas
        Turb_Loss(~Elevation_Flags)=0;
        Turb_Loss(Elevation_Flags) = Turbulence_Beam_Width_Increase.^(-2);

        %% atmospheric loss
        %compute elevation angles
        [~,Elevation_Angles]=RelativeHeadingAndElevation(Satellite,Ground_Station);
        %format spectral filters which correspond to these elevation angles
        Atmospheric_Spectral_Filter = Atmosphere_Spectral_Filter(Elevation_Angles,Satellite.Beacon.Wavelength,{Beacon_Downlink_Model.Visibility});
        Atmos_Loss = computeTransmission(Atmospheric_Spectral_Filter,Satellite.Beacon.Wavelength);
        
        %% APT loss
        APTracking_Loss=GetAPTLoss(Satellite.Beacon,Ground_Station.Camera);

        %record loss values
        Beacon_Downlink_Model=SetGeometricLoss(Beacon_Downlink_Model,Geo_Loss);
        Beacon_Downlink_Model=SetOpticalEfficiencyLoss(Beacon_Downlink_Model,Eff_Loss);
        Beacon_Downlink_Model=SetAtmosphericLoss(Beacon_Downlink_Model,Atmos_Loss);
        Beacon_Downlink_Model=SetAPTLoss(Beacon_Downlink_Model,APTracking_Loss);
        Beacon_Downlink_Model=SetTurbulenceLoss(Beacon_Downlink_Model,Turb_Loss);
        
        %compute total loss
        [Beacon_Downlink_Model,Link_Loss_dB]=SetTotalLoss(Beacon_Downlink_Model);
    end

    function Geometric_Loss_dB=GetGeometricLossdB(Beacon_Downlink_Model)
            %%GETGEOMETRICLOSSDB return an array of geometric losses in dB the same dimensions as the satellite link model
            
            Geometric_Loss_dB=Beacon_Downlink_Model.Geometric_Loss_dB;
        end

    function Atmospheric_Loss_dB=GetAtmosphericLossdB(Beacon_Downlink_Model)
        %%GETATMOSPHERICLOSSDB return an array of atmospheric losses in dB the
        %same dimensions as the satellite link model
        
        Atmospheric_Loss_dB=Beacon_Downlink_Model.Atmospheric_Loss_dB;
    end

    function OpticalEfficiency_Loss_dB=GetOpticalEfficiencyLossdB(Beacon_Downlink_Model)
        %%GETEFFICIENCYLOSSDB return an array of efficiency losses in dB the
        % same dimensions as the satellite link model

        OpticalEfficiency_Loss_dB = Beacon_Downlink_Model.Optical_Efficiency_Loss_dB;
    end

    function Turbulence_Loss_dB=GetTurbulenceLossdB(Satellite_Uplink_Model)
    %%GETTURBULENCELOSSDB return an array of acquistition, pointing and tracking
    % losses in dB the same dimensions as the satellite link model

    Turbulence_Loss_dB=Satellite_Uplink_Model.Turbulence_Loss_dB;
    end

    function APT_Loss_dB=GetAPTLossdB(Beacon_Downlink_Model)
        %%GETAPTLOSSDB return an array of acquistition, pointing and tracking
        % losses in dB the same dimensions as the satellite link model
        APT_Loss_dB=Beacon_Downlink_Model.APT_Loss_dB;
    end
    
    function Plot(Beacon_Downlink_Model,X_Axis,Plot_Select_Flags)
            %%PLOT plot the link loss over time of the satellite link

            %get losses
            Geo=GetGeometricLossdB(Beacon_Downlink_Model);
            Atmos=GetAtmosphericLossdB(Beacon_Downlink_Model);
            Eff=GetOpticalEfficiencyLossdB(Beacon_Downlink_Model);
            APT=GetAPTLossdB(Beacon_Downlink_Model);
            Turb=GetTurbulenceLossdB(Beacon_Downlink_Model);

            if nargin==3
            %if flags provided, select what to plot
            Geo=Geo(Plot_Select_Flags);
            Atmos=Atmos(Plot_Select_Flags);
            Eff=Eff(Plot_Select_Flags);
            APT=APT(Plot_Select_Flags);
            Turb=Turb(Plot_Select_Flags);
            end

            area(X_Axis(Plot_Select_Flags),[Geo',Atmos',Eff',APT',Turb']);
            xlabel('Time (s)')
            ylabel('Losses (dB)')

            %% adjust legend to represent what is plotted
            %atmospheric loss is non zero
            legend('Geometric loss','Atmospheric loss','Efficiency loss','APT loss','Turbulence loss','Orientation','horizontal');
            legend('Location','south')
        end

    function [Link_Model,Total_Loss_dB]=SetTotalLoss(Link_Model)
            %%SETTOTALLOSS update total loss to reflect stored loss values

            Total_Loss_dB=Link_Model.Geometric_Loss_dB+Link_Model.Optical_Efficiency_Loss_dB+Link_Model.APT_Loss_dB+Link_Model.Atmospheric_Loss_dB+Link_Model.Turbulence_Loss_dB;
            Link_Model.Link_Loss_dB=Total_Loss_dB;
            Link_Model.Link_Loss=10.^(-Total_Loss_dB/10);

        end

    function Downlink_Beacon_Model = SetVisibility(Downlink_Beacon_Model,Visibility)
        %%SETVISIBILITY set the visibility tag of this link model

        Downlink_Beacon_Model.Visibility = Visibility;
    end

    function Beacon_Downlink_Model = SetNumSteps(Beacon_Downlink_Model,N)
            %%SETNUMSTEPS set the number of points in the simulated link model

        Beacon_Downlink_Model.N=N;
        Beacon_Downlink_Model.Geometric_Loss=zeros(1,N);                                              %geometric loss in absolute terms
        Beacon_Downlink_Model.Geometric_Loss_dB=zeros(1,N);                                             %geometric loss in dB
        Beacon_Downlink_Model.Optical_Efficiency_Loss=zeros(1,N);                                       %Optical Efficiency loss in absolute terms
        Beacon_Downlink_Model.Optical_Efficiency_Loss_dB=zeros(1,N);                                    %Optical Efficiency loss in dB
        Beacon_Downlink_Model.APT_Loss=zeros(1,N);                                                      %tracking loss in absolute term s
        Beacon_Downlink_Model.APT_Loss_dB=zeros(1,N);                                                   %tracking loss in dB
        Beacon_Downlink_Model.Atmospheric_Loss=zeros(1,N);                                              %atmospheric loss in absolute terms
        Beacon_Downlink_Model.Atmospheric_Loss_dB=zeros(1,N);                                           %atmospheric loss in dB
        Beacon_Downlink_Model.Length=zeros(1,N);                                                        %link distance in m
        end
    end

    methods (Access=protected)

    function Link_Models=SetGeometricLoss(Link_Models,Geometric_Loss)
        %%SETGEOMETRICLOSS set the geometric loss in a link model array

        %% input validation
        if ~all(isreal(Geometric_Loss)&Geometric_Loss>=0)
            error('geometric loss must be a non-negative array of numeric values')
        end
        if isscalar(Geometric_Loss)
            Geometric_Loss=Geometric_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
        elseif isrow(Geometric_Loss)
        elseif iscolumn(Geometric_Loss)
            Geometric_Loss=Geometric_Loss'; %can transpose lengths to match dimensions of Link_Models
        else
            error('Array must be a vector or scalar');
        end

        Link_Models.Geometric_Loss=Geometric_Loss;
        Link_Models.Geometric_Loss_dB=-10*log10(Geometric_Loss);
    end

    function Link_Models=SetAtmosphericLoss(Link_Models,Atmospheric_Loss)
        %%SETATMOSPHERICLOSS

        %% input validation
        if ~all(isreal(Atmospheric_Loss)&Atmospheric_Loss>=0)
            error('atmospheric loss must be a real, nonnegative array of numeric values')
        end
        if isscalar(Atmospheric_Loss)
            Atmospheric_Loss=Atmospheric_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
        elseif isrow(Atmospheric_Loss)
        elseif iscolumn(Atmospheric_Loss)
            Atmospheric_Loss=Atmospheric_Loss'; %can transpose lengths to match dimensions of Link_Models
        else
            error('Array must be a vector or scalar');
        end
        
        Link_Models.Atmospheric_Loss=Atmospheric_Loss;
        Link_Models.Atmospheric_Loss_dB=-10*log10(Atmospheric_Loss);
    end

    function Link_Models=SetOpticalEfficiencyLoss(Link_Models,Optical_Efficiency_Loss)
        %%SETOPTICALEFFICIENCYLOSS set the optical efficiency loss in the link

        %% input validation
        if ~all(isreal(Optical_Efficiency_Loss)&Optical_Efficiency_Loss>=0)
            error('optical efficiency loss must be a real, positive array of numeric values')
        end
        if isscalar(Optical_Efficiency_Loss)
            Optical_Efficiency_Loss=Optical_Efficiency_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
        elseif isrow(Optical_Efficiency_Loss)
        elseif iscolumn(Optical_Efficiency_Loss)
            Optical_Efficiency_Loss=Optical_Efficiency_Loss'; %can transpose lengths to match dimensions of Link_Models
        else
            error('Array must be a vector or scalar');
        end

        Link_Models.Optical_Efficiency_Loss=Optical_Efficiency_Loss;
        Link_Models.Optical_Efficiency_Loss_dB=-10*log10(Optical_Efficiency_Loss);
    end

    function Link_Models=SetAPTLoss(Link_Models,APT_Loss)
        %%SETAPTLOSS set the acquistion, pointing and tracking loss of the link

        %% input validation
        if ~all(isreal(APT_Loss)&APT_Loss>=0)
            error('tracking loss must be a real, nonnegative array of numeric values')
        end
        if isscalar(APT_Loss)
            APT_Loss=APT_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
        elseif isrow(APT_Loss)
        elseif iscolumn(APT_Loss)
            APT_Loss=APT_Loss'; %can transpose lengths to match dimensions of Link_Models
        else
            error('Array must be a vector or scalar');
        end

        Link_Models.APT_Loss=APT_Loss;
        Link_Models.APT_Loss_dB=-10*log10(APT_Loss);
    end

       function Link_Models = SetTurbulenceLoss(Link_Models,Turbulence_Loss)
            %%SETTURBULENCELOSS set the turbulence loss of the link

            %% input validation
            if ~all(isreal(Turbulence_Loss)&Turbulence_Loss>=0)
                error('tracking loss must be a real, nonnegative array of numeric values')
            end
            if isscalar(Turbulence_Loss)
                Turbulence_Loss=Turbulence_Loss*ones(1,Link_Models.N); %if provided a scalar, put this into everywhere in the array 
            elseif isrow(Turbulence_Loss)
            elseif iscolumn(Turbulence_Loss)
                Turbulence_Loss=Turbulence_Loss'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Array must be a vector or scalar');
            end

            Link_Models.Turbulence_Loss=Turbulence_Loss;
            Link_Models.Turbulence_Loss_dB=-10*log10(Turbulence_Loss);
        end

    function Link_Models=SetLinkLength(Link_Models,Lengths)
        %%SETLINKLENGTH set the length of the links in the input array

        %% input validation
        if ~all(isreal(Lengths)&Lengths>0)
            error('lengths must be a real, positive array of numeric values')
        end
        
        assert(isvector(Lengths),'Lengths must be a vector')
            if iscolumn(Lengths)
                Lengths=Lengths'; %can transpose lengths to match dimensions of Link_Models
            else
                error('Lengths array must have the same dimensions as the array of link models');
            end

        Link_Models.Length=Lengths;
    end
    end
end