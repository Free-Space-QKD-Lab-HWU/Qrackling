classdef (Abstract) Protocol
    %PROTOCOL describes the operation of a QKD protocol

    properties(SetAccess=protected,Abstract=true)
        Name{mustBeText}                                                   %name of the protocol
        Efficiency double {mustBeLessThanOrEqual(Efficiency,1),mustBeNonnegative}
        DetectorRequirements                                               %cell array of names of properties the detector must contain to be compatible with this protocol
        SourceRequirements                                                 %cell array of names of properties the source must contain to be compatible with this protocol
    end

    methods(Access=public,Abstract=true)
        [Secret_Key_Rate,QBER] = EvaluateQKDLink(Protocol,Source,Detector,Link_Loss_dB,Background_Count_Rate)
        %%EVALUATEQKDLINK enact the link performance simulation for the
        %%particular protocol
    end
    methods (Access=public,Abstract=false)
        function IsCompatible=TestCompatibility(Protocol,obj)
            %%TESTCOMPATIBILITY test whether the object given is compatible
            %%with the current protocol
            if ~isprop(obj,'Protocol')
                error('this object does not have a defined protocol')
            end
            IsCompatible=isequal(Protocol.Name,obj.Protocol);
        end

        function [IsCompatible,Lacking_Properties]  = IsDetectorCompatible(Protocol,Detector)
            %%ISDETECTORCOMPATIBLE test whether the provided detector has the
            %%properties required for simulation of this protocol

            %% check that the list of properties is contained by this detector
            N=numel(Protocol.DetectorRequirements);
            PropertyPresent=false(1,N);
            %iterate over requirements
            for i=1:N
                PropertyPresent(i)=isprop(Detector,Protocol.DetectorRequirements{i})&&~isempty(Detector.(Protocol.DetectorRequirements{i}));
            end

            %produce logical result
            IsCompatible=all(PropertyPresent);
            %return properties which are lacking
            if ~IsCompatible
                Lacking_Properties=Protocol.DetectorRequirements{~PropertyPresent};
            else
                Lacking_Properties=[];
            end
        end

        function [IsCompatible,Lacking_Properties]  = IsSourceCompatible(Protocol,Source)
            %%ISSOURCECOMPATIBLE test whether the provided source has the
            %%properties required for simulation of this protocol

            %% check that the list of properties is contained by this source
            N=numel(Protocol.SourceRequirements);
            PropertyPresent=false(1,N);
            %iterate over requirements
            for i=1:N
                PropertyPresent(i)=isprop(Source,Protocol.SourceRequirements{i})&&~isempty(Source.(Protocol.SourceRequirements{i}));
            end

            %produce logical result
            IsCompatible=all(PropertyPresent);
            %return properties which are lacking
            if ~IsCompatible
                Lacking_Properties=Protocol.SourceRequirements{~PropertyPresent};
            else
                Lacking_Properties=[];
            end

        end
    end
end