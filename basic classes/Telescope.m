classdef Telescope
    %TELESCOPE contain the relevant properties of optical systems for
    %transmitters and receivers

    properties
        %diameter of the transmitter in m
        Diameter{mustBeScalarOrEmpty,mustBePositive};
        
        %ratio between theoretical and acutal far field divergence angle
        Far_Field_Divergence_Coefficient{mustBeScalarOrEmpty,mustBePositive}=1
        
        %optical efficiency- from cassegrain telescope obscuration (Link loss analysis for a satellite quantum communication downlink, Single photon group)
        Optical_Efficiency{mustBeScalarOrEmpty,mustBePositive}=0.6;
        
        %rms error in pointing in radians
        Pointing_Jitter{mustBeScalarOrEmpty,mustBeNonnegative}=10^-6;

        %focal length (in m_ of the telescope collecting optics
        Focal_Length {mustBeScalarOrEmpty,mustBeNonnegative}=[];

        %F number is the ratio of focal length to diameter
        F_Number {mustBeScalarOrEmpty,mustBeNonnegative}=8.4;   %default is 8.4

        %magnification of telescope- applied directly to beam expansion and
        %inversely to angle compression
        Magnification {mustBeScalarOrEmpty,mustBePositive};

        %eyepiece focal length (in m) to compute magnification
        Eyepiece_Focal_Length {mustBeScalarOrEmpty,mustBeNonnegative}= 0.058; %default is 2 inches
    end
    properties(SetAccess=protected)
        %wavelength of the transmitter (in nm), set by the satellite it is mounted to
        Wavelength{mustBeScalarOrEmpty,mustBePositive}=[];

        %angle in rads describing spread of photons as the propagate
        FOV{mustBeScalarOrEmpty,mustBeNonnegative};

        %collecting area of the telescope in m^2
        Collecting_Area (1,1) double {mustBeNonnegative}
    end

    methods
        function obj = Telescope(Diameter,varargin)
            %%TELESCOPE construct a telescope object

            %% allow empty default creation
            if nargin==0
                return
            end

            %% create and use input parser
            P=inputParser();
            %required inputs
            addRequired(P,'Diameter')

            %optional inputs
            addParameter(P,'Wavelength',[])
            addParameter(P,'Optical_Efficiency', obj.Optical_Efficiency);
            addParameter(P,'Far_Field_Divergence_Coefficient', ...
                         obj.Far_Field_Divergence_Coefficient);
            addParameter(P,'Pointing_Jitter',obj.Pointing_Jitter);
            addParameter(P,'FOV',[])
            addParameter(P,'Focal_Length',[]);
            addParameter(P,'F_Number',8.4);
            addParameter(P,'Eyepiece_Focal_Length',0.058);
            %parse inputs
            parse(P,Diameter,varargin{:});

            %% set values
            obj.Diameter=P.Results.Diameter;
            obj.Far_Field_Divergence_Coefficient = ...
                                P.Results.Far_Field_Divergence_Coefficient;
            obj.Optical_Efficiency=P.Results.Optical_Efficiency;
            obj=SetPointingJitter(obj,P.Results.Pointing_Jitter);
            obj=SetWavelength(obj,P.Results.Wavelength);
            if ~isempty(P.Results.FOV)
                obj=SetFOV(obj,P.Results.FOV);
            end
            
            if ~isempty(P.Results.Focal_Length)
                obj.Focal_Length = P.Results.Focal_Length;
                obj.F_Number = obj.Focal_Length/obj.Diameter;
            else
                obj.F_Number = P.Results.F_Number;
                obj.Focal_Length = obj.F_Number * obj.Diameter;
            end
            obj.Eyepiece_Focal_Length = P.Results.Eyepiece_Focal_Length;
            %record magnification
            obj.Magnification = obj.Focal_Length/obj.Eyepiece_Focal_Length;
        end

        function Telescope=SetWavelength(Telescope,Wavelength)
            %%SETWAVELENGTH set the wavelength (nm) of the transmitter
            Telescope.Wavelength=Wavelength;
        end

        function Telescope=SetDiameter(Telescope,Diameter)
            %%SETWAVELENGTH set the diameter (in m) of the transmitter
            Telescope.Diameter=Diameter;
        end

        function Telescope=SetPointingJitter(Telescope,Pointing_Jitter)
            %%SETPOINTINGJITTER set pointing jitter of the OGS
            Telescope.Pointing_Jitter=Pointing_Jitter;
        end

        function Telescope = SetFOV(Telescope, FOV)
            %%SETFOV set the FOV of a telescope by updating the far field
            %%divergence coefficient to suit

            if ~isempty(Telescope.Wavelength)
            Telescope.Far_Field_Divergence_Coefficient = ...
                        FOV * Telescope.Diameter / ...
                            (2.44 *( Telescope.Wavelength * 10^-9 ));  
            else
                Telescope.FOV = FOV;
            end
        end

        function Area = get.Collecting_Area(Telescope)
            %%COLLECTINGAREA return the total collecting area of the telescope in
            %%m^2
    
            Area = (pi/4)*Telescope.Diameter^2;
        end

        function FOV = get.FOV(Telescope)
            %%FOV return the FOV of the telescope in radians, computed by
            %%scaling the divergence limited FOV

            %if no wavelength is set then return empty FOV
            if isempty(Telescope.Wavelength)
                FOV=[];
                return
            end
    
            %compute the diffraction-limited FOV at a particular wavelength
            %with a modification 
            %see 
            % Chunmei Zhang, Alfonso Tello, Ugo Zanforlin, Gerald S. Buller,
            % and Ross J. Donaldson "Link loss analysis for a satellite quantum
            % communication down-link", Proc. SPIE 11540, Emerging Imaging and
            % Sensing Technologies for Security and Defence V; and Advanced
            % Manufacturing Technologies for Micro- and Nanosystems in Security
            % and Defence III, 1154007 (20 September 2020);
            % https://doi.org/10.1117/12.2573489
            FOV = 2.44 ...
                    * Telescope.Far_Field_Divergence_Coefficient ...
                    *( Telescope.Wavelength * 10^-9 ) ...
                    / Telescope.Diameter;
        end
    end
end
