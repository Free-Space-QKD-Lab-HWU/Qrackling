function mustBeReceiver(receiver)
% mustBeReceiver
%
% Validates that input is a receiver object of type nodes.Satellite or nodes.Ground_Station.
%
% Syntax:
% mustBeReceiver(receiver)
%
% Inputs:
% receiver - scalar or cell array of receiver objects

    if isscalar(receiver)
        mustBeA(receiver, ["nodes.Satellite", "nodes.Ground_Station"])
        return
    end

    for i = 1:numel(receiver)
        rx = receiver{i};
        nodes.mustBeReceiver(rx)
    end
end