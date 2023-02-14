classdef(Abstract) Satellite_Link_Model < Link_Model
    %an abstract class defining the interface for any link model from a
    %satellite to a ground station

    properties (SetAccess=protected,Abstract=false)
        N                                                                  %number of time steps to simulate
        Link_Loss;                                                         %link loss in absolute terms
        Link_Loss_dB;                                                      %link loss measured in dB
        Shadow_Flag;                                                       %flag describing when the link is shadowed
    end
    properties (SetAccess=protected)
        Geometric_Loss=nan;                                                %geometric loss in absolute terms
        Geometric_Loss_dB=nan;                                             %geometric loss in dB
        Optical_Efficiency_Loss=nan;                                       %Optical Efficiency loss in absolute terms
        Optical_Efficiency_Loss_dB=nan;                                    %Optical Efficiency loss in dB
        APT_Loss=nan;                                                      %tracking loss in absolute term s
        APT_Loss_dB=nan;                                                   %tracking loss in dB
        Turbulence_Loss=nan;                                               %turbulence loss in absolute terms
        Turbulence_Loss_dB=nan;                                            %loss due to atmospheric turbulence
        Atmospheric_Loss=nan;                                              %atmospheric loss in absolute terms
        Atmospheric_Loss_dB=nan;                                           %atmospheric loss in dB
        Length=nan;                                                        %link distance in m
        Visibility {mustBeText} ='clear'                                   %tag identifying the visibility conditions of this link
        Elevation_Angles(1,:)=nan;                                              %elevation of the satellite link
    end

    methods (Abstract = false, Access = protected)
        %%%%%%%%%%%%%%%%%%%%% comncrete methods common to all subclasses
        %%%%%%%%%%%%%%%%%%%%% which are not available outside the class
        function Link_Models=SetLinkLength(Link_Models,Satellite,Ground_Station)
            %%SETLINKLENGTH set the length of the links in the input array


            %% compute link lengths
            Lengths=ComputeDistanceBetween(Satellite,Ground_Station);


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

        function Link_Models = SetElevationAngle(Link_Models,Satellite,Ground_Station)
            %compute elevation angles
            [~,Elev_Angles]=RelativeHeadingAndElevation(Satellite,Ground_Station);

            Link_Models.Elevation_Angles = Elev_Angles;
        end

        function Link_Models = SetLinkGeometry(Link_Models,Satellite,Ground_Station)
            %%SETLINKGEOMETRY simultaneously set link length and elevation

            [~,Elevation,Length]=RelativeHeadingAndElevation(Satellite,Ground_Station);

            Link_Models.Elevation_Angles=Elevation;
            Link_Models.Length=Length;
        end


        function Geometric_Loss_dB=GetGeometricLossdB(Satellite_Link_Model)
            %%GETGEOMETRICLOSSDB return an array of geometric losses in dB the same dimensions as the satellite link model

            Geometric_Loss_dB=Satellite_Link_Model.Geometric_Loss_dB;
        end

        function Atmospheric_Loss_dB=GetAtmosphericLossdB(Satellite_Link_Model)
            %%GETATMOSPHERICLOSSDB return an array of atmospheric losses in dB the
            %same dimensions as the satellite link model
            Atmospheric_Loss_dB=Satellite_Link_Model.Atmospheric_Loss_dB;
        end

        function OpticalEfficiency_Loss_dB=GetOpticalEfficiencyLossdB(Satellite_Link_Model)
            %%GETEFFICIENCYLOSSDB return an array of efficiency losses in dB the
            % same dimensions as the satellite link model

            OpticalEfficiency_Loss_dB = Satellite_Link_Model.Optical_Efficiency_Loss_dB;
        end

        function APT_Loss_dB=GetAPTLossdB(Satellite_Link_Model)
            %%GETAPTLOSSDB return an array of acquistition, pointing and tracking
            % losses in dB the same dimensions as the satellite link model

            APT_Loss_dB=Satellite_Link_Model.APT_Loss_dB;
        end

        function Turbulence_Loss_dB=GetTurbulenceLossdB(Satellite_Link_Model)
            %%GETAPTLOSSDB return an array of acquistition, pointing and tracking
            % losses in dB the same dimensions as the satellite link model

            Turbulence_Loss_dB=Satellite_Link_Model.Turbulence_Loss_dB;
        end

        function Satellite_Link_Model = SetVisibility(Satellite_Link_Model,Visibility)
            %%SETVISIBILITY set the visibility tag of this link model

            Satellite_Link_Model.Visibility = Visibility;
        end

    end
    methods(Abstract = false, Access = public)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% concrete methods available in all
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% subclasses and called from outside
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% the object
        function Plot(Satellite_Link_Model,X_Axis, Plot_Select_Flags)
            %%PLOT plot the link loss over time of the satellite link


            Geo = GetGeometricLossdB(Satellite_Link_Model);
            Eff = GetOpticalEfficiencyLossdB(Satellite_Link_Model);
            APT = GetAPTLossdB(Satellite_Link_Model);
            Turb = GetTurbulenceLossdB(Satellite_Link_Model);
            Atmos = GetAtmosphericLossdB(Satellite_Link_Model);

            Geo=Geo(Plot_Select_Flags)';
            Eff=Eff(Plot_Select_Flags)';
            APT=APT(Plot_Select_Flags)';
            Turb=Turb(Plot_Select_Flags)';
            Atmos=Atmos(Plot_Select_Flags)';

            area(X_Axis(Plot_Select_Flags),[Geo,Eff,APT,Turb,Atmos]);
            xlabel('Time (s)')
            ylabel('Losses (dB)')

            %% adjust legend to represent what is plotted
            %atmospheric loss is non zero
            legend('Geometric','Efficiency','Pointing','Turbulence','Atmospheric','Orientation','horizontal');
            legend('Location','south')
        end

        function [Link_Model,Link_Loss_dB] = Compute_Link_Loss(Link_Model,Satellite,Ground_Station)
            %%COMPUTE_LINK_LOSS compute loss between satellite and ground
            %station

            %compute link geometry first
            Link_Model = SetLinkGeometry(Link_Model,Satellite,Ground_Station);

            %record loss values
            [Link_Model,Geo_Spot_Size]=SetGeometricLoss(Link_Model,Satellite,Ground_Station);
            Link_Model=SetOpticalEfficiencyLoss(Link_Model,Satellite,Ground_Station);
            Link_Model=SetAtmosphericLoss(Link_Model,Satellite,Ground_Station);
            Link_Model=SetAPTLoss(Link_Model,Satellite,Ground_Station);
            Link_Model=SetTurbulenceLoss(Link_Model,Satellite,Ground_Station,Geo_Spot_Size);

            %compute total loss
            [Link_Model,Link_Loss_dB]=SetTotalLoss(Link_Model);
        end
    
        function Satellite_Link_Model = SetNumSteps(Satellite_Link_Model,N)
            %%SETNUMSTEPS set the number of points in the simulated link model

            Satellite_Link_Model.N=N;
            Satellite_Link_Model.Geometric_Loss=zeros(1,N);                                                %geometric loss in absolute terms
            Satellite_Link_Model.Geometric_Loss_dB=zeros(1,N);                                             %geometric loss in dB
            Satellite_Link_Model.Turbulence_Loss=zeros(1,N);                                               %turbulence loss in absolute terms
            Satellite_Link_Model.Turbulence_Loss_dB=zeros(1,N);                                            %turbulence loss in dB
            Satellite_Link_Model.Optical_Efficiency_Loss=zeros(1,N);                                       %Optical Efficiency loss in absolute terms
            Satellite_Link_Model.Optical_Efficiency_Loss_dB=zeros(1,N);                                    %Optical Efficiency loss in dB
            Satellite_Link_Model.APT_Loss=zeros(1,N);                                                      %tracking loss in absolute term s
            Satellite_Link_Model.APT_Loss_dB=zeros(1,N);                                                   %tracking loss in dB
            Satellite_Link_Model.Atmospheric_Loss=zeros(1,N);                                              %atmospheric loss in absolute terms
            Satellite_Link_Model.Atmospheric_Loss_dB=zeros(1,N);                                           %atmospheric loss in dB
            Satellite_Link_Model.Length=zeros(1,N);                                                        %link distance in m
        end
    
        function [Link_Model,Total_Loss_dB]=SetTotalLoss(Link_Model)
            %%SETTOTALLOSS update total loss to reflect stored loss values

            Total_Loss_dB=Link_Model.Geometric_Loss_dB+Link_Model.Optical_Efficiency_Loss_dB+Link_Model.APT_Loss_dB+Link_Model.Turbulence_Loss_dB;
            Total_Loss= 10.^(Total_Loss_dB/10);
            Link_Model.Link_Loss_dB=Total_Loss_dB;
            Link_Model.Link_Loss=Total_Loss;
        end
    end
    
    methods (Abstract = true, Access = protected)
        %%%%%%%%%%%%%%%%%%%%% abstract methods which are implemented in
        %%%%%%%%%%%%%%%%%%%%% subclasses
        [Link_Models,Geo_Spot_Size]=SetGeometricLoss(Link_Models,Satellite,Ground_Station)

        Link_Models=SetAtmosphericLoss(Link_Models,~,Ground_Station)

        Link_Models=SetOpticalEfficiencyLoss(Link_Models,Satellite,Ground_Station)

        Link_Models=SetAPTLoss(Link_Models,Satellite,Ground_Station)

        Link_Models = SetTurbulenceLoss(Link_Models,Satellite,Ground_Station,Geo_Spot_Size)

    end
end
