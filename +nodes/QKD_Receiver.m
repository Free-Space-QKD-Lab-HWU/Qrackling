classdef (Abstract) QKD_Receiver
    %QKD_Receiver an abstract class containing function templates for any
    %receiver architecture

    properties
        % a detector object, validated individually in subclasses
        Detector = [];   
    end
end
