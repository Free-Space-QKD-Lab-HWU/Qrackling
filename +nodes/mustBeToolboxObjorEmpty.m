function mustBeToolboxObjorEmpty(X)
%MUSTBETOOLBOXOBJOREMPTY error if the provided object is not a matlab
%satellite communications toolbox satellite, ground station or platform.
%the only alternative is that the object provided is an empty array

if isempty(X)
    return
elseif isa(X,'matlabshared.satellitescenario.Satellite')||...
       isa(X,'matlabshared.satellitescenario.GroundStation')||...
       isa(X,'matlabshared.satellitescenario.Platform')
    return
end
error('object must be a MATLAB satcomms toolbox satellite, ground station or platform, or an empty array')
end

