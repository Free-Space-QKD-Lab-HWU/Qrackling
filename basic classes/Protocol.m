classdef (Abstract) Protocol
    %PROTOCOL an object collating all information relevant to the 
    %   Detailed explanation goes here

    properties(SetAccess=protected,Abstract=true)
        Name{mustBeText}                                                   %name of the protocol
        Efficiency double {mustBeLessThanOrEqual(Efficiency,1),mustBeNonnegative}
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
    end
end