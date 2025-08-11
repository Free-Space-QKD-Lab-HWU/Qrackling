classdef (Abstract) QKDReceiver
% QKDReceiver
%
% Abstract base class for all QKD receiver architectures.
% Subclasses must define and validate the detector module used for
% photon detection and signal processing.
%
% Syntax:
% receiver = nodes.QKDReceiver()

    properties
        % detector - (1,1) object representing the receiver's detection module
        detector = []
    end
end