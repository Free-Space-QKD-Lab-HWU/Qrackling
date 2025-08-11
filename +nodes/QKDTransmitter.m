classdef (Abstract) QKDTransmitter
% QKDTransmitter
%
% Abstract class implementing all behavior required by a QKD transmitter,
% whether deployed on a satellite or an optical ground station (OGS).
%
% Subclasses must define and validate the Source property, which contains
% the physical and spectral characteristics of the transmitter.
%
% Syntax:
% transmitter = nodes.QKDTransmitter()

    properties
        % source - (1,1) object containing transmitter details
        Source = []
    end
end