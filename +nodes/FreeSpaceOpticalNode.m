classdef (Abstract) FreeSpaceOpticalNode
% FreeSpaceOpticalNode
%
% Abstract base class representing an optical transmitter or receiver
% in a free-space optical communication system.
%
% Syntax:
% node = nodes.FreeSpaceOpticalNode()

    properties
        % telescope - optical telescope component used for transmission or reception
        telescope = components.Telescope.empty([0, 1])
    end
end